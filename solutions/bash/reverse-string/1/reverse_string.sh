#!/usr/bin/env bash

main() {
    local input="$1"
    local reversed=""
    local i
    
    for (( i=${#input}-1; i>=0; i-- )); do
        reversed+="${input:$i:1}"
    done
    
    printf "%s\n" "$reversed"
}

main "$@"
