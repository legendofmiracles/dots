if status is-interactive
	wal -i ~/Pictures/Screenshot_20200731_090055.png >> /dev/null
	thefuck --alias | source
	starship init fish | source
	figlet "Welcome Back!" | lolcat
	cowsay -f tux "In a world without walls, who needs windows or gates?"| lolcat
	printf "Log in time: "
	date
	fish_vi_key_bindings
	fish_vi_cursor
end

bind -k ppage 'xdotool key Up; sleep 0.1; xdotool keydown Escape key 0; sleep 0.1; xdotool keyup control; xdotool type "sudo "'
printf "%s\n" (date) >> /var/log/term_open
alias ls lsd
alias mv "mv -v"
alias emacs "i3-swallow emacs"
alias doas "doas --"

function cd
		 builtin cd $argv 2>&1 | sed s/"^cd: The directory"/"Bro, how the fuck did you even get so far in live?"/g | cut -d " " -f 1-12

end

# function sudo
# 		 printf "[sudo] password for (echo $USER):"
#   		 read -sp "" password
# 		 /usr/bin/sudo $argv
# end
