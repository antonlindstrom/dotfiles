function fish_prompt --description 'Write out the prompt'
	#    if not set -q __fish_git_prompt_show_informative_status
	#        set -g __fish_git_prompt_show_informative_status 1
	#    end
	#    if not set -q __fish_git_prompt_color_branch
	#        set -g __fish_git_prompt_color_branch brmagenta
	#    end
	#    if not set -q __fish_git_prompt_showupstream
	#        set -g __fish_git_prompt_showupstream "informative"
	#    end
	#    if not set -q __fish_git_prompt_showdirtystate
	#        set -g __fish_git_prompt_showdirtystate "yes"
	#    end
	#    if not set -q __fish_git_prompt_color_stagedstate
	#        set -g __fish_git_prompt_color_stagedstate yellow
	#    end
	#    if not set -q __fish_git_prompt_color_invalidstate
	#        set -g __fish_git_prompt_color_invalidstate red
	#    end
	#    if not set -q __fish_git_prompt_color_cleanstate
	#        set -g __fish_git_prompt_color_cleanstate brgreen
	#    end
	#
	#    set short_pwd (string replace -r "^$HOME" '~' $PWD)
	#    if test $short_pwd != '~'
	#        set short_pwd (basename $short_pwd)
	#    end
	#
	#    set user_host (whoami)@(hostname):
	#    set end_prompt :(jobs | wc -l)\$
	#    set end_prompt "$end_prompt "
	#
	#    printf '%s%s%s%s' (set_color normal) $user_host (set_color green) $short_pwd (__fish_git_prompt) (set_color green) $end_prompt
end
