// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Local test fixture only; no external accounts or email delivery.
export function createTestMailbox() {
 const messages=[];
 return {
  deliver(message) {
   if(!message.correlationId || !message.recipientRef) throw new Error("missing test correlation");
   messages.push(structuredClone(message));
  },
  async find({recipientRef,after,correlationId}) {
   return messages.filter(m=>m.recipientRef===recipientRef&&m.correlationId===correlationId&&Date.parse(m.receivedAt)>=Date.parse(after)).map(m=>structuredClone(m));
  }
 };
}
