
# UTS Manajemen Basis Data — Proyek 1

## Identitas
- Nama: Naila Aghna Auliya P
- NIM: 1247050051
- Program Studi: Teknik Informatika
- Mata Kuliah: Manajemen Basis Data
- Tahun Akademik: 2026/2027

## Deskripsi Proyek
Proyek ini merupakan tugas Ujian Tengah Semester
Manajemen Basis Data yang menggunakan PostgreSQL 15,
pgAdmin4, Docker, dan DBeaver.

Proyek mencakup konfigurasi database menggunakan Docker,
pembuatan schema dan tabel mahasiswa, pengujian
constraint, serta pengaturan hak akses pengguna.

## Teknologi
- PostgreSQL 15
- pgAdmin4
- Docker Compose
- DBeaver
- SQL

## Konfigurasi Docker
Container yang digunakan:
- postgres_NAILA
- pgadmin_NAILA

Port:
- PostgreSQL: 22051
- pgAdmin4: 44051

Database: uts_mbd
Schema: SALAM
Tabel utama: mahasiswas

Username dan password PostgreSQL disimpan pada
file .env dan tidak ditulis langsung di docker-compose.yml.

## Cara Menjalankan
1. Pastikan Docker Desktop sudah berjalan.
2. Salin file .env.example menjadi .env.
3. Sesuaikan username, password, dan konfigurasi port.
4. Jalankan perintah:

   docker compose up -d

5. Buka pgAdmin4 melalui http://localhost:44051
6. Hubungkan DBeaver ke localhost dengan port 22051.
7. Jalankan SQL pada database uts_mbd sesuai urutan.

## Urutan SQL
1. 01_schema_tabel.sql
   Membuat schema SALAM dan tabel mahasiswas.

2. 02_data_mahasiswa.sql
   Menambahkan tiga data mahasiswa.

3. 04a_view_mahasiswa.sql
   Membuat view mahasiswa aktif.

4. 04_user_hak_akses.sql
   Membuat user dan mengatur hak akses database.

## Script Pengujian
- 03_pengujian_constraint.sql
  Menguji PRIMARY KEY, UNIQUE, dan CHECK constraint.

- 05_pengujian_hak_akses.sql
  Menguji hak akses backend_dev, bi_dev, dan data_engineer.

Script pengujian dijalankan per bagian sesuai
koneksi user. Beberapa perintah sengaja menghasilkan
error untuk membuktikan pembatasan akses bekerja.

## Hak Akses User
| User          | Hak Akses |
|---            |---        |
| backend_dev   | SELECT, INSERT, UPDATE, DELETE |
| bi_dev        | SELECT tabel dan view |
| data_engineer | CRUD serta CREATE, ALTER, DROP objek yang dimiliki |

Pengaturan default privileges juga diterapkan
untuk objek baru yang dibuat oleh postgres pada
schema SALAM.

## Hasil Pengujian
- Container PostgreSQL dan pgAdmin4 berhasil berjalan.
- Koneksi internal melalui pgAdmin4 berhasil.
- Koneksi eksternal melalui DBeaver berhasil.
- Constraint PRIMARY KEY, UNIQUE, dan CHECK berfungsi.
- Hak akses ketiga user berhasil diuji.
- Operasi CREATE, ALTER, dan DROP berhasil diuji.

## Catatan
File .env tidak disertakan dalam repository
untuk menjaga keamanan password.

Pengujian dilakukan pada lingkungan lokal.
Dokumentasi hasil pengerjaan disertakan
dalam laporan UTS berbentuk PDF.
