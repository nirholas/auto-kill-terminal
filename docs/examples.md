# auto-kill-terminal examples

Stop AI agents from leaving zombie terminals in VS Code and GitHub Codespaces. Copy-paste terminal management rules for GitHub Copilot, Claude Code, Gemini, Cursor, Windsurf, and more.

## Example 1

```text
█████╗ ██╗   ██╗████████╗ ██████╗       ██╗  ██╗██╗██╗     ██╗     
  ██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗      ██║ ██╔╝██║██║     ██║     
  ███████║██║   ██║   ██║   ██║   ██║█████╗█████╔╝ ██║██║     ██║     
  ██╔══██║██║   ██║   ██║   ██║   ██║╚════╝██╔═██╗ ██║██║     ██║     
  ██║  ██║╚██████╔╝   ██║   ╚██████╔╝      ██║  ██╗██║███████╗███████╗
  ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝       ╚═╝  ╚═╝╚═╝╚══════╝╚══════╝
                    ████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗ █████╗ ██╗     
                    ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗██║     
                       ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║███████║██║     
                       ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██╔══██║██║     
                       ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗
                       ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝
```

## Example 2

```bash
# Option 1: Clone and copy what you need
git clone https://github.com/nirholas/auto-kill-terminal.git
cp auto-kill-terminal/.github/copilot-instructions.md your-project/.github/

# Option 2: Just copy the 5 bullet points from "The Fix" into your existing instruction file
```

## Example 3

```text
Agent                                Terminal
    |                                      |
    |-- run_in_terminal -----------------> | (isBackground: true)
    |   <-- terminal_id: a7b3c9d1          |
    |                                      |
    |-- await_terminal ------------------> | (wait for completion)
    |   <-- output + exit code             |
    |                                      |
    |-- kill_terminal -------------------> | x_x
    |                                      X
    |
    |-- (clean slate for next command)
```


Every snippet above is taken from the [repository documentation](https://github.com/nirholas/auto-kill-terminal#readme).
