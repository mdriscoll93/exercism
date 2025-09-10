#!/usr/bin/env bash

# Usage:
#   ./diffie_hellman.sh privateKey P
#     => output a random integer in [2..P-1]
#   ./diffie_hellman.sh publicKey P G PRIVATE
#     => output (G ^ PRIVATE) mod P
#   ./diffie_hellman.sh secret P PUBLIC PRIVATE
#     => output (PUBLIC ^ PRIVATE) mod P

case "$1" in
  privateKey)
    # Generate a random private key in [2..p-1]
    p="$2"

    # Validate that p is a positive integer
    if [[ ! "$p" =~ ^[0-9]+$ ]]; then
      echo "Error: p must be a positive integer."
      exit 1
    fi

    # Simple random in [2..p-1]
    echo $(( (RANDOM % (p - 2)) + 2 ))
    ;;

  publicKey)
    # Compute (g ^ private) mod p
    p="$2"
    g="$3"
    priv="$4"

    # Validate all inputs are integers
    if [[ ! "$p" =~ ^[0-9]+$ ]] || [[ ! "$g" =~ ^[0-9]+$ ]] || [[ ! "$priv" =~ ^[0-9]+$ ]]; then
      echo "Error: p, g, and private must be integers."
      exit 1
    fi

    bc <<< "$g ^ $priv % $p"
    ;;

  secret)
    # Compute (public ^ private) mod p
    p="$2"
    pub="$3"
    priv="$4"

    # Validate all inputs are integers
    if [[ ! "$p" =~ ^[0-9]+$ ]] || [[ ! "$pub" =~ ^[0-9]+$ ]] || [[ ! "$priv" =~ ^[0-9]+$ ]]; then
      echo "Error: p, public, and private must be integers."
      exit 1
    fi

    bc <<< "$pub ^ $priv % $p"
    ;;

  *)
    echo "Usage:"
    echo "  $0 privateKey P"
    echo "  $0 publicKey P G PRIVATE"
    echo "  $0 secret P PUBLIC PRIVATE"
    exit 1
    ;;
esac