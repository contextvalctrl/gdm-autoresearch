# GDM Epistemic Bond — Phase 0–1 Launch Package

**Maintainer:** Logan (ValCtrl AI — Chief of Staff)
**Run:** r078 (VAL-465) → updated r080 (VAL-468) → corrected r081 (VAL-469) → corrected r082 (VAL-470)
**Date:** 2026-04-03
**Issue:** VAL-465 → updated by VAL-468 → updated by VAL-469 → updated by VAL-470
**Depends on:** real-world-validation.md (r076/VAL-461), executable-roadmap.md (r077/VAL-462 → r080/VAL-468), epistemic-bond-v0-spec.md (r077/VAL-462), knower-calibration-test.md (r079/VAL-466), phase1-coordinates.md (r079/VAL-466)
**Purpose:** Final fine-tune and executable consolidation. Everything required to start Phase 0 this week — in one document. Updated in r080 to reflect 30-coordinate / two-wave structure per phase1-coordinates.md r079.

---

## Status: Ready to Launch — 8-Day Compressed Phase 0 Required

The corpus is validated. No blocking research gaps remain for Phase 0–1. This document completes the handoff.

Go/no-go: **GO on Phase 0 and Phase 1**, with four corrections already applied in r077 (unit pricing → $1 USDC, oracle sources, L1 scope clarification, Phase 1 exit criterion → T_i ≥ 0.5), one structural correction applied in r080 (coordinate count: 15 → 30 across two waves; Phase 1 duration: 4 weeks → 6–7 weeks), and two coordinate corrections applied in r082 (COST replaced by LOW; S_prev table fully completed for all 30 tickers).

**⚠️ CRITICAL TIMELINE ALERT (r082/VAL-470):** Today is April 3, 2026. The first Wave 1 commit window opens **April 11** (48 hours before the April 12 consensus freeze for April 14 BMO reporters GS, JPM, WFC, C). That is **8 calendar days**, not the 21 days the three-week Phase 0 plan assumed. Phase 0 must be compressed and parallelized immediately to capture Wave 1.

**The three things that need to start TODAY:**
1. Engineering: set up Foundry + PRBMath v4 + USDC mock; deploy `register()` to Arbitrum Sepolia by EOD
2. BD: build 50-person outreach list and send calibration test to first 20 candidates today
3. Protocol team: confirm Wave 1 coordinate dates and init S_prev values against phase1-coordinates.md

---

## Accelerated 8-Day Critical Path (r082/VAL-470)

The existing Week 1/2/3 plan is correct in content but was written assuming a 21-day Phase 0. The actual window is 8 days. All three tracks must run in parallel from Day 1.

| Day | Engineering | BD | Protocol |
|-----|-------------|----|----|
| **Day 1 (Apr 3)** | Foundry init; PRBMath v4 + OZ; USDC mock deployed to Arbitrum Sepolia; `register()` live | 50-person outreach list finalized; calibration test sent to first 20 | S_prev table reviewed; Wave 1 IR page verification begun |
| **Day 2 (Apr 4)** | `EpistemicBondRegistry.sol` complete: `register()`, `trackRecord()`, `credibilityWeight()` | Follow-up to first 20 outreach; begin second batch of 30 | Confirm ALL Wave 1 dates (BAC, GOOGL, V, UNH, INTC) via IR pages |
| **Day 3 (Apr 5)** | `commit()` with sealed-commitment scheme | Calibration test scoring begins; identify top-30 for next step | Wall Street Horizon account active; query consensus for all 15 Wave 1 tickers |
| **Day 4 (Apr 6)** | `reveal()` + `computeSPublic()` (LOP aggregation) | Top-15 knower invitations sent | Load Wave 1 coordinate parameters into staging sheet |
| **Day 5 (Apr 7)** | `resolveOracle()` + `settle()` + circuit breaker | Wallet setup sessions with accepted knowers | Oracle relay: EDGAR API integration tested |
| **Day 6 (Apr 8)** | Oracle relay service live on Arbitrum Sepolia; all three sources connected | Continue wallet setup; 10 knowers registered on testnet by EOD | Wave 1 S_prev values finalized; load coordinates into testnet contract |
| **Day 7 (Apr 9)** | End-to-end testnet run: 3 synthetic epochs, 5 mock knowers; fuzz tests for `_computeReward` | 15 knowers registered on testnet; registration confirmed on-chain | Verify oracle relay test resolution against 3 historical 8-K filings |
| **Day 8 (Apr 10)** | Security checklist; TOWL zone check; all 30 coordinates loaded + S_prev initialized | 15 knowers receive Phase 1 briefing; commit window instructions sent | Final go/no-go check: contract, oracle, 15 knowers, 30 coordinates |
| **Apr 11** | **FIRST COMMIT WINDOW OPENS — Wave 1 BMO reporters (GS, JPM, WFC, C)** | | |

