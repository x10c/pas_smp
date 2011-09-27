/*==============================================================*/
/* Database name:  PAS_SMP                                      */
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     9/24/2011 9:25:04 PM                         */
/*==============================================================*/


drop database if exists PAS_SMP;

/*==============================================================*/
/* Database: PAS_SMP                                            */
/*==============================================================*/
create database PAS_SMP;

use PAS_SMP;

/*==============================================================*/
/* Table: K_SEKOLAH_KEUANGAN                                    */
/*==============================================================*/
create table K_SEKOLAH_KEUANGAN
(
   KD_TAHUN_AJARAN      char(2) not null,
   SALDO_AWAL           decimal(18,2) not null default 0.00,
   TRM_GAJI_KSR_GURU    decimal(18,2) not null default 0.00,
   TRM_GAJI_KSR_PGW     decimal(18,2) not null default 0.00,
   TRM_GAJI_KSR_GURUBANTU decimal(18,2) not null default 0.00,
   TRM_BOS_REGULER      decimal(18,2) not null default 0.00,
   TRM_BOS_BUKU         decimal(18,2) not null default 0.00,
   TRM_BOMM             decimal(18,2) not null default 0.00,
   TRM_BKM              decimal(18,2) not null default 0.00,
   TRM_BOP              decimal(18,2) not null default 0.00,
   TRM_GJ_PGW           decimal(18,2) not null default 0.00,
   TRM_OPR_HARA         decimal(18,2) not null default 0.00,
   TRM_ADM              decimal(18,2) not null default 0.00,
   TRM_SWASTA_NON       decimal(18,2) not null default 0.00,
   TRM_PANGKAL_BANGKU   decimal(18,2) not null default 0.00,
   TRM_KOMITE           decimal(18,2) not null default 0.00,
   TRM_EKS_KUL          decimal(18,2) not null default 0.00,
   TRM_LAIN             decimal(18,2) not null default 0.00,
   TRM_PROD             decimal(18,2) not null default 0.00,
   TRM_SUMBER_LAIN      decimal(18,2) not null default 0.00,
   BYR_GURU             decimal(18,2) not null default 0.00,
   BYR_DPK              decimal(18,2) not null default 0.00,
   BYR_GURU_HON         decimal(18,2) not null default 0.00,
   BYR_BANTU            decimal(18,2) not null default 0.00,
   BYR_GURU_KESRA       decimal(18,2) not null default 0.00,
   BYR_PGW              decimal(18,2) not null default 0.00,
   BYR_PGW_HON          decimal(18,2) not null default 0.00,
   BYR_PGW_KESRA        decimal(18,2) not null default 0.00,
   BYR_PBM              decimal(18,2) not null default 0.00,
   BYR_GEDUNG           decimal(18,2) not null default 0.00,
   BYR_ALAT             decimal(18,2) not null default 0.00,
   BYR_PERABOT          decimal(18,2) not null default 0.00,
   BYR_REHAB            decimal(18,2) not null default 0.00,
   BYR_BUKU             decimal(18,2) not null default 0.00,
   BYR_ADA_LAIN         decimal(18,2) not null default 0.00,
   BYR_EKS_KUL          decimal(18,2) not null default 0.00,
   BYR_DAYA_JASA        decimal(18,2) not null default 0.00,
   BYR_TU_ADM           decimal(18,2) not null default 0.00,
   BYR_LAIN             decimal(18,2) not null default 0.00,
   SALDO_AKHIR          decimal(18,2) not null default 0.00,
   STATUS_AKHIR         char(1) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN)
);

/*==============================================================*/
/* Table: K_SEKOLAH_LISM                                        */
/*==============================================================*/
create table K_SEKOLAH_LISM
(
   KD_TAHUN_AJARAN      char(2) not null,
   RATA_NILAI_UN        decimal(5,2) not null default 0.00,
   NILAI_UN_INDO        decimal(5,2) not null default 0.00,
   NILAI_UN_MAT         decimal(5,2) not null default 0.00,
   NILAI_UN_ING         decimal(5,2) not null default 0.00,
   NILAI_UN_IPA         decimal(5,2) not null default 0.00,
   JML_JAM_LAB_IPA      tinyint unsigned not null default 0,
   JML_JAM_LAB_KIMIA    tinyint unsigned not null default 0,
   JML_JAM_LAB_FISIKA   tinyint unsigned not null default 0,
   JML_JAM_LAB_BIOLOGI  tinyint unsigned not null default 0,
   JML_JAM_LAB_BAHASA   tinyint unsigned not null default 0,
   JML_JAM_LAB_IPS      tinyint unsigned not null default 0,
   JML_JAM_LAB_KOMPUTER tinyint unsigned not null default 0,
   JML_JAM_LAB_MULTIMEDIA tinyint unsigned not null default 0,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN)
);

/*==============================================================*/
/* Table: K_SEKOLAH_PASSING_GRADE                               */
/*==============================================================*/
create table K_SEKOLAH_PASSING_GRADE
(
   KD_TAHUN_AJARAN      char(2) not null,
   RATA_UN              decimal(4,2) not null default 0.00,
   RENC_TERM            smallint unsigned not null default 0,
   JML_DAFT_L           smallint unsigned not null default 0,
   JML_DAFT_P           smallint unsigned not null default 0,
   JML_TERM_SD_L        smallint unsigned not null default 0,
   JML_TERM_SD_P        smallint unsigned not null default 0,
   JML_TERM_MI_L        smallint unsigned not null default 0,
   JML_TERM_MI_P        smallint unsigned not null default 0,
   JML_TERM_PKT_L       smallint unsigned not null default 0,
   JML_TERM_PKT_P       smallint unsigned not null default 0,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN)
);

/*==============================================================*/
/* Table: R_AGAMA                                               */
/*==============================================================*/
create table R_AGAMA
(
   KD_AGAMA             char(1) not null,
   NM_AGAMA             varchar(50) not null,
   ID_AGAMA             tinyint not null,
   primary key (KD_AGAMA)
);

/*==============================================================*/
/* Table: R_AKREDITASI                                          */
/*==============================================================*/
create table R_AKREDITASI
(
   KD_AKREDITASI        char(1) not null,
   NM_AKREDITASI        varchar(50) not null,
   primary key (KD_AKREDITASI)
);

/*==============================================================*/
/* Table: R_AKREDITASI_LAMA                                     */
/*==============================================================*/
create table R_AKREDITASI_LAMA
(
   ID_AKREDITASI_LAMA   tinyint not null,
   NM_AKREDITASI_LAMA   varchar(50) not null,
   primary key (ID_AKREDITASI_LAMA)
);

/*==============================================================*/
/* Table: R_ASAL_SEKOLAH                                        */
/*==============================================================*/
create table R_ASAL_SEKOLAH
(
   ASAL_SD              smallint unsigned not null auto_increment,
   KD_JENIS_SEKOLAH     char(2) not null,
   KD_STATUS_SEKOLAH    char(1) not null comment '1 = negeri; 2 = swasta',
   NM_SEKOLAH           varchar(50) not null,
   ALAMAT_SEKOLAH       varchar(255) not null,
   ID_PROPINSI          tinyint unsigned not null,
   ID_KABUPATEN         smallint unsigned not null,
   ID_KECAMATAN         smallint unsigned default NULL,
   NO_TELP              varchar(30) not null,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ASAL_SD)
);

/*==============================================================*/
/* Index: R_ASAL_SEKOLAH_UK                                     */
/*==============================================================*/
create unique index R_ASAL_SEKOLAH_UK on R_ASAL_SEKOLAH
(
   NM_SEKOLAH,
   ALAMAT_SEKOLAH,
   ID_PROPINSI,
   ID_KABUPATEN
);

/*==============================================================*/
/* Table: R_BANTUAN                                             */
/*==============================================================*/
create table R_BANTUAN
(
   KD_BANTUAN           char(2) not null,
   NM_BANTUAN           varchar(50) not null,
   primary key (KD_BANTUAN)
);

/*==============================================================*/
/* Table: R_BEASISWA                                            */
/*==============================================================*/
create table R_BEASISWA
(
   KD_BEASISWA          char(2) not null,
   NM_BEASISWA          varchar(50) not null,
   primary key (KD_BEASISWA)
);

/*==============================================================*/
/* Table: R_BENTUK_SEKOLAH                                      */
/*==============================================================*/
create table R_BENTUK_SEKOLAH
(
   KD_BENTUK_SEKOLAH    char(1) not null,
   NM_BENTUK_SEKOLAH    varchar(50) not null,
   primary key (KD_BENTUK_SEKOLAH)
);

/*==============================================================*/
/* Table: R_DAERAH                                              */
/*==============================================================*/
create table R_DAERAH
(
   KD_DAERAH            char(1) not null,
   NM_DAERAH            varchar(50) not null,
   primary key (KD_DAERAH)
);

/*==============================================================*/
/* Table: R_DAYA_LISTRIK                                        */
/*==============================================================*/
create table R_DAYA_LISTRIK
(
   KD_DAYA_LISTRIK      char(1) not null,
   NM_DAYA_LISTRIK      varchar(50) not null,
   primary key (KD_DAYA_LISTRIK)
);

/*==============================================================*/
/* Table: R_EKSTRAKURIKULER                                     */
/*==============================================================*/
create table R_EKSTRAKURIKULER
(
   ID_EKSTRAKURIKULER   tinyint unsigned not null auto_increment,
   NM_EKSTRAKURIKULER   varchar(50) not null,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_EKSTRAKURIKULER)
);

/*==============================================================*/
/* Index: R_EKSTRAKURIKULER_UK                                  */
/*==============================================================*/
create unique index R_EKSTRAKURIKULER_UK on R_EKSTRAKURIKULER
(
   NM_EKSTRAKURIKULER
);

/*==============================================================*/
/* Table: R_GOL_DARAH                                           */
/*==============================================================*/
create table R_GOL_DARAH
(
   KD_GOL_DARAH         char(1) not null,
   NM_GOL_DARAH         varchar(50) not null,
   primary key (KD_GOL_DARAH)
);

/*==============================================================*/
/* Table: R_GOL_PEKERJAAN_ORTU                                  */
/*==============================================================*/
create table R_GOL_PEKERJAAN_ORTU
(
   ID_GOL_PEKERJAAN_ORTU tinyint unsigned not null auto_increment,
   KD_PEKERJAAN_ORTU    char(1) not null,
   NM_GOL_PEKERJAAN_ORTU varchar(50) not null,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_GOL_PEKERJAAN_ORTU)
);

/*==============================================================*/
/* Index: R_GOL_PEKERJAAN_ORTU_UK                               */
/*==============================================================*/
create unique index R_GOL_PEKERJAAN_ORTU_UK on R_GOL_PEKERJAAN_ORTU
(
   NM_GOL_PEKERJAAN_ORTU
);

/*==============================================================*/
/* Table: R_HASIL_EVALUASI                                      */
/*==============================================================*/
create table R_HASIL_EVALUASI
(
   KD_HASIL_EVALUASI    char(1) not null,
   NM_HASIL_EVALUASI    varchar(50) not null,
   primary key (KD_HASIL_EVALUASI)
);

/*==============================================================*/
/* Table: R_HOBI                                                */
/*==============================================================*/
create table R_HOBI
(
   ID_HOBI              smallint unsigned not null auto_increment,
   KD_KEL_HOBI          char(1) not null,
   NM_HOBI              varchar(50) not null,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_HOBI)
);

/*==============================================================*/
/* Index: R_HOBI_UK                                             */
/*==============================================================*/
create unique index R_HOBI_UK on R_HOBI
(
   NM_HOBI
);

/*==============================================================*/
/* Table: R_JABATAN_PEGAWAI                                     */
/*==============================================================*/
create table R_JABATAN_PEGAWAI
(
   KD_JABATAN_PEGAWAI   char(2) not null,
   NM_JABATAN_PEGAWAI   varchar(50) not null,
   primary key (KD_JABATAN_PEGAWAI)
);

/*==============================================================*/
/* Table: R_JENIS_KETENAGAAN                                    */
/*==============================================================*/
create table R_JENIS_KETENAGAAN
(
   KD_JENIS_KETENAGAAN  char(1) not null,
   NM_JENIS_KETENAGAAN  varchar(50) not null,
   primary key (KD_JENIS_KETENAGAAN)
);

/*==============================================================*/
/* Table: R_JENIS_LOMBA                                         */
/*==============================================================*/
create table R_JENIS_LOMBA
(
   ID_JENIS_LOMBA       smallint unsigned not null auto_increment,
   NM_JENIS_LOMBA       varchar(50) not null,
   STATUS_JENIS_LOMBA   tinyint unsigned not null comment '1 = sekolah; 2 = guru; 4 = tenaga administrasi; 8 = siswa',
   JENIS_LOMBA          char(1) not null comment '0 = non akademik; 1 = akademik',
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_JENIS_LOMBA)
);

/*==============================================================*/
/* Table: R_JENIS_ORTU                                          */
/*==============================================================*/
create table R_JENIS_ORTU
(
   KD_JENIS_ORTU        char(1) not null,
   NM_JENIS_ORTU        varchar(50) not null,
   primary key (KD_JENIS_ORTU)
);

/*==============================================================*/
/* Table: R_JENIS_PEGAWAI                                       */
/*==============================================================*/
create table R_JENIS_PEGAWAI
(
   KD_JENIS_PEGAWAI     char(2) not null,
   NM_JENIS_PEGAWAI     varchar(255) not null,
   primary key (KD_JENIS_PEGAWAI)
);

/*==============================================================*/
/* Table: R_JENIS_PENATARAN                                     */
/*==============================================================*/
create table R_JENIS_PENATARAN
(
   KD_JENIS_PENATARAN   char(1) not null,
   NM_JENIS_PENATARAN   varchar(50) not null,
   primary key (KD_JENIS_PENATARAN)
);

/*==============================================================*/
/* Table: R_JENIS_PENGHARGAAN                                   */
/*==============================================================*/
create table R_JENIS_PENGHARGAAN
(
   KD_JENIS_PENGHARGAAN char(1) not null,
   NM_JENIS_PENGHARGAAN varchar(50) not null,
   primary key (KD_JENIS_PENGHARGAAN)
);

/*==============================================================*/
/* Table: R_JENIS_PESERTA_PENATARAN                             */
/*==============================================================*/
create table R_JENIS_PESERTA_PENATARAN
(
   KD_JENIS_PESERTA_PENATARAN char(1) not null,
   NM_JENIS_PESERTA_PENATARAN varchar(50) not null,
   primary key (KD_JENIS_PESERTA_PENATARAN)
);

/*==============================================================*/
/* Table: R_JENIS_PKH                                           */
/*==============================================================*/
create table R_JENIS_PKH
(
   ID_JENIS_PKH         tinyint unsigned not null auto_increment,
   NM_JENIS_PKH         varchar(50) not null,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_JENIS_PKH)
);

/*==============================================================*/
/* Index: R_JENIS_PKH_UK                                        */
/*==============================================================*/
create unique index R_JENIS_PKH_UK on R_JENIS_PKH
(
   NM_JENIS_PKH
);

/*==============================================================*/
/* Table: R_JENIS_SEKOLAH                                       */
/*==============================================================*/
create table R_JENIS_SEKOLAH
(
   KD_JENIS_SEKOLAH     char(2) not null,
   NM_JENIS_SEKOLAH     varchar(50) not null,
   primary key (KD_JENIS_SEKOLAH)
);

/*==============================================================*/
/* Table: R_KABUPATEN                                           */
/*==============================================================*/
create table R_KABUPATEN
(
   ID_KABUPATEN         smallint unsigned not null,
   NM_KABUPATEN         varchar(50) not null,
   STATUS_KOTA          char(1) not null comment '1 = kabupaten; 2 = kota',
   STATUS_PILIH         char(1) not null comment '0 = tidak dipilih; 1 = dipilih',
   primary key (ID_KABUPATEN)
);

/*==============================================================*/
/* Table: R_KECAMATAN                                           */
/*==============================================================*/
create table R_KECAMATAN
(
   ID_KECAMATAN         smallint unsigned not null,
   NM_KECAMATAN         varchar(50) not null,
   primary key (ID_KECAMATAN)
);

/*==============================================================*/
/* Table: R_KEL_HOBI                                            */
/*==============================================================*/
create table R_KEL_HOBI
(
   KD_KEL_HOBI          char(1) not null,
   NM_KEL_HOBI          varchar(50) not null,
   primary key (KD_KEL_HOBI)
);

/*==============================================================*/
/* Table: R_KEL_MATA_PELAJARAN                                  */
/*==============================================================*/
create table R_KEL_MATA_PELAJARAN
(
   KD_KEL_MATA_PELAJARAN char(2) not null,
   NM_KEL_MATA_PELAJARAN varchar(50) not null,
   primary key (KD_KEL_MATA_PELAJARAN)
);

/*==============================================================*/
/* Table: R_KEL_PROGRAM_STUDI                                   */
/*==============================================================*/
create table R_KEL_PROGRAM_STUDI
(
   KD_KEL_PROGRAM_STUDI char(2) not null,
   NM_KEL_PROGRAM_STUDI varchar(50) not null,
   primary key (KD_KEL_PROGRAM_STUDI)
);

/*==============================================================*/
/* Table: R_KEL_YAYASAN                                         */
/*==============================================================*/
create table R_KEL_YAYASAN
(
   KD_KEL_YAYASAN       char(2) not null,
   NM_KEL_YAYASAN       varchar(50) not null,
   primary key (KD_KEL_YAYASAN)
);

