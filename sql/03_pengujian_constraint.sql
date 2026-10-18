-- UTS MANAJEMEN BASIS DATA
-- PENGUJIAN CONSTRAINT
-- Tabel: SALAM.mahasiswas

-- TEST 1: UNIQUE CONSTRAINT
-- Menguji NIM yang sudah terdaftar

INSERT INTO "SALAM".mahasiswas
(nim, nama_lengkap, program_studi, angkatan,
 semester, email, ipk, status_mahasiswa)
VALUES
('1247050051', 'Mahasiswa Duplikat',
 'Teknik Informatika', 2024, 5,
 'duplikat@student.ac.id', 3.50, 'Aktif');


-- TEST 2: CHECK CONSTRAINT IPK
-- Menguji IPK yang melebihi batas 4.00

INSERT INTO "SALAM".mahasiswas
(nim, nama_lengkap, program_studi, angkatan,
 semester, email, ipk, status_mahasiswa)
VALUES
('1247050200', 'Mahasiswa IPK Tidak Valid',
 'Teknik Informatika', 2024, 5,
 'ipk200@student.ac.id', 5.00, 'Aktif');


-- TEST 3: PRIMARY KEY CONSTRAINT
-- Menguji ID mahasiswa yang sudah digunakan

INSERT INTO "SALAM".mahasiswas
(id_mahasiswa, nim, nama_lengkap,
 program_studi, angkatan, semester,
 email, ipk, status_mahasiswa)
OVERRIDING SYSTEM VALUE
VALUES
(1, '1247050300', 'Mahasiswa ID Duplikat',
 'Teknik Informatika', 2024, 5,
 'id300@student.ac.id', 3.50, 'Aktif');


-- TEST 4: CHECK CONSTRAINT SEMESTER
-- Menguji semester di luar batas 1 sampai 14

INSERT INTO "SALAM".mahasiswas
(nim, nama_lengkap, program_studi, angkatan,
 semester, email, ipk, status_mahasiswa)
VALUES
('1247050400', 'Mahasiswa Semester Tidak Valid',
 'Teknik Informatika', 2024, 20,
 'semester400@student.ac.id', 3.50, 'Aktif');
