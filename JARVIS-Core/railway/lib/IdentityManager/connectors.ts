/**
 * Provider-neutral connector contracts. A connector can register/login through
 * official OAuth or API flows and perform scoped read/write operations.
 * Provider credentials are never stored in the identity registry.
 */
export type ConnectionState = "disconnected" | "authorization_required" | "connected" | "expired";
export type ProviderGrant = Readonly<{
  provider: string;
  accountId: string;
  scopes: readonly string[];
  expiresAt?: string;
}>;
export type PendingAuthorization = Readonly<{
  state: "authorization_required";
  authorizationUrl: string;
  requestId: string;
  instructions?: string;
}>;
export type ConnectResult =
  | Readonly<{ state: "connected"; grant: ProviderGrant }>
  | PendingAuthorization;

export interface SecretVault {
  /** Stores credentials encrypted or via an external secret manager; never log values. */
  put(ref: string, value: string): Promise<void>;
  get(ref: string): Promise<string | null>;
  delete(ref: string): Promise<void>;
}
export interface PlatformConnector {
  readonly provider: string;
  /** Start official provider auth. May require user-mediated login/MFA. */
  beginConnect(identityId: string, requestedScopes: readonly string[]): Promise<ConnectResult>;
  /** Complete a provider callback and persist credentials in the vault. */
  completeConnect(requestId: string, callback: Record<string, string>): Promise<ProviderGrant>;
  /** Verify permissions with the provider; metadata alone is not proof. */
  probe(grant: ProviderGrant, operation: "read" | "write"): Promise<boolean>;
  /** Perform a provider-specific operation with validated scope and arguments. */
  execute(grant: ProviderGrant, operation: string, args: Record<string, unknown>): Promise<unknown>;
  disconnect(grant: ProviderGrant): Promise<void>;
}
export class ConnectorRegistry {
  private readonly connectors = new Map<string, PlatformConnector>();
  register(connector: PlatformConnector): void {
    if (!/^[a-z][a-z0-9_-]{1,63}$/.test(connector.provider)) throw new Error("Invalid provider");
    if (this.connectors.has(connector.provider)) throw new Error("Duplicate provider");
    this.connectors.set(connector.provider, connector);
  }
  list(): string[] { return [...this.connectors.keys()].sort(); }
  get(provider: string): PlatformConnector {
    const connector = this.connectors.get(provider);
    if (!connector) throw new Error(`Unsupported provider: ${provider}`);
    return connector;
  }
}
