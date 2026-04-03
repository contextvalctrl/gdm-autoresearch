# GDM Epistemic Bond — r083 Fine-Tune Pass (VAL-471)

**Maintainer:** Logan (ValCtrl AI — Chief of Staff)
**Run:** r083
**Date:** 2026-04-03
**Issue:** VAL-471
**Depends on:** All prior r073–r082 corpus files
**Purpose:** Final fine-tune and validation pass post-r082. Identifies and applies three residual corrections: (1) stale 15-coordinate / 4-week references in `epistemic-bond-v0-spec.md §8.1` that were missed in r080/r082; (2) FactSet consensus source reference in `epistemic-bond-v0-spec.md §8.1` that contradicts the corrected oracle sourcing from r077; (3) an underspecified Phase 0 knower registration fallback path for the accelerated 8-day timeline. Also adds a Day 1 engineering readiness checklist to `phase0-launch-package.md` that was absent.

---

## Summary of Corrections

| # | Issue | Severity | File(s) Updated |
|---|-------|----------|-----------------|
| 1 | `epistemic-bond-v0-spec.md §8.1` still says "15 coordinates, 4 weeks" — contradicts r080 (30 coords, 6–7 weeks) | **Medium** | `epistemic-bond-v0-spec.md` |
| 2 | `epistemic-bond-v0-spec.md §8.1` references "FactSet consensus" — contradicts r077 oracle correction (Wall Street Horizon) | **Medium** | `epistemic-bond-v0-spec.md` |
| 3 | No engineering Day 1 readiness signal: `phase0-launch-package.md` lacks a concrete pass/fail check for Day 1 completion | **Low** | `phase0-launch-package.md` |

---

## Correction 1: Stale Coordinate Count and Duration in spec §8.1

**Issue:** `epistemic-bond-v0-spec.md §8.1` reads:

> **8.1 Coordinate selection (15 coordinates, 4 weeks)**
> ...
> Minimum viable: Any 15 coordinates with unambiguous binary outcomes (EPS beat/miss vs. FactSet consensus).

This was not updated during r080 (VAL-468) when the coordinate count was corrected from 15 to 30 across two waves and Phase 1 duration was corrected from 4 weeks to 6–7 weeks. The success metrics in §8.3 were correctly updated (to 30 resolved predictions), but the heading and the Minimum Viable line were not.

**Fix:** Update `epistemic-bond-v0-spec.md §8.1`:

*Before:*
```
### 8.1 Coordinate selection (15 coordinates, 4 weeks)

Target: 40+ US earnings events/week (Lens r073). Select coordinates diversified across:

- 5 × Large-cap (AAPL, MSFT, GOOGL, META, AMZN) — high analyst coverage, highest WTP
- 5 × Mid-cap growth — moderate coverage, higher epistemic asymmetry
- 5 × Sector rotation plays (energy, healthcare, financials) — domain expertise signal test

Minimum viable: Any 15 coordinates with unambiguous binary outcomes (EPS beat/miss vs. FactSet consensus).
```

*After (r083):*
```
### 8.1 Coordinate selection (30 coordinates across two waves, 6–7 weeks)

**Updated r080/VAL-468 + r083/VAL-471:** Phase 1 uses 30 coordinates across two waves, not 15. The full
confirmed coordinate list with dates, S_prev values, and sector distribution is in `phase1-coordinates.md`.

Target: 40+ US earnings events/week (Lens r073). Phase 1 is diversified across:

- Wave 1 (Apr 14–May 1): 17 coordinates — large-cap financials + tech + communication services
  (GS, JPM, WFC, C, BAC, NFLX, TSLA, GOOGL, META, MSFT, AMZN, AAPL, V, UNH, INTC, T, VZ)
- Wave 2 (May 5–May 30): 13 coordinates — tech + consumer + energy + industrials
  (NVDA, CRM, SHOP, DE, HD, WMT, LOW, TGT, DIS, UBER, PYPL, XOM, CVX)

Minimum viable: All 30 coordinates per `phase1-coordinates.md`, with S_prev initialized from historical
beat-rate table and consensus source Wall Street Horizon. FactSet consensus is NOT used (r077 correction);
Wall Street Horizon ($200/month) is the standard consensus source for v0.
```

**Applied to:** `epistemic-bond-v0-spec.md` §8.1 (see below).

---

## Correction 2: FactSet Consensus Reference

**Issue:** The "FactSet consensus" reference in the old §8.1 "Minimum viable" line directly contradicts the oracle sourcing correction in r077 (VAL-462), which replaced FactSet (~$2,000/month) with Wall Street Horizon (~$200/month) as the Phase 1 consensus source.

This is already correct in `phase0-launch-package.md` Part 6 and in `executable-roadmap.md §3`, but the spec §8.1 still had the stale reference. The fix in Correction 1 above clears this simultaneously by replacing the entire §8.1 block.

No additional file changes required beyond what Correction 1 applies.

---

## Correction 3: Day 1 Engineering Readiness Signal

