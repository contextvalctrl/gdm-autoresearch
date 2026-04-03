# GDM Epistemic Bond: From Research to Real-World Executable Plan

**Maintainer:** Logan (ValCtrl AI — Chief of Staff)
**Last updated:** 2026-04-03
**Issue:** VAL-458
**Parent:** VAL-450 (fundamental analysis), VAL-455 (cross-agent synthesis)
**Scope:** Translating r001–r073 theoretical research into a concrete, time-bound, prioritized execution plan.

---

## TL;DR

The research is done. The mechanism is theoretically sound, genuinely novel, and market-validated. The next 90 days should produce a live closed beta on corporate earnings with 10+ credentialed knowers and 5+ institutional unknowers. The remaining open formal questions (Sybil correlation penalty proof, multi-epoch L1/L2 equilibrium) should be pursued in parallel — they are not launch blockers.

---

## 1. What We Know (Research Confidence Summary)

| Claim | Confidence | Evidence Base |
|---|---|---|
| Mechanism is IC under truth-telling | Very High | Atlas r072 Q6 formal proof; proper scoring rule literature (Sage r073) |
| No existing production analog | High | Scout r073 comprehensive competitive survey |
| Bootstrap solvable via Layer 1 + earnings domain | High | Lens r073 economics; Layer 1 oracle resolutions eliminate manufactured-demand problem |
| Sybil requires identity registration fee | High | Atlas r072 Q1 formal lower bound |
| IC is robust to oracle noise (not bias) | High | Atlas r072 Q6 |
| First-year SOM at $10/unit, 500 coords | Medium | Lens r073 sensitivity analysis |
| Track record history is primary durable moat | High | Lens r073 §4; confirmed unforkable time-locked asset |
| Corporate earnings is optimal first domain | High | Lens r073 domain scoring; all 4 criteria highest |

---

## 2. What Must Be Decided Before Writing Code

### 2.1 Protocol constants (required before spec)

These are governance choices, not engineering choices. They must be decided by Sarthak/Gaurav with ValCtrl.

| Parameter | What it controls | Recommended range | Research basis |
|---|---|---|---|
| `k_0` | Log-diminishing stake normalization reference | 100–1,000 protocol units | r071 §4.1 |
| `α` (credibility sigmoid steepness) | How sharply track record converts to weight | 0.1–1.0 | r071 §4.1 |
| `η` (track record update rate) | How fast T_i responds to new resolutions | 0.01–0.1 per epoch | r071 §4.2 |
| `c_id` (identity registration fee) | Sybil attack floor cost per identity | ≥ 10% of avg honest w_i | Atlas r072 Q1 |
| `TOWL thresholds` (Zone A/B/C) | Solvency gate trigger points | 70%/90% | r070 |
| `T_freshness` window | Detection staleness penalty window | Domain-specific (24h for earnings) | r070 |
| `holdback_base` | Fraction of reward withheld pending oracle | 20–40% | r069/r070 |
| `ε` (prior smoothing) | Zero-probability outcome smoothing | 1e-6 to 1e-3 | r071 §5.1 |
| `α_max` coupling coefficient | Max L1/L2 coupling to prevent circular self-dealing | Derived from Layer 1 price function | Atlas r072 Q2 |

**Action required:** ValCtrl to schedule a 90-minute parameter calibration session. Logan to prep a parameter worksheet by EOD this week.

### 2.2 Domain configuration (required before pilot launch)

- Confirm corporate earnings as the pilot domain ✓ (Lens r073 recommends; pending Sarthak sign-off)
- Select initial ticker set (recommended: 10–15 large-cap US equities with high institutional coverage, quarterly earnings, clean EPS consensus)
- Define resolution oracle source (SEC EDGAR filings for quarterly EPS + revenue; unambiguous, no-dispute)
- Define coordinate schema for earnings (value: EPS; precision_class: T2 default; applicability_domain: published consensus window ±15%)

### 2.3 Legal review (required before any public-facing launch)

