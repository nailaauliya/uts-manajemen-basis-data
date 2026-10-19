
-- UTS MANAJEMEN BASIS DATA
-- NOMOR 4: USER DAN HAK AKSES
-- Database: uts_mbd
-- Schema: SALAM
-- Jalankan menggunakan user postgres
-- Jalankan setelah 01_schema_tabel.sql dan 04a_view_mahasiswa.sql


-- 1. MEMBUAT USER DATABASE
-- Ganti placeholder password sebelum dijalankan.
-- Jangan unggah password asli ke GitHub.

CREATE USER backend_dev
WITH PASSWORD 'GANTI_PASSWORD_BACKEND';

CREATE USER bi_dev
WITH PASSWORD 'GANTI_PASSWORD_BI';

CREATE USER data_engineer
WITH PASSWORD 'GANTI_PASSWORD_ENGINEER';


-- 2. AKSES DATABASE DAN SCHEMA

GRANT CONNECT ON DATABASE uts_mbd
TO backend_dev, bi_dev, data_engineer;

GRANT USAGE ON SCHEMA "SALAM"
TO backend_dev, bi_dev, data_engineer;


-- 3. BACKEND_DEV: CRUD

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA "SALAM"
TO backend_dev;

GRANT USAGE ON ALL SEQUENCES IN SCHEMA "SALAM"
TO backend_dev;


-- 4. BI_DEV: READ ONLY

GRANT SELECT
ON ALL TABLES IN SCHEMA "SALAM"
TO bi_dev;


-- 5. DATA_ENGINEER: CRUD DAN PENGELOLAAN OBJEK

GRANT CREATE ON SCHEMA "SALAM"
TO data_engineer;

GRANT ALL PRIVILEGES
ON ALL TABLES IN SCHEMA "SALAM"
TO data_engineer;

GRANT ALL PRIVILEGES
ON ALL SEQUENCES IN SCHEMA "SALAM"
TO data_engineer;


-- 6. PENGATURAN KEPEMILIKAN OBJEK
-- Owner dapat melakukan ALTER dan DROP objek.

ALTER SCHEMA "SALAM"
OWNER TO data_engineer;

ALTER TABLE "SALAM".mahasiswas
OWNER TO data_engineer;

ALTER VIEW "SALAM".vw_mahasiswa_aktif
OWNER TO data_engineer;


-- 7. DEFAULT PRIVILEGES
-- Hak akses otomatis pada objek baru.


-- 7.1 Objek baru yang dibuat oleh postgres

ALTER DEFAULT PRIVILEGES
FOR ROLE postgres
IN SCHEMA "SALAM"
GRANT SELECT, INSERT, UPDATE, DELETE
ON TABLES TO backend_dev;

ALTER DEFAULT PRIVILEGES
FOR ROLE postgres
IN SCHEMA "SALAM"
GRANT SELECT
ON TABLES TO bi_dev;

ALTER DEFAULT PRIVILEGES
FOR ROLE postgres
IN SCHEMA "SALAM"
GRANT ALL PRIVILEGES
ON TABLES TO data_engineer;

ALTER DEFAULT PRIVILEGES
FOR ROLE postgres
IN SCHEMA "SALAM"
GRANT USAGE ON SEQUENCES TO backend_dev;

ALTER DEFAULT PRIVILEGES
FOR ROLE postgres
IN SCHEMA "SALAM"
GRANT ALL PRIVILEGES
ON SEQUENCES TO data_engineer;


-- 7.2 Objek baru yang dibuat oleh data_engineer
-- backend_dev mendapat CRUD
-- bi_dev mendapat SELECT

ALTER DEFAULT PRIVILEGES
FOR ROLE data_engineer
IN SCHEMA "SALAM"
GRANT SELECT, INSERT, UPDATE, DELETE
ON TABLES TO backend_dev;

ALTER DEFAULT PRIVILEGES
FOR ROLE data_engineer
IN SCHEMA "SALAM"
GRANT SELECT
ON TABLES TO bi_dev;

ALTER DEFAULT PRIVILEGES
FOR ROLE data_engineer
IN SCHEMA "SALAM"
GRANT USAGE ON SEQUENCES TO backend_dev;


-- 8. VERIFIKASI USER

SELECT
    rolname,
    rolcanlogin,
    rolsuper
FROM pg_roles
WHERE rolname IN (
    'backend_dev',
    'bi_dev',
    'data_engineer'
)
ORDER BY rolname;


-- 9. VERIFIKASI HAK AKSES TABEL

SELECT
    grantee,
    privilege_type
FROM information_schema.role_table_grants
WHERE table_schema = 'SALAM'
  AND table_name = 'mahasiswas'
  AND grantee IN (
      'backend_dev',
      'bi_dev',
      'data_engineer'
  )
ORDER BY grantee, privilege_type;


-- 10. VERIFIKASI KEPEMILIKAN OBJEK

SELECT
    relname AS nama_objek,
    pg_get_userbyid(relowner) AS pemilik
FROM pg_class
WHERE relnamespace = '"SALAM"'::regnamespace
  AND relname IN (
      'mahasiswas',
      'vw_mahasiswa_aktif'
  )
ORDER BY relname;


-- 11. VERIFIKASI DEFAULT PRIVILEGES

SELECT
    pg_get_userbyid(d.defaclrole) AS pembuat_objek,
    d.defaclobjtype AS jenis_objek,
    d.defaclacl AS hak_akses
FROM pg_default_acl d
WHERE d.defaclnamespace = '"SALAM"'::regnamespace
ORDER BY pembuat_objek, jenis_objek;