/*==============================================================*/
/* Table: R_KEPEMILIKAN                                         */
/*==============================================================*/
create table R_KEPEMILIKAN
(
   KD_KEPEMILIKAN       char(1) not null,
   NM_KEPEMILIKAN       varchar(50) not null,
   primary key (KD_KEPEMILIKAN)
);

/*==============================================================*/
/* Table: R_KEPRIBADIAN                                         */
/*==============================================================*/
create table R_KEPRIBADIAN
(
   KD_KEPRIBADIAN       char(1) not null,
   NM_KEPRIBADIAN       varchar(50) not null,
   STATUS_RAPOR         char(1) not null comment '0 = tidak aktif; 1 = aktif',
   primary key (KD_KEPRIBADIAN)
);

/*==============================================================*/
/* Table: R_KESEJAHTERAAN_KELUARGA                              */
/*==============================================================*/
create table R_KESEJAHTERAAN_KELUARGA
(
   KD_KESEJAHTERAAN_KELUARGA char(1) not null,
   NM_KESEJAHTERAAN_KELUARGA varchar(50) not null,
   primary key (KD_KESEJAHTERAAN_KELUARGA)
);

/*==============================================================*/
/* Table: R_KETUNAAN                                            */
/*==============================================================*/
create table R_KETUNAAN
(
   KD_KETUNAAN          char(2) not null,
   NM_KETUNAAN          varchar(50) not null,
   primary key (KD_KETUNAAN)
);

/*==============================================================*/
/* Table: R_KLASIFIKASI_GEOGRAFIS                               */
/*==============================================================*/
create table R_KLASIFIKASI_GEOGRAFIS
(
   KD_KLASIFIKASI_GEOGRAFIS char(1) not null,
   NM_KLASIFIKASI_GEOGRAFIS varchar(50) not null,
   ID_KLASIFIKASI_GEOGRAFIS tinyint not null,
   primary key (KD_KLASIFIKASI_GEOGRAFIS)
);

/*==============================================================*/
/* Table: R_KLASIFIKASI_SEKOLAH                                 */
/*==============================================================*/
create table R_KLASIFIKASI_SEKOLAH
(
   KD_KLASIFIKASI_SEKOLAH char(1) not null,
   NM_KLASIFIKASI_SEKOLAH varchar(50) not null,
   primary key (KD_KLASIFIKASI_SEKOLAH)
);

/*==============================================================*/
/* Table: R_KONDISI_RUANGAN                                     */
/*==============================================================*/
create table R_KONDISI_RUANGAN
(
   KD_KONDISI_RUANGAN   char(1) not null,
   NM_KONDISI_RUANGAN   varchar(50) not null,
   primary key (KD_KONDISI_RUANGAN)
);

/*==============================================================*/
/* Table: R_KURIKULUM                                           */
/*==============================================================*/
create table R_KURIKULUM
(
   KD_KURIKULUM         char(2) not null,
   NM_KURIKULUM         varchar(50) not null,
   KETERANGAN           varchar(255) default '',
   primary key (KD_KURIKULUM)
);

/*==============================================================*/
/* Table: R_MATA_PELAJARAN_DIAJARKAN                            */
/*==============================================================*/
create table R_MATA_PELAJARAN_DIAJARKAN
(
   KD_MATA_PELAJARAN_DIAJARKAN char(5) not null,
   NM_MATA_PELAJARAN_DIAJARKAN varchar(50) not null,
   KD_KEL_MATA_PELAJARAN char(2) not null,
   ORDER_LIST           smallint default NULL,
   ORDER_RAPOR          smallint default NULL,
   ORDER_STTB           smallint default NULL,
   ORDER_NEM            smallint default NULL,
   ORDER_LNS            smallint default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_MATA_PELAJARAN_DIAJARKAN)
);

/*==============================================================*/
/* Index: R_MATA_PELAJARAN_DIAJARKAN_UK                         */
/*==============================================================*/
create unique index R_MATA_PELAJARAN_DIAJARKAN_UK on R_MATA_PELAJARAN_DIAJARKAN
(
   NM_MATA_PELAJARAN_DIAJARKAN
);

/*==============================================================*/
/* Table: R_NILAI_AFEKTIF                                       */
/*==============================================================*/
create table R_NILAI_AFEKTIF
(
   ID_NILAI_AFEKTIF     tinyint unsigned not null auto_increment,
   NM_NILAI_AFEKTIF     varchar(50) not null,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_NILAI_AFEKTIF)
);

/*==============================================================*/
/* Index: R_NILAI_AFEKTIF_UK                                    */
/*==============================================================*/
create unique index R_NILAI_AFEKTIF_UK on R_NILAI_AFEKTIF
(
   NM_NILAI_AFEKTIF
);

/*==============================================================*/
/* Table: R_PANGKAT                                             */
/*==============================================================*/
create table R_PANGKAT
(
   KD_PANGKAT           char(2) not null,
   NM_PANGKAT           varchar(50) not null,
   primary key (KD_PANGKAT)
);

/*==============================================================*/
/* Table: R_PEKERJAAN_ORTU                                      */
/*==============================================================*/
create table R_PEKERJAAN_ORTU
(
   KD_PEKERJAAN_ORTU    char(1) not null,
   NM_PEKERJAAN_ORTU    varchar(50) not null,
   primary key (KD_PEKERJAAN_ORTU)
);

/*==============================================================*/
/* Table: R_PENATARAN                                           */
/*==============================================================*/
create table R_PENATARAN
(
   ID_PENATARAN         smallint unsigned not null auto_increment,
   NM_PENATARAN         varchar(50) not null,
   KD_JENIS_KETENAGAAN  char(1) not null,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_PENATARAN)
);

/*==============================================================*/
/* Index: R_PENATARAN_UK                                        */
/*==============================================================*/
create unique index R_PENATARAN_UK on R_PENATARAN
(
   NM_PENATARAN
);

/*==============================================================*/
/* Table: R_PENGGUNAAN_TANAH                                    */
/*==============================================================*/
create table R_PENGGUNAAN_TANAH
(
   KD_PENGGUNAAN_TANAH  char(1) not null,
   NM_PENGGUNAAN_TANAH  varchar(50) not null,
   primary key (KD_PENGGUNAAN_TANAH)
);

/*==============================================================*/
/* Table: R_PENYAKIT                                            */
/*==============================================================*/
create table R_PENYAKIT
(
   ID_PENYAKIT          smallint unsigned not null auto_increment,
   NM_PENYAKIT          varchar(50) not null,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_PENYAKIT)
);

/*==============================================================*/
/* Index: R_PENYAKIT_UK                                         */
/*==============================================================*/
create unique index R_PENYAKIT_UK on R_PENYAKIT
(
   NM_PENYAKIT
);

/*==============================================================*/
/* Table: R_PENYELENGGARA_PENATARAN                             */
/*==============================================================*/
create table R_PENYELENGGARA_PENATARAN
(
   KD_PENYELENGGARA_PENATARAN char(1) not null,
   NM_PENYELENGGARA_PENATARAN varchar(50) not null,
   primary key (KD_PENYELENGGARA_PENATARAN)
);

/*==============================================================*/
/* Table: R_PERIODE_BELAJAR                                     */
/*==============================================================*/
create table R_PERIODE_BELAJAR
(
   KD_PERIODE_BELAJAR   char(1) not null,
   NM_PERIODE_BELAJAR   varchar(50) not null,
   primary key (KD_PERIODE_BELAJAR)
);

/*==============================================================*/
/* Table: R_PERLENGKAPAN_SEKOLAH                                */
/*==============================================================*/
create table R_PERLENGKAPAN_SEKOLAH
(
   KD_PERLENGKAPAN_SEKOLAH char(2) not null,
   NM_PERLENGKAPAN_SEKOLAH varchar(50) not null,
   primary key (KD_PERLENGKAPAN_SEKOLAH)
);

/*==============================================================*/
/* Table: R_PROGRAM_STUDI                                       */
/*==============================================================*/
create table R_PROGRAM_STUDI
(
   KD_PROGRAM_STUDI     char(4) not null,
   KD_KEL_PROGRAM_STUDI char(2) not null,
   NM_PROGRAM_STUDI     varchar(50) not null,
   primary key (KD_PROGRAM_STUDI)
);

/*==============================================================*/
/* Index: R_PROGRAM_STUDI_UK                                    */
/*==============================================================*/
create unique index R_PROGRAM_STUDI_UK on R_PROGRAM_STUDI
(
   NM_PROGRAM_STUDI
);

/*==============================================================*/
/* Table: R_PROPINSI                                            */
/*==============================================================*/
create table R_PROPINSI
(
   ID_PROPINSI          tinyint unsigned not null,
   NM_PROPINSI          varchar(50) not null,
   KD_PROPINSI          char(2) not null,
   KD_WILAYAH           char(1) default NULL,
   TAHUN_AWAL           smallint unsigned not null,
   TAHUN_AKHIR          smallint unsigned default NULL,
   TANGGAL              date default NULL,
   STATUS_PILIH         char(1) not null comment '0 = tidak dipilih; 1 = dipilih',
   primary key (ID_PROPINSI)
);

/*==============================================================*/
/* Table: R_REPORT                                              */
/*==============================================================*/
create table R_REPORT
(
   ID_REPORT            varchar(10) not null,
   NAMA_REPORT          varchar(255) not null,
   TIPE_REPORT          varchar(10) not null,
   FILE_LOCATION        varchar(255) not null,
   WEB_PARAMS           varchar(100),
   REPORT_PARAMS        varchar(100),
   primary key (ID_REPORT)
);

/*==============================================================*/
/* Table: R_RUANG                                               */
/*==============================================================*/
create table R_RUANG
(
   KD_RUANG             char(2) not null,
   NM_RUANG             varchar(50) not null,
   primary key (KD_RUANG)
);

/*==============================================================*/
/* Table: R_SANKSI                                              */
/*==============================================================*/
create table R_SANKSI
(
   ID_SANKSI            tinyint unsigned not null auto_increment,
   NM_SANKSI            varchar(50) not null,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SANKSI)
);

/*==============================================================*/
/* Index: R_SANKSI_UK                                           */
/*==============================================================*/
create unique index R_SANKSI_UK on R_SANKSI
(
   NM_SANKSI
);

/*==============================================================*/
/* Table: R_SEKOLAH_SETINGKAT                                   */
/*==============================================================*/
create table R_SEKOLAH_SETINGKAT
(
   ASAL_SMP             smallint unsigned not null auto_increment,
   KD_JENIS_SEKOLAH     char(2) not null,
   KD_STATUS_SEKOLAH    char(1) not null comment '1 = negeri; 2 = swasta',
   NM_SEKOLAH           varchar(50) not null,
   ALAMAT_SEKOLAH       varchar(255) not null,
   ID_PROPINSI          tinyint unsigned not null,
   ID_KABUPATEN         smallint unsigned not null,
   ID_KECAMATAN         smallint unsigned default NULL,
   NO_TELP              varchar(30) not null,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ASAL_SMP)
);

/*==============================================================*/
/* Index: R_SEKOLAH_SETINGKAT_UK                                */
/*==============================================================*/
create unique index R_SEKOLAH_SETINGKAT_UK on R_SEKOLAH_SETINGKAT
(
   NM_SEKOLAH,
   ALAMAT_SEKOLAH,
   ID_PROPINSI,
   ID_KABUPATEN
);

/*==============================================================*/
/* Table: R_SERTIFIKAT                                          */
/*==============================================================*/
create table R_SERTIFIKAT
(
   KD_SERTIFIKAT        char(1) not null,
   NM_SERTIFIKAT        varchar(50) not null,
   primary key (KD_SERTIFIKAT)
);

/*==============================================================*/
/* Table: R_STATUS_PEGAWAI                                      */
/*==============================================================*/
create table R_STATUS_PEGAWAI
(
   KD_STATUS_PEGAWAI    char(1) not null,
   NM_STATUS_PEGAWAI    varchar(50) not null,
   primary key (KD_STATUS_PEGAWAI)
);

/*==============================================================*/
/* Table: R_SUMBER_LISTRIK                                      */
/*==============================================================*/
create table R_SUMBER_LISTRIK
(
   KD_SUMBER_LISTRIK    char(1) not null,
   NM_SUMBER_LISTRIK    varchar(50) not null,
   primary key (KD_SUMBER_LISTRIK)
);

/*==============================================================*/
/* Table: R_TAHUN_AJARAN                                        */
/*==============================================================*/
create table R_TAHUN_AJARAN
(
   KD_TAHUN_AJARAN      char(2) not null,
   NM_TAHUN_AJARAN      varchar(50) not null,
   primary key (KD_TAHUN_AJARAN)
);

/*==============================================================*/
/* Table: R_TENAGA_ADMINISTRASI                                 */
/*==============================================================*/
create table R_TENAGA_ADMINISTRASI
(
   KD_TENAGA_ADMINISTRASI char(1) not null,
   NM_TENAGA_ADMINISTRASI varchar(50) not null,
   primary key (KD_TENAGA_ADMINISTRASI)
);

/*==============================================================*/
/* Table: R_TINGKAT_IJAZAH                                      */
/*==============================================================*/
create table R_TINGKAT_IJAZAH
(
   KD_TINGKAT_IJAZAH    char(2) not null,
   NM_TINGKAT_IJAZAH    varchar(50) not null,
   primary key (KD_TINGKAT_IJAZAH)
);

/*==============================================================*/
/* Table: R_TINGKAT_KELAS                                       */
/*==============================================================*/
create table R_TINGKAT_KELAS
(
   KD_TINGKAT_KELAS     char(2) not null,
   NM_TINGKAT_KELAS     varchar(50) not null,
   KETERANGAN           varchar(255) default NULL,
   primary key (KD_TINGKAT_KELAS)
);

/*==============================================================*/
/* Table: R_TINGKAT_PRESTASI                                    */
/*==============================================================*/
create table R_TINGKAT_PRESTASI
(
   KD_TINGKAT_PRESTASI  char(1) not null,
   NM_TINGKAT_PRESTASI  varchar(50) not null,
   primary key (KD_TINGKAT_PRESTASI)
);

/*==============================================================*/
/* Table: R_TYPE_SEKOLAH                                        */
/*==============================================================*/
create table R_TYPE_SEKOLAH
(
   KD_TYPE_SEKOLAH      char(1) not null,
   NM_TYPE_SEKOLAH      varchar(50) not null,
   primary key (KD_TYPE_SEKOLAH)
);

/*==============================================================*/
/* Table: R_VOLTASE                                             */
/*==============================================================*/
create table R_VOLTASE
(
   KD_VOLTASE           char(1) not null,
   NM_VOLTASE           varchar(50) not null,
   primary key (KD_VOLTASE)
);

/*==============================================================*/
/* Table: R_WAKTU_PENYELENGGARAAN                               */
/*==============================================================*/
create table R_WAKTU_PENYELENGGARAAN
(
   KD_WAKTU_PENYELENGGARAAN char(1) not null,
   NM_WAKTU_PENYELENGGARAAN varchar(50) not null,
   ID_WAKTU_PENYELENGGARAAN tinyint unsigned not null,
   primary key (KD_WAKTU_PENYELENGGARAAN)
);

/*==============================================================*/
/* Table: T_KABUPATEN_KECAMATAN                                 */
/*==============================================================*/
create table T_KABUPATEN_KECAMATAN
(
   ID_KABUPATEN         smallint unsigned not null,
   ID_KECAMATAN         smallint unsigned not null,
   TAHUN_AWAL           smallint unsigned not null,
   KD_KECAMATAN         char(6) not null,
   TAHUN_AKHIR          smallint unsigned default NULL,
   TANGGAL              date default NULL,
   primary key (ID_KABUPATEN, ID_KECAMATAN, TAHUN_AWAL)
);

/*==============================================================*/
/* Table: T_KUR_KKM_MATPEL                                      */
/*==============================================================*/
create table T_KUR_KKM_MATPEL
(
   KD_TAHUN_AJARAN      char(2) not null,
   KD_TINGKAT_KELAS     char(2) not null,
   KD_ROMBEL            varchar(15) not null,
   KD_KURIKULUM         char(2) not null,
   KD_PERIODE_BELAJAR   char(1) not null,
   KD_MATA_PELAJARAN_DIAJARKAN char(5) not null,
   KKM                  tinyint unsigned not null default 65,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL, KD_KURIKULUM, KD_PERIODE_BELAJAR, KD_MATA_PELAJARAN_DIAJARKAN)
);

/*==============================================================*/
/* Table: T_KUR_KURIKULUM                                       */
/*==============================================================*/
create table T_KUR_KURIKULUM
(
   KD_KURIKULUM         char(2) not null,
   KD_TINGKAT_KELAS     char(2) not null,
   KD_PERIODE_BELAJAR   char(1) not null,
   KD_MATA_PELAJARAN_DIAJARKAN char(5) not null,
   STATUS_CIRI_KHAS     char(1) not null default '0',
   UAN                  char(1) not null default '0',
   ELEMEN               tinyint not null default 21,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_KURIKULUM, KD_TINGKAT_KELAS, KD_PERIODE_BELAJAR, KD_MATA_PELAJARAN_DIAJARKAN)
);

