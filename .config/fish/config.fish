if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
    # thanks, kitty
    function ssh
        set -lx TERM xterm-256color
        command ssh $argv
    end
    alias gcfg="git --git-dir=$HOME/.cfg --work-tree=$HOME"
end
