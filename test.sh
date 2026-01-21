#!/bin/bash
# Test script to validate environment setup
# Usage: ./test.sh

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
TESTS_PASSED=0
TESTS_FAILED=0

# Test functions
test_pass() {
    echo -e "${GREEN}✓${NC} $1"
    ((TESTS_PASSED++))
}

test_fail() {
    echo -e "${RED}✗${NC} $1"
    ((TESTS_FAILED++))
}

test_skip() {
    echo -e "${YELLOW}⊘${NC} $1 (skipped)"
}

echo "🧪 Running environment tests..."
echo ""

# Test 1: Check if shared dotfiles are stowed correctly
echo "Testing stowed configuration files..."

if [ -L "$HOME/.bashrc" ]; then
    test_pass "~/.bashrc is symlinked"
else
    test_fail "~/.bashrc is not symlinked"
fi

if [ -L "$HOME/.tmux.conf" ]; then
    test_pass "~/.tmux.conf is symlinked"
else
    test_fail "~/.tmux.conf is not symlinked"
fi

if [ -L "$HOME/.gitconfig" ]; then
    test_pass "~/.gitconfig is symlinked"
else
    test_fail "~/.gitconfig is not symlinked"
fi

if [ -d "$HOME/.config/nvim" ]; then
    test_pass "~/.config/nvim exists"
else
    test_fail "~/.config/nvim does not exist"
fi

if [ -d "$HOME/.config/fish" ]; then
    test_pass "~/.config/fish exists"
else
    test_fail "~/.config/fish does not exist"
fi

echo ""

# Test 2: Check for required tools
echo "Testing required tools..."

if command -v stow &>/dev/null; then
    test_pass "stow is installed"
else
    test_fail "stow is not installed"
fi

if command -v tmux &>/dev/null; then
    test_pass "tmux is installed"
else
    test_fail "tmux is not installed"
fi

if command -v nvim &>/dev/null; then
    test_pass "nvim is installed"
else
    test_fail "nvim is not installed"
fi

if command -v rg &>/dev/null; then
    test_pass "ripgrep (rg) is installed"
else
    test_fail "ripgrep (rg) is not installed"
fi

if command -v fd &>/dev/null || command -v fdfind &>/dev/null; then
    test_pass "fd/fdfind is installed"
else
    test_fail "fd/fdfind is not installed"
fi

if command -v jq &>/dev/null; then
    test_pass "jq is installed"
else
    test_fail "jq is not installed"
fi

if command -v fzf &>/dev/null; then
    test_pass "fzf is installed"
else
    test_fail "fzf is not installed"
fi

echo ""

# Test 3: Verify git configuration
echo "Testing git configuration..."

if git config --get user.name &>/dev/null; then
    test_pass "git user.name is configured"
else
    test_fail "git user.name is not configured"
fi

if git config --get user.email &>/dev/null; then
    test_pass "git user.email is configured"
else
    test_fail "git user.email is not configured"
fi

# Test git aliases
if git config --get alias.s &>/dev/null; then
    test_pass "git alias 's' is configured"
else
    test_fail "git alias 's' is not configured"
fi

if git config --get alias.l &>/dev/null; then
    test_pass "git alias 'l' is configured"
else
    test_fail "git alias 'l' is not configured"
fi

echo ""

# Test 4: Verify bash configuration
echo "Testing bash configuration..."

if [ -f "$HOME/.bashrc" ]; then
    if grep -q "alias ll=" "$HOME/.bashrc"; then
        test_pass "bash alias 'll' is defined"
    else
        test_fail "bash alias 'll' is not defined"
    fi
    
    if grep -q "alias g=" "$HOME/.bashrc" || grep -q 'alias g="git"' "$HOME/.bashrc"; then
        test_pass "bash alias 'g' is defined"
    else
        test_fail "bash alias 'g' is not defined"
    fi
fi

echo ""

# Test 5: Check tmux configuration
echo "Testing tmux configuration..."

if [ -f "$HOME/.tmux.conf" ]; then
    if grep -q "C-s" "$HOME/.tmux.conf"; then
        test_pass "tmux prefix is configured to C-s"
    else
        test_fail "tmux prefix C-s not found in config"
    fi
fi

echo ""

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Test Results:"
echo -e "${GREEN}Passed:${NC} $TESTS_PASSED"
echo -e "${RED}Failed:${NC} $TESTS_FAILED"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}✨ All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}❌ Some tests failed${NC}"
    exit 1
fi
