# Defined in - @ line 1
function pac --wraps=pacman\ -Slq\ \|\ fzf\ --multi\ --preview\ \'pacman\ -Si\ \{1\}\'\ \|\ xargs\ -ro\ sudo\ pacman\ -S --description alias\ pac\ pacman\ -Slq\ \|\ fzf\ --multi\ --preview\ \'pacman\ -Si\ \{1\}\'\ \|\ xargs\ -ro\ sudo\ pacman\ -S
  pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro yas pacman -S $argv;
end