/*==============================================================*/
/* Table: T_NILAI_NEM                                           */
/*==============================================================*/
create table T_NILAI_NEM
(
   ID_SISWA             bigint unsigned not null,
   NIS                  varchar(25) default NULL,
   KD_TAHUN_AJARAN      char(2) not null,
   KD_TINGKAT_KELAS     char(2) not null,
   KD_ROMBEL            varchar(15) not null,
   KD_KURIKULUM         char(2) not null,
   KD_PERIODE_BELAJAR   char(1) not null,
   KD_MATA_PELAJARAN_DIAJARKAN char(5) not null,
   NILAI                decimal(5,2) not null,
   NILAI_HURUF          varchar(255) default NULL,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL, KD_KURIKULUM, KD_PERIODE_BELAJAR, KD_MATA_PELAJARAN_DIAJARKAN)
);

/*==============================================================*/
/* Table: T_NILAI_RAPOR                                         */
/*==============================================================*/
create table T_NILAI_RAPOR
(
   ID_SISWA             bigint unsigned not null,
   NIS                  varchar(25) default NULL,
   KD_TAHUN_AJARAN      char(2) not null,
   KD_TINGKAT_KELAS     char(2) not null,
   KD_ROMBEL            varchar(15) not null,
   KD_PERIODE_BELAJAR   char(1) not null,
   ID_AHLAK             tinyint unsigned not null default '1',
   ID_PRIBADI           tinyint unsigned not null default '1',
   SAKIT                tinyint unsigned not null default 0,
   IJIN                 tinyint unsigned not null default 0,
   ABSEN                tinyint unsigned not null default 0,
   TANGGAL_DIBERIKAN    date default NULL,
   CATATAN              varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL, KD_PERIODE_BELAJAR)
);

/*==============================================================*/
/* Table: T_NILAI_RAPOR_EKSTRA                                  */
/*==============================================================*/
create table T_NILAI_RAPOR_EKSTRA
(
   ID_SISWA             bigint unsigned not null,
   NIS                  varchar(25) default NULL,
   KD_TAHUN_AJARAN      char(2) not null,
   KD_TINGKAT_KELAS     char(2) not null,
   KD_ROMBEL            varchar(15) not null,
   KD_PERIODE_BELAJAR   char(1) not null,
   ID_EKSTRAKURIKULER   tinyint unsigned not null,
   ID_NILAI_AFEKTIF     tinyint unsigned not null,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL, KD_PERIODE_BELAJAR, ID_EKSTRAKURIKULER)
);

/*==============================================================*/
/* Table: T_NILAI_RAPOR_KEPRIBADIAN                             */
/*==============================================================*/
create table T_NILAI_RAPOR_KEPRIBADIAN
(
   ID_SISWA             bigint unsigned not null,
   NIS                  varchar(25) default NULL,
   KD_TAHUN_AJARAN      char(2) not null,
   KD_TINGKAT_KELAS     char(2) not null,
   KD_ROMBEL            varchar(15) not null,
   KD_PERIODE_BELAJAR   char(1) not null,
   KD_KEPRIBADIAN       char(1) not null,
   ID_NILAI_AFEKTIF     tinyint unsigned not null,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL, KD_PERIODE_BELAJAR, KD_KEPRIBADIAN)
);

/*==============================================================*/
/* Table: T_NILAI_RAPOR_NILAI                                   */
/*==============================================================*/
create table T_NILAI_RAPOR_NILAI
(
   ID_SISWA             bigint unsigned not null,
   NIS                  varchar(25) default NULL,
   KD_TAHUN_AJARAN      char(2) not null,
   KD_TINGKAT_KELAS     char(2) not null,
   KD_ROMBEL            varchar(15) not null,
   KD_PERIODE_BELAJAR   char(1) not null,
   KD_KURIKULUM         char(2) not null,
   KD_MATA_PELAJARAN_DIAJARKAN char(5) not null,
   KKM                  tinyint unsigned not null,
   NILAI                decimal(5,2) not null default 0.00,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL, KD_PERIODE_BELAJAR, KD_KURIKULUM, KD_MATA_PELAJARAN_DIAJARKAN)
);

/*==============================================================*/
/* Table: T_NILAI_STTB                                          */
/*==============================================================*/
create table T_NILAI_STTB
(
   ID_SISWA             bigint unsigned not null,
   NIS                  varchar(25) default NULL,
   KD_TAHUN_AJARAN      char(2) not null,
   KD_TINGKAT_KELAS     char(2) not null,
   KD_ROMBEL            varchar(15) not null,
   KD_KURIKULUM         char(2) not null,
   KD_PERIODE_BELAJAR   char(1) not null,
   KD_MATA_PELAJARAN_DIAJARKAN char(5) not null,
   NILAI                decimal(5,2) not null,
   NILAI_HURUF          varchar(255) default NULL,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL, KD_KURIKULUM, KD_PERIODE_BELAJAR, KD_MATA_PELAJARAN_DIAJARKAN)
);

/*==============================================================*/
/* Table: T_PEGAWAI                                             */
/*==============================================================*/
create table T_PEGAWAI
(
   ID_PEGAWAI           smallint unsigned not null auto_increment,
   NIP                  varchar(18) not null,
   NUPTK                varchar(14) default NULL,
   NM_PEGAWAI           varchar(50) not null,
   INISIAL              varchar(3) default NULL,
   KOTA_LAHIR           varchar(50) not null,
   TANGGAL_LAHIR        date not null,
   KD_JENIS_KELAMIN     char(1) not null comment '1 = laki-laki; 2 = perempuan',
   KD_GOL_DARAH         char(1),
   KD_AGAMA             char(1) not null,
   KD_STATUS_NIKAH      char(1) not null comment 'N = menikah; J = janda; D = duda; B = belum menikah',
   ALAMAT               varchar(150) not null,
   KD_POS               char(5) default NULL,
   NO_TELP              varchar(30) default NULL,
   KD_JENIS_KETENAGAAN  char(1) not null,
   NO_HP                varchar(30) default NULL,
   OPERASI_KOMPUTER     char(1) default '0' comment '0 = belum mampu mengoperasikan; 1 = sudah mampu mengoperasikan',
   KURSUS_KOMPUTER      char(1) default '0' comment '0 = belum pernah; 1 = pernah',
   SERTIFIKASI          char(1) default '0' comment '0 = belum; 1 = sudah',
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_PEGAWAI)
);

/*==============================================================*/
/* Index: T_PEGAWAI_UK                                          */
/*==============================================================*/
create unique index T_PEGAWAI_UK on T_PEGAWAI
(
   NIP
);

/*==============================================================*/
/* Table: T_PEGAWAI_AKTIF                                       */
/*==============================================================*/
create table T_PEGAWAI_AKTIF
(
   KD_TAHUN_AJARAN      char(2) not null,
   ID_PEGAWAI           smallint unsigned not null,
   NIP                  varchar(18) default NULL,
   KD_JENIS_KETENAGAAN  char(1) not null,
   NM_PEGAWAI           varchar(50) default NULL,
   KOTA_LAHIR           varchar(50) default NULL,
   TANGGAL_LAHIR        date default NULL,
   KD_JENIS_KELAMIN     char(1) default NULL comment '1 = laki-laki; 2 = perempuan',
   UMUR                 smallint unsigned default 0,
   KD_USIA_PEGAWAI      char(2) default '00',
   URUT_DIDIK           tinyint unsigned default NULL,
   URUT_PANGKAT         tinyint unsigned default NULL,
   AWAL_JABATAN         tinyint unsigned default NULL,
   URUT_JABATAN         tinyint unsigned default NULL,
   URUT_TATAR           tinyint unsigned default NULL,
   STATUS_AKTIF         char(1) not null default '0' comment '0 = tidak aktif; 1 = aktif',
   STATUS_ENTRI         char(1) not null default '0',
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, ID_PEGAWAI)
);

/*==============================================================*/
/* Table: T_PEGAWAI_DIDIK_FORMAL                                */
/*==============================================================*/
create table T_PEGAWAI_DIDIK_FORMAL
(
   ID_PEGAWAI           smallint unsigned not null,
   NIP                  varchar(18) default NULL,
   NO_URUT              tinyint unsigned not null,
   KD_TINGKAT_IJAZAH    char(2) not null,
   KD_PROGRAM_STUDI     char(4) not null,
   NM_INSTANSI_PENDDKN  varchar(50) not null,
   KD_AKREDITASI        char(1) not null,
   TAHUN_MULAI          smallint unsigned not null,
   TAHUN_SELESAI        smallint unsigned default NULL,
   KD_STATUS_LULUS      char(1) not null default '0' comment '0 = tidak lulus; 1 = lulus',
   NO_IJAZAH            varchar(50) default NULL,
   TANGGAL_IJAZAH       date default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_PEGAWAI, NO_URUT)
);

/*==============================================================*/
/* Table: T_PEGAWAI_GURU_KEBUTUHAN                              */
/*==============================================================*/
create table T_PEGAWAI_GURU_KEBUTUHAN
(
   KD_TAHUN_AJARAN      char(2) not null,
   KD_KEL_MATA_PELAJARAN char(2) not null,
   JUMLAH_TETAP         tinyint unsigned not null default 0,
   JUMLAH_TAK_TETAP     tinyint unsigned not null default 0,
   JUMLAH_BUTUH         tinyint unsigned not null default 0,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, KD_KEL_MATA_PELAJARAN)
);

/*==============================================================*/
/* Table: T_PEGAWAI_KELUARGA                                    */
/*==============================================================*/
create table T_PEGAWAI_KELUARGA
(
   ID_PEGAWAI           smallint unsigned not null,
   NIP                  varchar(18) default NULL,
   NO_URUT              tinyint unsigned not null,
   NM_KELUARGA          varchar(50) not null,
   KD_HUB_KELUARGA      char(1) not null comment 'I = istri; S = suami; K = anak kandung; T = anak tiri; L = lain-lain',
   PROP_LAHIR           varchar(50) not null,
   KOTA_LAHIR           varchar(50) not null,
   TANGGAL_LAHIR        date not null,
   KD_JENIS_KELAMIN     char(1) not null comment '1 = laki-laki; 2 = perempuan',
   KD_GOL_DARAH         char(1),
   KD_AGAMA             char(1) not null,
   KD_STATUS_NIKAH      char(1) not null comment 'N = menikah; J = janda; D = duda; B = belum menikah',
   TANGGAL_MENIKAH      date default NULL,
   TAHUN_MENINGGAL      smallint unsigned default NULL,
   ALAMAT               varchar(150) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_PEGAWAI, NO_URUT)
);

/*==============================================================*/
/* Table: T_PEGAWAI_MENGAJAR                                    */
/*==============================================================*/
create table T_PEGAWAI_MENGAJAR
(
   KD_TAHUN_AJARAN      char(2) not null,
   ID_PEGAWAI           smallint unsigned not null,
   NIP                  varchar(18) default NULL,
   KD_MATA_PELAJARAN_DIAJARKAN char(5) not null,
   TAHUN_MULAI_AJAR     smallint unsigned not null default 0,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, ID_PEGAWAI, KD_MATA_PELAJARAN_DIAJARKAN)
);

/*==============================================================*/
/* Table: T_PEGAWAI_PENATARAN                                   */
/*==============================================================*/
create table T_PEGAWAI_PENATARAN
(
   ID_PEGAWAI           smallint unsigned not null,
   NIP                  varchar(18) default NULL,
   NO_URUT              tinyint unsigned not null,
   ID_PENATARAN         smallint unsigned not null,
   KD_PENYELENGGARA_PENATARAN char(1) not null,
   KD_JENIS_PENATARAN   char(1) not null,
   KD_JENIS_PESERTA_PENATARAN char(1) not null,
   KD_MATA_PELAJARAN_DIAJARKAN char(5) default NULL,
   TANGGAL_AWAL         date default NULL,
   TANGGAL_AKHIR        date default NULL,
   JAM                  smallint unsigned not null,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_PEGAWAI, NO_URUT)
);

/*==============================================================*/
/* Table: T_PEGAWAI_PENGHARGAAN                                 */
/*==============================================================*/
create table T_PEGAWAI_PENGHARGAAN
(
   ID_PEGAWAI           smallint unsigned not null,
   NIP                  varchar(18) default NULL,
   KD_JENIS_PENGHARGAAN char(1) not null,
   TANGGAL_PENGHARGAAN  date not null,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_PEGAWAI, KD_JENIS_PENGHARGAAN)
);

/*==============================================================*/
/* Table: T_PEGAWAI_PRESTASI                                    */
/*==============================================================*/
create table T_PEGAWAI_PRESTASI
(
   ID_PEGAWAI           smallint unsigned not null,
   NIP                  varchar(18) default NULL,
   ID_JENIS_LOMBA       smallint unsigned not null,
   KD_TINGKAT_PRESTASI  char(1) not null,
   TANGGAL_PRESTASI     date not null,
   JUARA_KE             tinyint unsigned not null,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_PEGAWAI, ID_JENIS_LOMBA, KD_TINGKAT_PRESTASI, TANGGAL_PRESTASI)
);

/*==============================================================*/
/* Table: T_PEGAWAI_ROMBEL                                      */
/*==============================================================*/
create table T_PEGAWAI_ROMBEL
(
   KD_TAHUN_AJARAN      char(2) not null,
   KD_TINGKAT_KELAS     char(2) not null,
   KD_ROMBEL            varchar(15) not null,
   ID_PEGAWAI           smallint unsigned default NULL,
   NIP                  varchar(18) default NULL,
   ID_PEGAWAI_BK        smallint unsigned default NULL,
   NIP_BK               varchar(18) default NULL,
   ID_RUANG_KELAS       bigint unsigned not null,
   KETERANGAN           varchar(255) default NULL,
   STATUS_NAIK_KELAS    char(1) not null default '0' comment '0 = belum naik kelas
            1 = sudah mendapatkan rapor semester 1
            2 = sudah mendapatkan rapor semester 2
            3 = sudah naik kelas',
   TANGGAL_SEMESTER_1   date default NULL,
   TANGGAL_SEMESTER_2   date default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL)
);

/*==============================================================*/
/* Table: T_PEGAWAI_RWYT_AJAR                                   */
/*==============================================================*/
create table T_PEGAWAI_RWYT_AJAR
(
   ID_PEGAWAI           smallint unsigned not null,
   NIP                  varchar(18) default NULL,
   KD_MATA_PELAJARAN_DIAJARKAN char(5) not null,
   TAHUN_MULAI_AJAR     smallint unsigned not null,
   STATUS_AJAR          char(1) default NULL,
   NM_SEKOLAH           varchar(50) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_PEGAWAI, KD_MATA_PELAJARAN_DIAJARKAN)
);

/*==============================================================*/
/* Table: T_PEGAWAI_RWYT_JABATAN                                */
/*==============================================================*/
create table T_PEGAWAI_RWYT_JABATAN
(
   ID_PEGAWAI           smallint unsigned not null,
   NIP                  varchar(18) default NULL,
   NO_URUT              tinyint unsigned not null,
   KD_JENIS_PEGAWAI     char(2) not null,
   KD_JABATAN_PEGAWAI   char(2) default NULL,
   KD_TENAGA_ADMINISTRASI char(1) default NULL,
   NO_SK                varchar(30) not null,
   TANGGAL_SK           date not null,
   TMT_SK               date not null,
   STATUS_JABATAN       char(1) default NULL,
   NM_SEKOLAH           varchar(50) default NULL,
   TAHUN_BERHENTI       smallint unsigned default NULL,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_PEGAWAI, NO_URUT)
);

/*==============================================================*/
/* Table: T_PEGAWAI_RWYT_PANGKAT                                */
/*==============================================================*/
create table T_PEGAWAI_RWYT_PANGKAT
(
   ID_PEGAWAI           smallint unsigned not null,
   NIP                  varchar(18) default NULL,
   NO_URUT              tinyint unsigned not null,
   KD_STATUS_PEGAWAI    char(1) not null,
   KD_PANGKAT           char(2) not null,
   NO_SK                varchar(30) not null,
   TANGGAL_SK           date not null,
   TMT_SK               date not null,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_PEGAWAI, NO_URUT)
);

/*==============================================================*/
/* Table: T_PROPINSI_KABUPATEN                                  */
/*==============================================================*/
create table T_PROPINSI_KABUPATEN
(
   ID_PROPINSI          tinyint unsigned not null,
   ID_KABUPATEN         smallint unsigned not null,
   TAHUN_AWAL           smallint unsigned not null,
   KD_KABUPATEN         char(4) not null,
   TAHUN_AKHIR          smallint unsigned default NULL,
   TANGGAL              date default NULL,
   primary key (ID_PROPINSI, ID_KABUPATEN, TAHUN_AWAL)
);

/*==============================================================*/
/* Table: T_SEKOLAH_ANCAM_DO                                    */
/*==============================================================*/
create table T_SEKOLAH_ANCAM_DO
(
   KD_TAHUN_AJARAN      char(2) not null,
   KD_TINGKAT_KELAS     char(2) not null,
   JUMLAH               smallint unsigned not null,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, KD_TINGKAT_KELAS)
);

/*==============================================================*/
/* Table: T_SEKOLAH_BANTUAN                                     */
/*==============================================================*/
create table T_SEKOLAH_BANTUAN
(
   KD_TAHUN_AJARAN      char(2) not null,
   KD_BANTUAN           char(2) not null,
   SUMBER_BANTUAN       varchar(50) not null,
   TAHUN_BANTUAN        smallint unsigned not null,
   JUMLAH_DANA          decimal(18,2) not null default 0.00,
   DANA_PENDAMPING      decimal(18,2) default 0.00,
   PERUNTUKAN_DANA      varchar(255) not null,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, KD_BANTUAN, SUMBER_BANTUAN)
);