**Fallback if Day 8 is incomplete:** Allow GS, JPM, WFC, C (April 14 BMO batch) to be observer coordinates — oracle resolution captured but no knower claims. Phase 1 runs on 26 active coordinates from April 15. Exit criterion revised: ≥26 resolved predictions per knower.

Everything else is sequenced below.

---

## Part 1: Consolidated Budget (Phase 0–1, Weeks 1–7)

### 1.1 Engineering (Phase 0, Weeks 1–3)

| Line Item | Estimate | Notes |
|---|---|---|
| Solidity contract development (EpistemicBond.sol) | 2–3 engineer-weeks | One experienced Solidity engineer; PRBMath v4 + OpenZeppelin SafeERC20 |
| Oracle relay service (off-chain, Node.js or Python) | 1 engineer-week | EDGAR + Alpha Vantage + Wall Street Horizon integration |
| Testnet deployment + Foundry test suite | Included above | Arbitrum Sepolia; fuzz tests for `_computeReward` |
| Arbitrum Sepolia testnet gas | ~$0 | Free via faucet |
| USDC mock deployment on Arbitrum Sepolia | ~$0 | Deploy OpenZeppelin MockERC20 |
| Infrastructure (CI/CD, monitoring) | ~$200/month | GitHub Actions + Infura/Alchemy RPC |

**Total Phase 0 Engineering: 3–4 engineer-weeks + ~$200/month infrastructure**

---

### 1.2 Oracle (Phase 1, Weeks 4+)

| Source | Cost | Purpose |
|---|---|---|
| SEC EDGAR | Free | Primary oracle: 8-K filings |
| Nasdaq Data Link / ZACKS (free tier) | Free | EPS actuals + consensus (≤500 tickers/month) |
| Alpha Vantage | $50/month | Earnings surprise data, same-day |
| Wall Street Horizon | $200/month | Machine-readable consensus estimates for S&P 500 |

**Total oracle cost: ~$250/month = ~$750 for Phase 1 (3 months)**

---

### 1.3 Seed Subsidy (Phase 1, Weeks 4–7)

The seed subsidy floor guarantees knower participation during the track-record bootstrap. It is a floor (minimum reward per epoch), not a bonus.

| Parameters | Value |
|---|---|
| Knowers | 15 |
| Epochs | 30 (4–5 weeks) |
| Seed floor per knower per epoch | 10 units ($10 USDC) |
| Total subsidy exposure | 15 × 30 × $10 = **$4,500 USDC** |

This is not a cost — it's escrowed capital that flows to knowers who file valid claims. If knowers don't file, nothing is released. Budget $4,500 USDC to the protocol treasury before Phase 1 begins.

---

### 1.4 BD / Recruitment (Weeks 1–3)

| Activity | Estimate | Notes |
|---|---|---|
| Knower outreach (email/LinkedIn) | BD lead time (1–2 hours/day for 3 weeks) | 50-person list → 30 calibration tests → 15 accepted |
| Calibration test (historical earnings questions) | 3–4 hours to create once | 10 questions; historical EPS data from EDGAR |
| Wallet setup assistance for non-crypto-native analysts | 1 hour per knower | Metamask setup guide + USDC faucet instructions |
| Phase 1 registration fees ($100 USDC × 15 knowers) | **$1,500 USDC from knowers** | Knowers pay this; it's non-refundable to the protocol |

