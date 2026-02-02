#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/helpers.sh"

CS="$(get_script_path cs)"

test_script_exists() {
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -x "$CS" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "cs script exists and is executable"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "cs script not found at $CS"
        print_skip "Skipping remaining tests - script not found"
        return 1
    fi
}

test_help_exits_zero() {
    if [[ ! -x "$CS" ]]; then
        print_skip "cs not found"
        return 0
    fi

    assert_exit_code 0 "$CS" --help
}

test_help_shows_usage() {
    if [[ ! -x "$CS" ]]; then
        print_skip "cs not found"
        return 0
    fi

    assert_contains "usage\|Usage\|USAGE" "$CS" --help
}

test_unknown_command_fails() {
    if [[ ! -x "$CS" ]]; then
        print_skip "cs not found"
        return 0
    fi

    assert_exit_code 1 "$CS" nope
}

test_status_command_forwards() {
    if [[ ! -x "$CS" ]]; then
        print_skip "cs not found"
        return 0
    fi

    # cs status should forward to cs-status -- help exits 0
    assert_exit_code 0 "$CS" status --help
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "=== Testing cs ==="
    run_tests
    print_summary
fi
