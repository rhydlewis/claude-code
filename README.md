# Claude Code Commands

Custom slash commands for [Claude Code](https://code.claude.com) to streamline workflow with the Beads issue tracking system.

## Commands

### `/refine [optional: idea description]`
Interactive tool to refine vague ideas into well-defined, actionable work items.

Guides you through a 9-phase process to transform rough ideas into crisp beads with:
- Clear problem statements
- Work type classification
- Well-defined scope boundaries
- Concrete acceptance criteria
- Risk assessment
- Appropriate prioritization

**Usage**: `/refine` or `/refine add user authentication`

---

### `/split <bead-id>`
Decompose large work items into smaller, manageable beads using proven decomposition strategies.

Supports 6 decomposition patterns:
- Vertical slicing (by user value)
- Horizontal slicing (by technical layer)
- Risk-based (spike first)
- Dependency-based (parallel vs sequential)
- Scope-based (MVP → enhancement → polish)
- Acceptance criteria-based

**Usage**: `/split beads-project-123`

---

### `/work [optional: bead-id]`
Autonomous work session. Auto-selects highest-priority ready bead or works on specified bead ID. Completes the work, commits changes, captures discovered work, and closes the bead.

Workflow:
1. Select highest-priority ready bead (or use provided ID)
2. Claim the bead
3. Prepare workspace (worktrees)
4. Execute the work following acceptance criteria
5. Commit with bead ID reference
6. Capture discovered work as new beads (YAGNI applied ruthlessly)
7. Close the bead

**Usage**: `/work` (auto-select) or `/work beads-project-456` (specific bead)

## Installation

### Quick Install

```bash
./deploy.sh
```

This copies all commands from `commands/` to `~/.claude/commands/`.

### Manual Install

```bash
cp commands/*.md ~/.claude/commands/
```

## Usage

Once installed, commands are available in any Claude Code session:

1. Type `/` to see available commands
2. Select a command from the autocomplete menu
3. Follow the interactive prompts

## Development

### Repository Structure

```
.
├── commands/           # Source command files
│   ├── refine.md
│   ├── split.md
│   └── work.md
├── deploy.sh          # Deployment script
└── README.md
```

### Adding New Commands

1. Create a new `.md` file in `commands/`
2. Add frontmatter with metadata:
   ```markdown
   ---
   allowed-tools: Bash(bd *), AskUserQuestion
   argument-hint: [optional-arg]
   description: Brief description
   ---
   ```
3. Write the command prompt
4. Run `./deploy.sh` to install

### Best Practices

- Keep commands focused and single-purpose
- Use `argument-hint` to document expected parameters
- Leverage `allowed-tools` to restrict permissions
- Use `!` prefix for bash context gathering
- Include clear DO/DON'T guidelines
- Provide workflow summaries

## Resources

- [Claude Code Documentation](https://code.claude.com/docs)
- [Custom Slash Commands Guide](https://code.claude.com/docs/en/slash-commands#custom-slash-commands)
- [Anthropic Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)

## License

MIT
