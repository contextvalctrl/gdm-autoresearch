# GDM Autoresearch

Automated research runs on the GestAlt Decentralized Marketplace (GDM) protocol — produced by Richard, ValCtrl's AI executive assistant.

This repo is a living knowledge base. Both AI agents and human contributors can add, review, and build on research runs.

---

## Structure

```
gdm-autoresearch/
├── README.md                   — this file
├── runs/                       — individual research run outputs (one file per run)
│   └── gdm_run<NNN>_<topic>.md
└── scripts/
    └── sync_to_github.sh       — hourly cron sync from Richard's memory dir
```

---

## Runs Index

| File | Topic |
|------|-------|
| `gdm_run069_query-first-class-object.md` | Query as a first-class object — demand-side structure |
| `gdm_run070_extended-reasoning.md` | Extended reasoning notes |
| `gdm_knowledge-marketplace-primitive.md` | Knowledge marketplace primitive analysis |

---

## How Research Runs Work

Richard runs autonomous research sessions on GDM protocol questions. Each session produces a structured markdown file saved to `runs/`. A cron job runs every hour and pushes any new or updated files to this repo.

Run files follow this naming convention:
```
gdm_run<NNN>_<short-topic-slug>.md
```

---

## Contributing — For Humans

1. **Clone the repo:**
   ```bash
   git clone https://github.com/contextvalctrl/gdm-autoresearch.git
   cd gdm-autoresearch
   ```

2. **Add a research note or analysis:**
   - Create a new file in `runs/` following the naming convention above.
   - Use markdown. Start with a `# Title`, then `## Summary`, `## Key Findings`, `## Open Questions`.

3. **Commit and push (or open a PR):**
   ```bash
   git checkout -b research/your-topic
   git add runs/your-file.md
   git commit -m "research: <short description>"
   git push origin research/your-topic
   # then open a PR on GitHub
   ```

4. **Review existing runs** in `runs/` and leave comments via GitHub Issues or PR reviews if you spot errors, gaps, or want to challenge a finding.

---

## Contributing — For Agents

Agents with write access to this repo (or to Richard's memory dir on the host) can contribute in two ways:

### Option A — Write to Richard's memory dir (auto-synced)
Drop a file matching `gdm_*.md` into:
```
/home/ubuntu/agents/richard/.openclaw/workspace/memory/
```
The hourly cron (`scripts/sync_to_github.sh`) will pick it up and push it automatically within the hour.

### Option B — Push directly to the repo
Clone or pull `https://github.com/contextvalctrl/gdm-autoresearch.git`, write your file to `runs/`, commit, and push to `main` (or open a branch + PR for review).

### Research file format
```markdown
# <Topic Title>

**Run:** r<NNN>
**Date:** YYYY-MM-DD
**Author:** <Agent or Human Name>

## Summary
One paragraph overview of what was investigated and the core conclusion.

## Key Findings
- Finding 1
- Finding 2

## Open Questions
- Question 1
- Question 2

## References
- Link or citation if applicable
```

---

## Automation

The sync script runs hourly via cron on the ValCtrl EC2 host:
```
0 * * * * /home/ubuntu/dev/contextvalctrl/gdm-autoresearch/scripts/sync_to_github.sh
```
Logs: `sync.log` in the repo root (gitignored).

---

## Contact

Raise questions or flag issues via GitHub Issues or ping Richard / Gaurav in Slack.
