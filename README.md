# GDM Autoresearch

A living knowledge base on the GestAlt Decentralized Marketplace (GDM) protocol, maintained by Richard (ValCtrl's AI executive assistant) and open for contribution by humans and other agents.

**This is not a run log.** Topic docs are CRUDed in place as research deepens. Each file in `topics/` represents the current best understanding of that area — it gets updated, not duplicated.

---

## Structure

```
gdm-autoresearch/
├── README.md               — this file
├── topics/                 — living topic docs (CRUDed in place)
│   └── <topic-slug>.md
└── scripts/
    └── sync_to_github.sh   — hourly cron sync from Richard's memory
```

---

## Topics

| File | Topic |
|------|-------|
| `query-as-first-class-object.md` | Query as a first-class object — demand-side structure |
| `knowledge-marketplace-primitive.md` | Knowledge marketplace primitive analysis |
| `extended-reasoning-notes.md` | Extended reasoning and protocol notes |
| `r082-fine-tune-notes.md` | r082 fine-tune pass corrections (VAL-470) |
| `r083-fine-tune-notes.md` | r083 fine-tune pass corrections — final validation (VAL-471) |
| `r084-fine-tune-notes.md` | r084 fine-tune pass — real-world validation + phase week-number corrections (VAL-472) |
| `r085-fine-tune-notes.md` | r085 fine-tune pass — Phase 1 header + §5 title + real-world-validation week corrections (VAL-473) |
| `r086-fine-tune-notes.md` | r086 fine-tune pass — Phase 1 "Weeks 4–7" → "Weeks 4–10" corrections in real-world-validation + phase0-launch-package (VAL-474) |
| `r087-fine-tune-notes.md` | r087 fine-tune pass — lens-market-analysis.md: SOM label corrections, seed capital note corrected, §5.4 GTM week numbers corrected to canonical phase timeline (VAL-475) |
| `r088-fine-tune-notes.md` | r088 fine-tune pass — lens-market-analysis.md §6.2 seed cost arithmetic corrected from $150K (old $10/unit) to $15K at $1/unit; research-synthesis.md §1.1 + confidence table clarified ($150K is budget envelope, not seed subsidy arithmetic) (VAL-493) |
| `r089-fine-tune-notes.md` | r089 fine-tune pass — cross-corpus consistency check post-r088/r131; epistemic-bond-v0-spec.md §10 updated with r129–r131 Phase 3 deferred items (LTRP, bounded-liability architecture, DA degraded mode); duplicate footer removed (VAL-494) |

---

## How It Works

Richard continuously researches GDM protocol questions. After each research pass, the relevant topic doc in `topics/` is updated (created, revised, or expanded). A cron job runs hourly to sync the latest state to this repo.

There is one doc per topic. If new insight changes a prior conclusion, the doc is edited — not a new file added.

---

## Contributing — For Humans

1. **Clone:**
   ```bash
   git clone https://github.com/contextvalctrl/gdm-autoresearch.git
   cd gdm-autoresearch
   ```

2. **Edit an existing topic** in `topics/` or create a new one:
   ```bash
   # Edit existing
   vim topics/knowledge-marketplace-primitive.md

   # Or create new
   vim topics/your-new-topic.md
   ```

3. **Commit and push (or open a PR):**
   ```bash
   git checkout -b research/your-topic
   git add topics/
   git commit -m "research: <what changed and why>"
   git push origin research/your-topic
   ```

4. Use GitHub Issues to flag open questions, challenge a finding, or propose a new topic area.

---

## Contributing — For Agents

### Option A — Update Richard's memory file (auto-synced hourly)
Write or update the relevant source file in:
```
/home/ubuntu/agents/richard/.openclaw/workspace/memory/
```
The cron job maps memory files to `topics/` and pushes any changes within the hour.

To add a new topic to the sync map, update `TOPIC_MAP` in `scripts/sync_to_github.sh`.

### Option B — Push directly to the repo
Pull the repo, edit or create a file in `topics/`, commit, and push to `main` (or open a branch + PR).

### Topic doc format
```markdown
# <Topic Title>

**Maintainer:** <Agent or Human>
**Last updated:** YYYY-MM-DD

## Summary
Current best understanding in one paragraph.

## Key Findings
- Finding 1 (with confidence level if relevant)
- Finding 2

## Open Questions
- Question still unresolved

## Revision History (optional)
- YYYY-MM-DD: <what changed>
```

---

## Automation

Hourly cron on the ValCtrl EC2 host:
```
0 * * * * /home/ubuntu/dev/contextvalctrl/gdm-autoresearch/scripts/sync_to_github.sh
```
Logs: `sync.log` in the repo root (gitignored).

---

## Contact

Questions or challenges → GitHub Issues or ping Richard / Gaurav in Slack.
