if status is-interactive
	wal -i ~/Pictures/Screenshot_20200731_090055.png >> /dev/null
	thefuck --alias | source
	starship init fish | source
	figlet "Welcome Back!" | lolcat
	cowsay -f tux "In a world without walls, who needs windows or gates?"| lolcat
	printf "Log in time: "
	date
    
end

bind -k ppage 'xdotool key Up; sleep 0.1; xdotool keydown control key a; sleep 0.1; xdotool keyup control; xdotool type "sudo "'
printf "%s\n" (date) >> /var/log/term_open
