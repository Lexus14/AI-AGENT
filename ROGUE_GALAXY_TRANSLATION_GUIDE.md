# Panduan Modding & Penerjemahan PS2 Rogue Galaxy (Bahasa Indonesia)

Panduan ini berisi langkah-langkah teknis, alat-alat (tools) yang dibutuhkan, serta panduan tata bahasa untuk menerjemahkan game PlayStation 2 **Rogue Galaxy** (Level-5) ke **Bahasa Indonesia** tanpa bug, crash, atau teks terpotong.

---

## 1. Persiapan Alat & Lingkungan (Tools Required)

1. **Rogue Galaxy ISO (USA / PAL / JPN)**:
   - Disarankan versi USA (NTSC) agar tata letak memori dan skrip bahasa Inggris lebih mudah dibaca.
2. **PCSX2 Emulator**:
   - Untuk testing langsung cepat (Save State, Debugger, & Texture Dump).
3. **Apache3 / ImgBurn / UltraISO**:
   - Untuk membongkar dan membangun kembali file ISO PS2.
4. **Alat Ekstraksi File Level-5 / QuickBMS**:
   - Skrip QuickBMS untuk arsip Level-5 (`.cfg`, `.arc`, `.bin`, `.pkg`).
   - Tool seperti **Kuriimu2** atau **Level-5 Tool** (dibuat oleh komunitas romhacking).
5. **Hex Editor**:
   - **HxD** atau **ImHex** (sangat bagus untuk mengecek pointer dan struktur byte).
6. **Font & Texture Editors**:
   - **Optixf2 / TM2Viewer / Rainbow** untuk mengedit file tekstur font `.TM2` / `.GIM`.
7. **Python (versi 3.8+)**:
   - Untuk menjalankan alat validasi skrip otomatis agar terhindar dari bug/crash.

---

## 2. Struktur File & Ekstraksi Rogue Galaxy

Rogue Galaxy dikembangkan oleh **Level-5**. Kebanyakan file teks dialog, item, nama jurus (Abilities), dan menu disimpan dalam format arsip khusus Level-5.

### File Utama:
- `DATA.CVM` atau `DATA.ARC`: Arsip utama game.
- `TEXT/` atau `MSG/`: Folder berisi file dialog (`.cfg`, `.bin`, atau `.txt`).
- `FONT/`: Berisi tekstur font (`.tm2` atau `.gim`) dan file data lebar karakter (*character width table*).

### Langkah Ekstraksi ISO:
1. Buka ISO Rogue Galaxy dengan **UltraISO** / **Apache3**.
2. Ekstrak file arsip data utama (misal `DATA.CVM`).
3. Gunakan **QuickBMS** dengan skrip `level5.bms` untuk menguraikan isi arsip menjadi folder file mentah.

---

## 3. Pencegahan Bug & Technical Rules (PENTING!)

Penyebab utama game PS2 mengalami *crash*, *freeze*, atau *glitch* saat diterjemahkan adalah:

### A. Format Specifiers / Variable Placeholders
Jangan pernah menghapus atau mengubah karakter placeholder berikut dalam teks:
- `%s` (Nama karakter / Nama item)
- `%d` / `%i` (Angka / Jumlah Gold / Damage)
- `%f` (Karakteristik desimal)

❌ **Satu Kesalahan Fatal:**
- Asli: `"You obtained %s x%d!"`
- Salah: `"Kamu mendapatkan barang ini!"` *(Menghapus %s dan %d akan menyebabkan CRASH saat game mencoba membaca variabel)*.
- **Benar:** `"Kamu mendapatkan %s x%d!"`

### B. Control Codes & Escape Characters
Karakter khusus kontrol dialog:
- `\n`: Pindah baris (*line break*).
- `<PAGE>` / `<WAIT>`: Halaman teks selanjutnya / tunggu tombol ditekan.
- `<COLOR:XX>`: Mengubah warna font.

Pastikan tag pembuka dan penutup selaras. Jika `<COLOR:01>` dibuka, harus ada tag penutupnya jika sistem game mengisyaratkan demikian.

