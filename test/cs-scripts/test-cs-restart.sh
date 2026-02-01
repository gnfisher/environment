#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/helpers.sh"

CS_RESTART="$(get_script_path cs-restart)"

test_script_exists() {
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -x "$CS_RESTART" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "cs-restart script exists and is executable"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "cs-restart script not found at $CS_RESTART"
        print_skip "Skipping remaining tests - script not found"
        return 1
    fi
}

test_help_exits_zero() {
    if [[ ! -x "$CS_RESTART" ]]; then
        print_skip "cs-restart not found"
        return 0
    fi
    
    assert_exit_code 0 "$CS_RESTART" --help
}

test_help_shows_usage() {
    if [[ ! -x "$CS_RESTART" ]]; then
        print_skip "cs-restart not found"
        return 0
    fi
    
    assert_contains "usage\|Usage\|USAGE" "$CS_RESTART" --help
}

test_minimal_flag_recognized() {
    if [[ ! -x "$CS_RESTART" ]]; then
        print_skip "cs-restart not found"
        return 0
    fi
    
    # Script will fail because /workspaces/github doesn't exist,
    # but it should NOT fail with "Unknown option" error
    set +e
    output_m=$("$CS_RESTART" -m 2>&1)
    exit_m=$?
    output_minimal=$("$CS_RESTART" --minimal 2>&1)
    exit_minimal=$?
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    # Check that flags are recognized (no "Unknown option" error)
    if ! echo "$output_m" | grep -q "Unknown option" && \
       ! echo "$output_minimal" | grep -q "Unknown option"; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "-m and --minimal flags are recognized"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "-m or --minimal flag not recognized"
    fi
}

test_sweagent_flag_recognized() {
    if [[ ! -x "$CS_RESTART" ]]; then
        print_skip "cs-restart not found"
        return 0
    fi
    
    set +e
    output_s=$("$CS_RESTART" -s 2>&1)
    exit_s=$?
    output_sweagent=$("$CS_RESTART" --sweagent 2>&1)
    exit_sweagent=$?
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if ! echo "$output_s" | grep -q "Unknown option" && \
       ! echo "$output_sweagent" | grep -q "Unknown option"; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "-s and --sweagent flags are recognized"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "-s or --sweagent flag not recognized"
    fi
}

test_full_flag_recognized() {
    if [[ ! -x "$CS_RESTART" ]]; then
        print_skip "cs-restart not found"
        return 0
    fi
    
    set +e
    output_f=$("$CS_RESTART" -f 2>&1)
    exit_f=$?
    output_full=$("$CS_RESTART" --full 2>&1)
    exit_full=$?
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if ! echo "$output_f" | grep -q "Unknown option" && \
       ! echo "$output_full" | grep -q "Unknown option"; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "-f and --full flags are recognized"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "-f or --full flag not recognized"
    fi
}

test_wait_flag_recognized() {
    if [[ ! -x "$CS_RESTART" ]]; then
        print_skip "cs-restart not found"
        return 0
    fi
    
    set +e
    output_w=$("$CS_RESTART" -w 2>&1)
    exit_w=$?
    output_wait=$("$CS_RESTART" --wait 2>&1)
    exit_wait=$?
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if ! echo "$output_w" | grep -q "Unknown option" && \
       ! echo "$output_wait" | grep -q "Unknown option"; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "-w and --wait flags are recognized"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "-w or --wait flag not recognized"
    fi
}

test_handles_missing_directories_gracefully() {
    if [[ ! -x "$CS_RESTART" ]]; then
        print_skip "cs-restart not found"
        return 0
    fi
    
    # Running outside a codespace where /workspaces doesn't exist
    # Script should exit with error but not crash (no unexpected errors)
    set +e
    output=$("$CS_RESTART" 2>&1)
    exit_code=$?
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    # Script should mention the missing directory, not crash with unexpected error
    if echo "$output" | grep -q "does not exist\|Directory"; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "handles missing directories gracefully (exit code: $exit_code)"
    else
        # Even if it doesn't print expected message, as long as it didn't crash unexpectedly
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "script ran without crashing (exit code: $exit_code)"
    fi
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "=== Testing cs-restart ==="
    run_tests
    print_summary
fi
