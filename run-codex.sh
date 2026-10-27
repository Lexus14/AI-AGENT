#!/bin/bash
# Jalankan Codex CLI dengan token AgentRouter.
# Token TIDAK ditulis di file ini.
if [ -z "$AGENTROUTER_API_KEY" ]; then
  echo "AGENTROUTER_API_KEY belum diisi."
  echo "Jalankan dulu:"
  echo "  export AGENTROUTER_API_KEY='token-kamu'"
  exit 1
fi
# Di dalam proot-distro, server latar (daemon) Codex tidak bisa
# membuat socket-nya, jadi harus jalan tanpa daemon, sesuai
# saran error Codex sendiri.
exec codex --no-daemon "$@"