/*==============================================================*/
/* Table: T_SEKOLAH_BERUBAH                                     */
/*==============================================================*/
create table T_SEKOLAH_BERUBAH
(
   KD_TAHUN_AJARAN      char(2) not null,
   NM_SEKOLAH_LAMA      varchar(50) not null,
   NPSN_LAMA            char(8) not null,
   KD_STATUS_SEKOLAH    char(1) not null,
   ALAMAT_LAMA          varchar(150) not null,
   ID_PROPINSI          tinyint unsigned not null,
   ID_KABUPATEN         smallint unsigned not null,
   ID_KECAMATAN         smallint unsigned not null,
   primary key (KD_TAHUN_AJARAN)
);

/*==============================================================*/
/* Table: T_SEKOLAH_BUALPEN                                     */
/*==============================================================*/
create table T_SEKOLAH_BUALPEN
(
   KD_TAHUN_AJARAN      char(2) not null,
   KD_MATA_PELAJARAN_DIAJARKAN char(5) not null,
   JML_JDL_GURU         tinyint unsigned not null default 0,
   JML_EKS_GURU         tinyint unsigned not null default 0,
   JML_JDL_SISWA        tinyint unsigned not null default 0,
   JML_EKS_SISWA        smallint unsigned not null default 0,
   JML_JDL_PEGANG       smallint unsigned not null default 0,
   JML_EKS_PEGANG       smallint unsigned not null default 0,
   PROSEN_PERAGA        numeric(3,2) not null default 0,
   PAKTEK               smallint unsigned not null default 0,
   MULMED               smallint unsigned not null default 0,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, KD_MATA_PELAJARAN_DIAJARKAN)
);

/*==============================================================*/
/* Table: T_SEKOLAH_DO                                          */
/*==============================================================*/
create table T_SEKOLAH_DO
(
   KD_TAHUN_AJARAN      char(2) not null,
   LANJUT_JAUH          tinyint unsigned not null,
   BIAYA                tinyint unsigned not null,
   TRANSPORTASI         tinyint unsigned not null,
   GEOGRAFI             tinyint unsigned not null,
   TERPENCIL            tinyint unsigned not null,
   KURANG_PENTING       tinyint unsigned not null,
   KERJA                tinyint unsigned not null,
   MENIKAH              tinyint unsigned not null,
   LAIN_LAIN            tinyint unsigned not null,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN)
);

/*==============================================================*/
/* Table: T_SEKOLAH_IDENTITAS                                   */
/*==============================================================*/
create table T_SEKOLAH_IDENTITAS
(
   KD_TAHUN_AJARAN      char(2) not null,
   NPSN                 char(8) not null,
   KD_STATUS_SEKOLAH    char(1) not null comment '1 = negeri; 2 = swasta',
   KD_BENTUK_SEKOLAH    char(1) not null,
   KD_JENIS_SEKOLAH     char(2) not null,
   NM_SEKOLAH           varchar(50) not null,
   JALAN                varchar(150) not null,
   KD_POS               char(5) default NULL,
   KD_DAERAH            char(1) not null,
   ID_PROPINSI          tinyint unsigned not null,
   ID_KABUPATEN         smallint unsigned not null,
   ID_KECAMATAN         smallint unsigned not null,
   KD_DESA              varchar(50) not null,
   KD_AREA              varchar(5) default NULL,
   NO_TELP              varchar(30) default NULL,
   NO_FAX               varchar(30) default NULL,
   JARAK_SKL_SJNS       decimal(5,2) default NULL,
   KD_WAKTU_PENYELENGGARAAN char(1) not null,
   KD_TYPE_SEKOLAH      char(1),
   KD_KLASIFIKASI_SEKOLAH char(1),
   KATEGORI             char(1) comment '1 = smp satu atap; 2 = biasa',
   KD_KLASIFIKASI_GEOGRAFIS char(1),
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN)
);

/*==============================================================*/
/* Table: T_SEKOLAH_INFO                                        */
/*==============================================================*/
create table T_SEKOLAH_INFO
(
   KD_TAHUN_AJARAN      char(2) not null,
   EMAIL                varchar(50) default NULL,
   WEBSITE              varchar(50) default NULL,
   KELILING_TANAH       decimal(18,2) default NULL,
   DIPAGAR_PERMANEN     decimal(18,2) default NULL,
   LUAS_SIAP_BANGUN     decimal(10,2) default NULL,
   LUAS_ATAS_SIAP_BANGUN decimal(10,2) default NULL,
   TAHUN_DIBUKA         smallint unsigned default NULL,
   TAHUN_OPERASI        smallint unsigned default NULL,
   TAHUN_AKHIR_RENOV    smallint unsigned default NULL,
   BUJUR                decimal(7,4) default NULL,
   LINTANG              decimal(7,4) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN)
);

/*==============================================================*/
/* Table: T_SEKOLAH_JURUSAN                                     */
/*==============================================================*/
create table T_SEKOLAH_JURUSAN
(
   KD_TAHUN_AJARAN      char(2) not null,
   KD_TINGKAT_KELAS     char(2) not null,
   KD_KURIKULUM         char(2) not null default '02',
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, KD_TINGKAT_KELAS)
);

/*==============================================================*/
/* Table: T_SEKOLAH_KEGIATAN                                    */
/*==============================================================*/
create table T_SEKOLAH_KEGIATAN
(
   KD_TAHUN_AJARAN      char(2) not null,
   NO_KEGIATAN          tinyint unsigned not null,
   NM_KEGIATAN          varchar(100) not null,
   TANGGAL_MULAI        date not null,
   TANGGAL_SELESAI      date not null,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, NO_KEGIATAN)
);

/*==============================================================*/
/* Table: T_SEKOLAH_KEPALA                                      */
/*==============================================================*/
create table T_SEKOLAH_KEPALA
(
   KD_TAHUN_AJARAN      char(2) not null,
   ID_PEGAWAI           smallint unsigned not null,
   NIP                  varchar(18) default NULL,
   NM_PEGAWAI           varchar(50) not null,
   NO_SK                varchar(30) not null,
   TANGGAL_SK           date not null,
   TMT_SK               date not null,
   primary key (KD_TAHUN_AJARAN, ID_PEGAWAI)
);

/*==============================================================*/
/* Table: T_SEKOLAH_PEMAKAIAN_LISTRIK                           */
/*==============================================================*/
create table T_SEKOLAH_PEMAKAIAN_LISTRIK
(
   KD_TAHUN_AJARAN      char(2) not null,
   KD_SUMBER_LISTRIK    char(1) not null,
   KD_DAYA_LISTRIK      char(1) not null,
   KD_VOLTASE           char(1) not null,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, KD_SUMBER_LISTRIK, KD_DAYA_LISTRIK, KD_VOLTASE)
);

/*==============================================================*/
/* Table: T_SEKOLAH_PERINGKAT_UAN                               */
/*==============================================================*/
create table T_SEKOLAH_PERINGKAT_UAN
(
   KD_TAHUN_AJARAN      char(2) not null,
   KD_TINGKAT_PRESTASI  char(1) not null,
   PERINGKAT_SEJENIS    smallint unsigned not null,
   PERINGKAT_GABUNGAN   smallint unsigned not null,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, KD_TINGKAT_PRESTASI)
);

/*==============================================================*/
/* Table: T_SEKOLAH_PERLENGKAPAN                                */
/*==============================================================*/
create table T_SEKOLAH_PERLENGKAPAN
(
   KD_TAHUN_AJARAN      char(2) not null,
   KD_PERLENGKAPAN_SEKOLAH char(2) not null,
   JUMLAH               smallint unsigned not null,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, KD_PERLENGKAPAN_SEKOLAH)
);

/*==============================================================*/
/* Table: T_SEKOLAH_PERLENGKAPAN_KBM                            */
/*==============================================================*/
create table T_SEKOLAH_PERLENGKAPAN_KBM
(
   KD_TAHUN_AJARAN      char(2) not null,
   KD_PERLENGKAPAN_SEKOLAH char(2) not null,
   JUMLAH               smallint unsigned not null,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, KD_PERLENGKAPAN_SEKOLAH)
);

/*==============================================================*/
/* Table: T_SEKOLAH_PKH_ALAT                                    */
/*==============================================================*/
create table T_SEKOLAH_PKH_ALAT
(
   KD_TAHUN_AJARAN      char(2) not null,
   NO_URUT              tinyint unsigned not null,
   NM_ALAT              varchar(50) not null,
   JUMLAH_BAIK          smallint unsigned not null default 0,
   JUMLAH_RINGAN        smallint unsigned not null default 0,
   JUMLAH_SEDANG        smallint unsigned not null default 0,
   JUMLAH_BERAT         smallint unsigned not null default 0,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, NO_URUT)
);

/*==============================================================*/
/* Table: T_SEKOLAH_PKH_GURU                                    */
/*==============================================================*/
create table T_SEKOLAH_PKH_GURU
(
   KD_TAHUN_AJARAN      char(2) not null,
   ID_PEGAWAI           smallint unsigned not null,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, ID_PEGAWAI)
);

/*==============================================================*/
/* Table: T_SEKOLAH_PKH_KEGIATAN                                */
/*==============================================================*/
create table T_SEKOLAH_PKH_KEGIATAN
(
   KD_TAHUN_AJARAN      char(2) not null,
   NO_URUT              tinyint unsigned not null,
   ID_JENIS_PKH         tinyint unsigned not null,
   TAHUN_AWAL           smallint unsigned not null default 1995,
   JUMLAH               smallint unsigned not null default 0,
   KD_HASIL_EVALUASI    char(1) not null,
   KETERANGAN           varchar(255),
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, NO_URUT)
);

/*==============================================================*/
/* Table: T_SEKOLAH_PKH_MITRA                                   */
/*==============================================================*/
create table T_SEKOLAH_PKH_MITRA
(
   KD_TAHUN_AJARAN      char(2) not null,
   NO_URUT              tinyint unsigned not null,
   NM_MITRA             varchar(50) not null,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, NO_URUT)
);

/*==============================================================*/
/* Table: T_SEKOLAH_PKH_NARASUMBER                              */
/*==============================================================*/
create table T_SEKOLAH_PKH_NARASUMBER
(
   KD_TAHUN_AJARAN      char(2) not null,
   NO_URUT              tinyint unsigned not null,
   NM_NARASUMBER        varchar(50) not null,
   TANGGAL_LAHIR        date not null,
   KD_TINGKAT_IJAZAH    char(2) not null,
   KD_PROGRAM_STUDI     char(4) not null,
   ID_GOL_PEKERJAAN_ORTU tinyint unsigned not null,
   BIDANG_KEAHLIAN      varchar(50) not null,
   SEDIA_WAKTU          tinyint unsigned not null,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, NO_URUT)
);

/*==============================================================*/
/* Table: T_SEKOLAH_PRESTASI                                    */
/*==============================================================*/
create table T_SEKOLAH_PRESTASI
(
   KD_TAHUN_AJARAN      char(2) not null,
   ID_JENIS_LOMBA       smallint unsigned not null,
   KD_TINGKAT_PRESTASI  char(1) not null,
   TANGGAL_PRESTASI     date not null,
   JUARA_KE             tinyint unsigned not null,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, ID_JENIS_LOMBA, KD_TINGKAT_PRESTASI, TANGGAL_PRESTASI)
);

/*==============================================================*/
/* Table: T_SEKOLAH_PROPERTI                                    */
/*==============================================================*/
create table T_SEKOLAH_PROPERTI
(
   KD_TAHUN_AJARAN      char(2) not null,
   KD_PENGGUNAAN_TANAH  char(1) not null,
   KD_KEPEMILIKAN       char(1) not null,
   KD_SERTIFIKAT        char(1) not null,
   LUAS                 decimal(9,2) default NULL,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, KD_PENGGUNAAN_TANAH, KD_KEPEMILIKAN, KD_SERTIFIKAT)
);

/*==============================================================*/
/* Table: T_SEKOLAH_REKENING                                    */
/*==============================================================*/
create table T_SEKOLAH_REKENING
(
   KD_TAHUN_AJARAN      char(2) not null,
   NO_URUT              tinyint unsigned not null,
   NM_REK               varchar(50) not null,
   NO_REK_SEKOLAH       varchar(20) not null,
   NM_BANK              varchar(50) not null,
   CABANG_BANK          varchar(50) not null,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, NO_URUT)
);

/*==============================================================*/
/* Table: T_SEKOLAH_RUANG                                       */
/*==============================================================*/
create table T_SEKOLAH_RUANG
(
   ID_RUANG_KELAS       bigint unsigned not null auto_increment,
   KD_TAHUN_AJARAN      char(2) not null,
   NM_RUANG_KELAS       varchar(50) not null,
   KD_RUANG             char(2) not null,
   KD_KEPEMILIKAN       char(1) not null,
   KD_KONDISI_RUANGAN   char(1) not null,
   KAPASITAS            smallint unsigned not null default 0,
   PANJANG              decimal(5,2) default 0.00,
   LEBAR                decimal(5,2) default 0.00,
   LUAS                 decimal(9,2) default 0.00,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_RUANG_KELAS)
);

/*==============================================================*/
/* Index: T_SEKOLAH_RUANG_UK                                    */
/*==============================================================*/
create unique index T_SEKOLAH_RUANG_UK on T_SEKOLAH_RUANG
(
   KD_TAHUN_AJARAN,
   NM_RUANG_KELAS
);

/*==============================================================*/
/* Table: T_SEKOLAH_SALDO_AWAL                                  */
/*==============================================================*/
create table T_SEKOLAH_SALDO_AWAL
(
   KD_TAHUN_AJARAN      char(2) not null,
   SALDO_AWAL           decimal(18,2) not null default 0.00,
   STATUS               char(1) not null default '0',
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN)
);

/*==============================================================*/
/* Table: T_SEKOLAH_SK                                          */
/*==============================================================*/
create table T_SEKOLAH_SK
(
   KD_TAHUN_AJARAN      char(2) not null,
   NO_SK_PENDIRIAN      varchar(30) default NULL,
   TANGGAL_SK_PENDIRIAN date default NULL,
   KD_KETERANGAN_SK     char(1) default NULL comment '1 = pemutihan; 2 = penegerian; 3 = alih fungsi; 4 = sekolah baru',
   NO_SK_AKHIR_STATUS   varchar(30) default NULL,
   TANGGAL_SK_AKHIR_STATUS date default NULL,
   NO_SK_AKREDITASI     varchar(30) default NULL,
   TANGGAL_SK_AKREDITASI date default NULL,
   NO_SK_AKREDITASI_AKHIR varchar(30) default NULL,
   TANGGAL_SK_AKREDITASI_AKHIR date default NULL,
   KD_AKREDITASI        char(1) not null,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN)
);

/*==============================================================*/
/* Table: T_SEKOLAH_SK_SWASTA                                   */
/*==============================================================*/
create table T_SEKOLAH_SK_SWASTA
(
   KD_TAHUN_AJARAN      char(2) not null,
   KD_AKREDITASI        char(1) not null,
   NO_DATA_SEKOLAH      char(10) default NULL,
   KD_KEL_YAYASAN       char(2) not null,
   NM_YAYASAN           varchar(50) not null,
   NO_AKTE_YAYASAN      varchar(30) not null,
   TANGGAL_AKTE_YAYASAN date not null,
   JALAN_YAYASAN        varchar(150) not null,
   ID_PROPINSI          tinyint unsigned not null,
   ID_KABUPATEN         smallint unsigned not null,
   ID_KECAMATAN         smallint unsigned not null,
   KD_DESA_YAYASAN      varchar(50) not null,
   NO_TELP              varchar(30) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN)
);

/*==============================================================*/
/* Table: T_SEKOLAH_SOFTWARE                                    */
/*==============================================================*/
create table T_SEKOLAH_SOFTWARE
(
   KD_TAHUN_AJARAN      char(2) not null,
   NM_SOFTWARE          varchar(50) not null,
   JUMLAH_LISENSI       tinyint unsigned not null default 0,
   JUMLAH_BAJAK         tinyint unsigned not null default 0,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (KD_TAHUN_AJARAN, NM_SOFTWARE)
);

/*==============================================================*/
/* Table: T_SISWA                                               */
/*==============================================================*/
create table T_SISWA
(
   ID_SISWA             bigint unsigned not null auto_increment,
   NIS                  varchar(25) not null,
   NM_SISWA             varchar(50) not null,
   NM_PANGGILAN         varchar(20) not null,
   KD_JENIS_KELAMIN     char(1) not null comment '1 = laki-laki; 2 = perempuan',
   KOTA_LAHIR           varchar(50) not null,
   TANGGAL_LAHIR        date not null,
   ALAMAT               varchar(150) not null,
   RT                   varchar(3) default NULL,
   RW                   varchar(2) default NULL,
   KD_POS               char(5) default NULL,
   KD_GOL_DARAH         char(1) default '4',
   KD_AGAMA             char(1) not null,
   NO_TELP              varchar(30) default NULL,
   NO_HP                varchar(30) default NULL,
   STATUS_SISWA         char(1) not null default '0' comment '0 = aktif; 1 = putus sekolah (do); 2 = masuk dari kab/kota ini; 3 = masuk dari kab/kota lain; 4 = keluar/pindah; 5 = cuti; 6 = lulus',
   KD_TINGKAT_KELAS     char(2) not null default '01',
   DITERIMA_TANGGAL     date not null,
   PINDAH_ALASAN        varchar(255) default NULL,
   ASAL_SD              smallint unsigned,
   ASAL_SMP             smallint unsigned,
   NILAI                decimal(5,2) default NULL,
   STATUS_ENTRI         char(1) not null default '1',
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA)
);

