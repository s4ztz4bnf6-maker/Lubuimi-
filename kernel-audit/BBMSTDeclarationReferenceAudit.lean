import Lean
import BBMSTPrefixMeasureRecursion

open Lean Elab Command

private def isProjectDecl (n : Name) : Bool :=
  let s := n.toString
  s.startsWith "BBMST" || s.startsWith "APW4"

run_cmd do
  let env ← getEnv
  let targets : List Name := [
    ``BBMSTPrefixMeasure.prefixFibre_updatedWeight_eq_PAt,
    ``BBMSTPrefixMeasure.PAt_nonneg,
    ``BBMSTPrefixMeasure.PAt_sum_eq_one,
    ``BBMSTPrefixMeasure.PAt_succ_le_prev_div_card_mul_one_sub_delta,
    ``BBMSTPrefixMeasure.PAt_le_initial_mul_distortionProduct
  ]
  let mut pending := targets
  let mut visited : NameSet := {}
  logInfo "GRAPH_FORMAT|BBMST_DIRECT_REFERENCE_AUDIT_V1"
  logInfo "SOURCE_POSITION_STATUS|NOT_MEASURED_BY_GETUSEDCONSTANTS"
  while !pending.isEmpty do
    let d := pending.head!
    pending := pending.tail!
    if !visited.contains d then
      visited := visited.insert d
      match env.find? d with
      | none =>
          logInfo m!"DECL|{d}|ZIELDEKLARATION_FEHLT"
      | some info =>
          let typeRefs := info.type.getUsedConstantsAsSet
          let valueRefs :=
            match info.value? (allowOpaque := true) with
            | some value => value.getUsedConstantsAsSet
            | none => ({} : NameSet)
          let kind := match info with
            | .axiomInfo _ => "AXIOM"
            | .thmInfo _ => "THEOREM"
            | .defnInfo _ => "DEFINITION"
            | .opaqueInfo _ => "OPAQUE"
            | .quotInfo _ => "QUOTIENT"
            | .inductInfo _ => "INDUCTIVE"
            | .ctorInfo _ => "CONSTRUCTOR"
            | .recInfo _ => "RECURSOR"
          let valueStatus :=
            if info.value? (allowOpaque := true) |>.isSome then
              "WERT_VERFÜGBAR"
            else if kind == "AXIOM" then
              "WERT_ERWARTET_NICHT_VORHANDEN"
            else
              "WERT_NICHT_VERFÜGBAR"
          logInfo m!"DECL|{d}|VERFÜGBAR|{kind}|{valueStatus}|type_sorryAx={typeRefs.contains `sorryAx}|value_sorryAx={valueRefs.contains `sorryAx}|declaration_position=NICHT_GEMESSEN"
          for r in typeRefs.toList do
            logInfo m!"REF|{d}|T|{r}|reference_positions=NICHT_GEMESSEN"
            if isProjectDecl r && !visited.contains r then
              pending := r :: pending
          for r in valueRefs.toList do
            logInfo m!"REF|{d}|V|{r}|reference_positions=NICHT_GEMESSEN"
            if isProjectDecl r && !visited.contains r then
              pending := r :: pending
