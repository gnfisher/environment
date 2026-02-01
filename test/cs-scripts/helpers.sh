#!/usr/bin/env bash
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Path to cs-* scripts (adjust if needed)
SCRIPTS_DIR="${SCRIPTS_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/shared/.local/bin}"

# Mock environment path
MOCK_WORKSPACES=""

# Print colored output
print_pass() {
    echo -e "${GREEN}PASS${NC}: $1"
}

print_fail() {
    echo -e "${RED}FAIL${NC}: $1"
}

print_skip() {
    echo -e "${YELLOW}SKIP${NC}: $1"
}

# Assert that a command exits with expected code
# Usage: assert_exit_code <expected_code> <command> [args...]
assert_exit_code() {
    local expected="$1"
    shift
    local actual
    
    set +e
    "$@" > /dev/null 2>&1
    actual=$?
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ "$actual" -eq "$expected" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "exit code $actual == $expected for: $*"
        return 0
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "exit code $actual != $expected for: $*"
        return 1
    fi
}

# Assert that output contains a string
# Usage: assert_contains <needle> <command> [args...]
assert_contains() {
    local needle="$1"
    shift
    local output
    
    set +e
    output=$("$@" 2>&1)
    local exit_code=$?
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if echo "$output" | grep -q "$needle"; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "output contains '$needle' for: $*"
        return 0
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "output missing '$needle' for: $*"
        echo "  Actual output: $output"
        return 1
    fi
}

# Assert that output does NOT contain a string
# Usage: assert_not_contains <needle> <command> [args...]
assert_not_contains() {
    local needle="$1"
    shift
    local output
    
    set +e
    output=$("$@" 2>&1)
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if ! echo "$output" | grep -q "$needle"; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "output does not contain '$needle' for: $*"
        return 0
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "output unexpectedly contains '$needle' for: $*"
        return 1
    fi
}

# Assert that a file exists
# Usage: assert_file_exists <path>
assert_file_exists() {
    local path="$1"
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -e "$path" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "file exists: $path"
        return 0
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "file missing: $path"
        return 1
    fi
}

# Assert that a file does NOT exist
# Usage: assert_file_not_exists <path>
assert_file_not_exists() {
    local path="$1"
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ ! -e "$path" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "file does not exist: $path"
        return 0
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "file unexpectedly exists: $path"
        return 1
    fi
}

# Create a mock /workspaces structure in /tmp
# Usage: setup_mock_env
setup_mock_env() {
    MOCK_WORKSPACES=$(mktemp -d)
    
    # Create mock structure mimicking Codespaces
    mkdir -p "$MOCK_WORKSPACES/repo1/.git"
    mkdir -p "$MOCK_WORKSPACES/repo2/.git"
    mkdir -p "$MOCK_WORKSPACES/.codespaces"
    
    # Create some mock cache/temp files
    mkdir -p "$MOCK_WORKSPACES/repo1/node_modules/.cache"
    mkdir -p "$MOCK_WORKSPACES/repo1/tmp"
    mkdir -p "$MOCK_WORKSPACES/repo2/__pycache__"
    
    # Create some dummy files
    echo "test" > "$MOCK_WORKSPACES/repo1/tmp/temp-file.txt"
    echo "cache" > "$MOCK_WORKSPACES/repo1/node_modules/.cache/data"
    echo "pyc" > "$MOCK_WORKSPACES/repo2/__pycache__/module.pyc"
    
    # Create .git files
    echo "ref: refs/heads/main" > "$MOCK_WORKSPACES/repo1/.git/HEAD"
    echo "ref: refs/heads/main" > "$MOCK_WORKSPACES/repo2/.git/HEAD"
    
    export MOCK_WORKSPACES
    echo "$MOCK_WORKSPACES"
}

# Clean up mock environment
# Usage: teardown_mock_env
teardown_mock_env() {
    if [[ -n "${MOCK_WORKSPACES:-}" && -d "$MOCK_WORKSPACES" ]]; then
        rm -rf "$MOCK_WORKSPACES"
        unset MOCK_WORKSPACES
    fi
}

# Run all test_* functions in the calling script
# Usage: run_tests
run_tests() {
    local test_funcs
    test_funcs=$(declare -F | awk '{print $3}' | grep '^test_' || true)
    
    if [[ -z "$test_funcs" ]]; then
        echo "No test functions found"
        return 1
    fi
    
    for func in $test_funcs; do
        echo ""
        echo "--- Running: $func ---"
        set +e
        "$func"
        set -e
    done
}

# Print test summary and exit with appropriate code
# Usage: print_summary
print_summary() {
    echo ""
    echo "================================"
    echo "Test Summary"
    echo "================================"
    echo "Total:  $TESTS_RUN"
    echo -e "Passed: ${GREEN}$TESTS_PASSED${NC}"
    echo -e "Failed: ${RED}$TESTS_FAILED${NC}"
    echo "================================"
    
    if [[ "$TESTS_FAILED" -gt 0 ]]; then
        return 1
    fi
    return 0
}

# Check if a script exists
# Usage: script_exists <script_name>
script_exists() {
    local script="$1"
    [[ -x "$SCRIPTS_DIR/$script" ]]
}

# Get full path to a script
# Usage: get_script_path <script_name>
get_script_path() {
    local script="$1"
    echo "$SCRIPTS_DIR/$script"
}
