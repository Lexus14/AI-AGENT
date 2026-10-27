#!/bin/bash
# Pasang Codex CLI di dalam Ubuntu proot-distro.
# Codex adalah klien resmi untuk model-model Sol, dan ia
# berbicara lewat Responses API, bukan Chat Completions.
# TIDAK berisi token.
set -e
echo "1. Pasang Codex CLI..."
npm install -g @openai/codex
echo "2. Salin config AgentRouter..."
mkdir -p ~/.codex
cp codex-config.toml ~/.codex/config.toml
echo "3. Cek versi..."
codex --version
echo ""
echo "Selesai. Selanjutnya, masih di dalam Ubuntu ini:"
echo "  export AGENTROUTER_API_KEY='token-kamu'"
echo "  bash run-codex.sh"
echo "Untuk ganti model sekali jalan, misal:"
echo "  codex --model gpt-6.1-sol"