/*==============================================================*/
/* Index: T_SISWA_UK                                            */
/*==============================================================*/
create unique index T_SISWA_UK on T_SISWA
(
   NIS
);

/*==============================================================*/
/* Table: T_SISWA_ALUMNI                                        */
/*==============================================================*/
create table T_SISWA_ALUMNI
(
   ID_SISWA             bigint unsigned not null,
   NIS                  varchar(25) default NULL,
   TAHUN_LULUS          smallint unsigned not null,
   NO_STL_LULUS         varchar(30) default NULL,
   LANJUT_DI            varchar(50) default NULL,
   NM_INSTANSI_PENDDKN  varchar(50) default NULL,
   TANGGAL_BEKERJA      date default NULL,
   NM_PERUSAHAAN        varchar(50) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA)
);

/*==============================================================*/
/* Table: T_SISWA_BEASISWA                                      */
/*==============================================================*/
create table T_SISWA_BEASISWA
(
   ID_SISWA             bigint unsigned not null,
   NIS                  varchar(25) default NULL,
   KD_TAHUN_AJARAN      char(2) not null,
   KD_BEASISWA          char(2) not null,
   TAHUN_MASUK          smallint unsigned not null,
   JUMLAH_BEASISWA_PER_BULAN decimal(18,2) not null default 0.00,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA, KD_TAHUN_AJARAN, KD_BEASISWA, TAHUN_MASUK)
);

/*==============================================================*/
/* Table: T_SISWA_CUTI                                          */
/*==============================================================*/
create table T_SISWA_CUTI
(
   ID_SISWA             bigint unsigned not null,
   NIS                  varchar(25) default NULL,
   TANGGAL              date not null,
   TANGGAL_MASUK        date default NULL,
   KETERANGAN           varchar(255) default NULL,
   STATUS_ASAL          char(1) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA, TANGGAL)
);

/*==============================================================*/
/* Table: T_SISWA_HOBI                                          */
/*==============================================================*/
create table T_SISWA_HOBI
(
   ID_SISWA             bigint unsigned not null,
   NIS                  varchar(25) default NULL,
   ID_HOBI              smallint unsigned not null,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA, ID_HOBI)
);

/*==============================================================*/
/* Table: T_SISWA_INFO                                          */
/*==============================================================*/
create table T_SISWA_INFO
(
   ID_SISWA             bigint unsigned not null,
   NIS                  varchar(25) default NULL,
   HUBUNGI              char(1) not null default '1' comment '1 = ayah; 2 = ibu; 3 = wali',
   TANGGUNG_BIAYA       tinyint unsigned not null default 1 comment '1 = ayah; 2 = ibu; 3 = wali; 4 = sendiri',
   STATUS_YATIM_PIATU   char(1) default '0' comment '0 = orangtua lengkap; 1 = yatim; 2 = piatu; 3 = yatim piatu',
   KD_KESEJAHTERAAN_KELUARGA char(1) default '1',
   ANAK_KE              tinyint unsigned default 1,
   JUMLAH_KANDUNG       tinyint unsigned default 0,
   JUMLAH_TIRI          tinyint unsigned default 0,
   JUMLAH_ANGKAT        tinyint unsigned default 0,
   KEWARGANEGARAAN      varchar(50) not null,
   BAHASA               varchar(50) default NULL,
   TINGGAL_DI           varchar(50) default NULL,
   JARAK_SEK            decimal(5,2) default NULL,
   KD_KETUNAAN          char(2) not null,
   KELAINAN_JASMANI     varchar(50) default NULL,
   BERAT_BADAN          decimal(5,2) default NULL,
   TINGGI_BADAN         decimal(5,2) default NULL,
   NO_STL_SD            varchar(30) default NULL,
   TANGGAL_STL_SD       date default NULL,
   LAMA_BELAJAR_SD      tinyint unsigned default NULL,
   USERNAME             varchar(20),
   TANGGAL_AKSES        timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA)
);

/*==============================================================*/
/* Table: T_SISWA_ORTU                                          */
/*==============================================================*/
create table T_SISWA_ORTU
(
   ID_SISWA             bigint unsigned not null,
   NIS                  varchar(25) default NULL,
   KD_JENIS_ORTU        char(1) not null,
   KD_JENIS_KELAMIN     char(1) not null comment '1 = laki-laki; 2 = perempuan',
   STATUS_HUB           char(1) default NULL comment '1 = kandung; 2 = tiri; 3 = angkat; 9 = lain-lain',
   NM_ORTU              varchar(50) not null,
   ALAMAT               varchar(150) not null,
   RT                   varchar(3) default NULL,
   RW                   varchar(2) default NULL,
   KD_POS               char(5) default NULL,
   ID_PROPINSI          tinyint unsigned,
   ID_KABUPATEN         smallint unsigned,
   NO_TELP              varchar(30) default NULL,
   NO_HP                varchar(30) default NULL,
   KOTA_LAHIR           varchar(50) default NULL,
   TANGGAL_LAHIR        date default NULL,
   KD_AGAMA             char(1) not null,
   KD_STATUS_NIKAH      char(1) default NULL comment 'N = nikah; B = belum nikah; J = janda; D = duda',
   KEWARGANEGARAAN      varchar(50) default NULL,
   KD_TINGKAT_IJAZAH    char(2) not null,
   ID_GOL_PEKERJAAN_ORTU tinyint unsigned not null,
   GAJI                 decimal(18,2) not null default 0.00,
   STATUS_HIDUP         char(1) not null default '1' comment '1 = masih hidup
            2 = sudah meninggal',
   TAHUN_MENINGGAL      smallint unsigned default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA, KD_JENIS_ORTU)
);

/*==============================================================*/
/* Table: T_SISWA_PINDAH                                        */
/*==============================================================*/
create table T_SISWA_PINDAH
(
   ID_SISWA             bigint unsigned not null,
   NIS                  varchar(25) default NULL,
   ASAL_SMP             smallint unsigned not null,
   PINDAH_ALASAN        varchar(255) not null,
   STATUS_ASAL          char(1) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA)
);

/*==============================================================*/
/* Table: T_SISWA_PRESTASI                                      */
/*==============================================================*/
create table T_SISWA_PRESTASI
(
   ID_SISWA             bigint unsigned not null,
   NIS                  varchar(25) default NULL,
   KD_TAHUN_AJARAN      char(2) not null,
   KD_TINGKAT_KELAS     char(2) not null,
   KD_ROMBEL            varchar(15) not null,
   ID_JENIS_LOMBA       smallint unsigned not null,
   KD_TINGKAT_PRESTASI  char(1) not null,
   TANGGAL_PRESTASI     date not null,
   JUARA_KE             tinyint unsigned not null,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL, ID_JENIS_LOMBA, KD_TINGKAT_PRESTASI, TANGGAL_PRESTASI)
);

/*==============================================================*/
/* Table: T_SISWA_PUTUS                                         */
/*==============================================================*/
create table T_SISWA_PUTUS
(
   ID_SISWA             bigint unsigned not null,
   NIS                  varchar(25) default NULL,
   TANGGAL_KELUAR       date not null,
   ALASAN_KELUAR        varchar(255) not null,
   STATUS_ASAL          char(1) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA)
);

/*==============================================================*/
/* Table: T_SISWA_RWYT_SAKIT                                    */
/*==============================================================*/
create table T_SISWA_RWYT_SAKIT
(
   ID_SISWA             bigint unsigned not null,
   NIS                  varchar(25) default NULL,
   NO_URUT              tinyint unsigned not null,
   ID_PENYAKIT          smallint unsigned not null,
   LAMA_SAKIT           tinyint unsigned not null,
   KETERANGAN           varchar(255) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA, NO_URUT)
);

/*==============================================================*/
/* Table: T_SISWA_TINGKAT                                       */
/*==============================================================*/
create table T_SISWA_TINGKAT
(
   ID_SISWA             bigint unsigned not null,
   NIS                  varchar(25) default NULL,
   KD_TAHUN_AJARAN      char(2) not null,
   KD_TINGKAT_KELAS     char(2) not null,
   KD_ROMBEL            varchar(15) not null,
   KD_STATUS_SISWA      char(1) not null default '0',
   KD_USIA_SISWA        char(2) not null default '00',
   KD_AGAMA             char(1) not null default '0',
   KD_JENIS_KELAMIN     char(1) not null default '0',
   KD_EBTA              char(1) not null default '0',
   KD_ASAL_SISWA        char(2) default NULL,
   NO_UAN               varchar(20) default NULL,
   KD_LULUS             char(1) default '0',
   NO_IJAZAH            varchar(50) default NULL,
   KODE                 char(4) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL)
);

/*==============================================================*/
/* Table: T_SISWA_TINGKAT_THN                                   */
/*==============================================================*/
create table T_SISWA_TINGKAT_THN
(
   ID_SISWA             bigint unsigned not null,
   KD_TAHUN_AJARAN      char(2) default NULL,
   KD_TINGKAT_KELAS     char(2) default NULL,
   KD_ROMBEL            varchar(15) default NULL,
   KD_STATUS_SISWA      char(1) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA)
);

/*==============================================================*/
/* Table: T_SISWA_TINGKAT_THN_BARU                              */
/*==============================================================*/
create table T_SISWA_TINGKAT_THN_BARU
(
   ID_SISWA             bigint unsigned not null,
   KD_TAHUN_AJARAN      char(2) default NULL,
   KD_TINGKAT_KELAS     char(2) default NULL,
   KD_ROMBEL            varchar(15) default NULL,
   USERNAME             varchar(20) not null,
   TANGGAL_AKSES        timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   primary key (ID_SISWA)
);

/*==============================================================*/
/* Table: X_REF_SEKOLAH                                         */
/*==============================================================*/
create table X_REF_SEKOLAH
(
   NPSN                 varchar(8) not null,
   NM_SEKOLAH           varchar(50) not null,
   KD_BENTUK_SEKOLAH    char(1),
   KD_JENIS_SEKOLAH     char(2) not null,
   ALAMAT_SEKOLAH       varchar(255),
   NO_TELP              varchar(20),
   KD_DAERAH            char(1),
   ID_PRO               tinyint unsigned not null,
   ID_KAB               smallint unsigned not null,
   ID_KEC               smallint unsigned not null,
   KD_DESA              char(1),
   TAHUN_DIBUKA         smallint unsigned,
   KD_STATUS_SEKOLAH    char(1),
   KD_WAKTU_PENYELENGGARAAN char(1) not null,
   JENJANG_SEKOLAH      tinyint unsigned not null,
   primary key (NPSN)
);

/*==============================================================*/
/* Table: __AUTH                                                */
/*==============================================================*/
create table __AUTH
(
   USERNAME             varchar(20) not null,
   ID_GRUP              int not null,
   PASSWORD             varchar(255) not null,
   STATUS_USER          tinyint unsigned not null default 1 comment '0 = tidak aktif; 1 = aktif',
   primary key (USERNAME)
);

/*==============================================================*/
/* Table: __GRUP_USER                                           */
/*==============================================================*/
create table __GRUP_USER
(
   ID_GRUP              int not null auto_increment,
   NAMA_GRUP            varchar(100) not null,
   KETERANGAN_GRUP      varchar(256),
   primary key (ID_GRUP)
);

/*==============================================================*/
/* Table: __HAK_AKSES                                           */
/*==============================================================*/
create table __HAK_AKSES
(
   HA_ID                bigint not null auto_increment,
   ID_GRUP              int not null,
   MENU_ID              varchar(20) not null,
   HA_LEVEL             smallint not null default 0 comment '0 = tidak ada akses; 1 = view; 2 = insert; 3 = update; 4 = delete',
   primary key (HA_ID)
);

/*==============================================================*/
/* Table: __MENU                                                */
/*==============================================================*/
create table __MENU
(
   MENU_ID              varchar(20) not null,
   MENU_NAME            varchar(100) not null,
   MENU_FOLDER          varchar(100),
   MENU_LEAF            char(1) default '1' comment '0 = not leaf; 1 = leaf',
   MENU_LEVEL           smallint default 0,
   MENU_KD              varchar(25),
   MENU_PARENT          varchar(100),
   ICON                 varchar(20),
   MENU_STATUS          char(1) default '1' comment '0 = tidak aktif; 1 = aktif',
   primary key (MENU_ID)
);

/*==============================================================*/
/* Table: __VER                                                 */
/*==============================================================*/
create table __VER
(
   TANGGAL              timestamp not null,
   DB_VER               decimal(5,3) not null,
   APP_VER              decimal(5,3) not null,
   JENJANG_SEKOLAH      tinyint not null,
   KD_MULOK             char(2) not null,
   primary key (TANGGAL)
);

alter table K_SEKOLAH_KEUANGAN add constraint FK_T_SEKOLAH_IDENTITAS_K_SEKOLAH_KEUANGAN foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table K_SEKOLAH_KEUANGAN add constraint FK___AUTH_K_SEKOLAH_KEUANGAN foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table K_SEKOLAH_LISM add constraint FK_T_SEKOLAH_IDENTITAS_K_SEKOLAH_LISM foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table K_SEKOLAH_LISM add constraint FK___AUTH_K_SEKOLAH_LISM foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table K_SEKOLAH_PASSING_GRADE add constraint FK_T_SEKOLAH_IDENTITAS_K_SEKOLAH_PASSING_GRADE foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table K_SEKOLAH_PASSING_GRADE add constraint FK___AUTH_K_SEKOLAH_PASSING_GRADE foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table R_ASAL_SEKOLAH add constraint FK_R_JENIS_SEKOLAH_R_ASAL_SEKOLAH foreign key (KD_JENIS_SEKOLAH)
      references R_JENIS_SEKOLAH (KD_JENIS_SEKOLAH) on delete restrict on update restrict;

alter table R_ASAL_SEKOLAH add constraint FK_R_KABUPATEN_R_ASAL_SEKOLAH foreign key (ID_KABUPATEN)
      references R_KABUPATEN (ID_KABUPATEN) on delete restrict on update restrict;

alter table R_ASAL_SEKOLAH add constraint FK_R_KECAMATAN_R_ASAL_SEKOLAH foreign key (ID_KECAMATAN)
      references R_KECAMATAN (ID_KECAMATAN) on delete restrict on update restrict;

alter table R_ASAL_SEKOLAH add constraint FK_R_PROPINSI_R_ASAL_SEKOLAH foreign key (ID_PROPINSI)
      references R_PROPINSI (ID_PROPINSI) on delete restrict on update restrict;

alter table R_ASAL_SEKOLAH add constraint FK___AUTH_R_ASAL_SEKOLAH foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table R_EKSTRAKURIKULER add constraint FK___AUTH_R_EKSTRAKURIKULER foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table R_GOL_PEKERJAAN_ORTU add constraint FK_R_PEKERJAAN_ORTU_R_GOL_PEKERJAAN_ORTU foreign key (KD_PEKERJAAN_ORTU)
      references R_PEKERJAAN_ORTU (KD_PEKERJAAN_ORTU) on delete restrict on update restrict;

alter table R_GOL_PEKERJAAN_ORTU add constraint FK___AUTH_R_GOL_PEKERJAAN_ORTU foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table R_HOBI add constraint FK_R_KEL_HOBI_R_HOBI foreign key (KD_KEL_HOBI)
      references R_KEL_HOBI (KD_KEL_HOBI) on delete restrict on update restrict;

alter table R_HOBI add constraint FK___AUTH_R_HOBI foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table R_JENIS_LOMBA add constraint FK___AUTH_R_JENIS_LOMBA foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table R_JENIS_PKH add constraint FK___AUTH_R_JENIS_PKH foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table R_MATA_PELAJARAN_DIAJARKAN add constraint FK_R_KEL_MATA_PELAJARAN_R_MATA_PELAJARAN_DIAJARKAN foreign key (KD_KEL_MATA_PELAJARAN)
      references R_KEL_MATA_PELAJARAN (KD_KEL_MATA_PELAJARAN) on delete restrict on update restrict;

alter table R_MATA_PELAJARAN_DIAJARKAN add constraint FK___AUTH_R_MATA_PELAJARAN_DIAJARKAN foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table R_NILAI_AFEKTIF add constraint FK___AUTH_R_NILAI_AFEKTIF foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table R_PENATARAN add constraint FK_R_JENIS_KETENAGAAN_R_PENATARAN foreign key (KD_JENIS_KETENAGAAN)
      references R_JENIS_KETENAGAAN (KD_JENIS_KETENAGAAN) on delete restrict on update restrict;

alter table R_PENATARAN add constraint FK___AUTH_R_PENATARAN foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table R_PENYAKIT add constraint FK___AUTH_R_PENYAKIT foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table R_PROGRAM_STUDI add constraint FK_R_KEL_PROGRAM_STUDI_R_PROGRAM_STUDI foreign key (KD_KEL_PROGRAM_STUDI)
      references R_KEL_PROGRAM_STUDI (KD_KEL_PROGRAM_STUDI) on delete restrict on update restrict;

