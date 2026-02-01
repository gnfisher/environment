#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/helpers.sh"

CS_STATUS="$(get_script_path cs-status)"

test_script_exists() {
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -x "$CS_STATUS" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "cs-status script exists and is executable"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "cs-status script not found at $CS_STATUS"
        print_skip "Skipping remaining tests - script not found"
        return 1
    fi
}

test_help_exits_zero() {
    if [[ ! -x "$CS_STATUS" ]]; then
        print_skip "cs-status not found"
        return 0
    fi
    
    assert_exit_code 0 "$CS_STATUS" --help
}

test_help_shows_usage() {
    if [[ ! -x "$CS_STATUS" ]]; then
        print_skip "cs-status not found"
        return 0
    fi
    
    assert_contains "usage\|Usage\|USAGE" "$CS_STATUS" --help
}

test_runs_without_error() {
    if [[ ! -x "$CS_STATUS" ]]; then
        print_skip "cs-status not found"
        return 0
    fi
    
    # cs-status should run without error even if services aren't running
    # It might exit non-zero if services are down, so we just check it runs
    set +e
    output=$("$CS_STATUS" 2>&1)
    exit_code=$?
    set -e
    
    TESTS_RUN=$((TESTS_RUN + 1))
    # Accept exit code 0 or 1 (services might be down)
    if [[ $exit_code -le 1 ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        print_pass "cs-status runs without crashing (exit code: $exit_code)"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        print_fail "cs-status crashed with exit code $exit_code"
    fi
}

test_output_contains_services_section() {
    if [[ ! -x "$CS_STATUS" ]]; then
        print_skip "cs-status not found"
        return 0
    fi
    
    assert_contains "Services\|services\|SERVICE" "$CS_STATUS"
}

test_output_contains_repositories_section() {
    if [[ ! -x "$CS_STATUS" ]]; then
        print_skip "cs-status not found"
        return 0
    fi
    
    assert_contains "Repositor\|repositor\|REPO" "$CS_STATUS"
}

test_output_contains_disk_section() {
    if [[ ! -x "$CS_STATUS" ]]; then
        print_skip "cs-status not found"
        return 0
    fi
    
    assert_contains "Disk\|disk\|DISK\|storage\|Storage" "$CS_STATUS"
}

test_output_contains_docker_section() {
    if [[ ! -x "$CS_STATUS" ]]; then
        print_skip "cs-status not found"
        return 0
    fi
    
    assert_contains "Docker\|docker\|DOCKER\|container\|Container" "$CS_STATUS"
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "=== Testing cs-status ==="
    run_tests
    print_summary
fi
