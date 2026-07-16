# VS Code Multi-Agent System

> Production-ready multi-agent orchestration system built on top of [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — 6 specialized AI agents covering the full software development lifecycle, installable globally for any VS Code workspace.

<p align="center">
  <img src="https://img.shields.io/badge/agents-6-blue" alt="6 agents">
  <img src="https://img.shields.io/badge/skills-24-green" alt="24 skills">
  <img src="https://img.shields.io/badge/platforms-Mac%20%7C%20Windows%20%7C%20Ubuntu-orange" alt="cross-platform">
  <img src="https://img.shields.io/badge/VS%20Code-Copilot%20%7C%20Claude%20Code-purple" alt="VS Code">
</p>

---

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/handikadevs/vscode-agents/main/install.sh | bash
```

Or clone and run manually:

```bash
git clone https://github.com/handikadevs/vscode-agents.git
cd vscode-agents && ./install.sh
```

**Windows (PowerShell):**

```powershell
iwr -Uri https://raw.githubusercontent.com/handikadevs/vscode-agents/main/install.ps1 | iex
```

After install, **restart VS Code** — done.

---

## The 6 Agents

| Agent                  | Role               | Skills | Use When                             |
| ---------------------- | ------------------ | ------ | ------------------------------------ |
| 🎨 **product-agent**   | Product Specialist | 8      | Specs, UI/UX, user research, design  |
| 🏗️ **tech-lead-agent** | Staff Engineer     | 10     | Architecture, code review, strategy  |
| 💻 **frontend-agent**  | Frontend Engineer  | 6      | UI, browser perf, components         |
| ⚙️ **backend-agent**   | Backend Engineer   | 6      | APIs, databases, server perf         |
| 🧪 **tester-agent**    | QA/QC Engineer     | 7      | Testing, debugging, security audit   |
| 🚀 **devops-agent**    | SRE/DevOps         | 6      | CI/CD, infra, deployment, monitoring |

**All 24 [addyosmani skills](https://github.com/addyosmani/agent-skills) are mapped** — no skill left unused.

---

## The Orchestrator

`/orchestrator` runs multiple agents in **parallel fan-out** and merges their reports:

```
                    ┌─→ product-agent    ─┐
                    ├─→ tech-lead-agent  ─┤
/orchestrator ─────┼─→ frontend-agent   ─┼─→ merge → synthesized report
  "audit my app"   ├─→ backend-agent    ─┤
                    ├─→ tester-agent    ─┘
                    └─→ devops-agent
```

It automatically selects the right agents based on your task:

| Task                             | Agents Invoked                                    |
| -------------------------------- | ------------------------------------------------- |
| Feature development (full-stack) | product + tech-lead + frontend + backend + tester |
| Code review                      | tech-lead + tester                                |
| Security audit                   | tester + devops                                   |
| Launch / ship                    | ALL six                                           |
| UI/UX only                       | product + frontend                                |
| Bug investigation                | tester + tech-lead                                |

---

## Usage (VS Code Copilot Chat)

Type natural language — no special syntax:

```
"As tester-agent, review the auth service for security issues"

"Use the frontend-agent to build a dark mode toggle"

"Run orchestrator: audit grikari-platform before production launch"
```

### Usage (Claude Code CLI)

Use slash commands:

```
/product   →  Product Agent
/tech-lead →  Tech Lead Agent
/frontend  →  Frontend Agent
/backend   →  Backend Agent
/tester    →  Tester Agent
/devops    →  DevOps Agent
/orchestrator →  Parallel multi-agent
```

---

## Repo Structure

```
vscode-agents/
├── README.md
├── install.sh              ← One-liner curl installer (Mac/Ubuntu)
├── install.ps1             ← One-liner PowerShell installer (Windows)
├── agents/                 ← Agent persona definitions
│   ├── product-agent.md
│   ├── tech-lead-agent.md
│   ├── frontend-agent.md
│   ├── backend-agent.md
│   ├── tester-agent.md
│   └── devops-agent.md
├── commands/               ← Slash commands (Claude Code)
│   ├── product.md
│   ├── tech-lead.md
│   ├── frontend.md
│   ├── backend.md
│   ├── tester.md
│   ├── devops.md
│   └── orchestrator.md
└── scripts/                ← Full install scripts
    ├── install-agent-skills.sh
    └── install-agent-skills.ps1
```

---

## How It Works

1. **Install** places files into VS Code's global prompts folder (`~/.config/Code/User/prompts/agent-skills/`)
2. **Clones** `addyosmani/agent-skills` as the skill library
3. **Overlays** custom agent personas and commands on top
4. **Works globally** — all VS Code windows, all workspaces, all projects

### Architecture

```
┌─────────────────────────────────────────┐
│         addyosmani/agent-skills          │  ← 24 engineering skills
│  (spec-driven, TDD, code-review, etc.)  │
├─────────────────────────────────────────┤
│         vscode-agents (this repo)        │  ← 6 agent personas
│  product, tech-lead, frontend, backend,  │     + orchestration
│  tester, devops, orchestrator           │
├─────────────────────────────────────────┤
│           VS Code Copilot Chat           │  ← Natural language interface
│   "As tester-agent, review this file"   │
└─────────────────────────────────────────┘
```

---

## Supported Platforms

| OS             | Installer     | VS Code Path                                       |
| -------------- | ------------- | -------------------------------------------------- |
| macOS          | `install.sh`  | `~/Library/Application Support/Code/User/prompts/` |
| Ubuntu / Linux | `install.sh`  | `~/.config/Code/User/prompts/`                     |
| Windows        | `install.ps1` | `%APPDATA%\Code\User\prompts\`                     |

---

## Dependencies

- [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — auto-cloned during install
- VS Code with GitHub Copilot Chat extension
- Git (for cloning)

---

## Updating

```bash
# Pull latest skills + re-apply custom agents
cd ~/.config/Code/User/prompts/agent-skills && git pull
# Then re-run the install script
```

---

## License

MIT — see [LICENSE](LICENSE)

---

<p align="center">
  <sub>Built with ❤️ by <a href="https://github.com/handikadevs">Handikadevs</a></sub>
</p>
