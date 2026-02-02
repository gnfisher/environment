#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SCRIPTS_DIR="$REPO_ROOT/shared/.local/bin"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Counters
TOTAL_TESTS=0
TOTAL_PASSED=0
TOTAL_FAILED=0
SHELLCHECK_FAILED=0

usage() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS] [test-name]

Run tests for cs-* scripts.

Arguments:
    test-name    Run only tests for specified script (e.g., cs-status, cs-clean, cs-forward)

Options:
    -h, --help          Show this help message
    -s, --skip-shellcheck   Skip shellcheck validation
    -v, --verbose       Show verbose output

Examples:
    $(basename "$0")              # Run all tests
    $(basename "$0") cs-status    # Run only cs-status tests
    $(basename "$0") -s           # Skip shellcheck
EOF
}

# Run shellcheck on all cs-* scripts
run_shellcheck() {
    echo -e "${BLUE}=== Running shellcheck on cs-* scripts ===${NC}"
    
    if ! command -v shellcheck &> /dev/null; then
        echo -e "${YELLOW}WARNING: shellcheck not installed, skipping${NC}"
        return 0
    fi
    
    local scripts
    scripts=$(find "$SCRIPTS_DIR" -maxdepth 1 -name 'cs-*' -type f 2>/dev/null || true)
    
    if [[ -z "$scripts" ]]; then
        echo -e "${YELLOW}No cs-* scripts found in $SCRIPTS_DIR${NC}"
        return 0
    fi
    
    local failed=0
    for script in $scripts; do
        local name
        name=$(basename "$script")
        echo -n "  Checking $name... "
        
        if shellcheck -x "$script" 2>/dev/null; then
            echo -e "${GREEN}OK${NC}"
        else
            echo -e "${RED}FAILED${NC}"
            failed=$((failed + 1))
            SHELLCHECK_FAILED=$((SHELLCHECK_FAILED + 1))
        fi
    done
    
    if [[ $failed -gt 0 ]]; then
        echo -e "${RED}shellcheck found issues in $failed script(s)${NC}"
        return 1
    fi
    
    echo -e "${GREEN}All scripts passed shellcheck${NC}"
    return 0
}

# Run a single test file
run_test_file() {
    local test_file="$1"
    local test_name
    test_name=$(basename "$test_file" .sh)
    
    echo ""
    echo -e "${BLUE}=== Running $test_name ===${NC}"
    
    if [[ ! -x "$test_file" ]]; then
        echo -e "${YELLOW}WARNING: $test_file is not executable, skipping${NC}"
        return 0
    fi
    
    set +e
    output=$("$test_file" 2>&1)
    exit_code=$?
    set -e
    
    echo "$output"
    
    # Parse test results from output
    local passed failed
    passed=$(echo "$output" | grep -c "^PASS:" || true)
    failed=$(echo "$output" | grep -c "^FAIL:" || true)
    
    TOTAL_PASSED=$((TOTAL_PASSED + passed))
    TOTAL_FAILED=$((TOTAL_FAILED + failed))
    TOTAL_TESTS=$((TOTAL_TESTS + passed + failed))
    
    return $exit_code
}

# Find and run test files
run_tests() {
    local filter="${1:-}"
    local test_files
    
    if [[ -n "$filter" ]]; then
        # Run specific test
        local test_file="$SCRIPT_DIR/test-$filter.sh"
        if [[ -f "$test_file" ]]; then
            test_files="$test_file"
        else
            echo -e "${RED}Test file not found: $test_file${NC}"
            return 1
        fi
    else
        # Run all tests
        test_files=$(find "$SCRIPT_DIR" -maxdepth 1 -name 'test-*.sh' -type f ! -name 'test-runner.sh' | sort)
    fi
    
    if [[ -z "$test_files" ]]; then
        echo -e "${YELLOW}No test files found${NC}"
        return 0
    fi
    
    local any_failed=0
    for test_file in $test_files; do
        if ! run_test_file "$test_file"; then
            any_failed=1
        fi
    done
    
    return $any_failed
}

# Print final summary
print_final_summary() {
    echo ""
    echo -e "${BLUE}======================================${NC}"
    echo -e "${BLUE}       FINAL TEST SUMMARY${NC}"
    echo -e "${BLUE}======================================${NC}"
    echo ""
    
    if [[ $SHELLCHECK_FAILED -gt 0 ]]; then
        echo -e "Shellcheck: ${RED}$SHELLCHECK_FAILED script(s) failed${NC}"
    else
        echo -e "Shellcheck: ${GREEN}All passed${NC}"
    fi
    
    echo ""
    echo "Test Results:"
    echo "  Total:  $TOTAL_TESTS"
    echo -e "  Passed: ${GREEN}$TOTAL_PASSED${NC}"
    echo -e "  Failed: ${RED}$TOTAL_FAILED${NC}"
    echo ""
    
    if [[ $TOTAL_FAILED -gt 0 ]] || [[ $SHELLCHECK_FAILED -gt 0 ]]; then
        echo -e "${RED}OVERALL: FAILED${NC}"
        return 1
    else
        echo -e "${GREEN}OVERALL: PASSED${NC}"
        return 0
    fi
}

# Main
main() {
    local skip_shellcheck=false
    local verbose=false
    local filter=""
    
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                usage
                exit 0
                ;;
            -s|--skip-shellcheck)
                skip_shellcheck=true
                shift
                ;;
            -v|--verbose)
                verbose=true
                shift
                ;;
            -*)
                echo "Unknown option: $1"
                usage
                exit 1
                ;;
            *)
                filter="$1"
                shift
                ;;
        esac
    done
    
    echo -e "${BLUE}======================================${NC}"
    echo -e "${BLUE}    cs-* Scripts Test Runner${NC}"
    echo -e "${BLUE}======================================${NC}"
    echo ""
    echo "Scripts directory: $SCRIPTS_DIR"
    echo "Tests directory:   $SCRIPT_DIR"
    echo ""
    
    local exit_code=0
    
    # Run shellcheck
    if [[ "$skip_shellcheck" != "true" ]]; then
        if ! run_shellcheck; then
            exit_code=1
        fi
    else
        echo -e "${YELLOW}Skipping shellcheck${NC}"
    fi
    
    # Run tests
    if ! run_tests "$filter"; then
        exit_code=1
    fi
    
    # Print summary
    if ! print_final_summary; then
        exit_code=1
    fi
    
    exit $exit_code
}

main "$@"
