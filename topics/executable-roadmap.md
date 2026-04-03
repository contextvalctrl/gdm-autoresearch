# GDM Epistemic Bond Layer — Executable Roadmap

**Maintainer:** Logan (ValCtrl AI — Chief of Staff)
**Issue:** VAL-459
**Run:** r074 (fine-tune and validate pass)
**Date:** 2026-04-03
**Inputs:** Synthesis of r001–r073 across all research tracks (Atlas, Scout, Lens, Sage, Echo)
**Purpose:** Convert the theoretical mechanism design into a time-sequenced, resource-tagged, risk-acknowledged execution plan.

---

## TL;DR

The GDM epistemic bond layer is ready to build. The mechanism is theoretically sound, academically novel, and economically validated. The remaining open questions are known and bounded — they do not block a v0 deployment.

**The executable idea, in one sentence:** A Layer 2 protocol on top of GestAlt's batch clearing that lets expert "knowers" post stake-backed belief updates on corporate earnings outcomes, routes those updates bilaterally to paying "unknowers," scores knowers on KL-divergence accuracy at settlement, and builds unforkable on-chain track records that compound into the mechanism's primary durable moat.

**Three numbers that anchor the plan:**
- **$150K** seed capital → first 50 credentialed knowers → organic flywheel within 3–6 months
- **4–6 weeks** to first statistically meaningful track record differentiation (corporate earnings domain)
- **~$1.8M/year** first-year SOM at $10/unit × 500 active coordinates (Lens r073)

---

## 1. What We're Building (Precise Scope)

### Layer 1 (prerequisite, not in scope here)
GestAlt batch clearing. Provides: epoch-based settlement, oracle resolutions (ω\*), front-run resistance. Layer 2 sits on top of this; it is not built in isolation.

### Layer 2 v0 (in scope: EpistemicBond v0)
A smart contract layer and off-chain coordination service that:

1. **Accepts knower claim submissions** — sealed commitments `hash(μ_i || k_i || nonce_i)` within each epoch window
2. **Reveals and aggregates claims at epoch close** — computes `S_public = Σ w_i · μ_i` using stake-influence and track-record weights
3. **Routes credentialed claim bundles to unknowers** who have paid fee `f` for access to `(μ_i, w_i)` pairs
4. **Settles at oracle resolution** — computes `R(μ_i, ω*) = k_i · [log μ_i(ω*) − log S_prev(ω*)]`, distributes rewards, slashes losers, updates `T_i`
5. **Maintains the on-chain track record registry** — the primary durable moat; immutable history of every knower's scoring performance

### What v0 explicitly does NOT include
- Full VCG fee structure (too complex for v0; competitive fee model is sufficient)
- Dynamic LOP/LogOP pool-type selection (LOP at launch; LogOP upgrade is Phase 2)
- Cross-domain track records or domain stratification (single domain: corporate earnings)
- AI agent API (Phase 2 after track records exist)
- L2 advisory signal feed to L1 (Phase 2; requires multi-epoch L1/L2 equilibrium proof first)

---

## 2. Build Sequence

### Phase 0: Infrastructure (Weeks 1–3)

**Goal:** Deploy the minimum viable smart contract layer on testnet.

| Task | Owner | Output |
|---|---|---|
| Implement EpistemicBond.sol: claim submission, epoch management, settlement | Engineering | Deployed testnet contract |
| Implement credibility weight function: `w_i = σ(α·T_i) · log(1 + k_i/k_0)` | Engineering | Auditable weight calculation |
| Implement sealed-commit / batch-reveal flow | Engineering | Front-run-resistant claim submission |
| Add non-refundable identity registration fee `c_id` | Engineering | Sybil cost floor (Atlas r073 Q1 requirement) |
| Integrate with Layer 1 oracle output (ω\* feed) | Engineering | Automated settlement trigger |
| Deploy on testnet with synthetic knower population | Engineering | Internal testing baseline |

**Hard requirement before Phase 1:** Identity registration fee must be in the contract. Per Atlas r073, the log-stake influence function is NOT Sybil-proof without it. This is not optional.

---

### Phase 1: Closed Knower Beta (Weeks 4–7)

**Goal:** Recruit 15 credentialed knowers, open 15 earnings coordinates, build the first 30 epochs of track records.

**Domain: Corporate earnings only.** Reasons: (a) highest epistemic asymmetry; (b) unambiguous oracle (SEC filing); (c) ~40 US earnings events/week; (d) institutional WTP benchmarked at $1,500–$2,000/hour via GLG; (e) Layer 1 anchoring works natively.

| Task | Owner | Output |
|---|---|---|
| Identify 15 credentialed analyst-tier knowers (ex-sell-side, alt-data providers) | BD/GTM | Knower cohort list |
| Deploy on mainnet (or production L1 testnet if L1 not yet live) | Engineering | Live contract |
| Seed subsidy: guarantee minimum `10 units/epoch` floor reward for first 30 epochs per knower | Protocol treasury | Knower participation lock-in |
| Open 15 earnings coordinates (mix of large-cap and mid-cap US equities) | Protocol team | Active coordinate set |
| No unknower fees yet — build track records only | — | Integrity of track record bootstrap |

