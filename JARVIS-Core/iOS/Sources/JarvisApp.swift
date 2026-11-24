// SPDX-License-Identifier: Apache-2.0
import SwiftUI
import UIKit
import Security
import AVFoundation
import UniformTypeIdentifiers

@main struct JarvisApp: App {
    var body: some Scene { WindowGroup { JarvisView() } }
}

struct APIError: LocalizedError {
    let errorDescription: String?
    init(_ message: String) { errorDescription = message }
}

enum SessionKey {
    static let match: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrService as String: "com.lubuimi.jarvis",
        kSecAttrAccount as String: "session"
    ]
    static func read() -> String? {
        var query = match
        query[kSecReturnData as String] = true
        var result: CFTypeRef?
        guard SecItemCopyMatching(query as CFDictionary, &result) == errSecSuccess,
              let data = result as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }
    static func save(_ value: String?) throws {
        if let value {
            let data = Data(value.utf8)
            let status = SecItemUpdate(match as CFDictionary, [kSecValueData as String: data] as CFDictionary)
            if status == errSecItemNotFound {
                var item = match
                item[kSecValueData as String] = data
                item[kSecAttrAccessible as String] = kSecAttrAccessibleWhenUnlockedThisDeviceOnly
                guard SecItemAdd(item as CFDictionary, nil) == errSecSuccess else {
                    throw APIError("Sitzung konnte nicht im Schlüsselbund gespeichert werden.")
                }
            } else if status != errSecSuccess {
                throw APIError("Sitzung konnte nicht im Schlüsselbund aktualisiert werden.")
            }
        } else {
            SecItemDelete(match as CFDictionary)
        }
    }
}

@MainActor final class Jarvis: ObservableObject {
    let host = URL(string: "https://jarvis-companion-app-production.up.railway.app")!
    private let session = URLSession(configuration: .ephemeral)
    private var token = SessionKey.read()
    @Published var loggedIn = false
    @Published var restoring = true
    @Published var messages: [Turn] = []
    @Published var models: [Model] = []
    @Published var selectedModel: Model?
    @Published var provider = ""
    @Published var sending = false
    let voice = AVSpeechSynthesizer()

    struct Turn: Identifiable {
        let id = UUID()
        let role: String
        let content: String
        var wire: [String: String] { ["role": role, "content": content] }
    }

    struct Model: Hashable {
        let provider: String
        let model: String
        var wire: [String: String] { ["provider": provider, "model": model] }
    }

    func call(_ path: String, _ payload: [String: Any]? = nil) async throws -> [String: Any] {
        guard path.hasPrefix("/api/"),
              let url = URL(string: host.absoluteString + path),
              url.host == host.host else { throw APIError("Ungültiger API-Pfad.") }
        var request = URLRequest(url: url, timeoutInterval: 65)
        request.httpShouldHandleCookies = false
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if let token { request.setValue("jarvis_session=" + token, forHTTPHeaderField: "Cookie") }
        if let payload {
            request.httpMethod = "POST"
            request.httpBody = try JSONSerialization.data(withJSONObject: payload)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse, http.url?.host == host.host,
              let value = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw APIError("JARVIS hat ein unerwartetes Antwortformat gesendet.")
        }
        guard (200..<300).contains(http.statusCode) else {
            if http.statusCode == 401 && path != "/api/login" {
                token = nil
                try? SessionKey.save(nil)
                loggedIn = false
            }
            throw APIError(value["error"] as? String ?? "HTTP \(http.statusCode)")
        }
        if path == "/api/login" {
            let cookie = http.value(forHTTPHeaderField: "Set-Cookie") ?? ""
            let prefix = "jarvis_session="
            guard cookie.hasPrefix(prefix),
                  let raw = cookie.dropFirst(prefix.count).split(separator: ";").first,
                  raw.count == 64, raw.allSatisfy(\.isHexDigit) else {
                throw APIError("Der Server hat keine gültige Sitzung ausgegeben.")
            }
            try SessionKey.save(String(raw))
            token = String(raw)
        }
        return value
    }

    func restore() async {
        defer { restoring = false }
        guard token != nil else { return }
        if let value = try? await call("/api/session") { loggedIn = value["authenticated"] as? Bool == true }
    }

    func login(_ code: String) async throws {
        _ = try await call("/api/login", ["code": code])
        loggedIn = true
    }

