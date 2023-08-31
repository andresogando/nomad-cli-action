#!/bin/bash

set -e

COMMAND=$1
TOKEN=$2
ADDRESS=$3

shift 3 # Shift the arguments to skip the command, token, and address

case $COMMAND in
  "info")
    nomad info -address=$ADDRESS -token=$TOKEN
    ;;
  "run")
    # Extract variables from the arguments
    VARIABLES=""
    while [[ $# -gt 0 ]]; do
      case "$1" in
        -var)
          VARIABLES="$VARIABLES $1 $2"
          shift 2
          ;;
        *)
          break
          ;;
      esac
    done

    # Run the nomad run command
    nomad run -address=$ADDRESS -token=$TOKEN $VARIABLES "${@}"
    ;;
  "validate")
    nomad validate -address=$ADDRESS -token=$TOKEN "${@}"
    ;;
  "job")
    nomad job -address=$ADDRESS -token=$TOKEN "${@}"
    ;;
  "allocations")
    nomad allocations -address=$ADDRESS -token=$TOKEN "${@}"
    ;;
  "evaluations")
    nomad evaluations -address=$ADDRESS -token=$TOKEN "${@}"
    ;;
  *)
    echo "Unknown command: $COMMAND"
    exit 1
    ;;
esac
