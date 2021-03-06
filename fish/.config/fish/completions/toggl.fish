function __fish_toggl_needs_command
    set cmd (commandline -opc)
    if [ (count $cmd) -eq 1 -a $cmd[1] = "toggl" ]
        return 0
    end
    return 1
end

function __fish_toggl_using_command
    set cmd (commandline -opc)
    if [ (count $cmd) -gt 1 ]
        if [ $argv[1] = $cmd[2] ]
            return 0
        end
    end
    return 1
end

# Help
function __fish_toggl_help_topics
    for c in (toggl --generate-bash-completion)
        printf "%s\thelp topic\n" $c
    end
end

complete -f -c toggl -n "__fish_toggl_needs_command" -a help -d "Shows a list of commands or help for one command"
complete -f -c toggl -n "__fish_toggl_using_command help" -a "(__fish_toggl_help_topics)"

complete -f -c toggl -n "__fish_toggl_needs_command" -a "(toggl --generate-bash-completion)"
