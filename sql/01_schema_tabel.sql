-- UTS Manajemen Basis Data
-- Pembuatan Schema SALAM dan Tabel Mahasiswas

CREATE SCHEMA IF NOT EXISTS "SALAM";

CREATE TABLE IF NOT EXISTS "SALAM".mahasiswas (
    id_mahasiswa INTEGER GENERATED ALWAYS AS IDENTITY,
    nim VARCHAR(15) NOT NULL,
    nama_lengkap VARCHAR(100) NOT NULL,
    program_studi VARCHAR(100) NOT NULL,
    angkatan INTEGER NOT NULL,
    semester INTEGER NOT NULL,
    email VARCHAR(100) NOT NULL,
    ipk NUMERIC(3,2) NOT NULL,
    status_mahasiswa VARCHAR(20) DEFAULT 'Aktif',
    tanggal_registrasi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    catatan_akademik VARCHAR(150),

    CONSTRAINT pk_mahasiswas PRIMARY KEY (id_mahasiswa),
    CONSTRAINT uq_mahasiswas_nim UNIQUE (nim),
    CONSTRAINT uq_mahasiswas_email UNIQUE (email),
    CONSTRAINT ck_mahasiswas_ipk CHECK (ipk BETWEEN 0 AND 4),
    CONSTRAINT ck_mahasiswas_semester CHECK (semester BETWEEN 1 AND 14),
    CONSTRAINT ck_mahasiswas_angkatan
        CHECK (angkatan BETWEEN 2000 AND 2100),
    CONSTRAINT ck_mahasiswas_status
        CHECK (status_mahasiswa IN ('Aktif', 'Cuti', 'Lulus'))
);
