-- UTS MANAJEMEN BASIS DATA
-- DATA AWAL MAHASISWA
-- Schema: SALAM
-- Tabel: mahasiswas

INSERT INTO "SALAM".mahasiswas
(nim, nama_lengkap, program_studi, angkatan,
 semester, email, ipk, status_mahasiswa)
VALUES
('1247050051', 'Naila Aghna Auliya P',
 'Teknik Informatika', 2024, 5,
 'naila051@student.ac.id', 3.85, 'Aktif'),

('1247050128', 'Karina',
 'Teknik Informatika', 2024, 5,
 'Karina011@student.ac.id', 3.80, 'Aktif'),

('1247050090', 'Giselle',
 'Teknik Informatika', 2024, 5,
 'Giselle@student.ac.id', 3.65, 'Aktif');

-- Menampilkan data mahasiswa
SELECT *
FROM "SALAM".mahasiswas
ORDER BY id_mahasiswa;
