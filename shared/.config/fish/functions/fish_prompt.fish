# Simple prompt: folderName$
function fish_prompt
    echo -n (basename $PWD)'$ '
end
