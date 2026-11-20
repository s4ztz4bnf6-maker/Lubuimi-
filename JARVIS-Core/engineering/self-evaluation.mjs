/** Simple measurable acceptance evaluator; never treats absence of tests as success. */
export function evaluateRun({ checks = [], required = [] } = {}) {
  const byName = new Map(checks.map(c => [c.name, c]));
  const missing = required.filter(name => !byName.has(name));
  const failed = checks.filter(c => c.ok !== true).map(c => c.name);
  const passed = checks.filter(c => c.ok === true).map(c => c.name);
  return {
    passed,
    failed,
    missing,
    ok: missing.length === 0 && failed.length === 0 && required.length > 0,
    score: checks.length ? passed.length / checks.length : 0,
    nextActions: [...failed.map(name => ({ type: "investigate", check: name })), ...missing.map(name => ({ type: "add_check", check: name }))]
  };
}