**Total BD time: ~30–40 hours over 3 weeks**
**Registration fees: collected from knowers, $100 USDC each = $1,500 USDC to protocol treasury**

---

### 1.5 Total Phase 0–1 Capital Summary

| Item | Amount |
|---|---|
| Engineering labor | 3–4 engineer-weeks (cost depends on team) |
| Infrastructure | ~$400 (Months 1–2) |
| Oracle feeds | ~$750 (Months 1–3) |
| Seed subsidy treasury | $4,500 USDC |
| Protocol reserve (oracle bond) | $5,000 USDC minimum (oracle bond > max knower stake) |
| **Total out-of-pocket capital** | **~$10,650 USDC + engineering labor** |
| Registration fees collected | +$1,500 USDC from knowers |
| **Net capital requirement** | **~$9,150 USDC + engineering labor** |

At a $150K seed capital budget (per Lens r073 long-term plan), Phase 0–1 consumes under 10% of that budget. The remaining $140K+ is available for Phase 2 BD, unknower onboarding, and protocol reserve deepening.

---

## Part 2: Week-by-Week Operator Checklist (Phase 0–1)

### Week 1 — Foundation

**Engineering:**
- [ ] Set up Foundry project: `forge init epistemic-bond`
- [ ] Add PRBMath v4 dependency: `forge install PaulRBerg/prb-math`
- [ ] Add OpenZeppelin v5: `forge install OpenZeppelin/openzeppelin-contracts`
- [ ] Scaffold `EpistemicBondRegistry.sol` with `register()`, `trackRecord()`, `credibilityWeight()`
- [ ] Scaffold `EpistemicBondCoordinate.sol` with epoch state machine (stub all functions)
- [ ] Deploy USDC mock (`MockERC20.sol`) on Arbitrum Sepolia
- [ ] Confirm Arbitrum Sepolia testnet is accessible (Infura/Alchemy key working)

**BD:**
- [ ] Build 50-person outreach list (sources: LinkedIn ex-sell-side, Good Judgment Project top forecasters, Metaculus leaderboard, alt-data networks)
- [ ] Create 10-question historical calibration test (EPS beat/miss for 10 past earnings events; use EDGAR 8-Ks as answer key)
- [ ] Draft outreach email (see Part 3 below)
- [ ] Begin sending to first 20 candidates

**Protocol:**
- [ ] Finalize 15 Phase 1 coordinate candidates (earnings events for Weeks 4–7; check earnings calendar)
- [ ] Document each coordinate: ticker, reporting date, consensus source (Wall Street Horizon)
- [ ] Set up Wall Street Horizon account ($200/month)

---

### Week 2 — Core Contract + Outreach Push

**Engineering:**
- [ ] Implement `commit()` with sealed-commitment scheme: `keccak256(pTrue || stake || nonce || epochId || contractAddress)`
- [ ] Implement `reveal()` with commitment validation
- [ ] Implement `computeSPublic()`: LOP aggregation with w_i = σ(α·T_i) × log(1 + k_i/k_0)
- [ ] Implement `_fixedLog()` using PRBMath v4 `UD60x18.ln()` 
- [ ] Write Foundry unit tests for `computeSPublic()` with 3–5 mock knowers
- [ ] Begin oracle relay service scaffold (EDGAR API integration first)

**BD:**
- [ ] Send calibration tests to all 50 candidates (or 30 if list not complete)
- [ ] First-pass filter: only advance candidates with ≥60% score
- [ ] Begin wallet setup conversations with willing candidates
- [ ] Target: 20 candidates in active pipeline by end of Week 2

**Protocol:**
- [ ] Alpha Vantage account active ($50/month)
- [ ] SEC EDGAR API tested (free; test with 3 real 8-K lookups)
- [ ] Confirm Wall Street Horizon consensus data quality for all 30 coordinates (Wave 1 priority: top 15)

---

### Week 3 — Integration + Knower Onboarding

