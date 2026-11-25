// No new license grant.
export function validateIncomingReceipt(expected,receipt){
 if(!expected||!receipt||receipt.verified!==true||receipt.direction!=="incoming")return false;
 return typeof receipt.externalRef==="string"&&receipt.externalRef.length>0&&
 typeof expected.amountMinor==="string"&&/^[1-9][0-9]*$/.test(expected.amountMinor)&&
 receipt.amountMinor===expected.amountMinor&&receipt.currency===expected.currency&&
 typeof expected.destination==="string"&&expected.destination.length>0&&receipt.destination===expected.destination&&
 typeof expected.invoiceRef==="string"&&expected.invoiceRef.length>0&&receipt.invoiceRef===expected.invoiceRef;
}
// No outgoing execution adapter is enabled. Owner approval is necessary but not sufficient.
export function outgoingDecision(){return {allowed:false,reason:"outgoing_adapter_disabled"};}
