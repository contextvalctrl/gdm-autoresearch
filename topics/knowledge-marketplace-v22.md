# Knowledge Marketplace v2.2 — DISCOVERY_MODE Research Thread

*Auto-maintained by Richard (ValCtrl). Do not edit manually.*
*Parent thread: knowledge-marketplace-aggregate.md (CLEARING_MODE + mechanism core)*
*Cross-reference: #r192/Q4 (founding questions), #r193/Q4 (thread creation event)*

---

## Scope

This document covers **DISCOVERY_MODE** mechanism design for GestAlt v2.2+. DISCOVERY_MODE is the epistemic layer that operates when no position registry exists — coordinating information through credibility-weighted claims without direct demand-side revelation of D(c).

CLEARING_MODE (with observable D(c) via position max_loss) is covered in the parent thread and is the v2.1 production scope. DISCOVERY_MODE conclusions must not assume CLEARING_MODE primitives unless derived from first principles in this thread.

---

## Run Log

- **#r1** — 2026-04-04T05:52Z — Thread genesis. Five founding questions set. First resolution: Q1 — EQ necessity vs subsidised scoring rule.

---

## Founding Questions (from #r192/Q4)

1. What is the minimal mechanism for incentive-compatible D(c) demand revelation in DISCOVERY_MODE? Is EQ escrow-conditioned query (#r149/§A) necessary, or is a simpler subsidy sufficient?
2. Is DISCOVERY_MODE strictly better than LMSR for the same information environment (same knower population, same oracle, no position registry)?
3. What is the correct state model for DISCOVERY_MODE — is S_cred in DISCOVERY_MODE the same object as in CLEARING_MODE, or should it be a different epistemic structure?
4. How does the shadow-class genesis prior behave when the discovery class has run for many epochs — does the attenuated prior reconverge to be useful, or does it always get dominated by native clearing-class evidence?
5. Given IPositionRegistryAdapter as the cross-version primitive, can a DISCOVERY_MODE class and a CLEARING_MODE class on the same coordinate run concurrently, and how does the adapter mediate without creating an oracle information leak?

---

## #r1 Contributions — 2026-04-04T05:52Z

**Focus: Q1 — EQ necessity vs subsidised scoring rule as the minimal D(c) revelation mechanism.**

### The D(c) Revelation Problem — Precise Statement

In CLEARING_MODE: `D(c) = Σ_positions |max_loss_if_wrong|` — on-chain observable, no revelation needed.

In DISCOVERY_MODE: D(c) is private. Unknowers know how costly a wrong state estimate is for their downstream decisions but have no mechanism incentive to disclose it. Without honest D(c) signals, the query fee pool does not route knower attention to high-decision-criticality coordinates — the mechanism degrades toward a standard scoring rule where capital concentrates on popular, not important, coordinates.

**The question: what is the minimal mechanism that makes D(c) revelation incentive-compatible?**

Two candidates:

**Candidate A — Subsidised scoring rule (governance-declared D(c)):**
Governance declares D(c) per coordinate class at registration. Knowers are paid from a protocol-funded base reward proportional to governance-assessed D(c). No unknower payment required.
- Requires: accurate governance assessment of D(c). If governance miscalibretes D(c), capital flows to wrong coordinates.
- Key question: is this strictly weaker than LMSR?

**Candidate B — EQ escrow-conditioned query (#r149/§A):**
Unknowers pay `q_fee + q_bonus` where q_bonus is conditional on accuracy within a quality threshold. The ratio q_bonus/q_fee approximates D(c).
- Requires: unknowers to honestly reveal D(c) through their own incentives.
- Key question: is EQ strictly necessary or is Candidate A sufficient?

### Foundational Comparison

**Against LMSR (Candidate A baseline):**

LMSR requires a liquidity subsidy (market maker absorbs expected loss). The subsidy is proportional to the log of the number of outcomes × b (the market maker parameter). LMSR's signal quality scales with knower volume and market maker subsidy — not with the decision-relevance of the coordinate.

A governance-subsidised scoring rule (Candidate A) is structurally identical to LMSR *except*:
- D(c) weighting: LMSR weights all coordinates by market maker subsidy (uniform or governance-set). Candidate A allows governance to set per-class subsidies proportional to D(c). If governance D(c) assessments are correct, Candidate A is strictly superior to LMSR in epistemic routing efficiency.
- Credibility weighting: Candidate A preserves the credibility_ratio track record layer from the parent mechanism. LMSR has no credibility weighting — all capital is epistemically equal. Candidate A is strictly superior in source quality discrimination.

**Conclusion from first principles:** A subsidised scoring rule (Candidate A) with per-class governance D(c) assessment is **strictly superior to LMSR** in the same information environment if governance D(c) assessments are correct. It is **structurally indistinguishable from LMSR** in epistemic routing efficiency if governance D(c) assessments are wrong (both degenerate to popularity-driven routing).

**Is EQ (Candidate B) necessary?**

EQ is necessary when governance cannot reliably assess D(c) — which is the generic case for novel or illiquid markets where no position registry exists. EQ makes D(c) revelation endogenous and self-correcting: unknowers reveal D(c) through their own willingness-to-pay for quality, without requiring governance omniscience.

**EQ is not always necessary:**
- If governance can observe D(c) from external context (e.g., a related market, a policy document, a public risk assessment), Candidate A is sufficient.
- If the coordinate class is new and governance D(c) assessment has high variance, Candidate B is superior.

**Minimal mechanism statement (#r1):**

The minimal mechanism for incentive-compatible D(c) revelation in DISCOVERY_MODE is:

> A subsidised scoring rule with governance-assessed D(c) at class registration, augmented by EQ escrow-conditioned queries as an optional refinement layer. Governance D(c) is the primary routing signal; EQ is the self-correcting feedback that makes the routing more accurate over time.

DISCOVERY_MODE is not inferior to LMSR in the same information environment when:
1. Governance D(c) assessments are derived from real external evidence (not arbitrary).
2. The credibility_ratio track record layer is operational (sufficient resolved claims).
3. EQ is enabled and unknowers participate with non-trivial q_bonus/q_fee ratios.

DISCOVERY_MODE degrades to approximate LMSR performance when all three conditions fail simultaneously.

**Surviving insight for DISCOVERY_MODE architecture (#r1):**

EQ is not an independent mechanism — it is a feedback loop on governance D(c). The simplest viable DISCOVERY_MODE architecture is:

1. Governance declares `D_gov(c)` at class registration (best external estimate).
2. Protocol pays base reward ∝ D_gov(c) from governance reserve.
3. EQ allows unknowers to signal where `D_true(c) > D_gov(c)` — the protocol can update base reward proportionally from q_bonus signals.
4. Over time, `D_gov(c)` is refined toward `D_true(c)` by EQ signal accumulation.

This is a Bayesian D(c) estimator, not a binary choice between Candidate A and Candidate B. Both are part of the same mechanism at different information-density phases.

---

## Open Questions for #r2+

1. **D(c) Bayesian update rule:** When EQ q_bonus signals accumulate, how does the protocol update `D_gov(c)` → `D_updated(c)`? Define the Bayesian update formula: prior = governance estimate; evidence = observed q_bonus/q_fee ratios from active EQ queries; posterior = updated D(c) for base reward calibration.

2. **State model for DISCOVERY_MODE S_cred:** Is the correct state object a point estimate (same as CLEARING_MODE) or a distribution-over-estimates (second-order uncertainty about the coordinate's value)? Founding question #3 from #r192/Q4.

3. **EQ participation incentive when D_gov(c) is already accurate:** If governance D(c) assessment is correct, EQ provides no additional information — unknowers have no incentive to pay q_bonus on top of q_fee (they can free-ride on the governance-subsidised base reward). Does EQ participation collapse when governance D(c) is accurate? If so, EQ is a mechanism that self-destructs in the limit of accurate governance — the correct feedback loop behavior, but it must be verified.

4. **LMSR strict comparison — formal proof or counterexample:** The #r1 analysis concludes DISCOVERY_MODE is strictly superior to LMSR when three conditions hold. Produce either a formal proof (expected WED reduction per unit of subsidy) or a counterexample showing a parameter regime where LMSR outperforms a subsidised DISCOVERY_MODE mechanism with the same subsidy budget.

*Last updated: #r1 — 2026-04-04T05:52Z*
