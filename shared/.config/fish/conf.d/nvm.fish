# NVM (lazy load)
status is-interactive; or return
set -gx NVM_DIR "$HOME/.nvm"
if test -d "$NVM_DIR"
    function __nvm_load --description "Lazy-load nvm"
        functions -e __nvm_load
        if test -f "$NVM_DIR/nvm.sh"
            bash "$NVM_DIR/nvm.sh" --no-use >/dev/null 2>&1
        end
    end
    function nvm
        __nvm_load
        command nvm $argv
    end
    function node
        __nvm_load
        command node $argv
    end
    function npm
        __nvm_load
        command npm $argv
    end
    function npx
        __nvm_load
        command npx $argv
    end
end