**Exit criteria for Phase 1:**
- ≥10 knowers with ≥30 resolved predictions each
- At least 3 knowers with statistically distinguishable T_i from baseline (p < 0.05, binary outcomes)
- Zero evidence of Sybil clustering (monitor cross-claim correlation per §7.3 atlas attack models)

---

### Phase 2: Unknower Soft Launch (Weeks 8–16)

**Goal:** Introduce paying unknowers; validate willingness to pay; achieve first organic fee revenue.

| Task | Owner | Output |
|---|---|---|
| Invite 5–10 institutional unknowers (small event-driven hedge funds, quant shops) | BD/GTM | Beta unknower cohort |
| Charge 10 bps/epoch per credentialed claim bundle | Protocol | First fee revenue |
| Publish credibility weight leaderboard (public-facing) | Engineering | Trust signal + marketing |
| Monitor break points: ≥5 unknowers/coordinate maintained? Knower T_i tracking S_prev? | Product | Health metrics |
| Gather feedback on S_public vs. internal models (unknower survey) | BD | Product-market fit data |

**Fee structure at launch:**
- Base fee: 5 bps/epoch (floor; funded by protocol treasury if demand is thin)
- Performance premium: 0–25 bps/epoch based on top knower credibility tier
- Protocol take rate: 15% of fee revenue (95 bps goes to knower escrow; 5 bps to protocol)

**Minimum viable health thresholds:**
- ≥5 unknowers/coordinate across ≥50% of coordinates
- Knower mean yield ≥ 0.036%/day (DeFi opportunity cost floor)
- ≤3 oracle resolution disputes across all coordinates in 30 days

---

### Phase 3: Scale and Expansion (Weeks 17+)

**Goal:** 100+ coordinates, public onboarding, first cross-domain expansion.

| Milestone | Target |
|---|---|
| 100 active coordinates | Week 20 |
| 50+ knowers with verified track records | Week 20 |
| $100K/month fee revenue | Week 24 |
| Second domain (macro data: GDP, CPI, Fed funds rate) | Week 20–24 |
| AI agent API for tool-call-based claim access | Week 24–28 |
| L2 advisory signal pilot to L1 (with bounded coupling α) | After multi-epoch equilibrium proof |
| LOP → dynamic pool-type selector (LogOP for low-correlation pairs) | Week 28+ |

---

## 3. Protocol Parameters (v0 Defaults)

These are the concrete protocol constants for deployment. All are governance-adjustable post-launch.

| Parameter | Symbol | v0 Value | Rationale |
|---|---|---|---|
| Identity registration fee | `c_id` | 100 units (non-refundable) | ~10% of average honest w_i; Atlas r073 Sybil lower bound requirement |
| Reference stake | `k_0` | 100 units | Log-diminishing inflection point; prevents trivially small stakes from gaming |
| Credibility sigmoid sensitivity | `α` | 1.0 | Moderate sigmoid steepness; tune empirically after Phase 1 |
| Track record learning rate | `η` | 0.01 | Slow-moving credibility; prevents single-epoch manipulation |
| W_max (max credibility weight) | `W_max` | 0.25 | No single knower controls >25% of S_public |
| Minimum claim stake | `k_min` | 50 units | Prevents cheap-talk pollution |
| Epoch duration | — | 24 hours (daily) | Matches earnings release cadence; one resolution per active coordinate per epoch max |
| Holdback base | — | 30% of stake | 70% released at epoch close; 30% at oracle resolution |
| T_freshness window | — | 72 hours | Time from first-detectable to provisional install; staleness penalty applies beyond this |
| TOWL capacity thresholds | Zone A/B/C | 70% / 90% | r070 resolution; hard gates, no continuous discount |
| Fee rate (base) | `f_base` | 5 bps/epoch | Floor; protocol-subsidized if needed during bootstrap |
| Fee rate (performance) | `f_perf` | 0–25 bps/epoch | Premium for top credibility-tier knowers |
| Protocol take rate | — | 15% | 85% of fees flow to knower escrow |
| ε-smoothing for S_prev | `ε` | 0.001 | Avoids undefined log at zero-probability outcomes |
| Seed subsidy | — | 10 units/epoch floor | First 30 epochs for Phase 1 knowers; floor only, not bonus |

---

## 4. Critical Path Risks and Mitigations

### Risk 1: Knowers don't stake (supply-side failure)
**Probability:** Medium. Knowers face capital lockup risk with uncertain fee revenue during bootstrap.
**Mitigation:** Seed subsidy (10 units/epoch floor) + guaranteed minimum for first 30 epochs. If yield still insufficient, raise floor or lower minimum stake k_min.
**Kill condition:** If <10 knowers reach 30 resolved epochs after 8 weeks, pause Phase 2 and investigate.

### Risk 2: Unknowers don't pay (demand-side failure)
**Probability:** Medium-Low. Institutional willingness-to-pay is benchmarked ($1,500–$2,000/hour GLG analog), but GDM format is unfamiliar.
**Mitigation:** Frame as "verifiable analyst track record" product, not "prediction market." First 5 unknowers should be warm introductions with high tolerance for early-stage infrastructure.
**Kill condition:** If 0 paying unknowers after 4 weeks of soft launch, re-examine product positioning and fee structure.

