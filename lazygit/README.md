# Documentation: Custom Commands in LazyGit

## Overview
LazyGit lets you add custom commands via its configuration file. Here’s how to set up a custom key binding for a Git push command.

## File Location
Save the configuration in:

```bash
~/.config/lazygit/config.yml
```

Create the file if it doesn’t exist.

## Custom Command Example
Add this to `config.yml`:

```yaml
customCommands:
  - key: '<c-p>'
    command: "git push origin HEAD:refs/for/master"
    context: 'global'
    loadingText: 'pushing'
```

### Key Details
- **key**: Key binding, e.g., `<c-p>` for "Ctrl + P."
- **command**: Git command to push towards `HEAD:/refs/for/master`
- **context**: Used when working in a trunk-based repo with Gerrit
- **loadingText**: Text shown while running the command.

## Applying Changes
1. Save the file in `~/.config/lazygit/`.
2. Restart LazyGit.

## Testing
1. Open LazyGit.
2. Stage files and create a commit.
2. Press `Ctrl + P`.
3. Confirm the command runs correctly and that the new commit is available in Gerrit.

## Notes
- Ensure you have push permissions.
- Adjust the `command` as needed.
- See the [LazyGit documentation](https://github.com/jesseduffield/lazygit#configuring) for more options.

