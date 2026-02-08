# Auto Kill Terminal — Dev Container Template

A dev container template that comes pre-configured with terminal management rules for all major AI coding agents.

## What's included

```
your-new-project/
├── .devcontainer/
│   └── devcontainer.json          ← Runs install script on create
├── .github/
│   └── copilot-instructions.md    ← Terminal rules for Copilot
└── CLAUDE.md                       ← Terminal rules for Claude
```

## Usage

### From GitHub

1. Create a new repository from this template
2. Open in Codespaces or VS Code with Dev Containers
3. The `postCreateCommand` automatically sets up all agent files

### Manually

Copy the `.devcontainer/devcontainer.json` into your project and rebuild the container.

## Customization

Edit the `postCreateCommand` to change which agents get configured:

```json
// All agents
"postCreateCommand": "curl -fsSL https://raw.githubusercontent.com/nirholas/auto-kill-terminal/main/install.sh | bash -s -- --all"

// Copilot only
"postCreateCommand": "curl -fsSL https://raw.githubusercontent.com/nirholas/auto-kill-terminal/main/install.sh | bash -s -- --copilot"

// Copilot + Claude
"postCreateCommand": "curl -fsSL https://raw.githubusercontent.com/nirholas/auto-kill-terminal/main/install.sh | bash -s -- --copilot --claude"
```
