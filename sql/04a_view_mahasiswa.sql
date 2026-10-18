-- PEMBUATAN VIEW MAHASISWA AKTIF
-- Jalankan menggunakan postgres

CREATE OR REPLACE VIEW "SALAM".vw_mahasiswa_aktif AS
SELECT
    nim,
    nama_lengkap,
    program_studi,
    angkatan,
    semester,
    ipk
FROM "SALAM".mahasiswas
WHERE status_mahasiswa = 'Aktif';