**Engineering:**
- [ ] Implement `resolveOracle()` with oracle address authentication
- [ ] Implement `settle()` with `_computeReward()` and `_updateTrackRecord()`
- [ ] Add circuit breaker: `|R_i| ≤ 2 × stake` in `settle()`
- [ ] Add TOWL zone check in `commit()` (revert in Zone C)
- [ ] Add `claimSettlement()` pull-payment pattern
- [ ] Complete oracle relay service (EDGAR + Alpha Vantage + Wall Street Horizon)
- [ ] Run full end-to-end testnet simulation: 5 synthetic epochs, 5 mock knowers
- [ ] Complete security checklist from epistemic-bond-v0-spec.md §7
- [ ] Fuzz test `_computeReward` with adversarial inputs (pTrue → 0, pTrue → 1, extreme S_prev values)

**BD:**
- [ ] Calibration test results received; rank candidates
- [ ] Identify top 15; send Phase 1 participation invitation
- [ ] Complete wallet setup for willing candidates (Metamask + Arbitrum Sepolia + USDC faucet)
- [ ] Confirm 15 registered knowers by end of Week 3

**Protocol:**
- [ ] Deploy EpistemicBond.sol to Arbitrum Sepolia
- [ ] 15 knowers complete on-chain `register()` (paying $100 USDC mock fee on testnet)
- [ ] **All 30 Phase 1 coordinates loaded into contract** (Wave 1 + Wave 2 per `phase1-coordinates.md`)
- [ ] S_prev initialized for all 30 coordinates using historical beat-rate table in `phase1-coordinates.md`
- [ ] Oracle relay service confirmed live on testnet
- [ ] Verify Wave 1 confirmed dates (BAC, GOOGL, V, UNH, INTC) via IR pages; verify Wave 2 estimated dates (priority: NVDA, CRM, WMT, HD)

---

### Week 4 — Phase 1 Begins (Wave 1)

**Protocol:**
- [ ] First real earnings epoch opens: GS, JPM, WFC, C all reporting April 14 (BMO)
- [ ] All 15 knowers submit sealed commitments for Wave 1 active coordinates
- [ ] Confirm oracle relay is delivering resolutions within 15 minutes of SEC EDGAR 8-K filing
- [ ] Verify reveal/settle flow works end-to-end with real data (use GS/JPM April 14 as live test)

**BD:**
- [ ] Begin identifying 5–10 potential Phase 2 unknowers (institutional; warm introductions preferred)
- [ ] Build unknower pitch deck (see Part 4 below for key framing)

**Monitoring (ongoing through Week 10):**
- [ ] Daily: check oracle resolution status for all active coordinates
- [ ] Weekly: review T_i values for all 15 knowers
- [ ] Weekly: check cross-claim correlation for Sybil signals (flag any pair >0.85 correlation)
- [ ] Weekly: review oracle dispute log (should be zero)

---

### Weeks 5–6 — Phase 1 Wave 1 Active

**Checkpoints:**
- Week 5 (10 epochs): At least 10 knowers have filed claims on ≥5 coordinates; no oracle disputes
- Week 6 (Wave 1 close, ~15 epochs): At least 5 knowers showing T_i > 0; Wave 1 complete (15 resolutions per knower)

---

### Weeks 7–10 — Phase 1 Wave 2 Active (30 Epochs Total)

Wave 2 coordinates (May 5–30) open continuously as Wave 1 closes. No gap in knower activity.

**Checkpoints:**
- Week 8 (20 epochs): Check T_i distribution; identify top-3 candidates for Phase 2 leaderboard
- Week 9 (25 epochs): Final pre-exit monitoring; flag any coordination anomalies
- Week 10 (30 epochs): **Phase 1 exit checkpoint** — evaluate against all 6 criteria below

**Phase 1 Exit Criteria (evaluate at 30 resolved predictions per knower):**
| Criterion | Target | Action if missed |
|---|---|---|
| Active knowers | ≥10 with ≥30 resolved predictions | Extend by 10 epochs; investigate drop-off |
| Track record differentiation | ≥3 knowers with T_i ≥ 0.5 | Check domain selection; was epistemic asymmetry real? Escalate to founders |
| Sybil signal clean | No cross-claim correlation > 0.85 | Audit registration; apply correlation penalty manually |
| Oracle disputes | 0 | Root-cause any dispute before Phase 2 |
| Contract uptime | 100% (no stuck epochs) | Postmortem any stuck epoch; fix oracle relay |
| Engineering confidence | Security checklist 100% complete | Block Phase 2 if any red items |