    func logout() async {
        _ = try? await call("/api/logout", [:])
        try? SessionKey.save(nil)
        token = nil
        loggedIn = false
        messages = []
        models = []
        selectedModel = nil
        provider = ""
    }

    func loadModels() async throws {
        let response = try await call("/api/chat", ["messages": [["role": "user", "content": "/models"]]])
        let tools = response["toolResult"] as? [String: Any]
        models = (tools?["models"] as? [[String: Any]] ?? []).compactMap {
            guard let provider = $0["provider"] as? String, let model = $0["model"] as? String else { return nil }
            return Model(provider: provider, model: model)
        }
    }

    func send(_ text: String) async throws {
        guard !sending else { return }
        sending = true
        defer { sending = false }
        let user = Turn(role: "user", content: text)
        messages.append(user)
        do {
            var body: [String: Any] = ["messages": messages.suffix(10).map(\.wire)]
            if let selectedModel { body["preferredModel"] = selectedModel.wire }
            let response = try await call("/api/chat", body)
            guard let reply = response["reply"] as? String else { throw APIError("JARVIS hat keine Chatantwort geliefert.") }
            messages.append(Turn(role: "assistant", content: reply))
            provider = [response["provider"], response["model"]].compactMap { $0 as? String }.joined(separator: " · ")
        } catch {
            if let index = messages.firstIndex(where: { $0.id == user.id }) { messages.remove(at: index) }
            throw error
        }
    }
}

enum Page: String, CaseIterable, Identifiable {
    case chat = "Chat", tasks = "Aufträge", library = "Bibliothek", agents = "KI-Agenten"
    case wallet = "Bitcoin", projects = "Projekte", network = "Tor & Netz", studio = "Code-Editor"
    case free = "FreeGood", trading = "Marktbeobachtung", approvals = "Freigaben", contact = "Kontakt"
    var id: Self { self }
    var icon: String {
        switch self {
        case .chat: "bubble.left.and.bubble.right"
        case .tasks: "checklist"
        case .library: "folder"
        case .agents: "person.2"
        case .wallet: "bitcoinsign.circle"
        case .projects: "square.stack"
        case .network: "network"
        case .studio: "chevron.left.forwardslash.chevron.right"
        case .free: "gift"
        case .trading: "chart.xyaxis.line"
        case .approvals: "checkmark.shield"
        case .contact: "person.crop.circle"
        }
    }
}

struct JarvisView: View {
    @StateObject private var jarvis = Jarvis()
    @State private var page: Page? = .chat
    @State private var code = ""
    @State private var error = ""
    var body: some View {
        Group {
            if jarvis.restoring { ProgressView("JARVIS verbinden") }
            else if jarvis.loggedIn {
                NavigationSplitView {
                    List(Page.allCases, selection: $page) { item in
                        NavigationLink(value: item) { Label(item.rawValue, systemImage: item.icon) }
                    }
                    .navigationTitle("JARVIS")
                    .toolbar { Button("Abmelden") { Task { await jarvis.logout() } } }
                } detail: {
                    NavigationStack {
                        detail(page ?? .chat).navigationTitle((page ?? .chat).rawValue)
                    }
                }
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    Image(systemName: "sparkles").font(.largeTitle).foregroundStyle(.mint)
                    Text("JARVIS").font(.largeTitle.bold())
                    SecureField("Persönlicher Zugangscode", text: $code)
                        .textContentType(.password).textFieldStyle(.roundedBorder)
                        .onSubmit(signIn)
                    Button("Anmelden", action: signIn).buttonStyle(.borderedProminent).disabled(code.isEmpty)
                    if !error.isEmpty { Text(error).foregroundStyle(.red) }
                }
                .frame(maxWidth: 420).padding(24)
            }
        }
        .tint(.mint)
        .task { await jarvis.restore() }
    }

    private func signIn() {
        Task {
            do { try await jarvis.login(code); code = ""; error = "" }
            catch { self.error = error.localizedDescription }
        }
    }

    @ViewBuilder private func detail(_ page: Page) -> some View {
        switch page {
        case .chat: ChatView(jarvis: jarvis)
        case .tasks: OperationsView(jarvis: jarvis, page: page, paths: ["/api/tasks"])
        case .library: OperationsView(jarvis: jarvis, page: page, paths: ["/api/library"])
        case .agents: OperationsView(jarvis: jarvis, page: page, paths: ["/api/agents"])
        case .wallet: OperationsView(jarvis: jarvis, page: page, paths: ["/api/wallet", "/api/claims", "/api/lightning/status"])
        case .projects: OperationsView(jarvis: jarvis, page: page, paths: ["/api/state"])
        case .network: NetworkView(jarvis: jarvis)
        case .studio: StudioView()
        case .free: FreeView(jarvis: jarvis)
        case .trading: NetworkView(jarvis: jarvis)
        case .approvals: OperationsView(jarvis: jarvis, page: page, paths: ["/api/approvals/pending"])
        case .contact: OperationsView(jarvis: jarvis, page: page, paths: ["/api/contact"])
        }
    }
}

