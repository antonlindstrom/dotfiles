# kubeless serverless on kubernetes

set -x

#
# Condition functions
#
function __fish_kubeless_needs_command
    set cmd (commandline -opc)
    if [ (count $cmd) -eq 1 -a $cmd[1] = "kubeless" ]
        return 0
    end
    return 1
end

function __fish_kubeless_using_command
    set cmd (commandline -opc)
    if [ (count $cmd) -gt 1 ]
        if [ $argv[1] = $cmd[2] ]
            return 0
        end
    end
    return 1
end

#
# List functions
#
function __fish_kubeless_available
    set cmd (commandline -opc)
    if [ (count $cmd) -gt 2 ]
        return 1
    end
    kubeless $argv[1] | awk '/Available/ {flag=1;next} /Flags/{flag=0} flag { print $1 }'
    return 0
end

function __fish_kubeless_functions
    kubeless function list -o json | jq -r .[].metadata.name
end

complete -f -c kubeless -n "__fish_kubeless_needs_command" -a "(__fish_kubeless_available)"

complete -f -c kubeless -n "__fish_kubeless_using_command autoscale" -a "(__fish_kubeless_available autoscale)"
complete -f -c kubeless -n "__fish_kubeless_using_command function" -a "(__fish_kubeless_available function)"
complete -f -c kubeless -n "__fish_kubeless_using_command topic" -a "(__fish_kubeless_available topic)"
complete -f -c kubeless -n "__fish_kubeless_using_command trigger" -a "(__fish_kubeless_available trigger)"
