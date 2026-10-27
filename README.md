# OpenCode + AgentRouter (Termux)

Setup OpenCode memakai token AgentRouter, supaya nanti tinggal
`git clone` lalu jalankan lagi — tidak perlu mengetik config
berulang-ulang.

## Sekali saja (instalasi)

```bash
git clone <URL-REPO-INI>
cd opencode-agentrouter-setup
bash install.sh
```

`install.sh` memasang Node.js, OpenCode (`npm install -g opencode-ai`),
dan menyalin `opencode.json` ke `~/.config/opencode/opencode.json`.

Catatan: di Termux polos, OpenCode kadang salah mendeteksi
arsitektur HP. Kalau `opencode --version` gagal, jalurnya adalah
Ubuntu di dalam Termux (`proot-distro`), lalu ulangi instalasi
di dalam Ubuntu itu.

## Setiap kali mau memakai

```bash
cd ~/opencode-agentrouter-setup
export AGENTROUTER_API_KEY='token-kamu'
./run.sh
```

Lalu di dalam OpenCode, pilih model dari AgentRouter
(misal `gpt-6.1-sol`) dan kirim pesan tes pendek.

## Keamanan

- Token TIDAK ada di repo ini, di `install.sh`, di `run.sh`,
  maupun di `opencode.json`. Token hanya ada di environment
  sesi Termux-mu.
- Jangan pernah membagikan token lengkap atau screenshot
  token lengkap. Kalau token pernah tersebar, hapus di konsol
  AgentRouter dan buat token baru.
- OpenCode adalah agen coding: ia bisa membaca, mengubah file,
  dan menjalankan perintah. Setujui hanya perintah yang kamu
  pahami.

## File

```
opencode.json  Config provider AgentRouter untuk OpenCode
install.sh     Instalasi sekali saja (Node.js, OpenCode, config)
run.sh         Peluncur OpenCode (cek token dulu, lalu opencode)
README.md      Panduan ini
```
