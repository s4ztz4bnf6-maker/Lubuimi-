// Fail closed until an independently verified complete migration inventory exists.
// No caller-provided flag or current identity lookup can authorize delivery.
export async function executeAuthorizedGitHubDelivery(){
 throw Error("MIGRATION_LOCKED_INCOMPLETE_HISTORY");
}
