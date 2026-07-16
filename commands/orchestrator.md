---
description: Parallel fan-out orchestrator — dispatches to all relevant specialist agents concurrently, then merges their reports into a single synthesized output
---

Invoke the agent-skills:planning-and-task-breakdown skill first to understand and decompose the request. Also load agent-skills:using-agent-skills to understand how to correctly invoke and orchestrate all available skills across agents.

`/orchestrator` is a **parallel fan-out orchestrator**. It runs multiple specialist personas concurrently against the current task, then merges their outputs into a single synthesized response. The personas operate independently — no shared state, no ordering — which makes parallel execution safe and efficient.

## Phase 0 — Understand & Classify

First, understand what the user is asking. Classify the task into domains:

| Domain                               | Agents to Invoke                                                                      |
| ------------------------------------ | ------------------------------------------------------------------------------------- |
| **Feature development** (full-stack) | `product-agent`, `tech-lead-agent`, `frontend-agent`, `backend-agent`, `tester-agent` |
| **UI/UX work only**                  | `product-agent`, `frontend-agent`                                                     |
| **Backend work only**                | `tech-lead-agent`, `backend-agent`, `tester-agent`                                    |
| **Code review / Quality**            | `tech-lead-agent`, `tester-agent`                                                     |
| **Bug investigation**                | `tester-agent`, `tech-lead-agent`                                                     |
| **Infrastructure / Deploy**          | `devops-agent`, `tech-lead-agent`                                                     |
| **Security audit**                   | `tester-agent`, `devops-agent`                                                        |
| **Performance audit**                | `tester-agent`, `frontend-agent` (or `backend-agent`)                                 |
| **Launch / Ship**                    | ALL six agents                                                                        |
| **Product discovery**                | `product-agent`                                                                       |
| **Tech debt / Migration**            | `tech-lead-agent`, `devops-agent`                                                     |

If the user doesn't specify, classify based on the task description and default to the most relevant 2-3 agents.

## Phase A — Parallel Fan-out

Spawn the selected agents **concurrently in a single turn**. Each agent:

1. Loads its assigned skills (from its `skills:` frontmatter)
2. Analyzes the task from its domain perspective
3. Returns a structured report

**Agent Descriptions for Subagent Invocation:**

1. **`product-agent`** — Product specialist: specs, UI/UX, user research, design. Skills: spec-driven-development, idea-refine, interview-me, frontend-ui-engineering, api-and-interface-design, planning-and-task-breakdown, documentation-and-adrs, shipping-and-launch.

2. **`tech-lead-agent`** — Staff Engineer: architecture, code quality, refactoring, technical strategy. Skills: code-review-and-quality, code-simplification, context-engineering, incremental-implementation, planning-and-task-breakdown, source-driven-development, doubt-driven-development, deprecation-and-migration, git-workflow-and-versioning, using-agent-skills.

3. **`frontend-agent`** — Frontend specialist: UI engineering, browser testing, web performance. Skills: frontend-ui-engineering, browser-testing-with-devtools, performance-optimization, api-and-interface-design, code-simplification, test-driven-development.

4. **`backend-agent`** — Backend specialist: API design, database, server performance, security. Skills: api-and-interface-design, performance-optimization, context-engineering, code-simplification, test-driven-development, security-and-hardening.

5. **`tester-agent`** — QA/QC specialist: testing, debugging, security audit, observability. Skills: test-driven-development, code-review-and-quality, debugging-and-error-recovery, browser-testing-with-devtools, security-and-hardening, observability-and-instrumentation, performance-optimization.

6. **`devops-agent`** — DevOps/SRE specialist: CI/CD, infrastructure, deployment, monitoring. Skills: ci-cd-and-automation, shipping-and-launch, git-workflow-and-versioning, observability-and-instrumentation, security-and-hardening, deprecation-and-migration.

**Prompt each agent with:** The user's original request. Let each agent apply its own domain lens. Do not pre-filter or redirect — the value of parallel fan-out is in diverse perspectives.

## Phase B — Merge & Synthesize

Once all reports are back, synthesize them into a single output:

```markdown
## 🎯 Orchestrator Synthesis

### Task Summary

[One-paragraph summary of what was asked and what was found]

### Key Findings (by Domain)

#### 🏗️ Architecture & Strategy (tech-lead-agent)

[Key architectural decisions, trade-offs, risks]

#### 🎨 Product & UX (product-agent)

[User impact, spec gaps, UX considerations]

#### 💻 Frontend (frontend-agent)

[UI implementation notes, performance, accessibility]

#### ⚙️ Backend (backend-agent)

[API design, database, security, performance]

#### 🧪 Quality & Security (tester-agent)

[Test coverage gaps, bugs, vulnerabilities]

#### 🚀 Infrastructure (devops-agent)

[CI/CD, deployment, monitoring, rollback plan]

### Consolidated Action Items

| #   | Action   | Owner   | Priority             |
| --- | -------- | ------- | -------------------- |
| 1   | [Action] | [Agent] | Critical/High/Medium |

### Risk Assessment

- **Blockers:** [Any issue that must be resolved before proceeding]
- **Risks:** [Known risks and mitigation strategies]
- **Open Questions:** [Questions that need stakeholder input]

### Recommendation

[Clear, actionable recommendation — "proceed," "pause and fix X," "more research needed on Y"]
```

## Phase C — Next Steps

End with a clear call to action. What should the user do next? Which agent should they invoke for deeper analysis on a specific area?

## Constraints

- Subagents cannot spawn other subagents — each agent works independently
- Issue all parallel agent calls in a single turn for maximum efficiency
- If a domain is not relevant to the task, skip that agent rather than forcing a report
- The merge step stays in the main context — it must be concise
