#!/usr/bin/env bash
set -o pipefail

# Please run docker login before if needed and check the host w.r.t. the target architecture...

#
# Build-and-push script
# - Pass directories as arguments (or set ARCHDIRS env var)
# - Root Dockerfile in each directory is tagged as :latest by default
# - Subdirectories are processed so exact names (e.g., "buster") come before
#   names that start with that prefix (e.g., "buster-for-codac")
#

# If you want a default, set archdirs=("pi") here.
# To require explicit input and show help when none is provided, leave archdirs empty.
archdirs=()

repo="lebarsfa"
default_root_tag="latest"

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
RESET='\033[0m'

print_help() {
  printf "${YELLOW}Usage:${RESET}\n"
  printf "  %s [DIR ...]\n" "$(basename "$0")"
  printf "\n"
  printf "${YELLOW}Description:${RESET}\n"
  printf "  Build and push Docker images for one or more directory trees.\n"
  printf "  Each argument may be a single directory name, a space separated list,\n"
  printf "  or a single comma separated string (\"pi-64,manylinux_2_28_aarch64-for-codac\").\n"
  printf "\n"
  printf "${YELLOW}Examples:${RESET}\n"
  printf "  %s pi-64 manylinux_2_28_aarch64-for-codac\n" "$(basename "$0")"
  printf "  %s \"pi-64,manylinux_2_28_aarch64-for-codac\"\n" "$(basename "$0")"
  printf "  ARCHDIRS=\"pi-64 manylinux_2_28_aarch64-for-codac\" %s\n" "$(basename "$0")"
  printf "\n"
  printf "${YELLOW}Notes:${RESET}\n"
  printf "  - Run docker login before if needed and check the host w.r.t. the target architecture...\n"
  printf "  - Root Dockerfile in each directory is tagged as :%s by default.\n" "$default_root_tag"
  printf "  - You can set ARCHDIRS environment variable as a fallback.\n"
}

# If user asked for help explicitly
if [ "${1-}" = "--help" ] || [ "${1-}" = "-h" ]; then
  print_help
  exit 0
fi

# If arguments were provided, parse them into archdirs
if [ "$#" -gt 0 ]; then
  args="$*"
  args="${args//,/ }"
  read -r -a archdirs <<< "$args"
elif [ -n "${ARCHDIRS-}" ]; then
  tmp="${ARCHDIRS//,/ }"
  read -r -a archdirs <<< "$tmp"
fi

if [ "${#archdirs[@]}" -eq 0 ]; then
  printf "${RED}No directories specified.${RESET}\n"
  print_help
  exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
  printf "${RED}docker not found. Install Docker and try again.${RESET}\n"
  exit 1
fi

printf "\n${YELLOW}Please run docker login before if needed...${RESET}\n\n"

shopt -s nullglob
for archdir in "${archdirs[@]}"; do
  # Trim whitespace
  archdir="${archdir#"${archdir%%[![:space:]]*}"}"
  archdir="${archdir%"${archdir##*[![:space:]]}"}"

  [ -n "$archdir" ] || continue

  if [ ! -d "$archdir" ]; then
    printf "\n${RED}Directory '%s' not found. Skipping.${RESET}\n\n" "$archdir"
    continue
  fi

  printf "\n${MAGENTA}Processing directory list item: %s${RESET}\n\n" "$archdir"

  # Build root Dockerfile in archdir if present (tagged as :latest by default)
  if [ -f "$archdir/Dockerfile" ]; then
    name="$default_root_tag"
    src="$archdir"
    printf "\n${CYAN}Building and pushing %s/%s:%s from %s${RESET}\n\n" "$repo" "$archdir" "$name" "$src"
    if docker build --progress=plain -t "${repo}/${archdir}:${name}" "$src"; then
      if docker push "${repo}/${archdir}:${name}"; then
        printf "\n${GREEN}SUCCESS: built and pushed %s/%s:%s${RESET}\n\n" "$repo" "$archdir" "$name"
      else
        printf "\n${RED}ERROR: push failed for %s/%s:%s${RESET}\n\n" "$repo" "$archdir" "$name"
      fi
    else
      printf "\n${RED}ERROR: build failed for %s/%s:%s${RESET}\n\n" "$repo" "$archdir" "$name"
    fi
  fi

  # Collect subdirectories
  dirs=()
  for d in "$archdir"/*/; do
    [ -d "$d" ] || continue
    dirs+=("$d")
  done

  if [ "${#dirs[@]}" -eq 0 ]; then
    printf "${YELLOW}No subdirectories in %s, skipping.${RESET}\n" "$archdir"
    continue
  fi

  # Build sortable lines: prefix<TAB>is_exact<TAB>basename<TAB>fullpath
  tmpfile=$(mktemp) || { printf "${RED}Failed to create temp file${RESET}\n"; exit 1; }
  for d in "${dirs[@]}"; do
    bn=$(basename "$d")
    prefix="${bn%%-*}"
    if [ "$bn" = "$prefix" ]; then
      is_exact=0
    else
      is_exact=1
    fi
    printf '%s\t%s\t%s\t%s\n' "$prefix" "$is_exact" "$bn" "$d" >> "$tmpfile"
  done

  # Choose sort command (prefer gsort on macOS if installed)
  if command -v gsort >/dev/null 2>&1; then
    SORT_CMD=(gsort -t$'\t' -k1,1 -k2,2n -k3,3)
  else
    SORT_CMD=(sort -t$'\t' -k1,1 -k2,2n -k3,3)
  fi

  # Produce sorted list of full paths into a temporary file
  "${SORT_CMD[@]}" "$tmpfile" | awk -F'\t' '{print $4}' > "${tmpfile}.sorted"

  # Read sorted paths into array
  sorted_dirs=()
  while IFS= read -r path; do
    sorted_dirs+=("$path")
  done < "${tmpfile}.sorted"

  rm -f "$tmpfile" "${tmpfile}.sorted"

  # Iterate sorted_dirs
  for dir in "${sorted_dirs[@]}"; do
    [ -d "$dir" ] || continue
    name=$(basename "$dir")
    src="$dir"
    printf "\n${CYAN}Building and pushing %s/%s:%s from %s${RESET}\n\n" "$repo" "$archdir" "$name" "$src"
    if docker build --progress=plain -t "${repo}/${archdir}:${name}" "$src"; then
      if docker push "${repo}/${archdir}:${name}"; then
        printf "\n${GREEN}SUCCESS: built and pushed %s/%s:%s${RESET}\n\n" "$repo" "$archdir" "$name"
      else
        printf "\n${RED}ERROR: push failed for %s/%s:%s${RESET}\n\n" "$repo" "$archdir" "$name"
      fi
    else
      printf "\n${RED}ERROR: build failed for %s/%s:%s${RESET}\n\n" "$repo" "$archdir" "$name"
    fi
  done

done
shopt -u nullglob