---

## Part 3: Knower Onboarding Guide (One-Pager)

*This is the "maximum loss" framing document requested in real-world-validation.md §7.1. Send this to every prospective knower before asking for commitment.*

---

**GDM Epistemic Bond — Knower Participation Guide (v0 Beta)**

**What you're joining:** A closed beta of an on-chain credentialed prediction market for corporate earnings outcomes. You stake capital to back your beliefs. Your stake compounds into a track record. Your track record becomes the credential that earns you fee revenue in Phase 2.

---

**What you actually do:**

Each day we have an active earnings event in your coverage, you:
1. Log into the beta interface
2. Submit a sealed probability estimate: "P(EPS beat) = X%"
3. Stake between $50 and (your choice) USDC to back your claim
4. Reveal at the close of the commit window
5. Collect your result after the oracle settles (typically within 2 hours of the SEC filing)

Time per day on active dates: **~10 minutes**. On inactive dates: nothing required.

---

**What you can earn:**

Your reward (or loss) per epoch is:

> `R = stake × [log(your probability at the outcome) − log(the crowd estimate at the outcome)]`

In plain English: **you make money when you're more right than the crowd.** If you match the crowd exactly, R = 0. You only make money by being better than the consensus.

Phase 1 (Weeks 1–7): **Seed subsidy floor of $10 per epoch guaranteed** for any epoch where you file a valid claim — regardless of outcome. This covers your expected staking cost and compensates you for participating while the track record bootstraps.

Phase 2 (post-exit): Fee revenue from institutional buyers replaces the seed subsidy. The Phase 1 track record is your proof-of-edge that earns premium fees.

---

**What you can lose:**

Your maximum loss per epoch is bounded by your stake and the distance of your estimate from the outcome.

- If you stake $50 and submit P = 70%, and the outcome confirms (EPS beats), your score against a crowd at P = 50% is: `50 × [log(0.70) − log(0.50)] ≈ +$17`
- If the outcome denies (EPS misses), your score is: `50 × [log(0.30) − log(0.50)] ≈ −$26`
- Maximum theoretical loss = your stake (if you submit P = 100% for the wrong outcome — but the protocol prevents 100% claims; minimum is ε = 0.1%)

**Practical floor:** In Phase 1, the $10/epoch seed subsidy absorbs most small-stake downside. A knower staking $50/epoch and losing every epoch would net approximately: `(+$10 subsidy) + (expected loss from bad predictions)`. Accurately calibrated knowers lose nothing in expectation.

---

**Registration:**

One-time, non-refundable: **$100 USDC**

This is your Sybil-resistance fee — it ensures your identity is unique in the system. It is not a subscription. It will never be charged again. After Phase 1 completes, your registration carries over to mainnet.

---

**Crypto setup required:**

- Metamask (or any EIP-1193 wallet)
- Arbitrum Sepolia (testnet) in Phase 1 — we provide test USDC
- Base mainnet for Phase 2

Not comfortable with crypto wallets? We'll walk you through setup in 15 minutes. It doesn't require understanding blockchain — just holding a wallet address.

---

**Privacy:**

Your wallet address is public. Your claim amounts and epoch outcomes are public. Your name is not on-chain. You are pseudonymous unless you choose to publish your identity in the Phase 2 leaderboard.

---

**What happens after Phase 1:**

If you finish Phase 1 with T_i ≥ 0.5 (positive credibility score), you're in the top tier of the Phase 2 knower roster. Institutional buyers pay fees for access to credibility-weighted claim bundles — your T_i determines your share of those fees. This is the GLG model but automated and self-settling.

---

**One-line commitment:** You're participating in a 4-week closed beta. Time: ~10 minutes/day on active earning dates. Capital at risk: up to your staked amount minus subsidy floor. Upside: track record that earns Phase 2 fee revenue.

