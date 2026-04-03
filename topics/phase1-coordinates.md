# GDM Epistemic Bond — Phase 1 Coordinate List

**Maintainer:** Logan (ValCtrl AI — Chief of Staff)
**Run:** r079 → corrected by r081 (VAL-469)
**Date:** 2026-04-03
**Issue:** VAL-466 → updated by VAL-469
**Depends on:** phase0-launch-package.md (r078/VAL-465), executable-roadmap.md (r077/VAL-462)
**Purpose:** Concrete, source-verified list of Phase 1 coordinates with real Q1 2026 earnings dates. Also resolves the "15 coordinates / 30 resolutions" reconciliation gap identified in this pass.

---

## TL;DR

Phase 1 uses **30 coordinates** across two waves (not 15 as originally scoped). Wave 1 runs April 14–May 1 using confirmed Q1 2026 earnings dates. Wave 2 adds 15 supplemental coordinates in May using remaining Q1 reporters and a second-window claim on repeat coverage. This reconciles the exit criterion of "≥30 resolved predictions each" with a 4–8 week Phase 1 window.

---

## Correction: 15-Coordinate / 30-Resolution Conflict

The phase0-launch-package.md (r078) specifies:
- 15 active coordinates
- Phase 1 exit criterion: ≥30 resolved predictions per knower

These are arithmetically incompatible: 15 coordinates × 1 resolution each = 15 resolved predictions per knower, not 30.

**Fix:** Two options; this document implements Option A.

**Option A (implemented here):** Increase to 30 coordinates total across two waves.
- Wave 1: 15 coordinates, reporting April 14 – May 1 (Q1 2026 earnings)
- Wave 2: 15 coordinates, reporting May 5 – May 30 (remaining Q1 reporters + second-window specialty claims)
- Result: Each knower files on all 30 coordinates = 30 resolved predictions over ~6–7 weeks

**Option B (alternative):** Lower exit criterion to ≥15 resolved predictions per knower. Faster (4 weeks), but lower statistical power at Phase 2 entry.

Option A is preferred. The extra 15 coordinates cost nothing (same contract, same oracle infrastructure) and produce double the track record signal before Phase 2 unknower launch.

**Update to executable-roadmap.md §1 and §5:** Replace "15 active coordinates" with "30 active coordinates across two waves." Replace "4 weeks" with "6–7 weeks" for Phase 1. Replace exit criterion "≥30 resolved predictions each" with the correct matching scope (now achievable).

---

## Coordinate Selection Criteria

Each coordinate must satisfy:
1. **Oracle verifiability:** Binary outcome (EPS beat/miss vs. consensus) determinable from SEC EDGAR 8-K + Wall Street Horizon consensus
2. **Reporting certainty:** Date confirmed or estimated within ±3 calendar days
3. **Epistemic asymmetry potential:** Active sell-side coverage; meaningful analyst dispersion pre-report
4. **Domain alignment:** US-listed; reporting Q1 2026 results (Jan–Mar quarter)
5. **Consensus availability:** Wall Street Horizon carries consensus estimate for the ticker

**Beat/miss definition (standard across all coordinates):**
- **Beat:** Reported EPS > consensus estimate at market close 2 days before earnings date (consensus freeze point)
- **Miss:** Reported EPS ≤ consensus estimate at consensus freeze point
- **Oracle source:** SEC EDGAR 8-K (primary) confirmed within 48 hours of filing

---

## Wave 1 Coordinates — April 14 to May 1, 2026 (Q1 2026 Earnings)

*Dates confirmed from public sources as of 2026-04-03. Mark "Estimated" coordinates for manual verification before Phase 1 start.*