Scout r073 flags CFTC risk. Before any real-money beta:
- Engage legal counsel to classify the fee-for-credentialed-claim model under US CFTC definitions
- Determine whether scoring reward constitutes a "swap" under CFTC Part 32
- Review EU MiFID II applicability for institutional unknowers
- Singapore MAS guidance for digital asset information services

**This is a hard blocker before real-money public launch. Closed beta with accredited investors may be lower-risk.**

---

## 3. The Concrete 90-Day Plan

### Phase 0: Week 1–2 — Spec and Recruit

**Deliverables:**
1. **Protocol Spec v0.1** — translate r071–r073 into an engineer-readable spec document covering:
   - State model (S_prev, S_public, claim tuple, epoch discipline)
   - Scoring function (log-score relative to prior, proof of IC)
   - Credibility weight function (stake influence + track record sigmoid)
   - TOWL accounting (separate ledger from challenge pool)
   - Provisional install protocol (two-component staleness)
   - Settlement model (hard + soft resolution paths)
   - Identity registration fee and Sybil-resistance design
   - Query contract schema (r069 demand manifest)
2. **Parameter worksheet** — all governance constants listed in §2.1, with recommended ranges and rationale, ready for ValCtrl decision session
3. **Knower recruitment list** — identify 15 target seed knowers:
   - Former sell-side analysts with verifiable public earnings accuracy records (FactSet estimates history, Bloomberg survey contributors)
   - Alt-data providers (Pyth publishers, supply chain analytics firms) who already have Polygon/USDC infrastructure
   - Quantitative hedge fund desks willing to participate in a closed beta for track record building
   - Target: 10 confirmed, credentialed, tech-ready knowers signed up before week 3

**Owner:** Logan (spec, worksheet); Sarthak/Gaurav (knower outreach, parameter decisions, legal triage)

---

### Phase 1: Weeks 3–6 — Closed Knower Beta (Layer 1 Anchored)

**What gets built:**
- Smart contract or off-chain settlement ledger for:
  - Claim submission (sealed, batch per epoch)
  - Track record accumulation
  - Scoring at epoch settlement using Layer 1 oracle outcomes
  - TOWL accounting
- **No real-money unknower access yet** — this phase is purely knower-side, building track records
- Oracle feed: Layer 1 batch clearing on selected earnings coordinates provides resolution (ω*)

**Success criteria for Phase 1:**
- ≥ 10 active knowers filing claims each epoch
- ≥ 30 resolved epochs across the cohort (approx. 3–4 weeks at 40 US earnings events/week)
- Track record divergence observable: top 3 knowers' T_i meaningfully above median T_i (p < 0.05)
- Zero identity registration fee gaming (validate c_id calibration)
- TOWL accounting correct and auditable

**What this phase validates:**
- Engineers' implementation of the scoring rule matches the formal proof
- Knowers actually file truthfully (IC in practice, not just theory)
- Track record differentiation is fast enough (3–4 weeks vs. theoretical minimum)

---

### Phase 2: Weeks 7–12 — Unknower Soft Launch

**Who gets invited:**
- 5–10 institutional unknowers: small event-driven hedge funds, earnings-focused quant shops
- Access priced at 10 bps/epoch per credibility-weighted claim bundle (5 bps floor + 5 bps performance premium for T_i > threshold)
- All access via signed bilateral agreements; accredited investors only (reduces legal risk)

**What unknowns need to validate:**
- Do unknowers find the S_public updates informative vs. public consensus (Bloomberg estimate)?
- What WTP do they demonstrate? (Compare to GLG $1,500–$2,000/hr benchmark)
- What coordinates drive highest fee demand? (Signals where to expand first)
- Are there friction points in the query contract UX? (r069 schema broker role may need tooling)

**Success criteria for Phase 2:**
- ≥ 5 active unknowers paying fees per epoch
- Fee revenue per epoch ≥ 250 units (50% of Lens r073 baseline SOM)
- Zero oracle manipulation incidents (validates oracle bonding design)
- Unknower NPS ≥ +20 (structured feedback sessions post each epoch)

---

### Phase 3: Week 13+ — Parameterize for Scale

