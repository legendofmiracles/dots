if status is-interactive
	thefuck --alias | source
	starship init fish | source
	# figlet "Welcome Back!" | lolcat
	# cowsay -f tux "In a world without walls, who needs windows or gates?"| lolcat
	printf "Log in time: "
	date
	fish_vi_key_bindings
	fish_vi_cursor
end

bind -k ppage 'xdotool key Up; sleep 0.1; xdotool keydown Escape key 0; sleep 0.1; xdotool keyup control; xdotool type "sudo "'
printf "%s\n" (date +%T\ %Y.%m.%d\ %a) >> /var/log/term_open
alias ls lsd
alias mv "mv -v"
alias rm "rm -v"
alias emacs "i3-swallow emacs"
alias shred "shred -v"
function cd
		 builtin cd $argv 2>&1 | sed s/"^cd: The directory"/"Bro, how the fuck did you even get so far in live?"/g | cut -d " " -f 1-12
end

#function cargo
#		 /usr/bin/env cargo $argv 2>&1 | sed s/"^error: could not find `Cargo.toml` in `\/"/"How stupid can one be? "/ | cut -d " " -f 1-5
#
#end

#function yay
#
#		 /usr/bin/yay $argv 2>&1 | sed s/"no packages match search"/"HAAHHAHAHAHAHHAHAH how stupid can one be?"/
#end
# function sudo
# 		 printf "[sudo] password for (echo $USER):"
#   		 read -sp "" password
# 		 /usr/bin/sudo $argv
# end
/bin/cat $HOME/.cache/wal/sequences
