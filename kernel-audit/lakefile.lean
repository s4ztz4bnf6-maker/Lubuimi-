import Lake
open Lake DSL

package research_kernel_audit

require mathlib from git "https://github.com/leanprover-community/mathlib4.git" @ "v4.35.0"

@[default_target]
lean_lib ResearchKernelAudit where
  roots := #[
    `ResearchKernelAudit,
    `APW4CanonicalMajorization, `APW4DiagonalAudit, `APW4HistoricalCRTCore,
    `APW4IncidenceSecondMoment, `SyracuseUniformFibreBridge,
    `BBMSTArithmeticCRT, `BBMSTCodimOneAugmentation, `BBMSTCodimOneFamily,
    `BBMSTCodimOneReduction, `BBMSTCongruenceCRT, `BBMSTCoordinateStage,
    `BBMSTFiberMeasureCore, `BBMSTFiniteFibreUpdate, `BBMSTFiniteProjection,
    `BBMSTFiniteProjectionAudit, `BBMSTFiniteSieveStage, `BBMSTFiniteUnionBound,
    `BBMSTGeometryStageCore, `BBMSTHyperplaneFibreIncidence, `BBMSTMomentBridge,
    `BBMSTMomentRecurrence, `BBMSTOldShadow, `BBMSTPrefixCylinderMass,
    `BBMSTPrefixIncidenceBridge, `BBMSTPrefixMeasureRecursion,
    `BBMSTPrefixMomentBridge, `BBMSTPrimeCoordinateInstantiation,
    `BBMSTPrimeExtension, `BBMSTSieveAlignedCore, `BBMSTSieveStage,
    `BBMSTStageMomentCore, `BBMSTUniformFibreInstantiation,
    `BBMSTUniformStageMoment, `BBMSTWeightUpdate
  ]
