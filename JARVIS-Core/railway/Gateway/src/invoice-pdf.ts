import PDFDocument from "pdfkit";
import { invoiceFooter } from "./invoice-footer";

export async function renderBankInvoicePdf(invoice:any, billingCountry:string, recipientAddress?:string):Promise<Uint8Array> {
 const doc=new PDFDocument({size:"A4",margin:48,info:{Title:"Invoice "+invoice.invoice_number,Author:"JARVIS AI AUTONOMOUS HOLDINGS LLC"}});
 const chunks:Uint8Array[]=[];
 const complete=new Promise<Uint8Array>((resolve,reject)=>{doc.on("data",(c:Uint8Array)=>chunks.push(c));doc.on("end",()=>resolve(Buffer.concat(chunks)));doc.on("error",reject);});
 const pageWidth=595.28, left=48, right=547, footTop=688;
 const footer=invoiceFooter(billingCountry);
 const amountMinor=Number(invoice.amount_minor);
 const currency=String(invoice.currency||"EUR");
 const amount=new Intl.NumberFormat("en-US",{style:"currency",currency}).format(amountMinor/100);
 const safe=(v:any,max=350)=>String(v??"").slice(0,max);
 doc.font("Helvetica-Bold").fontSize(19).fillColor("#172b4d").text("INVOICE",left,52);
 doc.font("Helvetica").fontSize(10).fillColor("#333333").text("JARVIS AI AUTONOMOUS HOLDINGS LLC",left,92);
 doc.fontSize(9).text("Republic of the Marshall Islands",left,107);
 doc.moveTo(left,135).lineTo(right,135).strokeColor("#dddddd").stroke();
 doc.font("Helvetica-Bold").fontSize(10).fillColor("#222222").text("Invoice number",left,154).text(safe(invoice.invoice_number,64),200,154);
 doc.text("Issue date",left,173).font("Helvetica").text(new Date(invoice.created_at||Date.now()).toISOString().slice(0,10),200,173);
 doc.font("Helvetica-Bold").text("Bill to",left,215);
 doc.font("Helvetica").fontSize(11).text(safe(invoice.customer_name,200),left,234,{width:470});
 if(recipientAddress)doc.fontSize(9).text(safe(recipientAddress,300),left,255,{width:470,height:50});
 doc.moveTo(left,320).lineTo(right,320).strokeColor("#dddddd").stroke();
 doc.font("Helvetica-Bold").fontSize(11).text("Description",left,334).text("Amount",430,334,{width:115,align:"right"});
 doc.font("Helvetica").fontSize(10).text(safe(invoice.description,800),left,362,{width:350,height:105,ellipsis:true});
 doc.font("Helvetica-Bold").fontSize(13).text(amount,412,362,{width:133,align:"right"});
 doc.moveTo(left,490).lineTo(right,490).strokeColor("#dddddd").stroke();
 doc.fontSize(15).fillColor("#172b4d").text("TOTAL DUE",left,508).text(amount,350,508,{width:195,align:"right"});
 doc.font("Helvetica-Bold").fontSize(11).fillColor("#222222").text("BANK TRANSFER",left,563);
 doc.font("Helvetica").fontSize(10).text("IBAN: "+safe(invoice.iban,40),left,584);
 doc.text("Payment reference: "+safe(invoice.invoice_number,64),left,601);
 doc.moveTo(left,footTop-12).lineTo(right,footTop-12).strokeColor("#dddddd").stroke();
 // Footer is deliberately tiny, but always within page boundaries.
 doc.font("Helvetica").fontSize(7).fillColor("#666666").text(footer.footer,left,footTop,{width:pageWidth-96,height:88,align:"left",lineGap:1,ellipsis:true});
 doc.font("Helvetica-Bold").fontSize(7).text(footer.companyLine,left,795,{width:pageWidth-96,align:"center"});
 doc.end();
 return complete;
}