alter table R_SANKSI add constraint FK___AUTH_R_SANKSI foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table R_SEKOLAH_SETINGKAT add constraint FK_R_JENIS_SEKOLAH_R_SEKOLAH_SETINGKAT foreign key (KD_JENIS_SEKOLAH)
      references R_JENIS_SEKOLAH (KD_JENIS_SEKOLAH) on delete restrict on update restrict;

alter table R_SEKOLAH_SETINGKAT add constraint FK_R_KABUPATEN_R_SEKOLAH_SETINGKAT foreign key (ID_KABUPATEN)
      references R_KABUPATEN (ID_KABUPATEN) on delete restrict on update restrict;

alter table R_SEKOLAH_SETINGKAT add constraint FK_R_KECAMATAN_R_SEKOLAH_SETINGKAT foreign key (ID_KECAMATAN)
      references R_KECAMATAN (ID_KECAMATAN) on delete restrict on update restrict;

alter table R_SEKOLAH_SETINGKAT add constraint FK_R_PROPINSI_R_SEKOLAH_SETINGKAT foreign key (ID_PROPINSI)
      references R_PROPINSI (ID_PROPINSI) on delete restrict on update restrict;

alter table R_SEKOLAH_SETINGKAT add constraint FK___AUTH_R_SEKOLAH_SETINGKAT foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_KABUPATEN_KECAMATAN add constraint FK_R_KABUPATEN_T_KABUPATEN_KECAMATAN foreign key (ID_KABUPATEN)
      references R_KABUPATEN (ID_KABUPATEN) on delete restrict on update restrict;

alter table T_KABUPATEN_KECAMATAN add constraint FK_R_KECAMATAN_T_KABUPATEN_KECAMATAN foreign key (ID_KECAMATAN)
      references R_KECAMATAN (ID_KECAMATAN) on delete restrict on update restrict;

alter table T_KUR_KKM_MATPEL add constraint FK_T_KUR_KURIKULUM_T_KUR_KKM_MATPEL foreign key (KD_KURIKULUM, KD_TINGKAT_KELAS, KD_PERIODE_BELAJAR, KD_MATA_PELAJARAN_DIAJARKAN)
      references T_KUR_KURIKULUM (KD_KURIKULUM, KD_TINGKAT_KELAS, KD_PERIODE_BELAJAR, KD_MATA_PELAJARAN_DIAJARKAN) on delete restrict on update restrict;

alter table T_KUR_KKM_MATPEL add constraint FK_T_PEGAWAI_ROMBEL_T_KUR_KKM_MATPEL foreign key (KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL)
      references T_PEGAWAI_ROMBEL (KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL) on delete restrict on update restrict;

alter table T_KUR_KKM_MATPEL add constraint FK___AUTH_T_KUR_KKM_MATPEL foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_KUR_KURIKULUM add constraint FK_R_KURIKULUM_T_KUR_KURIKULUM foreign key (KD_KURIKULUM)
      references R_KURIKULUM (KD_KURIKULUM) on delete restrict on update restrict;

alter table T_KUR_KURIKULUM add constraint FK_R_MATA_PELAJARAN_DIAJARKAN_T_KUR_KURIKULUM foreign key (KD_MATA_PELAJARAN_DIAJARKAN)
      references R_MATA_PELAJARAN_DIAJARKAN (KD_MATA_PELAJARAN_DIAJARKAN) on delete restrict on update restrict;

alter table T_KUR_KURIKULUM add constraint FK_R_PERIODE_BELAJAR_T_KUR_KURIKULUM foreign key (KD_PERIODE_BELAJAR)
      references R_PERIODE_BELAJAR (KD_PERIODE_BELAJAR) on delete restrict on update restrict;

alter table T_KUR_KURIKULUM add constraint FK_R_TINGKAT_KELAS_T_KUR_KURIKULUM foreign key (KD_TINGKAT_KELAS)
      references R_TINGKAT_KELAS (KD_TINGKAT_KELAS) on delete restrict on update restrict;

alter table T_KUR_KURIKULUM add constraint FK___AUTH_T_KUR_KURIKULUM foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_NILAI_NEM add constraint FK_T_KUR_KURIKULUM_T_NILAI_NEM foreign key (KD_KURIKULUM, KD_TINGKAT_KELAS, KD_PERIODE_BELAJAR, KD_MATA_PELAJARAN_DIAJARKAN)
      references T_KUR_KURIKULUM (KD_KURIKULUM, KD_TINGKAT_KELAS, KD_PERIODE_BELAJAR, KD_MATA_PELAJARAN_DIAJARKAN) on delete restrict on update restrict;

alter table T_NILAI_NEM add constraint FK_T_SISWA_TINGKAT_T_NILAI_NEM foreign key (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL)
      references T_SISWA_TINGKAT (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL) on delete restrict on update restrict;

alter table T_NILAI_NEM add constraint FK___AUTH_T_NILAI_NEM foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_NILAI_RAPOR add constraint FK_R_NILAI_AFEKTIF_T_NILAI_RAPOR_1 foreign key (ID_AHLAK)
      references R_NILAI_AFEKTIF (ID_NILAI_AFEKTIF) on delete restrict on update restrict;

alter table T_NILAI_RAPOR add constraint FK_R_NILAI_AFEKTIF_T_NILAI_RAPOR_2 foreign key (ID_PRIBADI)
      references R_NILAI_AFEKTIF (ID_NILAI_AFEKTIF) on delete restrict on update restrict;

alter table T_NILAI_RAPOR add constraint FK_R_PERIODE_BELAJAR_T_NILAI_RAPOR foreign key (KD_PERIODE_BELAJAR)
      references R_PERIODE_BELAJAR (KD_PERIODE_BELAJAR) on delete restrict on update restrict;

alter table T_NILAI_RAPOR add constraint FK_T_SISWA_TINGKAT_T_NILAI_RAPOR foreign key (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL)
      references T_SISWA_TINGKAT (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL) on delete restrict on update restrict;

alter table T_NILAI_RAPOR add constraint FK___AUTH_T_NILAI_RAPOR foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_NILAI_RAPOR_EKSTRA add constraint FK_R_EKSTRAKURIKULER_T_NILAI_RAPOR_EKSTRA foreign key (ID_EKSTRAKURIKULER)
      references R_EKSTRAKURIKULER (ID_EKSTRAKURIKULER) on delete restrict on update restrict;

alter table T_NILAI_RAPOR_EKSTRA add constraint FK_R_NILAI_AFEKTIF_T_NILAI_RAPOR_EKSTRA foreign key (ID_NILAI_AFEKTIF)
      references R_NILAI_AFEKTIF (ID_NILAI_AFEKTIF) on delete restrict on update restrict;

alter table T_NILAI_RAPOR_EKSTRA add constraint FK_T_NILAI_RAPOR_T_NILAI_RAPOR_EKSTRA foreign key (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL, KD_PERIODE_BELAJAR)
      references T_NILAI_RAPOR (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL, KD_PERIODE_BELAJAR) on delete restrict on update restrict;

alter table T_NILAI_RAPOR_EKSTRA add constraint FK___AUTH_T_NILAI_RAPOR_EKSTRA foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_NILAI_RAPOR_KEPRIBADIAN add constraint FK_R_KEPRIBADIAN_T_NILAI_RAPOR_KEPRIBADIAN foreign key (KD_KEPRIBADIAN)
      references R_KEPRIBADIAN (KD_KEPRIBADIAN) on delete restrict on update restrict;

alter table T_NILAI_RAPOR_KEPRIBADIAN add constraint FK_R_NILAI_AFEKTIF_T_NILAI_RAPOR_KEPRIBADIAN foreign key (ID_NILAI_AFEKTIF)
      references R_NILAI_AFEKTIF (ID_NILAI_AFEKTIF) on delete restrict on update restrict;

alter table T_NILAI_RAPOR_KEPRIBADIAN add constraint FK_T_NILAI_RAPOR_T_NILAI_RAPOR_KEPRIBADIAN foreign key (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL, KD_PERIODE_BELAJAR)
      references T_NILAI_RAPOR (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL, KD_PERIODE_BELAJAR) on delete restrict on update restrict;

alter table T_NILAI_RAPOR_KEPRIBADIAN add constraint FK___AUTH_T_NILAI_RAPOR_KEPRIBADIAN foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_NILAI_RAPOR_NILAI add constraint FK_T_KUR_KURIKULUM_T_NILAI_RAPOR_NILAI foreign key (KD_KURIKULUM, KD_TINGKAT_KELAS, KD_PERIODE_BELAJAR, KD_MATA_PELAJARAN_DIAJARKAN)
      references T_KUR_KURIKULUM (KD_KURIKULUM, KD_TINGKAT_KELAS, KD_PERIODE_BELAJAR, KD_MATA_PELAJARAN_DIAJARKAN) on delete restrict on update restrict;

alter table T_NILAI_RAPOR_NILAI add constraint FK_T_NILAI_RAPOR_T_NILAI_RAPOR_NILAI foreign key (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL, KD_PERIODE_BELAJAR)
      references T_NILAI_RAPOR (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL, KD_PERIODE_BELAJAR) on delete restrict on update restrict;

alter table T_NILAI_RAPOR_NILAI add constraint FK___AUTH_T_NILAI_RAPOR_NILAI foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_NILAI_STTB add constraint FK_T_KUR_KURIKULUM_T_NILAI_STTB foreign key (KD_KURIKULUM, KD_TINGKAT_KELAS, KD_PERIODE_BELAJAR, KD_MATA_PELAJARAN_DIAJARKAN)
      references T_KUR_KURIKULUM (KD_KURIKULUM, KD_TINGKAT_KELAS, KD_PERIODE_BELAJAR, KD_MATA_PELAJARAN_DIAJARKAN) on delete restrict on update restrict;

alter table T_NILAI_STTB add constraint FK_T_SISWA_TINGKAT_T_NILAI_STTB foreign key (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL)
      references T_SISWA_TINGKAT (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL) on delete restrict on update restrict;

alter table T_NILAI_STTB add constraint FK___AUTH_T_NILAI_STTB foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_PEGAWAI add constraint FK_R_AGAMA_T_PEGAWAI foreign key (KD_AGAMA)
      references R_AGAMA (KD_AGAMA) on delete restrict on update restrict;

alter table T_PEGAWAI add constraint FK_R_GOL_DARAH_T_PEGAWAI foreign key (KD_GOL_DARAH)
      references R_GOL_DARAH (KD_GOL_DARAH) on delete restrict on update restrict;

alter table T_PEGAWAI add constraint FK_R_JENIS_KETENAGAAN_T_PEGAWAI foreign key (KD_JENIS_KETENAGAAN)
      references R_JENIS_KETENAGAAN (KD_JENIS_KETENAGAAN) on delete restrict on update restrict;

alter table T_PEGAWAI add constraint FK___AUTH_T_PEGAWAI foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_PEGAWAI_AKTIF add constraint FK_R_JENIS_KETENAGAAN_T_PEGAWAI_AKTIF foreign key (KD_JENIS_KETENAGAAN)
      references R_JENIS_KETENAGAAN (KD_JENIS_KETENAGAAN) on delete restrict on update restrict;