struct ChatView: View {
    @ObservedObject var jarvis: Jarvis
    @State private var draft = ""
    @State private var error = ""
    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 12) {
                        if jarvis.messages.isEmpty {
                            ContentUnavailableView("Wie kann JARVIS helfen?", systemImage: "sparkles")
                        }
                        ForEach(jarvis.messages) { turn in
                            Text(turn.content).textSelection(.enabled)
                                .padding(12).background(turn.role == "user" ? Color.mint.opacity(0.18) : Color.secondary.opacity(0.09),
                                                        in: RoundedRectangle(cornerRadius: 16))
                                .frame(maxWidth: .infinity, alignment: turn.role == "user" ? .trailing : .leading)
                                .id(turn.id)
                                .contextMenu {
                                    Button("Kopieren", systemImage: "doc.on.doc") { UIPasteboard.general.string = turn.content }
                                    Button("Vorlesen", systemImage: "speaker.wave.2") {
                                        jarvis.voice.stopSpeaking(at: .immediate)
                                        let speech = AVSpeechUtterance(string: turn.content)
                                        speech.voice = AVSpeechSynthesisVoice(language: "de-DE")
                                        jarvis.voice.speak(speech)
                                    }
                                }
                        }
                        if jarvis.sending { ProgressView("JARVIS arbeitet …").padding() }
                    }.padding()
                }
                .onChange(of: jarvis.messages.count) { _, _ in
                    if let id = jarvis.messages.last?.id { withAnimation { proxy.scrollTo(id, anchor: .bottom) } }
                }
            }
            VStack(alignment: .leading, spacing: 8) {
                if !error.isEmpty { Text(error).font(.footnote).foregroundStyle(.red) }
                if !jarvis.provider.isEmpty { Text(jarvis.provider).font(.caption).foregroundStyle(.secondary) }
                HStack(alignment: .bottom) {
                    TextField("Nachricht an JARVIS", text: $draft, axis: .vertical)
                        .lineLimit(2...7).textFieldStyle(.roundedBorder)
                    Button("Senden", systemImage: "arrow.up.circle.fill", action: send)
                        .labelStyle(.iconOnly).font(.largeTitle)
                        .disabled(jarvis.sending || draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }.padding().background(.regularMaterial)
        }
        .toolbar {
            Menu {
                Button("Automatisch") { jarvis.selectedModel = nil }
                ForEach(jarvis.models, id: \.self) { model in
                    Button("\(model.model) · \(model.provider)") { jarvis.selectedModel = model }
                }
                Button("Modelle aktualisieren") { Task { await refreshModels() } }
            } label: { Label(jarvis.selectedModel?.model ?? "Automatisch", systemImage: "cpu") }
            ShareLink(item: jarvis.messages.map { "\($0.role): \($0.content)" }.joined(separator: "\n\n")) {
                Label("Chat teilen", systemImage: "square.and.arrow.up")
            }.disabled(jarvis.messages.isEmpty)
        }
        .task { await refreshModels() }
    }

    private func refreshModels() async {
        do { try await jarvis.loadModels() }
        catch { self.error = error.localizedDescription }
    }

    private func send() {
        let text = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        draft = ""; error = ""
        Task {
            do { try await jarvis.send(text) }
            catch { if draft.isEmpty { draft = text }; self.error = error.localizedDescription }
        }
    }
}

struct OperationsView: View {
    @ObservedObject var jarvis: Jarvis
    let page: Page
    let paths: [String]
    @State private var snapshot: [String: String] = [:]
    @State private var error = ""
    @State private var loading = false
    @State private var first = ""
    @State private var second = ""
    @State private var optedIn = false
    @State private var importing = false
    @State private var download: URL?
    @State private var busy = false

