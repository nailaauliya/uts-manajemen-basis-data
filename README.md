
# UTS Manajemen Basis Data — Proyek 1

## Identitas Mahasiswa

- **Nama:** Naila Aghna Auliya Prayitno
- **NIM:** 1247050051
- **Kelas:** C
- **Program Studi:** Teknik Informatika
- **Mata Kuliah:** Manajemen Basis Data
- **Tahun Akademik:** 2026/2027

## Deskripsi Proyek

Proyek Ujian Tengah Semester (UTS) Manajemen Basis Data ini bertujuan menerapkan pengelolaan database PostgreSQL menggunakan Docker Compose.

Pengerjaan mencakup konfigurasi PostgreSQL dan pgAdmin4, pengujian koneksi melalui DBeaver, pembuatan schema dan tabel, penerapan constraint, serta pengaturan dan pengujian hak akses pengguna.

## Teknologi yang Digunakan

- PostgreSQL 15
- pgAdmin4
- Docker Desktop
- Docker Compose
- DBeaver
- SQL
- Visual Studio Code
- Git dan GitHub

## Struktur Folder

```text
uts-manajemen-basis-data/
├── .env.example
├── .gitignore
├── docker-compose.yml
├── README.md
└── sql/
    ├── 01_schema_tabel.sql
    ├── 02_data_mahasiswa.sql
    ├── 03_pengujian_constraint.sql
    ├── 04a_view_mahasiswa.sql
    ├── 04_user_hak_akses.sql
    └── 05_pengujian_hak_akses.sql
```

File `.env` dibuat secara lokal dan tidak disertakan dalam repository untuk menjaga keamanan informasi autentikasi.

## 1. Konfigurasi PostgreSQL Menggunakan Docker

PostgreSQL dijalankan menggunakan image versi 15 melalui Docker Compose.

| Konfigurasi | Nilai |
|---|---|
| Image | PostgreSQL 15 |
| Container | `postgres_NAILA` |
| Database | `uts_mbd` |
| Username | `postgres` |
| Port eksternal | `22051` |
| Port internal | `5432` |

Username dan password PostgreSQL dikonfigurasi melalui file `.env`, sehingga tidak dituliskan secara langsung pada `docker-compose.yml`.

### Menjalankan Docker

Pastikan Docker Desktop sudah aktif.

Salin `.env.example` menjadi `.env`, kemudian sesuaikan variabel konfigurasi dan password dengan ketentuan tugas.

Jalankan perintah berikut melalui terminal VS Code:

```bash
docker compose up -d
```

Untuk memastikan container berjalan:

```bash
docker ps
```

## 2. Konfigurasi pgAdmin4 dan DBeaver

pgAdmin4 digunakan untuk mengakses PostgreSQL dari dalam jaringan Docker, sedangkan DBeaver digunakan untuk menguji koneksi dari luar Docker.

### Konfigurasi pgAdmin4

| Konfigurasi | Nilai |
|---|---|
| Image | `dpage/pgadmin4` |
| Container | `pgadmin_NAILA` |
| Port eksternal | `44051` |
| Port internal | `80` |
| URL | http://localhost:44051 |

### Koneksi PostgreSQL melalui pgAdmin4

- **Host:** `postgres`
- **Port:** `5432`
- **Database:** `uts_mbd`
- **Username:** `postgres`

### Koneksi PostgreSQL melalui DBeaver

- **Host:** `localhost`
- **Port:** `22051`
- **Database:** `uts_mbd`
- **Username:** `postgres`

Kedua koneksi telah berhasil diuji.

## 3. Pembuatan Schema, Tabel, dan Constraint

Schema yang digunakan adalah `"SALAM"` dengan tabel utama `mahasiswas`.

Tabel dibuat untuk menyimpan informasi mahasiswa, seperti NIM, nama, email, program studi, angkatan, semester, IPK, dan status mahasiswa.

### Constraint yang Diterapkan

| Constraint | Fungsi |
|---|---|
| PRIMARY KEY | Menjamin ID mahasiswa tidak duplikat |
| UNIQUE | Mencegah duplikasi NIM dan email |
| CHECK | Memvalidasi nilai IPK, semester, angkatan, dan status mahasiswa |

Pengujian dilakukan dengan memasukkan data valid dan data yang melanggar constraint.

PostgreSQL berhasil menolak data yang tidak sesuai, sehingga constraint terbukti bekerja.

## 4. Pembuatan User dan Pengaturan Hak Akses

Tiga user PostgreSQL dibuat dengan kewenangan yang berbeda.

| User | Hak Akses |
|---|---|
| `backend_dev` | SELECT, INSERT, UPDATE, DELETE (CRUD) |
| `bi_dev` | SELECT pada tabel dan VIEW |
| `data_engineer` | CRUD, CREATE, ALTER, dan DROP pada objek yang dikelola |

### Pengujian backend_dev

User `backend_dev` berhasil menjalankan operasi SELECT, INSERT, UPDATE, dan DELETE pada tabel `mahasiswas`.

Percobaan CREATE TABLE ditolak karena user tidak memiliki izin untuk membuat objek baru.

### Pengujian bi_dev

