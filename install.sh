#!/bin/bash
# Pasang OpenCode + config AgentRouter di Termux.
# TIDAK berisi token. Token diisi lewat environment di run.sh,
# atau diekspor manual sebelum menjalankan opencode.
set -e
echo "1. Pasang Node.js..."
pkg install -y nodejs
echo "2. Pasang OpenCode..."
npm install -g opencode-ai
echo "3. Salin config AgentRouter..."
mkdir -p ~/.config/opencode
cp opencode.json ~/.config/opencode/opencode.json
echo "4. Cek versi..."
opencode --version
echo ""
echo "Selesai. Selanjutnya:"
echo "  export AGENTROUTER_API_KEY='token-kamu'"
echo "  ./run.sh"
echo "atau langsung:  opencode"
