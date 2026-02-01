#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/helpers.sh"

CS_UPDATE="$(get_script_path cs-update)"

test_script_exists() {
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -x "$CS_UPDATE" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "cs-update script exists and is executable"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "cs-update script not found at $CS_UPDATE"
        print_skip "Skipping remaining tests - script not found"
        return 1
    fi
}

test_help_exits_zero() {
    if [[ ! -x "$CS_UPDATE" ]]; then
        print_skip "cs-update not found"
        return 0
    fi
    
    assert_exit_code 0 "$CS_UPDATE" --help
}

test_help_shows_usage() {
    if [[ ! -x "$CS_UPDATE" ]]; then
        print_skip "cs-update not found"
        return 0
    fi
    
    assert_contains "usage\|Usage\|USAGE" "$CS_UPDATE" --help
}

test_dry_run_exits_zero() {
    if [[ ! -x "$CS_UPDATE" ]]; then
        print_skip "cs-update not found"
        return 0
    fi
    
    assert_exit_code 0 "$CS_UPDATE" --dry-run
}

test_dry_run_shows_repos() {
    if [[ ! -x "$CS_UPDATE" ]]; then
        print_skip "cs-update not found"
        return 0
    fi
    
    # Dry run should mention repositories (github, sweagentd)
    assert_contains "github\|sweagentd\|repo\|Repo\|REPO" "$CS_UPDATE" --dry-run
}

test_dry_run_no_changes() {
    if [[ ! -x "$CS_UPDATE" ]]; then
        print_skip "cs-update not found"
        return 0
    fi
    
    # Dry run should indicate no changes will be made
    assert_contains "no changes\|No changes\|NO CHANGES\|dry\|Dry\|DRY\|would\|Would\|WOULD" "$CS_UPDATE" --dry-run
}

test_invalid_repo_handled() {
    if [[ ! -x "$CS_UPDATE" ]]; then
        print_skip "cs-update not found"
        return 0
    fi
    
    # Invalid repo should be handled gracefully (not crash)
    # We accept any exit code, just verify it doesn't hang or crash unexpectedly
    set +e
    output=$("$CS_UPDATE" --repo=nonexistent 2>&1)
    exit_code=$?
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    # Script should either exit 0 (skipped gracefully) or exit 1 (reported error)
    # Exit codes 2+ typically indicate crashes or severe errors
    if [[ $exit_code -le 1 ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "invalid repo handled gracefully (exit code: $exit_code)"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "invalid repo caused crash (exit code: $exit_code)"
    fi
}

test_continue_on_error_flag_accepted() {
    if [[ ! -x "$CS_UPDATE" ]]; then
        print_skip "cs-update not found"
        return 0
    fi
    
    # --continue-on-error with --dry-run should be accepted
    set +e
    output=$("$CS_UPDATE" --continue-on-error --dry-run 2>&1)
    exit_code=$?
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    # Should not error out due to unknown flag
    if [[ $exit_code -eq 0 ]] && ! echo "$output" | grep -qi "unknown\|invalid\|unrecognized"; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "--continue-on-error flag accepted"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "--continue-on-error flag not accepted (exit: $exit_code)"
    fi
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "=== Testing cs-update ==="
    run_tests
    print_summary
fi
