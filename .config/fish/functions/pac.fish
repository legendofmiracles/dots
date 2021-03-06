function pac 
  paru -Slq | sk --multi --preview 'paru -Si {1}' | xargs -ro paru -S $argv;
end
