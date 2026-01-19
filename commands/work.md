---
allowed-tools: Bash(bd *), Bash(git *), Bash(pwd:*), Skill(start)
argument-hint: [optional: bead-id]
description: Work on a bead - auto-selects highest priority or accepts specific bead ID
context: fork
agent: general-purpose
---

## Current Context

- Ready beads: !`bd ready`
- Blocked beads: !`bd blocked`
- Current worktrees: !`git worktree list`
- Current directory: !`pwd`
- Current branch: !`git branch --show-current`

## Autonomous Work Session

Work autonomously through all steps without stopping for confirmation. Complete the bead, commit changes, capture discovered work, and close. Only stop if genuinely blocked or need clarification on requirements.

## Workflow

### 1. Select and Claim

**If bead ID provided** (`$1` exists):
- Use bead ID: `$1`
- Verify it exists: `bd show $1`
- Check if ready to work (no blockers)

**If no bead ID provided**:
- Run `bd ready` and pick the highest-priority bead
- If no ready beads: run `bd blocked`, report issues, and exit

**Claim the bead**:
```bash
bd update <bead-id> --claim
```

### 2. Prepare Workspace

Check existing worktrees:
```bash
git worktree list
```

**Decision**:
- If appropriate worktree exists for this work, switch to it
- Otherwise, run `/start` to create new worktree

### 3. Read and Understand

Read the bead details carefully:
```bash
bd show <bead-id>
```

Understand:
- What the acceptance criteria are
- What the scope is (and isn't)
- Any dependencies or constraints
- Expected outcome

### 4. Execute Work

Complete the bead following these principles:
- **Stay focused** on acceptance criteria
- **Don't wander** into related improvements
- **Apply YAGNI** ruthlessly (You Aren't Gonna Need It)
- **Write clean code** that meets requirements
- **Test your changes** as you go

### 5. Commit Changes

Stage and commit relevant changes:
```bash
git add <relevant-files>
git commit -m "$(cat <<'EOF'
<type>: <description>

<optional details if needed>

Refs: <bead-id>
EOF
)"
```

**Commit type examples**:
- `✨ feat:` for new features
- `🔒️ fix:` for bug fixes
- `♻️ refactor:` for code improvements
- `💡 docs:` for documentation
- `📋 test:` for tests
- `🎨 style:` for code reformatting or style changes
- `📦️ chore:` for build process, tools changes etc.

### 6. Capture Discovered Work

**Be ruthless about YAGNI** - only capture legitimate discovered work:

Create new beads for:
- ✅ Bugs discovered during implementation
- ✅ Missing dependencies that block current work
- ✅ Technical debt that must be addressed

Do NOT create beads for:
- ❌ "Nice to have" improvements
- ❌ "While we're here" refactorings
- ❌ Hypothetical future needs

**Create discovered beads**:
```bash
bd create \
  --title="<specific title>" \
  --description="<clear description>" \
  --type=<type> \
  --priority=<priority>
```

**Link dependencies if needed**:
```bash
bd dep add <new-bead-id> <current-bead-id>
```

### 7. Close Bead

Mark the bead as complete:
```bash
bd close <bead-id>
```

Verify closure:
```bash
bd show <bead-id>
```

## Success Criteria

- ✅ Bead status is "closed"
- ✅ All acceptance criteria met
- ✅ Changes are committed with bead ID reference
- ✅ Any discovered work captured as new beads
- ✅ No scope creep or unnecessary work done

## Important Reminders

- **Autonomous operation**: Don't ask for permission at each step, just execute
- **Focus**: Complete this bead, nothing more
- **YAGNI**: Be ruthless about scope
- **Quality**: Write clean, tested code
- **Context**: Include bead ID in commit message
- **Capture**: Document discovered work as new beads, don't do it now
