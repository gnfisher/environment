#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/helpers.sh"

CS_SERVICES="$(get_script_path cs-services)"

test_script_exists() {
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -x "$CS_SERVICES" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "cs-services script exists and is executable"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "cs-services script not found at $CS_SERVICES"
        print_skip "Skipping remaining tests - script not found"
        return 1
    fi
}

test_help_exits_zero() {
    if [[ ! -x "$CS_SERVICES" ]]; then
        print_skip "cs-services not found"
        return 0
    fi
    
    assert_exit_code 0 "$CS_SERVICES" --help
}

test_help_shows_usage() {
    if [[ ! -x "$CS_SERVICES" ]]; then
        print_skip "cs-services not found"
        return 0
    fi
    
    assert_contains "usage\|Usage\|USAGE" "$CS_SERVICES" --help
}

test_status_exits_zero() {
    if [[ ! -x "$CS_SERVICES" ]]; then
        print_skip "cs-services not found"
        return 0
    fi
    
    assert_exit_code 0 "$CS_SERVICES" status
}

test_status_shows_services() {
    if [[ ! -x "$CS_SERVICES" ]]; then
        print_skip "cs-services not found"
        return 0
    fi
    
    # Status output should contain known service names
    assert_contains "github\|sweagentd\|capi\|mission-control" "$CS_SERVICES" status
}

test_unknown_command_fails() {
    if [[ ! -x "$CS_SERVICES" ]]; then
        print_skip "cs-services not found"
        return 0
    fi
    
    set +e
    "$CS_SERVICES" nonexistent_command >/dev/null 2>&1
    exit_code=$?
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ $exit_code -ne 0 ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "unknown command exits non-zero (exit code: $exit_code)"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "unknown command should exit non-zero but got $exit_code"
    fi
}

test_missing_service_for_start() {
    if [[ ! -x "$CS_SERVICES" ]]; then
        print_skip "cs-services not found"
        return 0
    fi
    
    set +e
    output=$("$CS_SERVICES" start 2>&1)
    exit_code=$?
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ $exit_code -ne 0 ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "start without service name exits non-zero (exit code: $exit_code)"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "start without service name should fail but got exit code $exit_code"
    fi
}

test_start_accepts_worktree_flag() {
    if [[ ! -x "$CS_SERVICES" ]]; then
        print_skip "cs-services not found"
        return 0
    fi

    set +e
    output=$("$CS_SERVICES" start github --worktree invalid 2>&1)
    exit_code=$?
    set -e

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ $exit_code -ne 0 ]] && echo "$output" | grep -qi "worktree\|directory not found"; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "worktree flag accepted (invalid worktree handled)"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "worktree flag not handled as expected (exit code: $exit_code)"
        echo "  Output: $output"
    fi
}

test_handles_invalid_service() {
    if [[ ! -x "$CS_SERVICES" ]]; then
        print_skip "cs-services not found"
        return 0
    fi
    
    set +e
    output=$("$CS_SERVICES" start invalid_service_name 2>&1)
    exit_code=$?
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    # Should exit non-zero and mention the invalid service
    if [[ $exit_code -ne 0 ]] && echo "$output" | grep -qi "unknown\|invalid\|error"; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "invalid service handled gracefully (exit code: $exit_code)"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "invalid service should fail gracefully (exit code: $exit_code)"
        echo "  Output: $output"
    fi
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "=== Testing cs-services ==="
    run_tests
    print_summary
fi