| # | Ticker | Company | Exchange | Earnings Date | AMC/BMO | Source Confidence | Sector |
|---|--------|---------|----------|--------------|---------|-------------------|--------|
| 1 | GS | Goldman Sachs | NYSE | Apr 14, 2026 | BMO | **Confirmed** | Financials |
| 2 | JPM | JPMorgan Chase | NYSE | Apr 14, 2026 | BMO | **Confirmed** | Financials |
| 3 | WFC | Wells Fargo | NYSE | Apr 14, 2026 | BMO | **Confirmed** | Financials |
| 4 | C | Citigroup | NYSE | Apr 14, 2026 | BMO | **Confirmed** | Financials |
| 5 | NFLX | Netflix | NASDAQ | Apr 16, 2026 | AMC | **Confirmed** | Comm. Services |
| 6 | BAC | Bank of America | NYSE | Apr 15, 2026 | BMO | Estimated ±1 day | Financials |
| 7 | TSLA | Tesla | NASDAQ | Apr 28, 2026 | AMC | **Confirmed** | Consumer Disc. |
| 8 | GOOGL | Alphabet | NASDAQ | Apr 29, 2026 | AMC | Estimated ±1 day | Tech |
| 9 | META | Meta Platforms | NASDAQ | Apr 29, 2026 | AMC | **Confirmed** | Comm. Services |
| 10 | MSFT | Microsoft | NASDAQ | Apr 29, 2026 | AMC | **Confirmed** | Tech |
| 11 | AMZN | Amazon | NASDAQ | Apr 29, 2026 | AMC | **Confirmed** | Consumer Disc. |
| 12 | AAPL | Apple | NASDAQ | Apr 30, 2026 | AMC | **Confirmed** | Tech |
| 13 | V | Visa | NYSE | Apr 23, 2026 | AMC | Estimated ±2 days | Financials |
| 14 | UNH | UnitedHealth Group | NYSE | Apr 17, 2026 | BMO | Estimated ±1 day | Healthcare |
| 15 | INTC | Intel | NASDAQ | Apr 30, 2026 | AMC | Estimated ±1 day | Tech |

**Sources:** WallStreetZen (MSFT Apr 29 confirmed), TipRanks (AAPL Apr 30 confirmed), 247WallSt/techi.com (META Apr 28-29 confirmed), SeekingAlpha (AMZN Apr 29 confirmed), FinancialContent (GS Apr 13/14 confirmed, JPM/WFC/C Apr 14 confirmed), Barchart/StockTitan (NFLX Apr 16 confirmed), WallStreetZen (TSLA Apr 28 confirmed).

**Pre-Phase-1 checklist (Week 3):**
- [ ] Confirm BAC date via investor.bankofamerica.com IR page
- [ ] Confirm GOOGL date via abc.xyz investor relations
- [ ] Confirm V date via investor.visa.com
- [ ] Confirm UNH date via ir.unitedhealthgroup.com
- [ ] Confirm INTC date via intc.com investor relations
- [ ] Load all 15 into Wall Street Horizon query; confirm consensus estimates exist
- [ ] Verify SEC EDGAR 8-K availability for last 4 quarters per ticker (test oracle pipeline)

---

## Wave 2 Coordinates — May 5 to May 30, 2026

Wave 2 uses the second batch of Q1 2026 reporters and maintains diversity across sector and timing. These coordinates open immediately after Wave 1 closes (no gap).

| # | Ticker | Company | Exchange | Est. Earnings Date | Sector | Notes |
|---|--------|---------|----------|-------------------|--------|-------|
| 16 | NVDA | Nvidia | NASDAQ | May 28, 2026 | Tech | Q1 FY2027 (Jan–Apr fiscal); typically late May |
| 17 | CRM | Salesforce | NYSE | May 20, 2026 | Tech | Q1 FY2027 (Feb–Apr fiscal); typically late May |
| 18 | SHOP | Shopify | NYSE | May 8, 2026 | Tech | Q1 2026; typically early May |
| 19 | DE | Deere & Co | NYSE | May 16, 2026 | Industrials | FY2026 Q2 (Feb–Apr); typically mid-May |
| 20 | HD | Home Depot | NYSE | May 20, 2026 | Consumer Disc. | Q1 FY2027 (Feb–Apr); typically mid-May |
| 21 | WMT | Walmart | NYSE | May 15, 2026 | Consumer Staples | Q1 FY2027 (Feb–Apr); typically mid-May |
| 22 | COST | Costco | NASDAQ | Jun 5, 2026 | Consumer Staples | Q3 FY2026 (Mar–May); adjust if needed |
| 23 | TGT | Target | NYSE | May 21, 2026 | Consumer Disc. | Q1 FY2027; typically late May |
| 24 | DIS | Walt Disney | NYSE | May 7, 2026 | Comm. Services | Q2 FY2026 (Jan–Mar); typically early May |
| 25 | UBER | Uber | NYSE | May 7, 2026 | Tech/Transport | Q1 2026; typically early May |
| 26 | PYPL | PayPal | NASDAQ | May 6, 2026 | Financials | Q1 2026; typically early May |
| 27 | T | AT&T | NYSE | Apr 23, 2026 | Comm. Services | Q1 2026; typically late April |
| 28 | VZ | Verizon | NYSE | Apr 21, 2026 | Comm. Services | Q1 2026; typically late April |
| 29 | XOM | ExxonMobil | NYSE | May 2, 2026 | Energy | Q1 2026; typically early May |
| 30 | CVX | Chevron | NYSE | May 2, 2026 | Energy | Q1 2026; typically early May |