Questions? Contact [BD lead contact].

---

## Part 4: BD Outreach Template

### 4.1 Initial outreach email

**Subject:** Closed beta — get paid for your earnings edge (on-chain, 4 weeks)

---

Hi [Name],

I'm reaching out because your track record as [sell-side analyst / alt-data forecaster / earnings forecaster on Metaculus] puts you in a rare category of people with a documented earnings edge.

We're running a closed beta of an on-chain epistemic bond protocol for corporate earnings. The short version: you stake capital to back probability estimates on earnings outcomes, the protocol scores you on KL-divergence accuracy at settlement, and your track record accrues as an on-chain credential.

**The ask:** 4 weeks, ~10 minutes/day on active earnings dates, $100 USDC registration fee (one-time, non-refundable), stakes of your choice (minimum $50 USDC per claim). Seed subsidy of $10 per epoch guaranteed for Phase 1.

**Why this matters:** Your expertise currently has no structured monetization path except consulting and directional bets (where the edge gets diluted into price signals). This protocol routes your belief directly to institutional buyers as credentialed information — separate from price impact. It's a new revenue stream for your edge, not a replacement for anything you're already doing.

I've attached a one-page participation guide. The calibration test to qualify is 10 questions on historical earnings — takes about 20 minutes.

Interested? Reply and I'll send the test.

[BD lead name]
ValCtrl

---

### 4.2 Qualification criteria (internal scoring, not shared with candidates)

| Criterion | Weight | Notes |
|---|---|---|
| Historical earnings calibration score (≥60% required) | 40% | Non-negotiable floor |
| Number of qualifying data points | 20% | Need ≥20 earnings calls in coverage; reject <20 |
| Domain alignment with Phase 1 coordinates | 20% | Prefer candidates with AAPL/MSFT/GOOGL/META/AMZN coverage |
| Crypto wallet comfort | 10% | Nice-to-have; can be onboarded; not a blocker |
| Response time to outreach | 10% | Proxy for engagement quality |

**Priority pool:** Former sell-side analysts at bulge brackets (Morgan Stanley, Goldman, JPMorgan) with documented coverage of large-cap tech or consumer discretionary. These candidates have the calibration data, the domain overlap, and the institutional connections that make them useful Phase 2 references.

**Secondary pool:** Good Judgment Project and Superforecaster alumni with documented earnings forecasting records. Less domain-specific but potentially higher calibration scores.

---

### 4.3 Rejection handling

For candidates who pass calibration but decline:

> "Understood — no pressure. If you want to revisit after Phase 1 when the track record data is available and Phase 2 fee revenue is live, please reach out. We'll send you the Phase 1 results summary in [Month]."

Maintain the list. Phase 2 demand side benefits from seeing Phase 1 outcomes first. Some of the best candidates will join in Phase 2 with proven data.

---

## Part 5: Engineering Starter Checklist (Day 1)

This is the minimum viable environment to get a Solidity engineer productive on Day 1.

### Environment setup

```bash
# Install Foundry
curl -L https://foundry.paradigm.xyz | bash
foundryup

# Create project
mkdir epistemic-bond && cd epistemic-bond
forge init --no-git

# Add dependencies
forge install PaulRBerg/prb-math@v4.0.0 --no-git
forge install OpenZeppelin/openzeppelin-contracts@v5.0.0 --no-git

# Add remappings to foundry.toml
# prb-math/=lib/prb-math/src/
# @openzeppelin/=lib/openzeppelin-contracts/

# Test environment
forge test

# Arbitrum Sepolia RPC (set FOUNDRY_ETH_RPC_URL)
export FOUNDRY_ETH_RPC_URL="https://sepolia-rollup.arbitrum.io/rpc"
```

### File structure target (Phase 0 end state)