### Risk 3: Knower accuracy not distinguishable from S_prev
**Probability:** Medium. If recruited knowers don't have genuine private signal, T_i stays flat and mechanism is vacuous.
**Mitigation:** Pre-screen knowers with a 10-question historical calibration test before onboarding. Only recruit those scoring ≥60% accuracy on historical earnings calls.
**Kill condition:** If <3 knowers show statistically distinguishable T_i after 30 epochs, the domain assumption is wrong — escalate to founders.

### Risk 4: Oracle manipulation (from §7.5)
**Probability:** Low in Phase 1 (corporate earnings have unambiguous resolution criteria — SEC filings). Higher in Phase 3 when domain expands.
**Mitigation:** For v0, restrict to binary earnings outcomes (beat/miss EPS) with unambiguous SEC resolution. Require multi-source oracle (primary: SEC EDGAR; backup: Bloomberg terminal feed).
**Protocol defense:** Require oracle bond > maximum observable knower stake. Set oracle liveness window to 48 hours post-earnings-release.

### Risk 5: L1 not live when Layer 2 is ready
**Probability:** Dependent on L1 roadmap. Layer 2 track records can still accrue using synthetic Layer 1 oracle outputs from a staging environment.
**Mitigation:** Run Phase 0–1 on a staging oracle (Chainlink price feeds or UMA OO as proxy) with explicit "testnet mode" disclaimer. Migrate to L1 oracle when live.

---

## 5. Minimum Viable Success Criteria (by Week 16)

These are the binary criteria that validate the idea is executable before committing to Phase 3 resources:

| Criterion | Target | Measured by |
|---|---|---|
| Supply bootstrapped | ≥10 knowers, ≥30 resolved predictions each | On-chain settlement records |
| Track record differentiation | ≥3 knowers with p < 0.05 vs. baseline at T_i | Statistical test on settlement history |
| Demand validated | ≥3 paying unknowers (not subsidized) | Fee payment records |
| Fee revenue positive | Protocol revenue > protocol subsidy outlay | Treasury accounting |
| No material Sybil clustering | No cross-claim correlation > 0.85 among top-5 knowers | Automated correlation monitor |
| No oracle resolution disputes | Zero escalations in 30-day window | Dispute registry |

If all 6 are green by Week 16: proceed to Phase 3 scale with confidence. If 2+ are red: pause, diagnose, pivot domain or fee structure.

---

## 6. What Remains Open (Do Not Block v0 On These)

These are known open items from r073. They are real, they matter long-term, but none block Phase 0–2.

| Open Item | Why It Doesn't Block v0 | Owner / Timeline |
|---|---|---|
| Correlation penalty formal proof (Q1 residual) | Identity registration fee provides Sybil floor without the proof; correlation monitoring runs in parallel | Atlas; post-Phase 1 |
| Multi-epoch L1/L2 equilibrium (Q2 residual) | L2 advisory → L1 coupling is Phase 3+; not in v0 scope | Atlas + Eng; post-Phase 2 |
| VCG welfare loss quantification (Q3 open) | Competitive fee structure is sufficient for v0; VCG is a theoretical optimization | Sage; post-Phase 2 |
| Regulatory analysis (US/EU/SG) | Phase 1 is closed beta with pre-screened institutional participants; regulatory exposure is minimal | Legal; parallel to Phase 1–2 |
| T_i calibration diagnostic vs. profitability signal | Acknowledged in docs; T_i is a profitability track record, not Dawid calibration score; this is fine for v0 | Documentation; pre-Phase 3 |

---

## 7. One-Page Pitch Version

**Problem:** Experts with private information can't monetize it as information — they can only bet on it (and their edge gets diluted into public price signals).

**Solution:** An epistemic bond market where experts stake capital on specific credentialed belief updates, route those updates bilaterally to paying consumers, and build unforkable on-chain track records that prove their accuracy over time.

**Why now:** Prediction markets reached $9B+ volume in 2024 (Polymarket alone). "Informed traders" netted $143M+ by extracting value from these markets — but they were paid only through directional accuracy, not for the information itself. There is a structural gap between what expert information is worth and what the current market structure pays for it.

**Why us:** GestAlt's batch clearing architecture is native infrastructure for this mechanism. Layer 1 epoch-based settlement is the oracle. The track record registry compounds as a time-locked moat no competitor can fork.

**First move:** Corporate earnings, closed beta, 15 knowers, 30 epochs. $150K seed capital. Organic flywheel in 3–6 months. First-year SOM: $1.8M/year.

**What success looks like:** Institutional buyers (hedge funds, event-driven strategies) paying for credentialed pre-earnings belief updates with verified track records — the GLG model, but automated, on-chain, and self-settling.

---

*This document supersedes all prior "roadmap" or "next steps" sections in the r073 corpus. It is the single canonical execution reference for GDM Layer 2 v0. All further research should update this document rather than creating new roadmap artifacts.*

*Logan — ValCtrl AI Chief of Staff | r074 | VAL-459*
