const expected={agent_tasks:["id","title","prompt","status","attempt_count"],djo2_task_checkpoints:["id","task_id","attempt","step","phase","note"]};
export async function verifyCommercialSchema(sql){
 if(typeof sql!=="function"||typeof sql.begin!=="function")throw Error("COMMERCIAL_DATABASE_UNAVAILABLE");
 const rows=await sql`SELECT c.relname AS table_name,a.attname AS column_name,pg_catalog.format_type(a.atttypid,a.atttypmod) AS data_type FROM pg_catalog.pg_class c JOIN pg_catalog.pg_attribute a ON a.attrelid=c.oid WHERE c.oid IN (to_regclass('agent_tasks'),to_regclass('djo2_task_checkpoints')) AND a.attnum>0 AND NOT a.attisdropped`;
 for(const [table,columns] of Object.entries(expected)){
  for(const column of columns)if(!rows.some(r=>r.table_name===table&&r.column_name===column))throw Error("COMMERCIAL_SCHEMA_MISMATCH:"+table+"."+column);
 }
 if(rows.find(r=>r.table_name==="djo2_task_checkpoints"&&r.column_name==="note")?.data_type!=="text")throw Error("COMMERCIAL_SCHEMA_NOTE_NOT_TEXT");
 return true;
}
