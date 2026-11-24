# JARVIS Quant & Trading Division

Status: RESERVED / DISABLED. Owner decision required before implementation or activation. Current operational priorities remain unchanged. This is an internal proposed business area, not a separate registered entity or verified revenue source.

## Scope
Research, historical backtesting, and automated paper trading on real public market data. Initial market: crypto spot; modular future equities, FX and other assets. No live broker integration, real orders, leverage, deposits, withdrawals, or financial credentials. No additional expenditure or paid feeds. No new scheduled jobs or services until separately approved.

## Architecture
Isolated market data ingestion with event timestamps, data quality and stale-feed checks; feature pipeline without future leakage; versioned strategy and model registry; deterministic risk engine independent of AI; simulated execution with fees, spreads, latency, liquidity, partial fills and slippage; separate virtual portfolio ledger; immutable audit events; research agents with bounded resources; dashboard explicitly marked simulation. Separate database namespace and credentials from operational revenue systems. Never book simulated P&L as revenue.

## Research and validation
Walk-forward and held-out tests, purged/embargoed validation where appropriate, realistic costs, benchmark comparisons, regime and stress tests, drawdown and risk-adjusted metrics, reproducible seeds and data snapshots. Track strategy selection bias and failed experiments. Continuous research is a future capability, not currently running. No guaranteed returns.

## Activation gates
Owner approval for paper-only implementation; tests for stale data, order idempotency, risk limits, ledger reconciliation and kill switch; zero additional spend verified before any runtime deployment. Any future live trading requires separate implementation, explicit approval, broker authorization and independent risk review. No automatic transition from paper to live.

## Handoff
Companion and worker should eventually expose read-only research status and simulated metrics. Until approved, do not enqueue trading tasks, deploy services or change existing workflows. Resume only on explicit owner instruction.