    var body: some View {
        List {
            if loading { ProgressView() }
            if !error.isEmpty { Text(error).foregroundStyle(.red) }
            if page == .tasks {
                Section("Auftrag anlegen") {
                    TextField("Titel", text: $first)
                    TextField("Beschreibung · mindestens 60 Zeichen", text: $second, axis: .vertical).lineLimit(3...8)
                    Button("Einreihen") { submit("/api/tasks", ["title": first, "prompt": second]) }
                        .disabled(first.trimmingCharacters(in: .whitespacesAndNewlines).count < 3 || second.trimmingCharacters(in: .whitespacesAndNewlines).count < 60 || busy)
                }
            }
            if page == .agents {
                Section("Agent registrieren") {
                    TextField("Name", text: $first)
                    TextField("HTTPS-Endpunkt", text: $second).keyboardType(.URL).textInputAutocapitalization(.never)
                    Toggle("Einwilligung zur Zusammenarbeit liegt vor", isOn: $optedIn)
                    Button("Registrieren") {
                        submit("/api/agents", ["name": first, "endpoint": second, "collaborationOptIn": true])
                    }.disabled(!optedIn || first.isEmpty || URLComponents(string: second)?.scheme != "https" ||
                               URLComponents(string: second)?.host == nil || busy)
                }
            }
            if page == .library {
                Section("Dateien") {
                    Button("Datei oder Bild speichern", systemImage: "square.and.arrow.up") { importing = true }.disabled(busy)
                    TextField("Eintrags-ID", text: $first).keyboardType(.numberPad)
                    Button("Datei abrufen", systemImage: "arrow.down.circle") {
                        guard let id = Int(first), id > 0 else { return }
                        prepareDownload(id)
                    }.disabled(Int(first) == nil || busy)
                    if let download { ShareLink(item: download) { Label("Datei teilen oder sichern", systemImage: "square.and.arrow.up") } }
                }
            }
            if page == .wallet {
                Section("Lightning-Empfang") {
                    TextField("Satoshis", text: $first).keyboardType(.numberPad)
                    TextField("Verwendungszweck", text: $second)
                    Button("Empfangsrechnung erstellen") {
                        guard let amount = Int(first), (1...100000).contains(amount) else { return }
                        submit("/api/lightning/invoices", ["amountSats": amount, "memo": second])
                    }.disabled(!(Int(first).map { (1...100000).contains($0) } ?? false) || busy)
                }
            }
            ForEach((paths + snapshot.keys.filter { !paths.contains($0) }.sorted()), id: \.self) { path in
                if let value = snapshot[path] {
                    Section(path) { Text(value).font(.system(.footnote, design: .monospaced)).textSelection(.enabled) }
                }
            }
        }
        .task(id: page) { await reload() }
        .refreshable { await reload() }
        .fileImporter(isPresented: $importing, allowedContentTypes: [.data]) { result in
            do {
                let url = try result.get()
                let access = url.startAccessingSecurityScopedResource()
                defer { if access { url.stopAccessingSecurityScopedResource() } }
                let data = try Data(contentsOf: url)
                guard !data.isEmpty && data.count <= 2_000_000 else { throw APIError("Dateigröße muss zwischen 1 Byte und 2 MB liegen.") }
                let type = UTType(filenameExtension: url.pathExtension) ?? .data
                submit("/api/library", ["kind": type.conforms(to: .image) ? "image" : "file",
                                       "title": url.lastPathComponent, "file_name": url.lastPathComponent,
                                       "mime_type": type.preferredMIMEType ?? "application/octet-stream",
                                       "content_base64": data.base64EncodedString()], showResponse: false)
            } catch { self.error = error.localizedDescription }
        }
    }

    private func reload() async {
        loading = true
        error = ""
        defer { loading = false }
        for path in paths {
            do { snapshot[path] = try pretty(await jarvis.call(path)) }
            catch { self.error = error.localizedDescription }
        }
    }

    private func submit(_ path: String, _ data: [String: Any], showResponse: Bool = true) {
        busy = true; error = ""
        Task {
            defer { busy = false }
            do {
                let response = try await jarvis.call(path, data)
                if showResponse { snapshot["Ergebnis"] = try pretty(response) }
                await reload()
            } catch { self.error = error.localizedDescription }
        }
    }