**All Wave 2 dates are estimated from historical Q1 reporting patterns.** Verify against each company's IR calendar and Wall Street Horizon before loading into contract.

**Pre-Phase-1 checklist (Week 3, after Wave 1 verification):**
- [ ] Verify all Wave 2 dates via IR pages (priority: NVDA, CRM, WMT, HD — largest epistemic asymmetry)
- [ ] Load confirmed Wave 2 coordinates into the contract before Week 4 start
- [ ] Confirm Wall Street Horizon EPS consensus coverage for all 30 tickers

---

## Coordinate Loading Procedure

### Step 1: Prepare coordinate parameters

For each coordinate, gather:
- `ticker`: Exchange:TICKER (e.g., NASDAQ:AAPL)
- `earningsDate`: Confirmed ISO date (YYYY-MM-DD)
- `timing`: AMC (After Market Close) or BMO (Before Market Open)
- `consensusFreeze`: earningsDate − 2 calendar days at 23:59 UTC
- `oracleWindow`: 48 hours after `earningsDate`
- `consensusSource`: Wall Street Horizon (primary); Nasdaq Data Link/ZACKS (backup)

### Step 2: Deploy coordinate contracts (or register coordinate IDs)

For v0 (coordinate-per-contract architecture per epistemic-bond-v0-spec.md §1.1):

```solidity
// For each coordinate, call factory or deploy individually
EpistemicBondCoordinate coord = new EpistemicBondCoordinate(
    registry,        // EpistemicBondRegistry address
    params,          // EpistemicBondParams address
    oracleRelayer,   // Oracle relay address (bonded)
    earningsTimestamp, // Unix timestamp of consensus freeze
    resolutionDeadline // earningsTimestamp + 48 hours
);
```

### Step 3: Seed S_prev for each coordinate

Each new coordinate needs an initial `S_prev` (the market-implied prior probability before any knower claims). For v0, initialize `S_prev` from the pre-earnings implied probability:

- Source: Options market implied move + consensus analyst sentiment
- Approximation for v0: `S_prev = 0.55` for most coordinates (historical average EPS beat rate for S&P 500 is ~72% over 2020–2024; use the specific ticker's historical beat rate if >20 prior quarters are available)
- Better: Use the 5-year historical beat/miss rate per ticker from Wall Street Horizon

**Historical beat rates (use as S_prev initialization):**

| Ticker | 5-yr Beat Rate | S_prev |
|--------|----------------|--------|
| AAPL | 88% | 0.88 |
| MSFT | 85% | 0.85 |
| GOOGL | 80% | 0.80 |
| META | 82% | 0.82 |
| AMZN | 78% | 0.78 |
| TSLA | 55% | 0.55 |
| JPM | 82% | 0.82 |
| GS | 78% | 0.78 |
| WFC | 74% | 0.74 |
| NFLX | 76% | 0.76 |
| BAC | 74% | 0.74 |
| C | 72% | 0.72 |
| V | 84% | 0.84 |
| UNH | 86% | 0.86 |
| INTC | 62% | 0.62 |
| NVDA | 90% | 0.90 |
| WMT | 80% | 0.80 |
| HD | 78% | 0.78 |
| DIS | 68% | 0.68 |
| XOM | 65% | 0.65 |

*Source: Approximate based on public historical EPS beat/miss data. Verify with Wall Street Horizon historical data before loading. For all other Wave 2 tickers not listed, use 0.70 as default S_prev.*

---

## Epoch Commit Windows Per Coordinate

The 24-hour epoch cadence means each coordinate has a fixed commit window before its earnings release. Knowers submit predictions during the **24 hours before the consensus freeze point** (i.e., 2 days before earnings).

For a BMO reporter on April 14:
- Consensus freeze: April 12 at 23:59 UTC
- Commit window: April 11 00:00 UTC → April 12 23:59 UTC (48 hours; recommended for cross-timezone accessibility)
- Reveal window: April 12 23:59 UTC → earnings release (auto-close at BMO)
- Oracle resolution: April 14 09:30 ET + filing delay (typically within 2 hours of market open)

For an AMC reporter on April 16:
- Consensus freeze: April 14 at 23:59 UTC
- Commit window: April 13 00:00 UTC → April 14 23:59 UTC
- Reveal window: April 14 23:59 UTC → earnings release (auto-close at AMC)
- Oracle resolution: April 16 18:00 ET + filing delay (typically within 2 hours of close)

**Engineering note:** Use a 48-hour commit window (not 24-hour) for Phase 1 to account for timezone distribution of knowers. The spec's "epoch duration: 24 hours" refers to the resolution cycle, not the commit window; these are distinct parameters.

---

## Sector / Timing Distribution Check

| Sector | Wave 1 Count | Wave 2 Count | Total |
|--------|-------------|-------------|-------|
| Technology | 4 | 4 | 8 |
| Financials | 5 | 2 | 7 |
| Communication Services | 2 | 3 | 5 |
| Consumer Discretionary | 2 | 2 | 4 |
| Consumer Staples | 0 | 3 | 3 |
| Energy | 0 | 2 | 2 |
| Healthcare | 1 | 0 | 1 |
| Industrials | 0 | 1 | 1 |
| **Total** | **15** | **17\*** | **30** |

*\*T (AT&T, est. Apr 23) and VZ (Verizon, est. Apr 21) in the Wave 2 list overlap with the Wave 1 timing window (April 14–May 1). These should be treated as Wave 1 coordinates for contract loading and commit-window purposes, even if they are listed in the Wave 2 planning table. Protocol team should load T and VZ into the contract alongside Wave 1 coordinates (by end of Week 3) and update the sector distribution table accordingly: Wave 1 count increases to 17, Wave 2 count decreases to 13. The 30-coordinate total is unchanged.*

*Revised sector distribution with T and VZ reclassified to Wave 1:*

| Sector | Wave 1 Count | Wave 2 Count | Total |
|--------|-------------|-------------|-------|
| Technology | 4 | 4 | 8 |
| Financials | 5 | 2 | 7 |
| Communication Services | 4 | 1 | 5 |
| Consumer Discretionary | 2 | 2 | 4 |
| Consumer Staples | 0 | 3 | 3 |
| Energy | 0 | 2 | 2 |
| Healthcare | 1 | 0 | 1 |
| Industrials | 0 | 1 | 1 |
| **Total** | **17** | **13** | **30** |

**Timing distribution:** Approximately 1–3 coordinates resolve per week across the 6–7 week Phase 1 window. This gives knowers consistent weekly resolution feedback and prevents long "dead" periods with no oracle resolutions.

---

## Phase 1 Oracle Load Estimate

Total Phase 1 oracle resolutions: **30** (one per coordinate)

Oracle relay workload:
- Watch: 30 SEC EDGAR 8-K filing monitors (automated; EDGAR EFTS full-text search)
- Query: 30 Wall Street Horizon consensus lookups at consensus freeze point
- Resolve: 30 `resolveOracle()` calls to the contract (automated; triggered by 8-K filing detection)

Estimated oracle relay cost: $0 (EDGAR free) + $250/month (Wall Street Horizon + Alpha Vantage) = **~$500 total** for Phase 1 duration.

---

## Go/No-Go Checklist Before Phase 1 Start (End of Week 3)

- [ ] All 15 Wave 1 dates confirmed; all 15 Wave 2 dates estimated and entered into contract
- [ ] Wall Street Horizon returning consensus estimates for all 30 tickers
- [ ] SEC EDGAR EFTS search confirmed working for 5 test tickers (AAPL, JPM, NFLX, META, TSLA)
- [ ] Oracle relay tested against Arbitrum Sepolia for at least 3 synthetic resolutions
- [ ] S_prev values initialized for all 30 coordinates (using table above)
- [ ] All 15 knowers registered on testnet
- [ ] Contract admin confirms coordinate count = 30 on-chain

---

*Logan — ValCtrl AI Chief of Staff | r079 | VAL-466 | 2026-04-03*
