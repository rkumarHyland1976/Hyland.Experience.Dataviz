#!/bin/bash

# Local development testing script

set -e

echo "🧪 Running Complete Test Suite..."

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Counters
PASSED=0
FAILED=0

run_test() {
    local name=$1
    local command=$2
    
    echo -e "\n${YELLOW}▶ Running: $name${NC}"
    if eval "$command"; then
        echo -e "${GREEN}✅ PASSED: $name${NC}"
        ((PASSED++))
    else
        echo -e "${RED}❌ FAILED: $name${NC}"
        ((FAILED++))
    fi
}

# Start Docker services
echo "🐳 Starting Docker services..."
docker-compose up -d

# Wait for services
echo "⏳ Waiting for services to be ready..."
sleep 10

# Run tests
run_test "Restore dependencies" "dotnet restore"
run_test "Build solution" "dotnet build -c Release"
run_test "Unit tests" "dotnet test test/Hyland.Experience.SampleProject.Api.UnitTests -c Release"

# Health checks
echo -e "\n${YELLOW}🏥 Running health checks...${NC}"

# Stop services
echo -e "\n${YELLOW}🛑 Cleaning up...${NC}"
docker-compose down

# Summary
echo -e "\n╔════════════════════════════════════════╗"
echo -e "║          TEST SUMMARY                  ║"
echo -e "╠════════════════════════════════════════╣"
echo -e "║ ${GREEN}Passed: $PASSED${NC}"
echo -e "║ ${RED}Failed: $FAILED${NC}"
echo -e "╚════════════════════════════════════════╝"

if [ $FAILED -eq 0 ]; then
    echo -e "\n${GREEN}🎉 All tests passed!${NC}"
    exit 0
else
    echo -e "\n${RED}❌ Some tests failed!${NC}"
    exit 1
fi
