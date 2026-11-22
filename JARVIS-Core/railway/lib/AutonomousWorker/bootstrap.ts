import postgres from "postgres";
import { initializeAutonomousWorker } from "./init";

/**
 * Standalone worker identity bootstrap.
 * Does not replace the existing production worker event loop.
 * Run only after schema.sql has been applied to the target database.
 */
export async function bootstrapWorkerIdentity(env: Record<string, string | undefined> = process.env) {
  if (!env.DATABASE_URL) throw new Error("DATABASE_URL is required");
  const sql = postgres(env.DATABASE_URL, { max: 2, connect_timeout: 10 });
  try {
    const system = await initializeAutonomousWorker(sql, env);
    if (!system.github.configured) {
      console.log(JSON.stringify({
        component: "worker-identity",
        ready: false,
        reason: "missing_github_app_configuration",
        missing: system.github.missing,
      }));
      return { system, sql };
    }
    const github = system.registry.get("github");
    const connected = await github.beginConnect("jarvis-autonomous-worker", ["contents:read"]);
    const grant = connected.state === "connected" ? connected.grant : null;
    const readAllowed = grant ? await github.probe(grant, "read") : false;
    const writeAllowed = grant ? await github.probe(grant, "write") : false;
    console.log(JSON.stringify({
      component: "worker-identity",
      configured: true,
      authenticated: Boolean(grant),
      readAllowed,
      writeAllowed,
      note: "Write permission metadata is not proof of a successful write operation",
    }));
    return { system, sql };
  } catch (error) {
    await sql.end();
    throw error;
  }
}

if (import.meta.main) {
  bootstrapWorkerIdentity()
    .then(async result => {
      await result.sql.end();
      if (!result.system.github.configured) process.exitCode = 2;
    })
    .catch(error => {
      console.error("Worker identity bootstrap failed:", error instanceof Error ? error.message : "unknown error");
      process.exitCode = 1;
    });
}