```
epistemic-bond/
├── src/
│   ├── EpistemicBondRegistry.sol      # Knower registration + c_id + T_i storage
│   ├── EpistemicBondCoordinate.sol    # Per-coordinate epoch flow
│   ├── EpistemicBondParams.sol        # Protocol constants (governance-adjustable)
│   └── interfaces/
│       ├── IEpistemicBondRegistry.sol
│       ├── IEpistemicBondCoordinate.sol
│       └── IEpistemicBondParams.sol
├── test/
│   ├── EpistemicBondRegistry.t.sol
│   ├── EpistemicBondCoordinate.t.sol
│   └── fuzz/
│       └── ComputeReward.t.sol         # Fuzz tests for _computeReward
├── script/
│   ├── Deploy.s.sol                   # Deployment script for testnet
│   └── SeedKnowers.s.sol             # Register 5 mock knowers for testing
└── foundry.toml
```

### Critical implementation order (do NOT parallelize these)

1. `MockERC20.sol` (USDC mock) → deploy to Arbitrum Sepolia → get address
2. `EpistemicBondParams.sol` (constants) → no dependencies
3. `EpistemicBondRegistry.sol` (depends on Params + USDC address)
4. `IEpistemicBondCoordinate.sol` (interface first)
5. `EpistemicBondCoordinate.sol` — implement commit/reveal FIRST, then computeSPublic, then settle
6. End-to-end integration test BEFORE oracle relay work begins
7. Oracle relay service (depends on working contract)

### Fuzz test template for `_computeReward`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/EpistemicBondCoordinate.sol";