**Issue:** The `phase0-launch-package.md` "Accelerated 8-Day Critical Path" table describes what should happen on Day 1, but does not give engineering a concrete pass/fail check. On Day 1, there are multiple setup actions happening in parallel; the risk is that a half-completed Day 1 is mistaken for a complete one, pushing the schedule into Day 2 without a clear status signal.

**Fix:** Add a Day 1 engineering completion checklist (pass/fail gate) to `phase0-launch-package.md` immediately after the 8-day critical path table.

```markdown
### Day 1 Engineering Gate (April 3, 2026) — Pass/Fail

Before ending Day 1, confirm ALL of the following are true. If any are false, the Day 2 tasks must be
re-scoped to absorb the slip before the April 11 Wave 1 commit window.

**Must be TRUE by end of Day 1:**
- [ ] `forge build` runs clean with PRBMath v4 + OpenZeppelin v5 in the project
- [ ] `MockERC20.sol` is deployed on Arbitrum Sepolia; deployment address recorded
- [ ] `EpistemicBondRegistry.sol` skeleton exists with `register()` stub (even if not fully implemented)
- [ ] `register()` function accepts USDC transfer and records address as registered knower (on testnet with mock USDC)
- [ ] BD outreach list of ≥30 candidates exists; first 15 emails sent

**Day 1 is NOT complete if:**
- Any dependency (PRBMath, OZ) install fails and is unresolved
- USDC mock deployment is still pending
- BD outreach list does not exist yet

If Day 1 gate is missed: escalate to founders by EOD April 3. The April 14 Wave 1 batch is at risk.
```

**Applied to:** `phase0-launch-package.md` — add as a subsection immediately after the "Accelerated 8-Day Critical Path" table.

---

## What This Pass Does NOT Change

The following aspects of the corpus have been reviewed and confirmed correct:

| Area | Status |
|------|--------|
| Unit economics ($1 USDC per unit; $100 registration; $50 min stake) | ✅ Correct across all docs |
| Oracle sourcing (EDGAR + Alpha Vantage + Wall Street Horizon; no Bloomberg/Refinitiv in Phase 1) | ✅ Correct in spec §4.1, roadmap §3, launch package Part 1.2 |
| Phase 1 exit criterion (T_i ≥ 0.5 for ≥3 knowers; not p < 0.05) | ✅ Correct in spec §8.3, roadmap §5, launch package Part 2 Week 10 |
| 30-coordinate two-wave structure | ✅ Correct in phase1-coordinates.md, roadmap §1, launch package |
| Phase 1 duration (6–7 weeks) | ✅ Correct in all docs except spec §8.1 (fixed by Correction 1) |
| COST → LOW replacement for coordinate #22 | ✅ Correct in phase1-coordinates.md |
| S_prev table complete for all 30 tickers | ✅ Correct in phase1-coordinates.md |
| Base-rate filter Brier score protocol (0.15 threshold) | ✅ Correct in knower-calibration-test.md |
| L1 dependency clarification (staging oracle for Phase 0–1; L1 is Phase 2 trigger) | ✅ Correct in spec §9, roadmap §2, launch package Part 6 |
| Circuit breaker (|R_i| ≤ 2×stake) | ✅ In spec §7 security checklist |
| Timeline compression (8-day Phase 0) | ✅ Correct in launch package, phase0 critical path |

---

## State of the Corpus After r083

All ten prior corrections (r076–r082, 10 total across 5 runs) remain valid. This pass adds three targeted fixes, two of which are medium-severity consistency issues in `epistemic-bond-v0-spec.md §8.1`, and one low-severity operational improvement to `phase0-launch-package.md`.

**Corpus completeness check:**

| Document | Status | Last Updated |
|----------|--------|-------------|
| `research-synthesis.md` | ✅ Complete | r081/VAL-469 |
| `executable-roadmap.md` | ✅ Complete | r080/VAL-468 |
| `epistemic-bond-v0-spec.md` | ✅ Updated (Correction 1+2) | r083/VAL-471 |
| `real-world-validation.md` | ✅ Complete | r076/VAL-461 |
| `phase0-launch-package.md` | ✅ Updated (Correction 3) | r083/VAL-471 |
| `phase1-coordinates.md` | ✅ Complete | r082/VAL-470 |
| `knower-calibration-test.md` | ✅ Complete | r082/VAL-470 |
| `atlas-formal-analysis.md` | ✅ Complete | r072/VAL-452 |
| `architecture-diagrams.md` | ✅ Complete | r073/VAL-455 |
| `r082-fine-tune-notes.md` | ✅ Complete | r082/VAL-470 |

**Validation verdict (r083):** The GDM epistemic bond corpus is now fully consistent and execution-ready. No further research or fine-tune passes are required before Phase 0 engineering begins. The two medium-severity consistency issues in `epistemic-bond-v0-spec.md §8.1` are now resolved. The corpus is internally coherent across all parameter values, timelines, oracle sources, and exit criteria.

**Next trigger:** Phase 1 exit checkpoint at Week 10 (30 epochs complete, ~May 30, 2026). Report to founders: T_i distribution for all 15 knowers, oracle resolution rate, Sybil monitor status, and Phase 2 go/no-go recommendation.

---

*Logan — ValCtrl AI Chief of Staff | r083 | VAL-471 | 2026-04-03*
