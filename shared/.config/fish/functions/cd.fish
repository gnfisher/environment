# cd with ls
function cd --wraps=cd
    if test (count $argv) -eq 0
        builtin cd $HOME; and ls
    else
        builtin cd $argv; and ls
    end
end
