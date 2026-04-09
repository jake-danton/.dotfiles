set -l dbg_user (/usr/bin/id -un 2>&1)
set -l dbg_ids (/usr/bin/id 2>&1)
set -l dbg_shell_var "$SHELL"
set -l dbg_pwd (/bin/pwd 2>&1)
set -l dbg_pwdp (/bin/pwd -P 2>&1)
set -l dbg_ls_dot (/bin/ls -ld . 2>&1)
set -l dbg_stat_dot (/usr/bin/stat -c '%A %U:%G %a %n' . 2>&1)
set -l dbg_ws (/bin/ls -ld /workspaces /workspaces/banbe 2>&1)
set -l dbg_brew_paths (/bin/ls -ld /home/linuxbrew /home/linuxbrew/.linuxbrew /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/bin/brew /home/linuxbrew/.linuxbrew/bin/fish 2>&1)
printf 'fish debug: user=%s\n' "$dbg_user" >&2
printf 'fish debug: ids=%s\n' "$dbg_ids" >&2
printf 'fish debug: SHELL=%s\n' "$dbg_shell_var" >&2
printf 'fish debug: pwd=%s\n' "$dbg_pwd" >&2
printf 'fish debug: pwd -P=%s\n' "$dbg_pwdp" >&2
printf 'fish debug: ls .=%s\n' "$dbg_ls_dot" >&2
printf 'fish debug: stat .=%s\n' "$dbg_stat_dot" >&2
printf 'fish debug: workspaces=%s\n' "$dbg_ws" >&2
printf 'fish debug: brew-paths=%s\n' "$dbg_brew_paths" >&2

if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
else if test -x /usr/local/bin/brew
    /usr/local/bin/brew shellenv | source
else if test -x /home/linuxbrew/.linuxbrew/bin/brew
    /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
end

if status is-interactive
    fzf --fish | source
    starship init fish | source
    zoxide init fish | source
end