### C. Batasan Panjang Teks (Buffer & Box Overflow)
- **Kotak Dialog**: Maksimal biasanya 3-4 baris per kotak.
- **Menu & UI**: Teks Bahasa Indonesia cenderung lebih panjang dibanding Bahasa Inggris/Jepang.
  - Contoh: `"Equipment"` -> `"Perlengkapan"` (terlalu panjang bisa menabrak garis UI).
  - Gunakan singkatan yang lazim jika perlu (misal: `"Perlengkap."` atau sesuaikan posisi UI).
- **Pointer/Panjang String Byte**:
  - Jika file terjemahan dimasukkan kembali (*reinsert*) secara manual lewat Hex, panjang byte string baru **TIDAK BOLEH** melebihi alokasi string asli kecuali pointer offset diperbarui.

---

## 4. Panduan Penerjemahan Bahasa Indonesia yang Baik

Agar terjemahan terasa natural, komunikatif, dan tidak kaku (bukan hasil *Google Translate* mentah):

1. **Padanan Istilah Khas RPG Rogue Galaxy**:
   - *Weapon Synthesis* -> *Sintesis Senjata* / *Penggabungan Senjata*
   - *Hunter Log* -> *Catatan Pemburu*
   - *Factory* -> *Pabrik*
   - *Revelation Flow* -> *Alur Revelasi* / *Papan Kemampuan*
   - *Insectron* -> *Insectron* (Nama fitur, biarkan tetap)
   - *Quarry* -> *Buruan* / *Target Buruan*

2. **Gaya Bahasa & Tone Dialog**:
   - **Jaster** (Protagonis muda): Gunakan bahasa santai namun sopan ("Aku", "Kamu").
   - **Zegram** (Sarkastik/Tegas): Bahasa sedikit kasar/maskulin ("Aku", "Kau").
   - **Kisala** (Ramah & Ceria): Bahasa kasual ("Aku", "Kamu").
   - **Karakter Bangsawan/Pejabat**: Gunakan bahasa baku ("Saya", "Anda").

3. **Gunakan Istilah KBBI yang Luwes**:
   - Jangan gunakan bahasa gaul modern slang/alay ("Gue", "Lu", "Otw", dll) karena akan merusak nuansa dunia sci-fi/fantasy Rogue Galaxy.

---

## 5. Menyesuaikan Font & Karakter Khusus (Trik Teknis)

Bahasa Indonesia memerlukan huruf kapital, tanda baca lengkap, dan terkadang simbol khusus.
- **Masalah**: Karakter seperti `“` `”` `…` atau huruf beraksen mungkin tidak muncul jika font PS2 asli belum memuatnya.
- **Solusi**:
  1. Ekstrak file font (`.tm2`).
  2. Buka gambar font menggunakan editor grafik (Photoshop/GIMP).
  3. Edit gambar font untuk menambahkan glip/karakter yang kurang.
  4. Sesuaikan *Character Width Table* agar jarak antar huruf pas dan tidak bertumpuk.

---

## 6. Uji Coba (Testing) & Repacking

1. **Validasi Teks**:
   Jalankan script validasi python (`python3 tools/validate_translation.py input_file.txt`) sebelum membungkus kembali file teks.
2. **Repack Container**:
   Gunakan alat repack Level-5 untuk mengubah kembali folder teks menjadi file `.bin` / `.arc`.
3. **Rebuild ISO**:
   Masukkan file yang telah di-mod ke dalam ISO Rogue Galaxy menggunakan **Apache3** atau **cdmage**.
4. **Pengujian Emulator**:
   - Mainkan di PCSX2 dari Chapter 1.
   - Cek skenario berikut:
     - Percakapan cerita utama (Cek *line wrapping* & *control codes*).
     - Menu status & *Revelation Flow*.
     - Buka menu item & deskripsi senjata (Cek apakah teks terpotong).
     - Pertarungan (Cek nama jurus & damage display).

---

## 7. Skrip Pembantu Alat Validasi Otomatis

Untuk mencegah bug fatal, selalu gunakan script validasi otomatis yang disediakan di folder `tools/` pada repositori ini. Script tersebut akan mengecek:
- Keberadaan `%s`, `%d`, `%f` yang hilang.
- Tag warna / kontrol yang tidak seimbang.
- Baris teks yang terlalu panjang melebihi batas rekomendasi.
