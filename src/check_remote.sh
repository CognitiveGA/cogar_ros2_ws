#!/bin/bash

# Define some colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}🔍 Scanning Git remotes for packages in $(pwd)...${NC}"
echo

for d in */; do
  if [ -d "$d/.git" ]; then
    echo -e "${YELLOW}📦 ${d%/}${NC}"

    remotes=$(git -C "$d" remote -v)
    if [ -n "$remotes" ]; then
      while IFS= read -r line; do
        # Use 🔼 for push, 🔽 for fetch
        if [[ "$line" == *"(fetch)"* ]]; then
          echo -e "  🔽 ${GREEN}${line}${NC}"
        elif [[ "$line" == *"(push)"* ]]; then
          echo -e "  🔼 ${GREEN}${line}${NC}"
        fi
      done <<< "$remotes"
    else
      echo -e "  ❌ ${RED}No remotes configured${NC}"
    fi
    echo
  fi
done