contract ComputeRewardFuzzTest is Test {
    EpistemicBondCoordinate coord;
    uint256 constant WAD = 1e18;
    uint256 constant EPSILON = 1e15; // 0.1% min probability

    function setUp() public {
        // deploy with test params
        coord = new EpistemicBondCoordinate(/* params */);
    }

    /// @dev Fuzz: pTrue close to 0
    function testFuzz_rewardNearZero(uint256 stakeWad, uint256 sPrevWad) public {
        uint256 pTrue = EPSILON; // near-zero probability
        stakeWad = bound(stakeWad, 50 * WAD, 10000 * WAD);
        sPrevWad = bound(sPrevWad, EPSILON, WAD - EPSILON);
        
        int256 reward = coord.computeRewardPublic(pTrue, stakeWad, sPrevWad, true);
        // Circuit breaker: |R| ≤ 2 × stake
        assertTrue(reward >= -int256(2 * stakeWad), "Negative reward exceeds 2x stake");
        assertTrue(reward <= int256(2 * stakeWad), "Positive reward exceeds 2x stake");
    }

    /// @dev Fuzz: pTrue close to 1
    function testFuzz_rewardNearOne(uint256 stakeWad, uint256 sPrevWad) public {
        uint256 pTrue = WAD - EPSILON; // near-one probability
        stakeWad = bound(stakeWad, 50 * WAD, 10000 * WAD);
        sPrevWad = bound(sPrevWad, EPSILON, WAD - EPSILON);
        
        int256 reward = coord.computeRewardPublic(pTrue, stakeWad, sPrevWad, false);
        // If pTrue ≈ 1 and outcome is false, reward should be deeply negative but bounded
        assertTrue(reward >= -int256(2 * stakeWad), "Slash exceeds 2x stake");
    }

    /// @dev Fuzz: extreme S_prev
    function testFuzz_extremeSPrev(uint256 pTrue, uint256 stakeWad, bool outcome) public {
        pTrue = bound(pTrue, EPSILON, WAD - EPSILON);
        stakeWad = bound(stakeWad, 50 * WAD, 10000 * WAD);
        uint256 sPrev = EPSILON; // adversarially small S_prev
        
        int256 reward = coord.computeRewardPublic(pTrue, stakeWad, sPrev, outcome);
        assertTrue(reward >= -int256(2 * stakeWad), "Negative reward exceeds bound");
        assertTrue(reward <= int256(2 * stakeWad), "Positive reward exceeds bound");
    }
}
```

---

## Part 6: Rapid Reference — Key Numbers

| Item | Value | Source |
|---|---|---|
| Unit = | $1 USDC | r077 correction |
| Registration fee (c_id) | $100 USDC | Atlas Sybil lower bound |
| Minimum stake (k_min) | $50 USDC | Calibrated to below annoyance threshold |
| Reference stake (k_0) | $100 USDC | Log-diminishing inflection |
| Seed subsidy floor | $10 USDC/epoch | Phase 1 only |
| Max credibility per knower | 25% (W_max) | Single-knower dominance guard |
| Phase 1 knowers | 15 | Closed beta |
| Phase 1 epochs | 30 | ~6–7 weeks across two waves |
| Phase 1 coordinates | 30 (two waves of 15) | Corporate earnings, binary; see phase1-coordinates.md |
| Oracle cost | ~$250/month | EDGAR + Alpha Vantage + Wall Street Horizon |
| Phase 1 exit criterion | T_i ≥ 0.5 for ≥3 knowers | Replaces p < 0.05 (statistically insufficient) |
| Total Phase 0–1 capital | ~$9,150 USDC + engineering | Budget section above |
| Chain (testnet) | Arbitrum Sepolia | Better faucet availability |
| Chain (mainnet) | Base | Lowest gas post-Dencun; Coinbase backing |
| Fixed-point math library | PRBMath v4 (`UD60x18.ln()`) | Audited; Foundry-native |
| Token standard | USDC ERC-20, OpenZeppelin SafeERC20 | Dollar-denominated from Day 1 |
| L1 dependency in Phase 0–1 | None (staging oracle only) | L1 integration is Phase 2 trigger |
| L1 migration trigger | L1 live ≥30 epochs AND Phase 1 exit criteria met | Can proceed in parallel |

---

## Part 7: What This Document Does NOT Replace

This package adds the missing operational artifacts. The canonical technical and research references remain:

| Document | Purpose |
|---|---|
| `epistemic-bond-v0-spec.md` | Full Solidity interface + security checklist + oracle integration |
| `executable-roadmap.md` | Protocol parameters table + phase build sequence + risk register |
| `real-world-validation.md` | Go/no-go rationale + four corrections applied in r077 |
| `research-synthesis.md` | Cross-agent theoretical validation |
| `atlas-formal-analysis.md` | Sybil lower bounds, IC proofs, L1/L2 coupling conditions |

---

## Final Call to Action

**⚠️ TIMELINE COMPRESSION (r082/VAL-470):** The original "end of Week 1" deadlines are now **Day 1–2 deadlines** (April 3–4). See the Accelerated 8-Day Critical Path above.

**Engineering:** PRBMath v4 + USDC mock + `register()` function live on Arbitrum Sepolia testnet by **end of Day 1 (April 3)**. Full contract + oracle relay complete by **Day 8 (April 10)**. If this slips, Wave 1 (April 14 BMO reporters) slips.

**BD:** 50-person outreach list built and calibration test sent to first 20 candidates by **end of Day 1 (April 3)**. Recruitment must run in parallel with engineering from Day 1. Target: 15 knowers registered on testnet by Day 8.

**Protocol team:** All 30 Phase 1 coordinates (Wave 1: 15 confirmed dates, Wave 2: 15 estimated dates per `phase1-coordinates.md`) verified with consensus sources and S_prev initialized by **Day 6 (April 8)**. LOW replaces COST as coordinate #22 — verify LOW IR date at ir.lowes.com.

**Next trigger:** Phase 1 exit checkpoint at Week 10 (30 epochs complete across both waves). Report to founders: T_i distribution, oracle resolution rate, Sybil monitor status. If all 6 exit criteria are green, proceed to Phase 2 unknower soft launch.

---

*This document is the final fine-tune artifact for the GDM epistemic bond executable idea. No further research passes are required. Everything is known, bounded, and ready to build. The next step is execution, not analysis.*

*Five corrections have been applied across this corpus: four in r077 (unit pricing → $1 USDC; oracle sources; L1 scope; Phase 1 exit criterion → T_i ≥ 0.5) and one in r080 (coordinate count: 15 → 30 across two waves; Phase 1 duration: 4 weeks → 6–7 weeks). See `phase1-coordinates.md` for the full coordinate list.*

*Logan — ValCtrl AI Chief of Staff | r078 → r080 | VAL-465 → VAL-468*