alter table T_PEGAWAI_AKTIF add constraint FK_R_TAHUN_AJARAN_T_PEGAWAI_AKTIF foreign key (KD_TAHUN_AJARAN)
      references R_TAHUN_AJARAN (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_PEGAWAI_AKTIF add constraint FK_T_PEGAWAI_T_PEGAWAI_AKTIF foreign key (ID_PEGAWAI)
      references T_PEGAWAI (ID_PEGAWAI) on delete restrict on update restrict;

alter table T_PEGAWAI_AKTIF add constraint FK___AUTH_T_PEGAWAI_AKTIF foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_PEGAWAI_DIDIK_FORMAL add constraint FK_R_AKREDITASI_T_PEGAWAI_DIDIK_FORMAL foreign key (KD_AKREDITASI)
      references R_AKREDITASI (KD_AKREDITASI) on delete restrict on update restrict;

alter table T_PEGAWAI_DIDIK_FORMAL add constraint FK_R_PROGRAM_STUDI_T_PEGAWAI_DIDIK_FORMAL foreign key (KD_PROGRAM_STUDI)
      references R_PROGRAM_STUDI (KD_PROGRAM_STUDI) on delete restrict on update restrict;

alter table T_PEGAWAI_DIDIK_FORMAL add constraint FK_R_TINGKAT_IJAZAH_T_PEGAWAI_DIDIK_FORMAL foreign key (KD_TINGKAT_IJAZAH)
      references R_TINGKAT_IJAZAH (KD_TINGKAT_IJAZAH) on delete restrict on update restrict;

alter table T_PEGAWAI_DIDIK_FORMAL add constraint FK_T_PEGAWAI_T_PEGAWAI_DIDIK_FORMAL foreign key (ID_PEGAWAI)
      references T_PEGAWAI (ID_PEGAWAI) on delete restrict on update restrict;

alter table T_PEGAWAI_DIDIK_FORMAL add constraint FK___AUTH_T_PEGAWAI_DIDIK_FORMAL foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_PEGAWAI_GURU_KEBUTUHAN add constraint FK_R_KEL_MATA_PELAJARAN_T_PEGAWAI_GURU_KEBUTUHAN foreign key (KD_KEL_MATA_PELAJARAN)
      references R_KEL_MATA_PELAJARAN (KD_KEL_MATA_PELAJARAN) on delete restrict on update restrict;

alter table T_PEGAWAI_GURU_KEBUTUHAN add constraint FK_R_TAHUN_AJARAN_T_PEGAWAI_GURU_KEBUTUHAN foreign key (KD_TAHUN_AJARAN)
      references R_TAHUN_AJARAN (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_PEGAWAI_GURU_KEBUTUHAN add constraint FK___AUTH_T_PEGAWAI_GURU_KEBUTUHAN foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_PEGAWAI_KELUARGA add constraint FK_R_AGAMA_T_PEGAWAI_KELUARGA foreign key (KD_AGAMA)
      references R_AGAMA (KD_AGAMA) on delete restrict on update restrict;

alter table T_PEGAWAI_KELUARGA add constraint FK_R_GOL_DARAH_T_PEGAWAI_KELUARGA foreign key (KD_GOL_DARAH)
      references R_GOL_DARAH (KD_GOL_DARAH) on delete restrict on update restrict;

alter table T_PEGAWAI_KELUARGA add constraint FK_T_PEGAWAI_T_PEGAWAI_KELUARGA foreign key (ID_PEGAWAI)
      references T_PEGAWAI (ID_PEGAWAI) on delete restrict on update restrict;

alter table T_PEGAWAI_KELUARGA add constraint FK___AUTH_T_PEGAWAI_KELUARGA foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_PEGAWAI_MENGAJAR add constraint FK_R_MATA_PELAJARAN_DIAJARKAN_T_PEGAWAI_MENGAJAR foreign key (KD_MATA_PELAJARAN_DIAJARKAN)
      references R_MATA_PELAJARAN_DIAJARKAN (KD_MATA_PELAJARAN_DIAJARKAN) on delete restrict on update restrict;

alter table T_PEGAWAI_MENGAJAR add constraint FK_T_PEGAWAI_AKTIF_T_PEGAWAI_MENGAJAR foreign key (KD_TAHUN_AJARAN, ID_PEGAWAI)
      references T_PEGAWAI_AKTIF (KD_TAHUN_AJARAN, ID_PEGAWAI) on delete restrict on update restrict;

alter table T_PEGAWAI_MENGAJAR add constraint FK___AUTH_T_PEGAWAI_MENGAJAR foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_PEGAWAI_PENATARAN add constraint FK_R_JENIS_PENATARAN_T_PEGAWAI_PENATARAN foreign key (KD_JENIS_PENATARAN)
      references R_JENIS_PENATARAN (KD_JENIS_PENATARAN) on delete restrict on update restrict;

alter table T_PEGAWAI_PENATARAN add constraint FK_R_JENIS_PESERTA_PENATARAN_T_PEGAWAI_PENATARAN foreign key (KD_JENIS_PESERTA_PENATARAN)
      references R_JENIS_PESERTA_PENATARAN (KD_JENIS_PESERTA_PENATARAN) on delete restrict on update restrict;

alter table T_PEGAWAI_PENATARAN add constraint FK_R_MATA_PELAJARAN_DIAJARKAN_T_PEGAWAI_PENATARAN foreign key (KD_MATA_PELAJARAN_DIAJARKAN)
      references R_MATA_PELAJARAN_DIAJARKAN (KD_MATA_PELAJARAN_DIAJARKAN) on delete restrict on update restrict;

alter table T_PEGAWAI_PENATARAN add constraint FK_R_PENATARAN_T_PEGAWAI_PENATARAN foreign key (ID_PENATARAN)
      references R_PENATARAN (ID_PENATARAN) on delete restrict on update restrict;

alter table T_PEGAWAI_PENATARAN add constraint FK_R_PENYELENGGARA_PENATARAN_T_PEGAWAI_PENATARAN foreign key (KD_PENYELENGGARA_PENATARAN)
      references R_PENYELENGGARA_PENATARAN (KD_PENYELENGGARA_PENATARAN) on delete restrict on update restrict;

alter table T_PEGAWAI_PENATARAN add constraint FK_T_PEGAWAI_T_PEGAWAI_PENATARAN foreign key (ID_PEGAWAI)
      references T_PEGAWAI (ID_PEGAWAI) on delete restrict on update restrict;

alter table T_PEGAWAI_PENATARAN add constraint FK___AUTH_T_PEGAWAI_PENATARAN foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_PEGAWAI_PENGHARGAAN add constraint FK_R_JENIS_PENGHARGAAN_T_PEGAWAI_PENGHARGAAN foreign key (KD_JENIS_PENGHARGAAN)
      references R_JENIS_PENGHARGAAN (KD_JENIS_PENGHARGAAN) on delete restrict on update restrict;

alter table T_PEGAWAI_PENGHARGAAN add constraint FK_T_PEGAWAI_T_PEGAWAI_PENGHARGAAN foreign key (ID_PEGAWAI)
      references T_PEGAWAI (ID_PEGAWAI) on delete restrict on update restrict;

alter table T_PEGAWAI_PENGHARGAAN add constraint FK___AUTH_T_PEGAWAI_PENGHARGAAN foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_PEGAWAI_PRESTASI add constraint FK_R_JENIS_LOMBA_T_PEGAWAI_PRESTASI foreign key (ID_JENIS_LOMBA)
      references R_JENIS_LOMBA (ID_JENIS_LOMBA) on delete restrict on update restrict;

alter table T_PEGAWAI_PRESTASI add constraint FK_R_TINGKAT_PRESTASI_T_PEGAWAI_PRESTASI foreign key (KD_TINGKAT_PRESTASI)
      references R_TINGKAT_PRESTASI (KD_TINGKAT_PRESTASI) on delete restrict on update restrict;

alter table T_PEGAWAI_PRESTASI add constraint FK_T_PEGAWAI_T_PEGAWAI_PRESTASI foreign key (ID_PEGAWAI)
      references T_PEGAWAI (ID_PEGAWAI) on delete restrict on update restrict;

alter table T_PEGAWAI_PRESTASI add constraint FK___AUTH_T_PEGAWAI_PRESTASI foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_PEGAWAI_ROMBEL add constraint FK_T_PEGAWAI_T_PEGAWAI_ROMBEL_1 foreign key (ID_PEGAWAI)
      references T_PEGAWAI (ID_PEGAWAI) on delete restrict on update restrict;

alter table T_PEGAWAI_ROMBEL add constraint FK_T_PEGAWAI_T_PEGAWAI_ROMBEL_2 foreign key (ID_PEGAWAI_BK)
      references T_PEGAWAI (ID_PEGAWAI) on delete restrict on update restrict;

alter table T_PEGAWAI_ROMBEL add constraint FK_T_SEKOLAH_JURUSAN_T_PEGAWAI_ROMBEL foreign key (KD_TAHUN_AJARAN, KD_TINGKAT_KELAS)
      references T_SEKOLAH_JURUSAN (KD_TAHUN_AJARAN, KD_TINGKAT_KELAS) on delete restrict on update restrict;

alter table T_PEGAWAI_ROMBEL add constraint FK_T_SEKOLAH_RUANG_T_PEGAWAI_ROMBEL foreign key (ID_RUANG_KELAS)
      references T_SEKOLAH_RUANG (ID_RUANG_KELAS) on delete restrict on update restrict;

alter table T_PEGAWAI_ROMBEL add constraint FK___AUTH_T_PEGAWAI_ROMBEL foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_PEGAWAI_RWYT_AJAR add constraint FK_R_MATA_PELAJARAN_DIAJARKAN_T_PEGAWAI_RWYT_AJAR foreign key (KD_MATA_PELAJARAN_DIAJARKAN)
      references R_MATA_PELAJARAN_DIAJARKAN (KD_MATA_PELAJARAN_DIAJARKAN) on delete restrict on update restrict;

alter table T_PEGAWAI_RWYT_AJAR add constraint FK_T_PEGAWAI_T_PEGAWAI_RWYT_AJAR foreign key (ID_PEGAWAI)
      references T_PEGAWAI (ID_PEGAWAI) on delete restrict on update restrict;

alter table T_PEGAWAI_RWYT_AJAR add constraint FK___AUTH_T_PEGAWAI_RWYT_AJAR foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_PEGAWAI_RWYT_JABATAN add constraint FK_R_JABATAN_PEGAWAI_T_PEGAWAI_RWYT_JABATAN foreign key (KD_JABATAN_PEGAWAI)
      references R_JABATAN_PEGAWAI (KD_JABATAN_PEGAWAI) on delete restrict on update restrict;

alter table T_PEGAWAI_RWYT_JABATAN add constraint FK_R_JENIS_PEGAWAI_T_PEGAWAI_RWYT_JABATAN foreign key (KD_JENIS_PEGAWAI)
      references R_JENIS_PEGAWAI (KD_JENIS_PEGAWAI) on delete restrict on update restrict;

alter table T_PEGAWAI_RWYT_JABATAN add constraint FK_R_TENAGA_ADMINISTASI_T_PEGAWAI_RWYT_JABATAN foreign key (KD_TENAGA_ADMINISTRASI)
      references R_TENAGA_ADMINISTRASI (KD_TENAGA_ADMINISTRASI) on delete restrict on update restrict;

alter table T_PEGAWAI_RWYT_JABATAN add constraint FK_T_PEGAWAI_T_PEGAWAI_RWYT_JABATAN foreign key (ID_PEGAWAI)
      references T_PEGAWAI (ID_PEGAWAI) on delete restrict on update restrict;

alter table T_PEGAWAI_RWYT_JABATAN add constraint FK___AUTH_T_PEGAWAI_RWYT_JABATAN foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_PEGAWAI_RWYT_PANGKAT add constraint FK_R_PANGKAT_T_PEGAWAI_RWYT_PANGKAT foreign key (KD_PANGKAT)
      references R_PANGKAT (KD_PANGKAT) on delete restrict on update restrict;

alter table T_PEGAWAI_RWYT_PANGKAT add constraint FK_R_STATUS_PEGAWAI_T_PEGAWAI_RWYT_PANGKAT foreign key (KD_STATUS_PEGAWAI)
      references R_STATUS_PEGAWAI (KD_STATUS_PEGAWAI) on delete restrict on update restrict;

alter table T_PEGAWAI_RWYT_PANGKAT add constraint FK_T_PEGAWAI_T_PEGAWAI_RWYT_PANGKAT foreign key (ID_PEGAWAI)
      references T_PEGAWAI (ID_PEGAWAI) on delete restrict on update restrict;

alter table T_PEGAWAI_RWYT_PANGKAT add constraint FK___AUTH_T_PEGAWAI_RWYT_PANGKAT foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_PROPINSI_KABUPATEN add constraint FK_R_KABUPATEN_T_PROPINSI_KABUPATEN foreign key (ID_KABUPATEN)
      references R_KABUPATEN (ID_KABUPATEN) on delete restrict on update restrict;

alter table T_PROPINSI_KABUPATEN add constraint FK_R_PROPINSI_T_PROPINSI_KABUPATEN foreign key (ID_PROPINSI)
      references R_PROPINSI (ID_PROPINSI) on delete restrict on update restrict;

alter table T_SEKOLAH_ANCAM_DO add constraint FK_R_TINGKAT_KELAS_T_SEKOLAH_ANCAM_DO foreign key (KD_TINGKAT_KELAS)
      references R_TINGKAT_KELAS (KD_TINGKAT_KELAS) on delete restrict on update restrict;

alter table T_SEKOLAH_ANCAM_DO add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_ANCAM_DO foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_ANCAM_DO add constraint FK___AUTH_T_SEKOLAH_ANCAM_DO foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_BANTUAN add constraint FK_R_BANTUAN_T_SEKOLAH_BANTUAN foreign key (KD_BANTUAN)
      references R_BANTUAN (KD_BANTUAN) on delete restrict on update restrict;

alter table T_SEKOLAH_BANTUAN add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_BANTUAN foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_BANTUAN add constraint FK___AUTH_T_SEKOLAH_BANTUAN foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_BERUBAH add constraint FK_R_KABUPATEN_T_SEKOLAH_BERUBAH foreign key (ID_KABUPATEN)
      references R_KABUPATEN (ID_KABUPATEN) on delete restrict on update restrict;

alter table T_SEKOLAH_BERUBAH add constraint FK_R_KECAMATAN_T_SEKOLAH_BERUBAH foreign key (ID_KECAMATAN)
      references R_KECAMATAN (ID_KECAMATAN) on delete restrict on update restrict;

alter table T_SEKOLAH_BERUBAH add constraint FK_R_PROPINSI_T_SEKOLAH_BERUBAH foreign key (ID_PROPINSI)
      references R_PROPINSI (ID_PROPINSI) on delete restrict on update restrict;

alter table T_SEKOLAH_BERUBAH add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_BERUBAH foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_BUALPEN add constraint FK_R_MATA_PELAJARAN_DIAJARKAN_T_SEKOLAH_BUALPEN foreign key (KD_MATA_PELAJARAN_DIAJARKAN)
      references R_MATA_PELAJARAN_DIAJARKAN (KD_MATA_PELAJARAN_DIAJARKAN) on delete restrict on update restrict;

alter table T_SEKOLAH_BUALPEN add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_BUALPEN foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_BUALPEN add constraint FK___AUTH_T_SEKOLAH_BUALPEN foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_DO add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_DO foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_DO add constraint FK___AUTH_T_SEKOLAH_DO foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_IDENTITAS add constraint FK_R_BENTUK_SEKOLAH_T_SEKOLAH_IDENTITAS foreign key (KD_BENTUK_SEKOLAH)
      references R_BENTUK_SEKOLAH (KD_BENTUK_SEKOLAH) on delete restrict on update restrict;

alter table T_SEKOLAH_IDENTITAS add constraint FK_R_DAERAH_T_SEKOLAH_IDENTITAS foreign key (KD_DAERAH)
      references R_DAERAH (KD_DAERAH) on delete restrict on update restrict;

alter table T_SEKOLAH_IDENTITAS add constraint FK_R_JENIS_SEKOLAH_T_SEKOLAH_IDENTITAS foreign key (KD_JENIS_SEKOLAH)
      references R_JENIS_SEKOLAH (KD_JENIS_SEKOLAH) on delete restrict on update restrict;

alter table T_SEKOLAH_IDENTITAS add constraint FK_R_KABUPATEN_T_SEKOLAH_IDENTITAS foreign key (ID_KABUPATEN)
      references R_KABUPATEN (ID_KABUPATEN) on delete restrict on update restrict;

alter table T_SEKOLAH_IDENTITAS add constraint FK_R_KECAMATAN_T_SEKOLAH_IDENTITAS foreign key (ID_KECAMATAN)
      references R_KECAMATAN (ID_KECAMATAN) on delete restrict on update restrict;

alter table T_SEKOLAH_IDENTITAS add constraint FK_R_KLASIFIKASI_GEOGRAFIS_T_SEKOLAH_IDENTITAS foreign key (KD_KLASIFIKASI_GEOGRAFIS)
      references R_KLASIFIKASI_GEOGRAFIS (KD_KLASIFIKASI_GEOGRAFIS) on delete restrict on update restrict;

alter table T_SEKOLAH_IDENTITAS add constraint FK_R_KLASIFIKASI_SEKOLAH_T_SEKOLAH_IDENTITAS foreign key (KD_KLASIFIKASI_SEKOLAH)
      references R_KLASIFIKASI_SEKOLAH (KD_KLASIFIKASI_SEKOLAH) on delete restrict on update restrict;

alter table T_SEKOLAH_IDENTITAS add constraint FK_R_PROPINSI_T_SEKOLAH_IDENTITAS foreign key (ID_PROPINSI)
      references R_PROPINSI (ID_PROPINSI) on delete restrict on update restrict;

alter table T_SEKOLAH_IDENTITAS add constraint FK_R_TAHUN_AJARAN_T_SEKOLAH_IDENTITAS foreign key (KD_TAHUN_AJARAN)
      references R_TAHUN_AJARAN (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_IDENTITAS add constraint FK_R_TYPE_SEKOLAH_T_SEKOLAH_IDENTITAS foreign key (KD_TYPE_SEKOLAH)
      references R_TYPE_SEKOLAH (KD_TYPE_SEKOLAH) on delete restrict on update restrict;

alter table T_SEKOLAH_IDENTITAS add constraint FK_R_WAKTU_PENYELENGGARAAN_T_SEKOLAH_IDENTITAS foreign key (KD_WAKTU_PENYELENGGARAAN)
      references R_WAKTU_PENYELENGGARAAN (KD_WAKTU_PENYELENGGARAAN) on delete restrict on update restrict;

alter table T_SEKOLAH_IDENTITAS add constraint FK___AUTH_T_SEKOLAH_IDENTITAS foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_INFO add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_INFO foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_INFO add constraint FK___AUTH_T_SEKOLAH_INFO foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_JURUSAN add constraint FK_R_KURIKULUM_T_SEKOLAH_JURUSAN foreign key (KD_KURIKULUM)
      references R_KURIKULUM (KD_KURIKULUM) on delete restrict on update restrict;

alter table T_SEKOLAH_JURUSAN add constraint FK_R_TAHUN_AJARAN_T_SEKOLAH_JURUSAN foreign key (KD_TAHUN_AJARAN)
      references R_TAHUN_AJARAN (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_JURUSAN add constraint FK_R_TINGKAT_KELAS_T_SEKOLAH_JURUSAN foreign key (KD_TINGKAT_KELAS)
      references R_TINGKAT_KELAS (KD_TINGKAT_KELAS) on delete restrict on update restrict;

alter table T_SEKOLAH_JURUSAN add constraint FK___AUTH_T_SEKOLAH_JURUSAN foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_KEGIATAN add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_KEGIATAN foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_KEGIATAN add constraint FK___AUTH_T_SEKOLAH_KEGIATAN foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_KEPALA add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_KEPALA foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_PEMAKAIAN_LISTRIK add constraint FK_R_DAYA_LISTRIK_T_SEKOLAH_PEMAKAIAN_LISTRIK foreign key (KD_DAYA_LISTRIK)
      references R_DAYA_LISTRIK (KD_DAYA_LISTRIK) on delete restrict on update restrict;

alter table T_SEKOLAH_PEMAKAIAN_LISTRIK add constraint FK_R_SUMBER_LISTRIK_T_SEKOLAH_PEMAKAIAN_LISTRIK foreign key (KD_SUMBER_LISTRIK)
      references R_SUMBER_LISTRIK (KD_SUMBER_LISTRIK) on delete restrict on update restrict;

alter table T_SEKOLAH_PEMAKAIAN_LISTRIK add constraint FK_R_VOLTASE_T_SEKOLAH_PEMAKAIAN_LISTRIK foreign key (KD_VOLTASE)
      references R_VOLTASE (KD_VOLTASE) on delete restrict on update restrict;

alter table T_SEKOLAH_PEMAKAIAN_LISTRIK add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_PEMAKAIAN_LISTRIK foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_PEMAKAIAN_LISTRIK add constraint FK___AUTH_T_SEKOLAH_PEMAKAIAN_LISTRIK foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_PERINGKAT_UAN add constraint FK_R_TINGKAT_PRESTASI_T_SEKOLAH_PERINGKAT_UAN foreign key (KD_TINGKAT_PRESTASI)
      references R_TINGKAT_PRESTASI (KD_TINGKAT_PRESTASI) on delete restrict on update restrict;

alter table T_SEKOLAH_PERINGKAT_UAN add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_PERINGKAT_UAN foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_PERINGKAT_UAN add constraint FK___AUTH_T_SEKOLAH_PERINGKAT_UAN foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_PERLENGKAPAN add constraint FK_R_PERLENGKAPAN_SEKOLAH_T_SEKOLAH_PERLENGKAPAN foreign key (KD_PERLENGKAPAN_SEKOLAH)
      references R_PERLENGKAPAN_SEKOLAH (KD_PERLENGKAPAN_SEKOLAH) on delete restrict on update restrict;

alter table T_SEKOLAH_PERLENGKAPAN add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_PERLENGKAPAN foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_PERLENGKAPAN add constraint FK___AUTH_T_SEKOLAH_PERLENGKAPAN foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_PERLENGKAPAN_KBM add constraint FK_R_PERLENGKAPAN_SEKOLAH_T_SEKOLAH_PERLENGKAPAN_KBM foreign key (KD_PERLENGKAPAN_SEKOLAH)
      references R_PERLENGKAPAN_SEKOLAH (KD_PERLENGKAPAN_SEKOLAH) on delete restrict on update restrict;

alter table T_SEKOLAH_PERLENGKAPAN_KBM add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_PERLENGKAPAN_KBM foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_PERLENGKAPAN_KBM add constraint FK___AUTH_T_SEKOLAH_PERLENGKAPAN_KBM foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_PKH_ALAT add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_PKH_ALAT foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_PKH_ALAT add constraint FK___AUTH_T_SEKOLAH_PKH_ALAT foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_PKH_GURU add constraint FK_T_PEGAWAI_T_SEKOLAH_PKH_GURU foreign key (ID_PEGAWAI)
      references T_PEGAWAI (ID_PEGAWAI) on delete restrict on update restrict;

alter table T_SEKOLAH_PKH_GURU add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_PKH_GURU foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_PKH_GURU add constraint FK___AUTH_T_SEKOLAH_PKH_GURU foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_PKH_KEGIATAN add constraint FK_R_HASIL_EVALUASI_T_SEKOLAH_PKH_KEGIATAN foreign key (KD_HASIL_EVALUASI)
      references R_HASIL_EVALUASI (KD_HASIL_EVALUASI) on delete restrict on update restrict;

alter table T_SEKOLAH_PKH_KEGIATAN add constraint FK_R_JENIS_PKH_T_SEKOLAH_PKH_KEGIATAN foreign key (ID_JENIS_PKH)
      references R_JENIS_PKH (ID_JENIS_PKH) on delete restrict on update restrict;

alter table T_SEKOLAH_PKH_KEGIATAN add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_PKH_KEGIATAN foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_PKH_KEGIATAN add constraint FK___AUTH_T_SEKOLAH_PKH_KEGIATAN foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_PKH_MITRA add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_PKH_MITRA foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_PKH_MITRA add constraint FK___AUTH_T_SEKOLAH_PKH_MITRA foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_PKH_NARASUMBER add constraint FK_R_GOL_PEKERJAAN_ORTU_T_SEKOLAH_PKH_NARASUMBER foreign key (ID_GOL_PEKERJAAN_ORTU)
      references R_GOL_PEKERJAAN_ORTU (ID_GOL_PEKERJAAN_ORTU) on delete restrict on update restrict;

alter table T_SEKOLAH_PKH_NARASUMBER add constraint FK_R_PROGRAM_STUDI_T_SEKOLAH_PKH_NARASUMBER foreign key (KD_PROGRAM_STUDI)
      references R_PROGRAM_STUDI (KD_PROGRAM_STUDI) on delete restrict on update restrict;

alter table T_SEKOLAH_PKH_NARASUMBER add constraint FK_R_TINGKAT_IJAZAH_T_SEKOLAH_PKH_NARASUMBER foreign key (KD_TINGKAT_IJAZAH)
      references R_TINGKAT_IJAZAH (KD_TINGKAT_IJAZAH) on delete restrict on update restrict;

alter table T_SEKOLAH_PKH_NARASUMBER add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_PKH_NARASUMBER foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_PKH_NARASUMBER add constraint FK___AUTH_T_SEKOLAH_PKH_NARASUMBER foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_PRESTASI add constraint FK_R_JENIS_LOMBA_T_SEKOLAH_PRESTASI foreign key (ID_JENIS_LOMBA)
      references R_JENIS_LOMBA (ID_JENIS_LOMBA) on delete restrict on update restrict;

alter table T_SEKOLAH_PRESTASI add constraint FK_R_TINGKAT_PRESTASI_T_SEKOLAH_PRESTASI foreign key (KD_TINGKAT_PRESTASI)
      references R_TINGKAT_PRESTASI (KD_TINGKAT_PRESTASI) on delete restrict on update restrict;

alter table T_SEKOLAH_PRESTASI add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_PRESTASI foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_PRESTASI add constraint FK___AUTH_T_SEKOLAH_PRESTASI foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_PROPERTI add constraint FK_R_KEPEMILIKAN_T_SEKOLAH_PROPERTI foreign key (KD_KEPEMILIKAN)
      references R_KEPEMILIKAN (KD_KEPEMILIKAN) on delete restrict on update restrict;

alter table T_SEKOLAH_PROPERTI add constraint FK_R_PENGGUNAAN_TANAH_T_SEKOLAH_PROPERTI foreign key (KD_PENGGUNAAN_TANAH)
      references R_PENGGUNAAN_TANAH (KD_PENGGUNAAN_TANAH) on delete restrict on update restrict;

alter table T_SEKOLAH_PROPERTI add constraint FK_R_SERTIFIKAT_T_SEKOLAH_PROPERTI foreign key (KD_SERTIFIKAT)
      references R_SERTIFIKAT (KD_SERTIFIKAT) on delete restrict on update restrict;

alter table T_SEKOLAH_PROPERTI add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_PROPERTI foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_PROPERTI add constraint FK___AUTH_T_SEKOLAH_PROPERTI foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_REKENING add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_REKENING foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_REKENING add constraint FK___AUTH_T_SEKOLAH_REKENING foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_RUANG add constraint FK_R_KEPEMILIKAN_T_SEKOLAH_RUANG foreign key (KD_KEPEMILIKAN)
      references R_KEPEMILIKAN (KD_KEPEMILIKAN) on delete restrict on update restrict;

alter table T_SEKOLAH_RUANG add constraint FK_R_KONDISI_RUANGAN_T_SEKOLAH_RUANG foreign key (KD_KONDISI_RUANGAN)
      references R_KONDISI_RUANGAN (KD_KONDISI_RUANGAN) on delete restrict on update restrict;

alter table T_SEKOLAH_RUANG add constraint FK_R_RUANG_T_SEKOLAH_RUANG foreign key (KD_RUANG)
      references R_RUANG (KD_RUANG) on delete restrict on update restrict;

alter table T_SEKOLAH_RUANG add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_RUANG foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_RUANG add constraint FK___AUTH_T_SEKOLAH_RUANG foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_SALDO_AWAL add constraint FK_R_TAHUN_AJARAN_T_SEKOLAH_SALDO_AWAL foreign key (KD_TAHUN_AJARAN)
      references R_TAHUN_AJARAN (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_SALDO_AWAL add constraint FK___AUTH_T_SEKOLAH_SALDO_AWAL foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_SK add constraint FK_R_AKREDITASI_T_SEKOLAH_SK foreign key (KD_AKREDITASI)
      references R_AKREDITASI (KD_AKREDITASI) on delete restrict on update restrict;

alter table T_SEKOLAH_SK add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_SK foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_SK add constraint FK___AUTH_T_SEKOLAH_SK foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_SK_SWASTA add constraint FK_R_AKREDITASI_T_SEKOLAH_SK_SWASTA foreign key (KD_AKREDITASI)
      references R_AKREDITASI (KD_AKREDITASI) on delete restrict on update restrict;

alter table T_SEKOLAH_SK_SWASTA add constraint FK_R_KABUPATEN_T_SEKOLAH_SK_SWASTA foreign key (ID_KABUPATEN)
      references R_KABUPATEN (ID_KABUPATEN) on delete restrict on update restrict;

alter table T_SEKOLAH_SK_SWASTA add constraint FK_R_KECAMATAN_T_SEKOLAH_SK_SWASTA foreign key (ID_KECAMATAN)
      references R_KECAMATAN (ID_KECAMATAN) on delete restrict on update restrict;

alter table T_SEKOLAH_SK_SWASTA add constraint FK_R_KEL_YAYASAN_T_SEKOLAH_SK_SWASTA foreign key (KD_KEL_YAYASAN)
      references R_KEL_YAYASAN (KD_KEL_YAYASAN) on delete restrict on update restrict;

alter table T_SEKOLAH_SK_SWASTA add constraint FK_R_PROPINSI_T_SEKOLAH_SK_SWASTA foreign key (ID_PROPINSI)
      references R_PROPINSI (ID_PROPINSI) on delete restrict on update restrict;

alter table T_SEKOLAH_SK_SWASTA add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_SK_SWASTA foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_SK_SWASTA add constraint FK___AUTH_T_SEKOLAH_SK_SWASTA foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SEKOLAH_SOFTWARE add constraint FK_T_SEKOLAH_IDENTITAS_T_SEKOLAH_SOFTWARE foreign key (KD_TAHUN_AJARAN)
      references T_SEKOLAH_IDENTITAS (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SEKOLAH_SOFTWARE add constraint FK___AUTH_T_SEKOLAH_SOFTWARE foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SISWA add constraint FK_R_AGAMA_T_SISWA foreign key (KD_AGAMA)
      references R_AGAMA (KD_AGAMA) on delete restrict on update restrict;

alter table T_SISWA add constraint FK_R_ASAL_SEKOLAH_T_SISWA foreign key (ASAL_SD)
      references R_ASAL_SEKOLAH (ASAL_SD) on delete restrict on update restrict;

alter table T_SISWA add constraint FK_R_GOL_DARAH_T_SISWA foreign key (KD_GOL_DARAH)
      references R_GOL_DARAH (KD_GOL_DARAH) on delete restrict on update restrict;

alter table T_SISWA add constraint FK_R_SEKOLAH_SETINGKAT_T_SISWA foreign key (ASAL_SMP)
      references R_SEKOLAH_SETINGKAT (ASAL_SMP) on delete restrict on update restrict;

alter table T_SISWA add constraint FK_R_TINGKAT_KELAS_T_SISWA foreign key (KD_TINGKAT_KELAS)
      references R_TINGKAT_KELAS (KD_TINGKAT_KELAS) on delete restrict on update restrict;

alter table T_SISWA add constraint FK___AUTH_T_SISWA foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SISWA_ALUMNI add constraint FK_T_SISWA_T_SISWA_ALUMNI foreign key (ID_SISWA)
      references T_SISWA (ID_SISWA) on delete restrict on update restrict;

alter table T_SISWA_ALUMNI add constraint FK___AUTH_T_SISWA_ALUMNI foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SISWA_BEASISWA add constraint FK_R_BEASISWA_T_SISWA_BEASISWA foreign key (KD_BEASISWA)
      references R_BEASISWA (KD_BEASISWA) on delete restrict on update restrict;

alter table T_SISWA_BEASISWA add constraint FK_R_TAHUN_AJARAN_T_SISWA_BEASISWA foreign key (KD_TAHUN_AJARAN)
      references R_TAHUN_AJARAN (KD_TAHUN_AJARAN) on delete restrict on update restrict;

alter table T_SISWA_BEASISWA add constraint FK_T_SISWA_T_SISWA_BEASISWA foreign key (ID_SISWA)
      references T_SISWA (ID_SISWA) on delete restrict on update restrict;

alter table T_SISWA_BEASISWA add constraint FK___AUTH_T_SISWA_BEASISWA foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SISWA_CUTI add constraint FK_T_SISWA_T_SISWA_CUTI foreign key (ID_SISWA)
      references T_SISWA (ID_SISWA) on delete restrict on update restrict;

alter table T_SISWA_CUTI add constraint FK___AUTH_T_SISWA_CUTI foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SISWA_HOBI add constraint FK_R_HOBI_T_SISWA_HOBI foreign key (ID_HOBI)
      references R_HOBI (ID_HOBI) on delete restrict on update restrict;

alter table T_SISWA_HOBI add constraint FK_T_SISWA_T_SISWA_HOBI foreign key (ID_SISWA)
      references T_SISWA (ID_SISWA) on delete restrict on update restrict;

alter table T_SISWA_HOBI add constraint FK___AUTH_T_SISWA_HOBI foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SISWA_INFO add constraint FK_R_KESEJAHTERAAN_KELUARGA_T_SISWA_INFO foreign key (KD_KESEJAHTERAAN_KELUARGA)
      references R_KESEJAHTERAAN_KELUARGA (KD_KESEJAHTERAAN_KELUARGA) on delete restrict on update restrict;

alter table T_SISWA_INFO add constraint FK_R_KETUNAAN_T_SISWA_INFO foreign key (KD_KETUNAAN)
      references R_KETUNAAN (KD_KETUNAAN) on delete restrict on update restrict;

alter table T_SISWA_INFO add constraint FK_T_SISWA_T_SISWA_INFO foreign key (ID_SISWA)
      references T_SISWA (ID_SISWA) on delete restrict on update restrict;

alter table T_SISWA_INFO add constraint FK___AUTH_T_SISWA_INFO foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SISWA_ORTU add constraint FK_R_AGAMA_T_SISWA_ORTU foreign key (KD_AGAMA)
      references R_AGAMA (KD_AGAMA) on delete restrict on update restrict;

alter table T_SISWA_ORTU add constraint FK_R_GOL_PEKERJAAN_ORTU_T_SISWA_ORTU foreign key (ID_GOL_PEKERJAAN_ORTU)
      references R_GOL_PEKERJAAN_ORTU (ID_GOL_PEKERJAAN_ORTU) on delete restrict on update restrict;

alter table T_SISWA_ORTU add constraint FK_R_JENIS_ORTU_T_SISWA_ORTU foreign key (KD_JENIS_ORTU)
      references R_JENIS_ORTU (KD_JENIS_ORTU) on delete restrict on update restrict;

alter table T_SISWA_ORTU add constraint FK_R_KABUPATEN_T_SISWA_ORTU foreign key (ID_KABUPATEN)
      references R_KABUPATEN (ID_KABUPATEN) on delete restrict on update restrict;

alter table T_SISWA_ORTU add constraint FK_R_PROPINSI_T_SISWA_ORTU foreign key (ID_PROPINSI)
      references R_PROPINSI (ID_PROPINSI) on delete restrict on update restrict;

alter table T_SISWA_ORTU add constraint FK_R_TINGKAT_IJAZAH_T_SISWA_ORTU foreign key (KD_TINGKAT_IJAZAH)
      references R_TINGKAT_IJAZAH (KD_TINGKAT_IJAZAH) on delete restrict on update restrict;

alter table T_SISWA_ORTU add constraint FK_T_SISWA_T_SISWA_ORTU foreign key (ID_SISWA)
      references T_SISWA (ID_SISWA) on delete restrict on update restrict;

alter table T_SISWA_ORTU add constraint FK___AUTH_T_SISWA_ORTU foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SISWA_PINDAH add constraint FK_R_SEKOLAH_SETINGKAT_T_SISWA_PINDAH foreign key (ASAL_SMP)
      references R_SEKOLAH_SETINGKAT (ASAL_SMP) on delete restrict on update restrict;

alter table T_SISWA_PINDAH add constraint FK_T_SISWA_T_SISWA_PINDAH foreign key (ID_SISWA)
      references T_SISWA (ID_SISWA) on delete restrict on update restrict;

alter table T_SISWA_PINDAH add constraint FK___AUTH_T_SISWA_PINDAH foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SISWA_PRESTASI add constraint FK_R_JENIS_LOMBA_T_SISWA_PRESTASI foreign key (ID_JENIS_LOMBA)
      references R_JENIS_LOMBA (ID_JENIS_LOMBA) on delete restrict on update restrict;

alter table T_SISWA_PRESTASI add constraint FK_R_TINGKAT_PRESTASI_T_SISWA_PRESTASI foreign key (KD_TINGKAT_PRESTASI)
      references R_TINGKAT_PRESTASI (KD_TINGKAT_PRESTASI) on delete restrict on update restrict;

alter table T_SISWA_PRESTASI add constraint FK_T_SISWA_TINGKAT_T_SISWA_PRESTASI foreign key (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL)
      references T_SISWA_TINGKAT (ID_SISWA, KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL) on delete restrict on update restrict;

alter table T_SISWA_PRESTASI add constraint FK___AUTH_T_SISWA_PRESTASI foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SISWA_PUTUS add constraint FK_T_SISWA_T_SISWA_PUTUS foreign key (ID_SISWA)
      references T_SISWA (ID_SISWA) on delete restrict on update restrict;

alter table T_SISWA_PUTUS add constraint FK___AUTH_T_SISWA_PUTUS foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SISWA_RWYT_SAKIT add constraint FK_R_PENYAKIT_T_SISWA_RWYT_SAKIT foreign key (ID_PENYAKIT)
      references R_PENYAKIT (ID_PENYAKIT) on delete restrict on update restrict;

alter table T_SISWA_RWYT_SAKIT add constraint FK_T_SISWA_T_SISWA_RWYT_SAKIT foreign key (ID_SISWA)
      references T_SISWA (ID_SISWA) on delete restrict on update restrict;

alter table T_SISWA_RWYT_SAKIT add constraint FK___AUTH_T_SISWA_RWYT_SAKIT foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SISWA_TINGKAT add constraint FK_T_PEGAWAI_ROMBEL_T_SISWA_TINGKAT foreign key (KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL)
      references T_PEGAWAI_ROMBEL (KD_TAHUN_AJARAN, KD_TINGKAT_KELAS, KD_ROMBEL) on delete restrict on update restrict;

alter table T_SISWA_TINGKAT add constraint FK_T_SISWA_T_SISWA_TINGKAT foreign key (ID_SISWA)
      references T_SISWA (ID_SISWA) on delete restrict on update restrict;

alter table T_SISWA_TINGKAT add constraint FK___AUTH_T_SISWA_TINGKAT foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SISWA_TINGKAT_THN add constraint FK_T_SISWA_T_SISWA_TINGKAT_THN foreign key (ID_SISWA)
      references T_SISWA (ID_SISWA) on delete restrict on update restrict;

alter table T_SISWA_TINGKAT_THN add constraint FK___AUTH_T_SISWA_TINGKAT_THN foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table T_SISWA_TINGKAT_THN_BARU add constraint FK_T_SISWA_T_SISWA_TINGKAT_THN_BARU foreign key (ID_SISWA)
      references T_SISWA (ID_SISWA) on delete restrict on update restrict;

alter table T_SISWA_TINGKAT_THN_BARU add constraint FK___AUTH_T_SISWA_TINGKAT_THN_BARU foreign key (USERNAME)
      references __AUTH (USERNAME) on delete restrict on update restrict;

alter table __AUTH add constraint FK___GRUP_USER___AUTH foreign key (ID_GRUP)
      references __GRUP_USER (ID_GRUP) on delete restrict on update restrict;

alter table __HAK_AKSES add constraint FK___GRUP_USER___HAK_AKSES foreign key (ID_GRUP)
      references __GRUP_USER (ID_GRUP) on delete restrict on update restrict;

alter table __HAK_AKSES add constraint FK___MENU___HAK_AKSES foreign key (MENU_ID)
      references __MENU (MENU_ID) on delete restrict on update restrict;

