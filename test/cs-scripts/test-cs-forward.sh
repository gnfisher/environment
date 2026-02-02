#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/helpers.sh"

CS_FORWARD="$(get_script_path cs-forward)"

test_script_exists() {
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -x "$CS_FORWARD" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "cs-forward script exists and is executable"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "cs-forward script not found at $CS_FORWARD"
        print_skip "Skipping remaining tests - script not found"
        return 1
    fi
}

test_help_exits_zero() {
    if [[ ! -x "$CS_FORWARD" ]]; then
        print_skip "cs-forward not found"
        return 0
    fi

    assert_exit_code 0 "$CS_FORWARD" --help
}

test_help_shows_usage() {
    if [[ ! -x "$CS_FORWARD" ]]; then
        print_skip "cs-forward not found"
        return 0
    fi

    assert_contains "usage\|Usage\|USAGE" "$CS_FORWARD" --help
}

test_dry_run_ports_override() {
    if [[ ! -x "$CS_FORWARD" ]]; then
        print_skip "cs-forward not found"
        return 0
    fi

    assert_exit_code 0 "$CS_FORWARD" --ports 3000,8080 --dry-run
}

test_dry_run_shows_command() {
    if [[ ! -x "$CS_FORWARD" ]]; then
        print_skip "cs-forward not found"
        return 0
    fi

    assert_contains "gh codespace ports forward" "$CS_FORWARD" --ports 3000 --dry-run
}

test_status_exits_zero() {
    if [[ ! -x "$CS_FORWARD" ]]; then
        print_skip "cs-forward not found"
        return 0
    fi

    assert_exit_code 0 "$CS_FORWARD" status
}

test_stop_exits_zero() {
    if [[ ! -x "$CS_FORWARD" ]]; then
        print_skip "cs-forward not found"
        return 0
    fi

    assert_exit_code 0 "$CS_FORWARD" stop
}

test_invalid_ports_rejected() {
    if [[ ! -x "$CS_FORWARD" ]]; then
        print_skip "cs-forward not found"
        return 0
    fi

    set +e
    output=$("$CS_FORWARD" --ports invalid --dry-run 2>&1)
    exit_code=$?
    set -e

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ $exit_code -ne 0 ]] && echo "$output" | grep -qi "no valid ports"; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "invalid ports rejected"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "invalid ports not rejected (exit: $exit_code)"
    fi
}

test_unknown_flag_fails() {
    if [[ ! -x "$CS_FORWARD" ]]; then
        print_skip "cs-forward not found"
        return 0
    fi

    assert_exit_code 1 "$CS_FORWARD" --nope
}

test_ports_range_parsing() {
    if [[ ! -x "$CS_FORWARD" ]]; then
        print_skip "cs-forward not found"
        return 0
    fi

    assert_contains "3000 3001 3002" "$CS_FORWARD" --ports 3000-3002 --dry-run
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "=== Testing cs-forward ==="
    run_tests
    print_summary
fi
