# Source .bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Silence macOS bash deprecation warning
export BASH_SILENCE_DEPRECATION_WARNING=1
