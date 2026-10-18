-- UTS MANAJEMEN BASIS DATA
-- NOMOR 4: PENGUJIAN HAK AKSES USER
-- Database: uts_mbd
-- Schema: SALAM
--
-- Jalankan setiap bagian menggunakan koneksi
-- user yang sesuai di DBeaver.


-- =========================================
-- A. PENGUJIAN BACKEND_DEV
-- Koneksi: uts_backend_dev
-- =========================================

-- Verifikasi user
SELECT current_user, current_database();

-- TEST 1: SELECT
SELECT *
FROM "SALAM".mahasiswas;

-- TEST 2: INSERT
INSERT INTO "SALAM".mahasiswas
(nim, nama_lengkap, program_studi, angkatan,
 semester, email, ipk, status_mahasiswa)
VALUES
('1247050500', 'Mahasiswa Uji Backend',
 'Teknik Informatika', 2024, 5,
 'backend500@student.ac.id', 3.70, 'Aktif')
RETURNING *;

-- TEST 3: UPDATE
UPDATE "SALAM".mahasiswas
SET ipk = 3.90
WHERE nim = '1247050500'
RETURNING *;

-- TEST 4: DELETE
DELETE FROM "SALAM".mahasiswas
WHERE nim = '1247050500'
RETURNING *;

-- TEST 5: CREATE TABLE
-- Hasil yang diharapkan: permission denied
CREATE TABLE "SALAM".uji_akses_backend (
    id INTEGER PRIMARY KEY,
    keterangan VARCHAR(100)
);


-- =========================================
-- B. PENGUJIAN BI_DEV
-- Koneksi: uts_bi_dev
-- =========================================

-- Verifikasi user
SELECT current_user, current_database();

-- TEST 1: SELECT TABEL
SELECT *
FROM "SALAM".mahasiswas;

-- TEST 2: SELECT VIEW
SELECT *
FROM "SALAM".vw_mahasiswa_aktif;

-- TEST 3: INSERT
-- Hasil yang diharapkan: permission denied
INSERT INTO "SALAM".mahasiswas
(nim, nama_lengkap, program_studi, angkatan,
 semester, email, ipk, status_mahasiswa)
VALUES
('1247050600', 'Mahasiswa Uji BI',
 'Teknik Informatika', 2024, 5,
 'bi600@student.ac.id', 3.75, 'Aktif');

-- TEST 4: UPDATE
-- Hasil yang diharapkan: permission denied
UPDATE "SALAM".mahasiswas
SET ipk = 3.95
WHERE nim = '1247050051';

-- TEST 5: DELETE
-- Hasil yang diharapkan: permission denied
DELETE FROM "SALAM".mahasiswas
WHERE nim = '1247050051';


-- =========================================
-- C. PENGUJIAN DATA_ENGINEER
-- Koneksi: uts_data_engineer
-- =========================================

-- Verifikasi user
SELECT current_user, current_database();

-- TEST 1: CREATE TABLE
CREATE TABLE "SALAM".uji_transaksi_akademik (
    id_transaksi INTEGER GENERATED ALWAYS
        AS IDENTITY PRIMARY KEY,
    nim VARCHAR(15) NOT NULL,
    jenis_transaksi VARCHAR(30) NOT NULL,
    jumlah INTEGER NOT NULL,
    tanggal_transaksi DATE DEFAULT CURRENT_DATE
);

-- TEST 2: MODIFY
ALTER TABLE "SALAM".uji_transaksi_akademik
ADD COLUMN keterangan VARCHAR(100);

-- TEST 3: INSERT
INSERT INTO "SALAM".uji_transaksi_akademik
(nim, jenis_transaksi, jumlah, keterangan)
VALUES
('1247050051', 'Pembayaran UKT', 2500000,
 'Pembayaran semester berjalan')
RETURNING *;

-- TEST 4: SELECT
SELECT *
FROM "SALAM".uji_transaksi_akademik;

-- TEST 5: UPDATE
UPDATE "SALAM".uji_transaksi_akademik
SET keterangan = 'Pembayaran telah diverifikasi'
WHERE nim = '1247050051'
RETURNING *;

-- TEST 6: DELETE
DELETE FROM "SALAM".uji_transaksi_akademik
WHERE nim = '1247050051'
RETURNING *;

-- TEST 7: DROP TABLE
DROP TABLE "SALAM".uji_transaksi_akademik;


-- =========================================
-- D. VERIFIKASI AKSES AKHIR
-- Jalankan secara terpisah pada setiap user
-- =========================================

SELECT current_user, COUNT(*)
FROM "SALAM".mahasiswas
GROUP BY current_user;