    private func prepareDownload(_ id: Int) {
        busy = true; error = ""
        Task {
            defer { busy = false }
            do {
                let response = try await jarvis.call("/api/library/\(id)/content")
                guard let item = response["item"] as? [String: Any], let encoded = item["content_base64"] as? String,
                      let data = Data(base64Encoded: encoded) else { throw APIError("Dateiinhalt fehlt.") }
                let name = ((item["file_name"] as? String) ?? "Datei").split(separator: "/").last.map(String.init) ?? "Datei"
                let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
                try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: false)
                let url = directory.appendingPathComponent([".", ".."].contains(name) ? "Datei" : name)
                try data.write(to: url, options: .atomic)
                download = url
            } catch { self.error = error.localizedDescription }
        }
    }
}

func pretty(_ data: [String: Any]) throws -> String {
    try String(decoding: JSONSerialization.data(withJSONObject: data, options: [.prettyPrinted, .sortedKeys]), as: UTF8.self)
}

struct NetworkView: View {
    @ObservedObject var jarvis: Jarvis
    @State private var status = "Bereit"
    @State private var running = false
    var body: some View {
        Form {
            Section("Öffentlicher Abruf") {
                Button("Tor und Coinbase-Status prüfen", systemImage: "network") { Task { await verify() } }.disabled(running)
                if running { ProgressView() }
                Text(status)
            }
            Section("Verbindungsregeln") {
                Text("Kontozugriffe, Orders und Zahlungen nutzen die direkte Verbindung.")
                Text("Regionaler VPN-Vergleich ist ohne freigegebenen Endpunkt offen.")
            }
        }
    }
    private func verify() async {
        running = true; status = "Verbindung wird geprüft …"
        defer { running = false }
        do {
            var response = try await jarvis.call("/api/network/tor", [:])
            for _ in 0..<60 {
                guard (response["result"] as? [String: Any])?["state"] as? String == "running" else { break }
                try await Task.sleep(for: .seconds(2))
                response = try await jarvis.call("/api/network/tor")
            }
            let result = response["result"] as? [String: Any]
            if result?["tor"] as? Bool == true {
                let exchange = result?["exchangeStatus"] as? String ?? "unavailable"
                let labels = ["none": "Normalbetrieb", "minor": "kleinere Störung", "major": "größere Störung",
                              "critical": "kritische Störung", "maintenance": "Wartung"]
                status = "Tor bestätigt · Coinbase: " + (labels[exchange] ?? "Status nicht verfügbar")
            } else if result?["state"] as? String == "running" {
                status = "Tor-Prüfung läuft noch."
            } else {
                status = "Tor-Verbindung konnte nicht bestätigt werden."
            }
        } catch { status = error.localizedDescription }
    }
}

struct FreeView: View {
    @ObservedObject var jarvis: Jarvis
    @State private var area = ""
    @State private var response = ""
    @State private var busy = false
    var body: some View {
        Form {
            Section("Öffentliche Gratisangebote") {
                TextField("Region oder Produktkategorie", text: $area)
                Button("Rechercheauftrag anlegen") {
                    busy = true
                    Task {
                        defer { busy = false }
                        do {
                            let result = try await jarvis.call("/api/tasks", ["title": "FreeGood · öffentliche Angebote",
                                "prompt": "Recherchiere öffentliche Gratisangebote für Deutschland in dieser Region oder Kategorie: \(area). Liefere Originalquellen, Fristen, Teilnahmevoraussetzungen und getrennte Nachweise für Artikelpreis und Versand von jeweils 0 EUR. Nur Recherche. Keine Registrierung, Bestellung, Nachrichten, personenbezogenen Daten oder Ausgaben."])
                            response = try pretty(result)
                        } catch { response = error.localizedDescription }
                    }
                }.disabled(busy || area.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                if !response.isEmpty { Text(response).textSelection(.enabled) }
            }
        }
    }
}

struct StudioView: View {
    @AppStorage("jarvis.studio.draft") private var draft = ""
    var body: some View {
        TextEditor(text: $draft)
            .font(.system(.body, design: .monospaced))
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding()
            .accessibilityLabel("Code-Entwurf")
            .toolbar {
                ShareLink(item: draft) { Label("Entwurf teilen", systemImage: "square.and.arrow.up") }.disabled(draft.isEmpty)
                Link(destination: URL(string: "https://github.com/s4ztz4bnf6-maker/Lubuimi-/tree/feat/jarvis-private-ios/JARVIS-Core/iOS")!) {
                    Label("Quellcode öffnen", systemImage: "arrow.up.right.square")
                }
            }
    }
}
