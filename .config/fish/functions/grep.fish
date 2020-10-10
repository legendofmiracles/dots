# Defined in - @ line 1
function grep --wraps='grep -in' --wraps='grep -in --color=auto' --description 'alias grep grep -in --color=auto'
 command grep -in --color=auto $argv;
end
