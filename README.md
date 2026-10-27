# AI-AGENT: Codex (jalan) + OpenCode (terbatas) + AgentRouter

Setup agen AI memakai token AgentRouter, supaya nanti tinggal
`git clone` lalu jalankan lagi — tidak perlu mengetik config
berulang-ulang.

## JALUR YANG TERBUKTI JALAN (2026-10-27): Codex CLI

Di dalam Ubuntu proot-distro, setelah `git clone`:

```bash
bash install-codex-ubuntu.sh
export AGENTROUTER_API_KEY='token-kamu'
bash run-codex.sh
```

`run-codex.sh` memakai `codex --no-daemon`, karena daemon
Codex tidak bisa membuat socket-nya di dalam proot.
Model default: `gpt-6.1-sol` (lihat `codex-config.toml`).
Jangan pakai `gpt-6-sol` polos: AgentRouter menolaknya
dengan 503 "no available channel".
Tes pertama yang terbukti berhasil: `hallo` -> dibalas
"Halo! Ada yang bisa saya bantu?", walau lambat (2 menit).

Kenapa lambat: model Sol adalah model penalaran, jawaban
pertama butuh waktu, dan kalau sedang kena rate limit
di region penyedia, Codex akan mencoba ulang beberapa kali.
Kalau muncul rate limit, tekan Esc, tunggu beberapa menit,
lalu coba lagi atau ganti model lewat `/model`
(`gpt-6-astra` / `gpt-5.6-sol`).

## JALUR OpenCode: TERBATAS untuk model Sol

OpenCode terpasang (1.19.4) dan config terbaca, tapi model
Sol di AgentRouter HANYA dilayani lewat Responses API,
sementara OpenCode 1.19.4 tetap mengirim lewat Chat
Completions untuk model ini, sehingga selalu error:
"Model gpt-5.6-sol does not support /v1/chat/completions,
please use /v1/responses instead" — walau `opencode.json`
sudah diganti ke `@ai-sdk/openai`. Jadi untuk model Sol,
pakai Codex, bukan OpenCode.

## Sekali saja (instalasi)

```bash
git clone <URL-REPO-INI>
cd opencode-agentrouter-setup
bash install.sh
```

`install.sh` memasang Node.js, OpenCode (`npm install -g opencode-ai`),
dan menyalin `opencode.json` ke `~/.config/opencode/opencode.json`.

## Penting: Termux polos DITOLAK oleh npm OpenCode

Paket `opencode-ai` versi npm hanya menerima OS darwin/linux/win32,
bukan `android`. Jadi instalasi di Termux polos AKAN gagal dengan
`EBADPLATFORM ... Actual os: android`. Itu sudah terbukti di HP
(2026-10-27). Jalur yang dipakai adalah Ubuntu di dalam Termux:

```bash
pkg install -y proot-distro
proot-distro install ubuntu
proot-distro login ubuntu
```

Di dalam Ubuntu itu (prompt berubah jadi `root@localhost:~#`):

```bash
apt update && apt install -y git
git clone https://github.com/Lexus14/AI-AGENT.git
cd AI-AGENT
bash install-ubuntu.sh
export AGENTROUTER_API_KEY='token-kamu'
./run.sh
```

`install-ubuntu.sh` memakai `apt`/`npm` (bukan `pkg` Termux).
Setiap kali mau memakai lagi, ulangi `proot-distro login ubuntu`,
lalu `cd AI-AGENT` dan dua baris terakhir di atas.

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
