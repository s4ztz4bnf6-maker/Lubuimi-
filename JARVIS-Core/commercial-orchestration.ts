// DJO² commercial orchestration policy
export const COMMERCIAL_ORCHESTRATION = Object.freeze({
 stages:["discover","verify","accept","execute","test","deliver","invoice_if_required","reconcile_payment"],
 roles:["scraper","commercial_verifier","coder","formal_prover","quality_reviewer","submission_agent","billing_agent","payment_reconciler"],
 delegation:{enabled:true,chatGPTBridge:true,peerAgents:true,requireAuthorizedConnector:true,requireVerifiedDelivery:true,shareSecrets:false,publicPeersReceiveOnlyPublicTaskData:true},
 parallel:{processAllEligibleWithinCapacity:true,preventDuplicateClaims:true,checkpointEachStage:true},
 finance:{zeroSpend:true,receiveBTC:true,receiveFiat:true,paidOnlyAfterReconciliation:true},
 fallback:{retryOtherAuthorizedAgents:true,neverBypassPlatformAccessControls:true,recordBlocker:true}
} as const);
