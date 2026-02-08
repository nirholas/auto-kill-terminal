# Dev Containers Integration

Three ways to automatically add terminal management rules to every new project.

## Option 1: `postCreateCommand` (Simplest)

Add one line to your existing `.devcontainer/devcontainer.json`:

```json
{
  "postCreateCommand": "curl -fsSL https://raw.githubusercontent.com/nirholas/auto-kill-terminal/main/install.sh | bash -s -- --all"
}
```

This runs after the container is created and adds terminal rules to all agent instruction files. Uses `--all` to create files for Copilot, Claude, Gemini, Cursor, and AGENTS.md.

**Target specific agents:**

```json
{
  "postCreateCommand": "curl -fsSL https://raw.githubusercontent.com/nirholas/auto-kill-terminal/main/install.sh | bash -s -- --copilot --claude"
}
```

**Combine with your existing postCreateCommand:**

```json
{
  "postCreateCommand": "npm install && curl -fsSL https://raw.githubusercontent.com/nirholas/auto-kill-terminal/main/install.sh | bash -s -- --all"
}
```

## Option 2: Dev Container Feature (Cleanest)

> **Note:** This requires the feature to be published to a container registry. See the publishing steps below.

Add to your `.devcontainer/devcontainer.json`:

```json
{
  "features": {
    "ghcr.io/nirholas/auto-kill-terminal/auto-kill-terminal:1": {}
  }
}
```

With options:

```json
{
  "features": {
    "ghcr.io/nirholas/auto-kill-terminal/auto-kill-terminal:1": {
      "agents": "copilot"
    }
  }
}
```

Options:
| Option | Default | Values |
|---|---|---|
| `agents` | `"all"` | `all`, `copilot`, `claude`, `gemini`, `cursor` |

## Option 3: Dev Container Template (For New Projects)

Use the template in `devcontainer-template/` as a starting point for new repos. It includes:

- `.devcontainer/devcontainer.json` with the install script
- `.github/copilot-instructions.md` pre-configured
- `CLAUDE.md` pre-configured

Copy the template directory:

```bash
cp -r devcontainer-template/.devcontainer your-new-project/
cp devcontainer-template/CLAUDE.md your-new-project/
cp -r devcontainer-template/.github your-new-project/
```

## VS Code Settings (Bonus)

Add these VS Code settings to your devcontainer to help with terminal hygiene:

```json
{
  "customizations": {
    "vscode": {
      "settings": {
        "terminal.integrated.enablePersistentSessions": false
      }
    }
  }
}
```

This disables persistent terminal sessions, so terminals don't survive container rebuilds.

## How It Works

When using `postCreateCommand`:

```
1. Dev container is created
2. postCreateCommand runs install.sh
3. install.sh detects existing agent files or creates new ones
4. Terminal management rules are appended
5. AI agents read the rules and manage terminals properly
```

The rules are idempotent — running the installer multiple times won't duplicate the rules.

## Full Example: devcontainer.json

```json
{
  "name": "My Project",
  "image": "mcr.microsoft.com/devcontainers/typescript-node:20",

  "postCreateCommand": "npm install && curl -fsSL https://raw.githubusercontent.com/nirholas/auto-kill-terminal/main/install.sh | bash -s -- --all",

  "customizations": {
    "vscode": {
      "settings": {
        "terminal.integrated.enablePersistentSessions": false
      },
      "extensions": [
        "github.copilot"
      ]
    }
  }
}
```

