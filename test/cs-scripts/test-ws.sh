#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/helpers.sh"

WS="$(get_script_path ws)"

test_script_exists() {
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -x "$WS" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "ws script exists and is executable"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "ws script not found at $WS"
        print_skip "Skipping remaining tests - script not found"
        return 1
    fi
}

test_help_exits_zero() {
    if [[ ! -x "$WS" ]]; then
        print_skip "ws not found"
        return 0
    fi
    
    assert_exit_code 0 "$WS" --help
}

test_help_shows_usage() {
    if [[ ! -x "$WS" ]]; then
        print_skip "ws not found"
        return 0
    fi
    
    assert_contains "usage\|Usage\|USAGE" "$WS" --help
}

test_list_exits_zero() {
    if [[ ! -x "$WS" ]]; then
        print_skip "ws not found"
        return 0
    fi
    
    assert_exit_code 0 "$WS" list
}

test_list_no_worktrees_message() {
    if [[ ! -x "$WS" ]]; then
        print_skip "ws not found"
        return 0
    fi
    
    # Create a temporary empty directory to test with
    local temp_dir
    temp_dir=$(mktemp -d)
    
    set +e
    output=$(WS_BASE_DIR="$temp_dir" "$WS" list 2>&1)
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if echo "$output" | grep -qi "no worktrees found\|No worktrees"; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "output contains 'No worktrees found' message"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "output missing 'No worktrees found' message"
        echo "  Actual output: $output"
    fi
    
    rm -rf "$temp_dir"
}

test_unknown_command_fails() {
    if [[ ! -x "$WS" ]]; then
        print_skip "ws not found"
        return 0
    fi
    
    set +e
    "$WS" nonexistent-command > /dev/null 2>&1
    local exit_code=$?
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ "$exit_code" -ne 0 ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "unknown command exits non-zero (exit code: $exit_code)"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "unknown command should exit non-zero, got: $exit_code"
    fi
}

test_new_requires_args() {
    if [[ ! -x "$WS" ]]; then
        print_skip "ws not found"
        return 0
    fi
    
    set +e
    "$WS" new > /dev/null 2>&1
    local exit_code=$?
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ "$exit_code" -ne 0 ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "ws new without args exits non-zero (exit code: $exit_code)"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "ws new without args should exit non-zero, got: $exit_code"
    fi
}

test_invalid_repo_rejected() {
    if [[ ! -x "$WS" ]]; then
        print_skip "ws not found"
        return 0
    fi
    
    set +e
    output=$("$WS" new invalid-repo test-worktree 2>&1)
    local exit_code=$?
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ "$exit_code" -ne 0 ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "ws new with invalid repo exits non-zero (exit code: $exit_code)"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "ws new with invalid repo should exit non-zero, got: $exit_code"
    fi
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "=== Testing ws ==="
    run_tests
    print_summary
fi
