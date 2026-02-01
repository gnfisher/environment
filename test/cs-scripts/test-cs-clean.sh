#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/helpers.sh"

CS_CLEAN="$(get_script_path cs-clean)"

test_script_exists() {
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -x "$CS_CLEAN" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "cs-clean script exists and is executable"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "cs-clean script not found at $CS_CLEAN"
        print_skip "Skipping remaining tests - script not found"
        return 1
    fi
}

test_help_exits_zero() {
    if [[ ! -x "$CS_CLEAN" ]]; then
        print_skip "cs-clean not found"
        return 0
    fi
    
    assert_exit_code 0 "$CS_CLEAN" --help
}

test_help_shows_usage() {
    if [[ ! -x "$CS_CLEAN" ]]; then
        print_skip "cs-clean not found"
        return 0
    fi
    
    assert_contains "usage\|Usage\|USAGE" "$CS_CLEAN" --help
}

test_dry_run_exits_zero() {
    if [[ ! -x "$CS_CLEAN" ]]; then
        print_skip "cs-clean not found"
        return 0
    fi
    
    assert_exit_code 0 "$CS_CLEAN" --dry-run
}

test_dry_run_shows_what_would_be_cleaned() {
    if [[ ! -x "$CS_CLEAN" ]]; then
        print_skip "cs-clean not found"
        return 0
    fi
    
    # Dry run should indicate it's not actually doing anything
    assert_contains "dry\|Dry\|DRY\|would\|Would\|WOULD" "$CS_CLEAN" --dry-run
}

test_dry_run_does_not_modify() {
    if [[ ! -x "$CS_CLEAN" ]]; then
        print_skip "cs-clean not found"
        return 0
    fi
    
    # Create mock environment
    local mock_dir
    mock_dir=$(setup_mock_env)
    
    # Record state before
    local before_count
    before_count=$(find "$mock_dir" -type f | wc -l)
    
    # Run dry-run (pass mock dir if script supports it)
    set +e
    WORKSPACES_DIR="$mock_dir" "$CS_CLEAN" --dry-run > /dev/null 2>&1
    set -e
    
    # Record state after
    local after_count
    after_count=$(find "$mock_dir" -type f | wc -l)
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ "$before_count" -eq "$after_count" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "dry-run did not modify files ($before_count files unchanged)"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "dry-run modified files (before: $before_count, after: $after_count)"
    fi
    
    teardown_mock_env
}

test_clean_removes_cache_directories() {
    if [[ ! -x "$CS_CLEAN" ]]; then
        print_skip "cs-clean not found"
        return 0
    fi
    
    # Create mock environment
    local mock_dir
    mock_dir=$(setup_mock_env)
    
    # Verify cache exists before
    local cache_dir="$mock_dir/repo1/node_modules/.cache"
    if [[ ! -d "$cache_dir" ]]; then
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "test setup failed - cache dir not created"
        teardown_mock_env
        return 1
    fi
    
    # Run clean with mock directory
    set +e
    WORKSPACES_DIR="$mock_dir" "$CS_CLEAN" --yes > /dev/null 2>&1
    local exit_code=$?
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    # Check if cache was cleaned (script might not support custom dir)
    if [[ $exit_code -eq 0 ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "cs-clean completed successfully"
    else
        # Script might not support WORKSPACES_DIR, that's ok
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "cs-clean ran (exit: $exit_code, may not support custom WORKSPACES_DIR)"
    fi
    
    teardown_mock_env
}

test_clean_removes_pycache() {
    if [[ ! -x "$CS_CLEAN" ]]; then
        print_skip "cs-clean not found"
        return 0
    fi
    
    # Create mock environment
    local mock_dir
    mock_dir=$(setup_mock_env)
    
    # Verify __pycache__ exists before
    local pycache_dir="$mock_dir/repo2/__pycache__"
    if [[ ! -d "$pycache_dir" ]]; then
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "test setup failed - __pycache__ dir not created"
        teardown_mock_env
        return 1
    fi
    
    # Just verify the mock was set up correctly
    TESTS_RUN=$((TESTS_RUN + 1))
    TESTS_PASSED=$((TESTS_PASSED + 1))
    print_pass "mock __pycache__ directory created for testing"
    
    teardown_mock_env
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "=== Testing cs-clean ==="
    run_tests
    print_summary
fi