Following Phase 2 validation, expand:
- Widen ticker set to 50+ earnings coordinates
- Open knower pool to application (vs. hand-curated seed)
- Launch credibility leaderboard (public-facing trust signal; drives organic knower recruitment)
- Expand to domain 2 (recommended: US macro data — GDP, CPI, FOMC decisions; lower frequency but high institutional WTP)
- Build AI agent integration layer (per Scout r073: MCP-compatible query contract interface; targets the emerging AI agent information market)

---

## 4. Parallel Research Work (Non-Blockers, but Needed Before Scale)

These open items from the Atlas/Sage/Lens/Scout tracks should proceed in parallel with Phase 1–2, not gate them.

| Item | Owner | Target completion | Why not a launch blocker |
|---|---|---|---|
| Formal proof of correlation penalty effectiveness (Q1 residual) | Atlas | Before Phase 3 (not Phase 1) | Phase 1 is closed beta; Sybil attack not practical at seed scale |
| Multi-epoch L1/L2 equilibrium (Q2 residual) | Atlas + Engineering simulation | Before Phase 3 | Static-epoch coupling condition sufficient for closed beta |
| VCG welfare loss quantification (Sage open item 3) | Sage | Research only; not an implementation item | Competitive pricing is adequate for MVP |
| Dynamic LOP/LogOP selector (Sage open item 4) | Protocol R&D | 6+ months out | LOP is conservative and correct for bootstrap phase |
| T_i calibration diagnostic (separate from weighting) | Engineering | Phase 2 | Useful for unknower transparency, not a settlement blocker |
| Legal analysis (US/EU/SG) | External counsel | Before Phase 2 public | Phase 1 closed knower beta is lower risk; get legal engagement started in Week 2 |

---

## 5. What a "Done" Looks Like for This Issue

This issue (VAL-458) closes when:
1. Protocol Spec v0.1 is drafted and reviewed by Sarthak/Gaurav
2. Parameter calibration session is scheduled with a concrete decision on all governance constants
3. Knower recruitment list of 15 targets is assembled with contact information and availability
4. Legal engagement initiated (counsel selected and briefed)
5. Phase 0 deliverables are complete and Phase 1 engineering scoping is drafted

The concrete executable roadmap is now defined. Execution starts with the spec and recruitment in Week 1.

---

## 6. What This Is Not

This roadmap is not:
- An academic whitepaper (that's Sage's output track, in parallel)
- A token launch or tokenomics design (Layer 1 handles this; Layer 2 fees can be denominated in existing Layer 1 token)
- A full GestAlt integration spec (the L1/L2 interface spec is a separate engineering deliverable)
- A market-maker system (no MM required; the mechanism is self-sustaining if the knower population is seeded correctly)

---

## 7. Key Risks and Mitigations

| Risk | Probability | Severity | Mitigation |
|---|---|---|---|
| Knowers won't stake without track record | High | High | Seed subsidy (5–10 units/epoch floor guarantee for first 30 epochs); hand-curate trusted knowers who understand the mechanism |
| Earnings oracle disputed (SEC filing clarification required) | Medium | Medium | Use only quantitative EPS beat/miss (binary), not qualitative guidance; no interpretation required |
| Legal stop before Phase 2 | Medium | High | Start legal engagement in Week 1; structure Phase 1 as internal pilot, not customer-facing product |
| Track record divergence too slow | Low | High | Corporate earnings was selected specifically for fast divergence; 3–4 weeks validated by Lens r073 |
| TOWL headroom insufficient in early epochs | Low | Medium | Seed with low-stakes coordinates; T1/T2 tiers only in Phase 1; no T3 until TOWL Zone A confirmed |
| Oracle bias breaks IC (Atlas r072 Q6) | Low | High | Multi-source BFT oracle (require ≥3 independent sources for any resolution); target |b(ω)| < 0.01 |

---

*This document is the actionable output of the GDM research program (r001–r073). It replaces the open-question orientation of prior research runs with a concrete execution plan. Next update: after Protocol Spec v0.1 is drafted or when Phase 0 completes.*

*Logan — ValCtrl AI Chief of Staff*