User `bi_dev` berhasil membaca data dari tabel `mahasiswas` dan VIEW `vw_mahasiswa_aktif`.

Pengujian INSERT, UPDATE, dan DELETE ditolak sesuai pembatasan hak akses yang diberikan.

### Pengujian data_engineer

User `data_engineer` berhasil membuat tabel, mengubah struktur tabel menggunakan ALTER TABLE, menghapus tabel, serta melakukan operasi CRUD.

Kepemilikan schema `"SALAM"`, tabel `mahasiswas`, dan VIEW `vw_mahasiswa_aktif` juga dialihkan kepada `data_engineer` untuk mendukung pengelolaan objek database.

### Pengaturan Default Privileges

Pengaturan `ALTER DEFAULT PRIVILEGES` diterapkan agar tabel baru yang dibuat oleh `postgres` maupun `data_engineer` memperoleh hak akses otomatis sesuai kebutuhan:

- `backend_dev` memperoleh hak CRUD pada tabel baru.
- `bi_dev` memperoleh hak SELECT pada tabel baru.
- `backend_dev` memperoleh USAGE pada sequence baru.
- `data_engineer` memperoleh hak akses pada tabel dan sequence baru yang dibuat oleh `postgres` sesuai konfigurasi SQL.

Pengujian dilakukan dengan membuat tabel sementara `uji_akses_role` menggunakan `data_engineer`.

Hasil pengujian:

- INSERT menggunakan `backend_dev` berhasil.
- SELECT menggunakan `bi_dev` berhasil.
- INSERT menggunakan `bi_dev` ditolak dengan pesan `permission denied`.

Hal ini menunjukkan bahwa pengaturan hak akses otomatis telah berjalan sesuai peran masing-masing user.

## 5. Aktivitas Tambahan

Sebagai pengembangan dari ketentuan utama UTS, dilakukan beberapa aktivitas tambahan:

1. **Simulasi transaksi pembayaran UKT** sebesar Rp2.500.000 menggunakan tabel pengujian `uji_transaksi_akademik`.
2. **Pembuatan VIEW `vw_mahasiswa_aktif`** untuk menampilkan mahasiswa dengan status aktif.
3. **Pengujian kepemilikan objek database** agar `data_engineer` dapat melakukan perubahan struktur dan penghapusan objek.
4. **Pengujian default privileges** untuk memastikan hak akses tetap diterapkan pada tabel baru.

Tabel sementara yang digunakan dalam pengujian dihapus setelah pengujian selesai.

## 6. Urutan Menjalankan SQL Script

Seluruh script dijalankan pada database `uts_mbd`.

| Urutan | File | Keterangan |
|---|---|---|
| 1 | `01_schema_tabel.sql` | Membuat schema, tabel, dan constraint |
| 2 | `02_data_mahasiswa.sql` | Menambahkan data mahasiswa awal |
| 3 | `04a_view_mahasiswa.sql` | Membuat VIEW mahasiswa aktif |
| 4 | `04_user_hak_akses.sql` | Membuat user dan mengatur hak akses |

Script pengujian yang disediakan:

- `03_pengujian_constraint.sql` untuk menguji PRIMARY KEY, UNIQUE, dan CHECK.
- `05_pengujian_hak_akses.sql` untuk menguji kewenangan masing-masing user.

**Catatan:** Script pengujian dijalankan sesuai koneksi dan user yang ditentukan. Sebagian pengujian memang dirancang menghasilkan error untuk membuktikan pembatasan akses.

Sebelum menjalankan `04_user_hak_akses.sql` pada instalasi baru, ganti placeholder password menggunakan nilai lokal masing-masing user. Jangan mengunggah password asli ke GitHub.

## 7. Hasil Pengujian

Berdasarkan pengujian yang telah dilakukan:

- Container PostgreSQL dan pgAdmin4 berhasil dijalankan.
- Database `uts_mbd` berhasil diakses melalui pgAdmin4 dan DBeaver.
- Schema `"SALAM"` dan tabel `mahasiswas` berhasil dibuat.
- Constraint PRIMARY KEY, UNIQUE, dan CHECK berfungsi sesuai ketentuan.
- Hak akses `backend_dev`, `bi_dev`, dan `data_engineer` berhasil diuji.
- VIEW `vw_mahasiswa_aktif` dapat diakses.
- Pengaturan default privileges berhasil diuji.

Pada pemeriksaan akhir, database `uts_mbd` memiliki tiga data mahasiswa pada tabel utama `mahasiswas`.

## 8. Dokumentasi

Dokumentasi pengerjaan tersedia dalam laporan UTS berbentuk PDF yang berisi screenshot konfigurasi Docker, pengujian koneksi, pembuatan objek database, pengujian constraint, serta pengujian hak akses.

## 9. Keamanan Konfigurasi

File `.env` berisi informasi autentikasi dan tidak diunggah ke repository publik.

File `.env.example` digunakan sebagai contoh konfigurasi, sedangkan `.gitignore` digunakan untuk mengecualikan file yang bersifat sensitif.

---

**UTS Manajemen Basis Data — Proyek 1**  
**Naila Aghna Auliya Prayitno — 1247050051**
