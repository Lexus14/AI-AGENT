#!/bin/bash
# Jalankan INI DI DALAM Ubuntu proot-distro, bukan di Termux polos.
# OpenCode versi npm menolak OS "android", jadi harus lewat
# Linux sungguhan (Ubuntu di proot-distro).
# TIDAK berisi token. Token diisi lewat environment di run.sh.
set -e
echo "1. Update dan pasang Node.js..."
apt update
apt install -y nodejs npm git
echo "2. Pasang OpenCode..."
npm install -g opencode-ai
echo "3. Salin config AgentRouter..."
mkdir -p ~/.config/opencode
cp opencode.json ~/.config/opencode/opencode.json
chmod +x run.sh install.sh install-ubuntu.sh 2>/dev/null || true
echo "4. Cek versi..."
opencode --version
echo ""
echo "Selesai. Selanjutnya, masih di dalam Ubuntu ini:"
echo "  export AGENTROUTER_API_KEY='token-kamu'"
echo "  ./run.sh"
