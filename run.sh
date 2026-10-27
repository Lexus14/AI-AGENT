#!/bin/bash
# Jalankan OpenCode dengan token AgentRouter.
# Token TIDAK ditulis di file ini. Isi lewat salah satu cara:
#   export AGENTROUTER_API_KEY='token-kamu'
# lalu jalankan ./run.sh
if [ -z "$AGENTROUTER_API_KEY" ]; then
  echo "AGENTROUTER_API_KEY belum diisi."
  echo "Jalankan dulu:"
  echo "  export AGENTROUTER_API_KEY='token-kamu'"
  echo "Token disalin dari konsol AgentRouter, jangan dibagikan."
  exit 1
fi
exec opencode "$@"
