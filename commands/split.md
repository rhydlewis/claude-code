---
allowed-tools: Bash(bd *), AskUserQuestion
argument-hint: "<bead-id>"
description: Decompose large work items into smaller, manageable beads using proven decomposition strategies
---

## Work Item Decomposition

Break down complex work items into smaller, more manageable pieces using proven decomposition strategies.

## Usage

/split <bead-id>

## Current Context

Bead ID to split: `$1`

First, show the bead details by running `bd show $1`

## Decomposition Strategies

Choose the appropriate pattern based on the work:

1. **Vertical Slicing** (by user value) - Each slice delivers value, crosses all layers (UI → API → DB)
   - Best for: Feature development, user stories

2. **Horizontal Slicing** (by technical layer) - Split by DB, backend, frontend, integration
   - Best for: Technical refactoring, infrastructure work

3. **Risk-Based** - Spike/research first, then implementation with known solutions
   - Best for: Novel features, unclear requirements, technical unknowns

4. **Dependency-Based** - Identify independent work vs. sequential work
   - Best for: Large features, team coordination, parallel development

5. **Scope-Based** - MVP → Enhancement → Polish
   - Best for: Time-constrained work, iterative delivery

6. **Acceptance Criteria** - One bead per major criterion
   - Best for: Well-defined requirements with clear criteria

## Process

### Step 1: Analyze the Bead

Read and analyze:
- Title, description, acceptance criteria
- Type, priority, current status
- Existing dependencies
- Complexity indicators (size, uncertainty, risk)

### Step 2: Choose Strategy

Use AskUserQuestion to determine:
- What makes this work too large or risky?
- Are there natural boundaries or stages?
- Are there unknowns needing research first?
- Can parts be done independently?
- Is there a minimum viable scope?

Present strategy options and get user confirmation.

### Step 3: Propose Breakdown

Present decomposition plan:
- List each proposed bead with title and brief description
- Explain rationale
- Show dependencies between beads
- Identify which can be done in parallel
- Suggest priorities

Ask for confirmation or adjustments via AskUserQuestion.

### Step 4: Create New Beads

For each split item:
```bash
bd create \
  --title="[Specific title]" \
  --description="[Clear description with context]" \
  --type=[type] \
  --priority=[inherited or adjusted] \
  --labels="split-from-$1"
```

Capture the new bead IDs.

### Step 5: Establish Dependencies

Link beads with dependencies:
```bash
# If bead-002 depends on bead-001
bd dep add beads-xxx-002 beads-xxx-001

# Multiple beads depending on foundation
bd dep add beads-xxx-003 beads-xxx-001
bd dep add beads-xxx-004 beads-xxx-001
```

### Step 6: Update Original Bead

Mark the original as split:
```bash
bd update $1 \
  --add-label="split" \
  --status="closed" \
  --description="Split into smaller beads:
- beads-xxx-001: [title]
- beads-xxx-002: [title]
- beads-xxx-003: [title]

Original description:
[preserved original description]"
```

### Step 7: Summarize

Present:
- Original bead ID and title
- Number of new beads created
- Dependency structure
- Suggested work order (based on `bd ready`)
- Recommended next action

## Example: Risk-Based Decomposition

**Original**: "Integrate with third-party payment API"
**Analysis**: High uncertainty, unclear API behavior

**Split into**:
1. "Spike: Research payment API and create proof-of-concept" (P0)
2. "Implement payment API integration (core flow)" (P0, depends on #1)
3. "Add payment error handling and retries" (P1, depends on #2)
4. "Add payment webhooks for status updates" (P2, depends on #2)

Dependencies: All depend on spike to reduce risk. #3 and #4 can be parallel after #2.

## Guidelines

### DO:
- ✅ Preserve original context in split descriptions
- ✅ Use clear, specific titles explaining what each bead accomplishes
- ✅ Add `split-from-<id>` labels for traceability
- ✅ Create dependencies reflecting true technical constraints
- ✅ Consider what can be done in parallel
- ✅ Ensure each bead is independently testable
- ✅ Keep beads small enough to complete in one focused session (1-4 hours)

### DON'T:
- ❌ Create too many tiny beads (overhead costs matter)
- ❌ Over-decompose simple work
- ❌ Create circular dependencies
- ❌ Split without understanding user's constraints
- ❌ Lose important context from original
- ❌ Make beads dependent when they could be parallel

## Bead Sizing

**Good**: 1-4 hours focused work, completable in single session, clear acceptance criteria
**Too small**: < 30 minutes, no meaningful deliverable, pure overhead
**Too large**: > 8 hours, multiple concerns mixed, hard to review, high rework risk

## Workflow Summary

1. **Read**: Understand the work item via `bd show $1`
2. **Analyze**: Identify why it needs splitting (size, risk, complexity)
3. **Strategize**: Choose appropriate decomposition strategy
4. **Propose**: Present breakdown with rationale
5. **Confirm**: Get user agreement via AskUserQuestion
6. **Create**: Generate new beads with `bd create`
7. **Link**: Establish dependencies with `bd dep add`
8. **Close**: Update original bead to reference split
9. **Summarize**: Present next steps
