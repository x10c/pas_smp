use PAS_SMP;


delimiter $$

CREATE FUNCTION F_GAJI_ORTU (
    picC_ids    BIGINT
) 
RETURNS DECIMAL(18,2)
BEGIN
	DECLARE v_rtn DECIMAL(18,2);
	
	SET v_rtn = 0;

	SELECT	gaji
	INTO	v_rtn
	FROM	t_siswa_ortu
	WHERE	id_siswa 		= picC_ids
	AND		kd_jenis_ortu	= '3';

	IF v_rtn = 0 OR v_rtn IS NULL THEN
		SELECT	SUM(gaji)
		INTO	v_rtn
		FROM	t_siswa_ortu
		WHERE	id_siswa = picC_ids;
	END IF;

	IF v_rtn IS NULL THEN
		SET v_rtn = 0;
	END IF;

	RETURN(v_rtn);
END
$$

delimiter ;


delimiter $$

CREATE FUNCTION F_GURU_MAPEL_AJAR (
    pic2_thn CHAR(2)
,   pisi_idp SMALLINT UNSIGNED
) 
RETURNS VARCHAR(255)
BEGIN
	DECLARE v__done INT DEFAULT 0;
	DECLARE vc_rtn VARCHAR(255);
	DECLARE vc__mpl VARCHAR(50);
	
	DECLARE C_AJAR CURSOR FOR
		SELECT	DISTINCT B.NM_MATA_PELAJARAN_DIAJARKAN
		FROM	T_PEGAWAI_MENGAJAR 			AS A
		,		R_MATA_PELAJARAN_DIAJARKAN 	AS B
		WHERE	B.KD_MATA_PELAJARAN_DIAJARKAN   = A.KD_MATA_PELAJARAN_DIAJARKAN 
		AND		A.KD_TAHUN_AJARAN               = pic2_thn
		AND		A.ID_PEGAWAI                    = pisi_idp;
		
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET v__done = 1;
	
	OPEN C_AJAR;
	
	SET vc_rtn = NULL;
	
	REPEAT
		FETCH C_AJAR INTO vc__mpl;
		
		IF NOT v__done THEN
			IF vc_rtn IS NULL THEN
				SET vc_rtn = vc__mpl;
			ELSE
				SET vc_rtn = CONCAT(vc_rtn, '; ', vc__mpl);
			END IF;
		END IF;
	UNTIL v__done END REPEAT;
	
	CLOSE C_AJAR;
	
	RETURN(vc_rtn);
END
$$

delimiter ;


delimiter $$

create function F_GURU_MULAI_AJAR (
    pisi_idp smallint unsigned
) 
RETURNS VARCHAR(255)
BEGIN
	DECLARE v__done INT DEFAULT 0;
	DECLARE vc_rtn VARCHAR(255);
	DECLARE vc__mpl VARCHAR(50);
	
	DECLARE C_AJAR CURSOR FOR
		SELECT	TRIM(CAST(A.TAHUN_MULAI_AJAR AS CHAR(4)))
		FROM	T_PEGAWAI_RWYT_AJAR AS A
		WHERE	A.ID_PEGAWAI = pisi_idp;
		
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET v__done = 1;
	
	OPEN C_AJAR;
	
	SET vc_rtn = NULL;
	
	REPEAT
		FETCH C_AJAR INTO vc__mpl;
		
		IF NOT v__done THEN
			IF vc_rtn IS NULL THEN
				SET vc_rtn = vc__mpl;
			ELSE
				SET vc_rtn = CONCAT(vc_rtn, '; ', vc__mpl);
			END IF;
		END IF;
	UNTIL v__done END REPEAT;
	
	CLOSE C_AJAR;
	
	RETURN(vc_rtn);
END
$$

delimiter ;


delimiter $$

create function F_KD_TAHUN_AJARAN (
    pidt_tgl    DATE
) 
RETURNS CHAR(2)
BEGIN
	DECLARE v_rtn CHAR(2);
	DECLARE v_thn CHAR(4);

	SET v_rtn = '00';

	IF pidt_tgl IS NOT NULL THEN
		IF MONTH(pidt_tgl) < 7 THEN
			SET v_thn = CAST((YEAR(pidt_tgl) - 1) AS CHAR);
		ELSE
			SET v_thn = CAST(YEAR(pidt_tgl) AS CHAR);
		END IF;
	  
		SELECT	KD_TAHUN_AJARAN
		INTO	v_rtn
		FROM	R_TAHUN_AJARAN
		WHERE	LEFT(NM_TAHUN_AJARAN,4) = v_thn;
	END IF;
	
	RETURN(v_rtn);
END
$$

delimiter ;


delimiter $$

CREATE FUNCTION F_PEGAWAI_NIP (
    pivc_nip    VARCHAR(18)
) 
RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_rtn SMALLINT UNSIGNED;

    SELECT  ID_PEGAWAI
    INTO    v_rtn 
    FROM    T_PEGAWAI
    WHERE   NIP = pivc_nip;

    RETURN(v_rtn);
END
$$

delimiter ;


delimiter $$

CREATE FUNCTION F_PEGAWAI_PENATARAN (
    pisi_idp    SMALLINT UNSIGNED
) 
RETURNS TINYINT UNSIGNED
BEGIN
	DECLARE v_retun TINYINT UNSIGNED;

	SET v_retun = NULL;

	SELECT  MAX(NO_URUT)
	INTO    v_retun
	FROM    T_PEGAWAI_PENATARAN
	WHERE   ID_PEGAWAI = pisi_idp;

	RETURN(v_retun);
END
$$

delimiter ;


delimiter $$

CREATE FUNCTION F_SISWA_NIS (
    pivc_nis    VARCHAR(25)
) 
RETURNS BIGINT UNSIGNED
BEGIN
    DECLARE v_rtn BIGINT UNSIGNED;

    SELECT  ID_SISWA
    INTO    v_rtn 
    FROM    T_SISWA
    WHERE   NIS = pivc_nis;

    RETURN(v_rtn);
END
$$

delimiter ;


delimiter $$

create procedure SP_INSERT_KKM (
    in pic2_thn char(2)
,   in pic2_kls char(2)
,   in picF_rbl varchar(15)
,   in pivx_usr varchar(20)
,   in pits_tgl timestamp
)
begin
	declare v__do int default 0;
	declare v_kur char(2);
	declare v_prd char(1);
	declare v_mtp char(5);
	declare v_asp tinyint unsigned;
	declare v_rbl varchar(15);
   
	declare C_MATPEL cursor for
		select 	KD_PERIODE_BELAJAR
		, 		KD_MATA_PELAJARAN_DIAJARKAN
        from 	T_KUR_KURIKULUM
		where 	KD_KURIKULUM 		= v_kur 
		and		KD_TINGKAT_KELAS 	= pic2_kls;
		
	declare continue handler for SQLSTATE '02000' set v__do = 1;
   
	select	ifnull(KD_KURIKULUM, '02')
    into 	v_kur
    from 	T_SEKOLAH_JURUSAN
    where 	KD_TAHUN_AJARAN 	= pic2_thn 
	and		KD_TINGKAT_KELAS 	= pic2_kls;
   
	if v_kur = '02' then
		open C_MATPEL;
		repeat
			fetch C_MATPEL into v_prd, v_mtp;
      
			if not v__do then
				insert into T_KUR_KKM_MATPEL 
				values(	pic2_thn
					, 	pic2_kls
					, 	picF_rbl
					, 	v_kur
					,	v_prd
					, 	v_mtp
					, 	65
					,	pivx_usr
					,	pits_tgl);
			end if;
		until v__do end repeat;
   
		close C_MATPEL;
   end if;
end
$$

delimiter ;


delimiter $$

CREATE PROCEDURE SP_INSERT_RAPOR (
    IN picC_ids BIGINT UNSIGNED
,   IN pic2_thn CHAR(2)
,   IN pic2_kls CHAR(2)
,   IN picF_rbl VARCHAR(15)
,   IN pic1_prd CHAR(1)
,   IN pivx_usr VARCHAR(20)
,   IN pits_tgl TIMESTAMP
)
BEGIN
	DECLARE v__do INT DEFAULT 0;
	DECLARE v_aga CHAR(5);
	DECLARE v_kur CHAR(2);
	DECLARE v_mtp CHAR(5);
	DECLARE v_asp TINYINT UNSIGNED;
	DECLARE v_kkm TINYINT UNSIGNED;

	DECLARE C_MATPEL_NON_AGAMA CURSOR FOR
		SELECT	KD_MATA_PELAJARAN_DIAJARKAN
		,		KKM
		FROM	T_KUR_KKM_MATPEL
		WHERE	KD_TAHUN_AJARAN						= pic2_thn
		AND		KD_TINGKAT_KELAS 					= pic2_kls
		AND		KD_ROMBEL 							= picF_rbl
		AND		KD_PERIODE_BELAJAR 					= pic1_prd
		AND		LEFT(KD_MATA_PELAJARAN_DIAJARKAN,2) <> '13';

	DECLARE C_MATPEL_AGAMA CURSOR FOR
		SELECT	KD_MATA_PELAJARAN_DIAJARKAN
		,		KKM
		FROM	T_KUR_KKM_MATPEL
		WHERE	KD_TAHUN_AJARAN 			= pic2_thn
		AND		KD_TINGKAT_KELAS 			= pic2_kls
		AND		KD_ROMBEL 					= picF_rbl
		AND		KD_PERIODE_BELAJAR 			= pic1_prd
		AND		KD_MATA_PELAJARAN_DIAJARKAN = v_aga;

	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET v__do = 1;

	SELECT 	CONCAT('1300',KD_AGAMA)
	INTO	v_aga
	FROM 	T_SISWA
	WHERE 	ID_SISWA = picC_ids;

	SELECT	IFNULL(KD_KURIKULUM, '01')
	INTO	v_kur
	FROM	T_SEKOLAH_JURUSAN
	WHERE	KD_TAHUN_AJARAN		= pic2_thn 
	AND		KD_TINGKAT_KELAS 	= pic2_kls;

	IF v_kur = '02' THEN
		OPEN C_MATPEL_NON_AGAMA;

		REPEAT
			FETCH C_MATPEL_NON_AGAMA INTO v_mtp, v_kkm;
	  
			IF NOT v__do THEN
				INSERT INTO T_NILAI_RAPOR_NILAI 
				VALUES(	picC_ids
                    ,   null
					,	pic2_thn
					,	pic2_kls
					,	picF_rbl
					,	pic1_prd
					,	v_kur
					,	v_mtp
					,	v_kkm
					,	0
					,	''
					,	pivx_usr
					,	pits_tgl);
			END IF;
		UNTIL v__do END REPEAT;

		CLOSE C_MATPEL_NON_AGAMA;

		SET v__do = 0;

		OPEN C_MATPEL_AGAMA;

		REPEAT
			FETCH C_MATPEL_AGAMA INTO v_mtp, v_kkm;
	  
			IF NOT v__do THEN
				INSERT INTO T_NILAI_RAPOR_NILAI
				VALUES(	picC_ids
                    ,   null
					,	pic2_thn
					, 	pic2_kls
					, 	picF_rbl
					,	pic1_prd
                    ,	v_kur
					,	v_mtp
					,	v_kkm
					,	0
					,	''
					,	pivx_usr
					,	pits_tgl);
			END IF;
		UNTIL v__do END REPEAT;

		CLOSE C_MATPEL_AGAMA;
	END IF;
END
$$

delimiter ;


delimiter $$

CREATE PROCEDURE SP_INSERT_SEKOLAH (
    IN pic2_thn CHAR(2)
,   IN pic2_new CHAR(2)
,   IN pivx_usr VARCHAR(20)
,   IN pits_tgl TIMESTAMP
)
BEGIN
	DECLARE v__do INT DEFAULT 0;
	/* t_sekolah_rekening */
	DECLARE v_rekening_no_urut TINYINT(3) UNSIGNED;
	DECLARE v_rekening_nm_rek VARCHAR(50);
	DECLARE v_rekening_no_rek_sekolah VARCHAR(20);
	DECLARE v_rekening_nm_bank VARCHAR(50);
	DECLARE v_rekening_cabang_bank VARCHAR(50);
	/* t_sekolah_properti */
	DECLARE v_properti_kd_penggunaan_tanah CHAR(1);
	DECLARE v_properti_kd_kepemilikan CHAR(1);
	DECLARE v_properti_kd_sertifikat CHAR(1);
	DECLARE v_properti_luas DECIMAL(9,2);
	DECLARE v_properti_keterangan VARCHAR(255);
	/* t_sekolah_ruang */
	DECLARE v_ruang_nm_ruang_kelas VARCHAR(50);
	DECLARE v_ruang_kd_ruang CHAR(2);
	DECLARE v_ruang_kd_kepemilikan CHAR(1);
	DECLARE v_ruang_kd_kondisi_ruangan CHAR(1);
	DECLARE v_ruang_kapasitas SMALLINT(5) UNSIGNED;
	DECLARE v_ruang_panjang DECIMAL(5,2);
	DECLARE v_ruang_lebar DECIMAL(5,2);
	DECLARE v_ruang_luas DECIMAL(9,2);
	DECLARE v_ruang_keterangan VARCHAR(255);
	/* t_sekolah_perlengkapan */
	DECLARE v_perlengkapan_kd_perlengkapan_sekolah CHAR(2);
	DECLARE v_perlengkapan_jumlah SMALLINT(5) UNSIGNED;
	/* t_sekolah_perlengkapan_kbm */
	DECLARE v_perlengkapan_kbm_kd_perlengkapan_sekolah CHAR(2);
	DECLARE v_perlengkapan_kbm_jumlah SMALLINT(5) UNSIGNED;
	/* t_sekolah_bualpen */
	DECLARE v_bualpen_kd_mata_pelajaran_diajarkan CHAR(5);
	DECLARE v_bualpen_jml_jdl_guru TINYINT(3) UNSIGNED;
	DECLARE v_bualpen_jml_eks_guru TINYINT(3) UNSIGNED;
	DECLARE v_bualpen_jml_jdl_siswa TINYINT(3) UNSIGNED;
	DECLARE v_bualpen_jml_eks_siswa SMALLINT(5) UNSIGNED;
	DECLARE v_bualpen_jml_jdl_pegang SMALLINT(5) UNSIGNED;
	DECLARE v_bualpen_jml_eks_pegang SMALLINT(5) UNSIGNED;
	DECLARE v_bualpen_prosen_peraga DECIMAL(3,2);
	DECLARE v_bualpen_paktek SMALLINT(5) UNSIGNED;
	DECLARE v_bualpen_mulmed SMALLINT(5) UNSIGNED;
	/* t_pegawai_aktif */
	DECLARE v_pegawai_id_pegawai SMALLINT(5) UNSIGNED;
	DECLARE v_pegawai_nip VARCHAR(18);
	DECLARE v_pegawai_kd_jenis_ketenagaan CHAR(1);
	DECLARE v_pegawai_nm_pegawai VARCHAR(50);
	DECLARE v_pegawai_kota_lahir VARCHAR(50);
	DECLARE v_pegawai_tanggal_lahir DATE;
	DECLARE v_pegawai_kd_jenis_kelamin CHAR(1);
	DECLARE v_pegawai_umur SMALLINT(5) UNSIGNED;
	DECLARE v_pegawai_kd_usia_pegawai CHAR(2);
	DECLARE v_pegawai_urut_didik TINYINT(3) UNSIGNED;
	DECLARE v_pegawai_urut_pangkat TINYINT(3) UNSIGNED;
	DECLARE v_pegawai_awal_jabatan TINYINT(3) UNSIGNED;
	DECLARE v_pegawai_urut_jabatan TINYINT(3) UNSIGNED;
	DECLARE v_pegawai_urut_tatar TINYINT(3) UNSIGNED;
	DECLARE v_pegawai_status_aktif CHAR(1);
	/* t_sekolah_pkh_kegiatan */
	DECLARE v_pkh_kegiatan_no_urut TINYINT(3) UNSIGNED;
	DECLARE v_pkh_kegiatan_id_jenis_pkh TINYINT(3) UNSIGNED;
	DECLARE v_pkh_kegiatan_tahun_awal SMALLINT(5) UNSIGNED;
	DECLARE v_pkh_kegiatan_jumlah SMALLINT(5) UNSIGNED;
	DECLARE v_pkh_kegiatan_kd_hasil_evaluasi CHAR(1);
	DECLARE v_pkh_kegiatan_keterangan VARCHAR(255);
	/* t_sekolah_pkh_alat */
	DECLARE v_pkh_alat_no_urut TINYINT(3) UNSIGNED;
	DECLARE v_pkh_alat_nm_alat VARCHAR(50);
	DECLARE v_pkh_alat_jumlah_baik SMALLINT(5) UNSIGNED;
	DECLARE v_pkh_alat_jumlah_ringan SMALLINT(5) UNSIGNED;
	DECLARE v_pkh_alat_jumlah_sedang SMALLINT(5) UNSIGNED;
	DECLARE v_pkh_alat_jumlah_berat SMALLINT(5) UNSIGNED;
	/* t_sekolah_pkh_mitra */
	DECLARE v_pkh_mitra_no_urut TINYINT(3) UNSIGNED;
	DECLARE v_pkh_mitra_nm_mitra VARCHAR(50);
	DECLARE v_pkh_mitra_keterangan VARCHAR(255);
	/* t_sekolah_pkh_guru */
	DECLARE v_pkh_guru_id_pegawai SMALLINT(5) UNSIGNED;
	DECLARE v_pkh_guru_keterangan VARCHAR(255);
	/* t_sekolah_pkh_narasumber */
	DECLARE v_pkh_narasumber_no_urut TINYINT(3) UNSIGNED;
	DECLARE v_pkh_narasumber_nm_narasumber VARCHAR(50);
	DECLARE v_pkh_narasumber_tanggal_lahir DATE;
	DECLARE v_pkh_narasumber_kd_tingkat_ijazah CHAR(2);
	DECLARE v_pkh_narasumber_kd_program_studi CHAR(4);
	DECLARE v_pkh_narasumber_id_gol_pekerjaan_ortu TINYINT(3) UNSIGNED;
	DECLARE v_pkh_narasumber_bidang_keahlian VARCHAR(50);
	DECLARE v_pkh_narasumber_sedia_waktu TINYINT(3) UNSIGNED;
	DECLARE v_pkh_narasumber_keterangan VARCHAR(255);

	DECLARE C_REKENING CURSOR FOR
		SELECT	NO_URUT
		, 		NM_REK
		, 		NO_REK_SEKOLAH
		, 		NM_BANK
		, 		CABANG_BANK
		FROM 	T_SEKOLAH_REKENING
		WHERE 	KD_TAHUN_AJARAN = pic2_thn;

	DECLARE C_PROPERTI CURSOR FOR
		SELECT	KD_PENGGUNAAN_TANAH
		, 		KD_KEPEMILIKAN
		, 		KD_SERTIFIKAT
		, 		LUAS
		, 		KETERANGAN
		FROM 	T_SEKOLAH_PROPERTI
		WHERE 	KD_TAHUN_AJARAN = pic2_thn;
		
	DECLARE C_RUANG CURSOR FOR
		SELECT	NM_RUANG_KELAS
		, 		KD_RUANG
		, 		KD_KEPEMILIKAN
		, 		KD_KONDISI_RUANGAN
		, 		KAPASITAS
		, 		PANJANG
		, 		LEBAR
		,		LUAS
		,		KETERANGAN
		FROM 	T_SEKOLAH_RUANG
		WHERE 	KD_TAHUN_AJARAN = pic2_thn;

	DECLARE C_PERLENGKAPAN CURSOR FOR
		SELECT	KD_PERLENGKAPAN_SEKOLAH
		, 		JUMLAH
		FROM 	T_SEKOLAH_PERLENGKAPAN
		WHERE 	KD_TAHUN_AJARAN = pic2_thn;

	DECLARE C_PERLENGKAPAN_KBM CURSOR FOR
		SELECT	KD_PERLENGKAPAN_SEKOLAH
		, 		JUMLAH
		FROM 	T_SEKOLAH_PERLENGKAPAN_KBM
		WHERE 	KD_TAHUN_AJARAN = pic2_thn;
		
	DECLARE C_BUALPEN CURSOR FOR
		SELECT	KD_MATA_PELAJARAN_DIAJARKAN
		, 		JML_JDL_GURU
		, 		JML_EKS_GURU
		,		JML_JDL_SISWA
		, 		JML_EKS_SISWA
		, 		JML_JDL_PEGANG
		, 		JML_EKS_PEGANG
		,		PROSEN_PERAGA
		, 		PAKTEK
		, 		MULMED
		FROM 	T_SEKOLAH_BUALPEN
		WHERE 	KD_TAHUN_AJARAN = pic2_thn;

	DECLARE C_GURU CURSOR FOR
		SELECT	ID_PEGAWAI
		, 		NIP
		, 		KD_JENIS_KETENAGAAN
		, 		NM_PEGAWAI
		, 		KOTA_LAHIR
		, 		TANGGAL_LAHIR
		,		KD_JENIS_KELAMIN
		, 		UMUR
		, 		KD_USIA_PEGAWAI
		, 		URUT_DIDIK
		, 		URUT_PANGKAT
		, 		AWAL_JABATAN
		,		URUT_JABATAN
		, 		URUT_TATAR
		, 		STATUS_AKTIF
		FROM 	T_PEGAWAI_AKTIF
		WHERE 	KD_TAHUN_AJARAN = pic2_thn;

	DECLARE C_GIAT_PKH CURSOR FOR
		SELECT	NO_URUT
		, 		ID_JENIS_PKH
		, 		TAHUN_AWAL
		, 		JUMLAH
		, 		KD_HASIL_EVALUASI
		, 		KETERANGAN
		FROM 	T_SEKOLAH_PKH_KEGIATAN
		WHERE 	KD_TAHUN_AJARAN = pic2_thn;

	DECLARE C_ALAT_PKH CURSOR FOR
		SELECT	NO_URUT
		, 		NM_ALAT
		, 		JUMLAH_BAIK
		, 		JUMLAH_RINGAN
		, 		JUMLAH_SEDANG
		, 		JUMLAH_BERAT
		FROM 	T_SEKOLAH_PKH_ALAT
		WHERE 	KD_TAHUN_AJARAN = pic2_thn;

	DECLARE C_MITRA_PKH CURSOR FOR
		SELECT	NO_URUT
		, 		NM_MITRA
		, 		KETERANGAN
		FROM 	T_SEKOLAH_PKH_MITRA
		WHERE 	KD_TAHUN_AJARAN = pic2_thn;

	DECLARE C_GURU_PKH CURSOR FOR
		SELECT	ID_PEGAWAI
		,		KETERANGAN
		FROM 	T_SEKOLAH_PKH_GURU
		WHERE 	KD_TAHUN_AJARAN = pic2_thn;

	DECLARE C_NARSUM_PKH CURSOR FOR
		SELECT	NO_URUT
		, 		NM_NARASUMBER
		, 		TANGGAL_LAHIR
		, 		KD_TINGKAT_IJAZAH
		, 		KD_PROGRAM_STUDI
		,		ID_GOL_PEKERJAAN_ORTU
		, 		BIDANG_KEAHLIAN
		, 		SEDIA_WAKTU
		, 		KETERANGAN
		FROM 	T_SEKOLAH_PKH_NARASUMBER
		WHERE 	KD_TAHUN_AJARAN = pic2_thn;

	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET v__do = 1;

	/* begin insert into t_sekolah_rekening */
	OPEN C_REKENING;

	REPEAT
		FETCH	C_REKENING
		INTO	v_rekening_no_urut
		,		v_rekening_nm_rek
		,		v_rekening_no_rek_sekolah
		,		v_rekening_nm_bank
		,		v_rekening_cabang_bank;
		
		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_REKENING(
				KD_TAHUN_AJARAN
			,	NO_URUT
			,	NM_REK
			,	NO_REK_SEKOLAH
			,	NM_BANK
			,	CABANG_BANK
			,	USERNAME
			,	TANGGAL_AKSES)
			VALUES (
				pic2_new
			, 	v_rekening_no_urut
			, 	v_rekening_nm_rek
			, 	v_rekening_no_rek_sekolah
			, 	v_rekening_nm_bank
			, 	v_rekening_cabang_bank
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;
	
	CLOSE C_REKENING;
	/* end insert into t_sekolah_rekening */
	
	SET v__do = 0;

	/* begin insert into t_sekolah_properti */
	OPEN C_PROPERTI;

	REPEAT
		FETCH	C_PROPERTI
		INTO	v_properti_kd_penggunaan_tanah
		, 		v_properti_kd_kepemilikan
		, 		v_properti_kd_sertifikat
		, 		v_properti_luas
		, 		v_properti_keterangan;

		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_PROPERTI(
				KD_TAHUN_AJARAN
			,	KD_PENGGUNAAN_TANAH
			,	KD_KEPEMILIKAN
			,	KD_SERTIFIKAT
			,	LUAS
			,	KETERANGAN
			,	USERNAME
			,	TANGGAL_AKSES)
			VALUES (
				pic2_new
			, 	v_properti_kd_penggunaan_tanah
			, 	v_properti_kd_kepemilikan
			, 	v_properti_kd_sertifikat
			, 	v_properti_luas
			, 	v_properti_keterangan
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;
	
	CLOSE C_PROPERTI;
	/* end insert into t_sekolah_properti */
	
	SET v__do = 0;

	/* begin insert into t_sekolah_ruang */
	OPEN C_RUANG;

	REPEAT
		FETCH	C_RUANG
		INTO	v_ruang_nm_ruang_kelas
		, 		v_ruang_kd_ruang
		, 		v_ruang_kd_kepemilikan
		, 		v_ruang_kd_kondisi_ruangan
		, 		v_ruang_kapasitas
		, 		v_ruang_panjang
		, 		v_ruang_lebar
		, 		v_ruang_luas
		, 		v_ruang_keterangan;
	  
		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_RUANG(
				KD_TAHUN_AJARAN
			,	NM_RUANG_KELAS
			,	KD_RUANG
			,	KD_KEPEMILIKAN
			,	KD_KONDISI_RUANGAN
			,	KAPASITAS
			,	PANJANG
			,	LEBAR
			,	LUAS
			,	KETERANGAN
			,	USERNAME
			,	TANGGAL_AKSES)
			VALUES (
			 	pic2_new
			, 	v_ruang_nm_ruang_kelas
			, 	v_ruang_kd_ruang
			, 	v_ruang_kd_kepemilikan
			, 	v_ruang_kd_kondisi_ruangan
			, 	v_ruang_kapasitas
			, 	v_ruang_panjang
			, 	v_ruang_lebar
			,	v_ruang_luas
			, 	v_ruang_keterangan
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_RUANG;
	/* end insert into t_sekolah_ruang */
	
	SET v__do = 0;

	/* begin insert into t_sekolah_perlengkapan */
	OPEN C_PERLENGKAPAN;

	REPEAT
		FETCH	C_PERLENGKAPAN
		INTO 	v_perlengkapan_kd_perlengkapan_sekolah
		,		v_perlengkapan_jumlah;

		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_PERLENGKAPAN(
				KD_TAHUN_AJARAN
			,	KD_PERLENGKAPAN_SEKOLAH
			,	JUMLAH
			,	USERNAME
			,	TANGGAL_AKSES)
			VALUES (
				pic2_new
			, 	v_perlengkapan_kd_perlengkapan_sekolah
			, 	v_perlengkapan_jumlah
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_PERLENGKAPAN;
	/* end insert into t_sekolah_perlengkapan */
	
	SET v__do = 0;

	/* begin insert into t_sekolah_perlengkapan_kbm */
	OPEN C_PERLENGKAPAN_KBM;

	REPEAT
		FETCH	C_PERLENGKAPAN_KBM
		INTO 	v_perlengkapan_kbm_kd_perlengkapan_sekolah
		, 		v_perlengkapan_kbm_jumlah;
	  
		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_PERLENGKAPAN_KBM(
				KD_TAHUN_AJARAN
			,	KD_PERLENGKAPAN_SEKOLAH
			,	JUMLAH
			,	USERNAME
			,	TANGGAL_AKSES)
			VALUES(
				pic2_new
			, 	v_perlengkapan_kbm_kd_perlengkapan_sekolah
			, 	v_perlengkapan_kbm_jumlah
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_PERLENGKAPAN_KBM;
	/* end insert into t_sekolah_perlengkapan_kbm */
	
	SET v__do = 0;

	/* begin insert into t_sekolah_bualpen */
	OPEN C_BUALPEN;

	REPEAT
		FETCH	C_BUALPEN
		INTO 	v_bualpen_kd_mata_pelajaran_diajarkan
		, 		v_bualpen_jml_jdl_guru
		, 		v_bualpen_jml_eks_guru
		, 		v_bualpen_jml_jdl_siswa
		, 		v_bualpen_jml_eks_siswa
		, 		v_bualpen_jml_jdl_pegang
		, 		v_bualpen_jml_eks_pegang
		, 		v_bualpen_prosen_peraga
		, 		v_bualpen_paktek
		, 		v_bualpen_mulmed;

		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_BUALPEN(
				KD_TAHUN_AJARAN
			,	KD_MATA_PELAJARAN_DIAJARKAN
			,	JML_JDL_GURU
			,	JML_EKS_GURU
			,	JML_JDL_SISWA
			,	JML_EKS_SISWA
			,	JML_JDL_PEGANG
			,	JML_EKS_PEGANG
			,	PROSEN_PERAGA
			,	PAKTEK
			,	MULMED
			,	USERNAME
			,	TANGGAL_AKSES)
			VALUES (
				pic2_new
			, 	v_bualpen_kd_mata_pelajaran_diajarkan
			, 	v_bualpen_jml_jdl_guru
			, 	v_bualpen_jml_eks_guru
			, 	v_bualpen_jml_jdl_siswa
			, 	v_bualpen_jml_eks_siswa
			, 	v_bualpen_jml_jdl_pegang
			,	v_bualpen_jml_eks_pegang
			, 	v_bualpen_prosen_peraga
			, 	v_bualpen_paktek
			, 	v_bualpen_mulmed
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_BUALPEN;
	/* end insert into t_sekolah_bualpen */
	
	SET v__do = 0;

	/* begin insert into t_pegawai_aktif */
	OPEN C_GURU;

	REPEAT
		FETCH	C_GURU
		INTO 	v_pegawai_id_pegawai
		, 		v_pegawai_nip
		, 		v_pegawai_kd_jenis_ketenagaan
		, 		v_pegawai_nm_pegawai
		, 		v_pegawai_kota_lahir
		, 		v_pegawai_tanggal_lahir
		, 		v_pegawai_kd_jenis_kelamin
		, 		v_pegawai_umur
		, 		v_pegawai_kd_usia_pegawai
		, 		v_pegawai_urut_didik
		, 		v_pegawai_urut_pangkat
		, 		v_pegawai_awal_jabatan
		, 		v_pegawai_urut_jabatan
		, 		v_pegawai_urut_tatar
		, 		v_pegawai_status_aktif;

		IF NOT v__do THEN
			INSERT INTO T_PEGAWAI_AKTIF(
				KD_TAHUN_AJARAN
			,	ID_PEGAWAI
			,	NIP
			,	KD_JENIS_KETENAGAAN
			,	NM_PEGAWAI
			,	KOTA_LAHIR
			,	TANGGAL_LAHIR
			,	KD_JENIS_KELAMIN
			,	UMUR
			,	KD_USIA_PEGAWAI
			,	URUT_DIDIK
			,	URUT_PANGKAT
			,	AWAL_JABATAN
			,	URUT_JABATAN
			,	URUT_TATAR
			,	STATUS_AKTIF
			,	STATUS_ENTRI
			,	USERNAME
			,	TANGGAL_AKSES)
			VALUES (
				pic2_new
			, 	v_pegawai_id_pegawai
			, 	v_pegawai_nip
			, 	v_pegawai_kd_jenis_ketenagaan
			, 	v_pegawai_nm_pegawai
			, 	v_pegawai_kota_lahir
			, 	v_pegawai_tanggal_lahir
			, 	v_pegawai_kd_jenis_kelamin
			,	v_pegawai_umur
			, 	v_pegawai_kd_usia_pegawai
			, 	v_pegawai_urut_didik
			, 	v_pegawai_urut_pangkat
			, 	v_pegawai_awal_jabatan
			, 	v_pegawai_urut_jabatan
			, 	v_pegawai_urut_tatar
			, 	v_pegawai_status_aktif
			,	'0'
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_GURU;
	/* end insert into t_pegawai_aktif */
	
	SET v__do = 0;

	/* begin insert into t_sekolah_pkh_kegiatan */
	OPEN C_GIAT_PKH;

	REPEAT
		FETCH	C_GIAT_PKH
		INTO 	v_pkh_kegiatan_no_urut
		, 		v_pkh_kegiatan_id_jenis_pkh
		, 		v_pkh_kegiatan_tahun_awal
		, 		v_pkh_kegiatan_jumlah
		, 		v_pkh_kegiatan_kd_hasil_evaluasi
		, 		v_pkh_kegiatan_keterangan;

		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_PKH_KEGIATAN(
				KD_TAHUN_AJARAN
			,	NO_URUT
			,	ID_JENIS_PKH
			,	TAHUN_AWAL
			,	JUMLAH
			,	KD_HASIL_EVALUASI
			,	KETERANGAN
			,	USERNAME
			,	TANGGAL_AKSES)
			VALUES (
				pic2_new
			, 	v_pkh_kegiatan_no_urut
			, 	v_pkh_kegiatan_id_jenis_pkh
			, 	v_pkh_kegiatan_tahun_awal
			, 	v_pkh_kegiatan_jumlah
			, 	v_pkh_kegiatan_kd_hasil_evaluasi
			,	v_pkh_kegiatan_keterangan
			, 	pivx_usr
			,	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_GIAT_PKH;
	/* end insert into t_sekolah_pkh_kegiatan */
	
	SET v__do = 0;

	/* begin insert into t_sekolah_pkh_alat */
	OPEN C_ALAT_PKH;

	REPEAT
		FETCH	C_ALAT_PKH
		INTO 	v_pkh_alat_no_urut
		, 		v_pkh_alat_nm_alat
		, 		v_pkh_alat_jumlah_baik
		, 		v_pkh_alat_jumlah_ringan
		, 		v_pkh_alat_jumlah_sedang
		, 		v_pkh_alat_jumlah_berat;

		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_PKH_ALAT(
				KD_TAHUN_AJARAN
			,	NO_URUT
			,	NM_ALAT
			,	JUMLAH_BAIK
			,	JUMLAH_RINGAN
			,	JUMLAH_SEDANG
			,	JUMLAH_BERAT
			,	USERNAME
			,	TANGGAL_AKSES)
			VALUES (
				pic2_new
			, 	v_pkh_alat_no_urut
			, 	v_pkh_alat_nm_alat
			, 	v_pkh_alat_jumlah_baik
			, 	v_pkh_alat_jumlah_ringan
			, 	v_pkh_alat_jumlah_sedang
			, 	v_pkh_alat_jumlah_berat
			, 	pivx_usr
			,	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_ALAT_PKH;
	/* end insert into t_sekolah_pkh_alat */
	
	SET v__do = 0;

	/* begin insert into t_sekolah_pkh_mitra */
	OPEN C_MITRA_PKH;

	REPEAT
		FETCH	C_MITRA_PKH
		INTO 	v_pkh_mitra_no_urut
		, 		v_pkh_mitra_nm_mitra
		, 		v_pkh_mitra_keterangan;

		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_PKH_MITRA(
				KD_TAHUN_AJARAN
			,	NO_URUT
			,	NM_MITRA
			,	KETERANGAN
			,	USERNAME
			,	TANGGAL_AKSES)
			VALUES(
				pic2_new
			, 	v_pkh_mitra_no_urut
			, 	v_pkh_mitra_nm_mitra
			, 	v_pkh_mitra_keterangan
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_MITRA_PKH;
	/* end insert into t_sekolah_pkh_mitra */
	
	SET v__do = 0;

	/* begin insert into t_sekolah_pkh_guru */
	OPEN C_GURU_PKH;

	REPEAT
		FETCH	C_GURU_PKH
		INTO 	v_pkh_guru_id_pegawai
		, 		v_pkh_guru_keterangan;

		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_PKH_GURU(
				KD_TAHUN_AJARAN
			,	ID_PEGAWAI
			,	KETERANGAN
			,	USERNAME
			,	TANGGAL_AKSES)
			VALUES (
				pic2_new
			, 	v_pkh_guru_id_pegawai
			, 	v_pkh_guru_keterangan
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_GURU_PKH;
	/* end insert into t_sekolah_pkh_guru */
	
	SET v__do = 0;

	/* begin insert into t_sekolah_pkh_narasumber */
	OPEN C_NARSUM_PKH;

	REPEAT
		FETCH	C_NARSUM_PKH
		INTO 	v_pkh_narasumber_no_urut
		, 		v_pkh_narasumber_nm_narasumber
		, 		v_pkh_narasumber_tanggal_lahir
		, 		v_pkh_narasumber_kd_tingkat_ijazah
		, 		v_pkh_narasumber_kd_program_studi
		, 		v_pkh_narasumber_id_gol_pekerjaan_ortu
		, 		v_pkh_narasumber_bidang_keahlian
		, 		v_pkh_narasumber_sedia_waktu
		, 		v_pkh_narasumber_keterangan;

		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_PKH_NARASUMBER(
				KD_TAHUN_AJARAN
			,	NO_URUT
			,	NM_NARASUMBER
			,	TANGGAL_LAHIR
			,	KD_TINGKAT_IJAZAH
			,	KD_PROGRAM_STUDI
			,	ID_GOL_PEKERJAAN_ORTU
			,	BIDANG_KEAHLIAN
			,	SEDIA_WAKTU
			,	KETERANGAN
			,	USERNAME
			,	TANGGAL_AKSES)
			VALUES (
				pic2_new
			, 	v_pkh_narasumber_no_urut
			, 	v_pkh_narasumber_nm_narasumber
			, 	v_pkh_narasumber_tanggal_lahir
			, 	v_pkh_narasumber_kd_tingkat_ijazah
			, 	v_pkh_narasumber_kd_program_studi
			, 	v_pkh_narasumber_id_gol_pekerjaan_ortu
			, 	v_pkh_narasumber_bidang_keahlian
			, 	v_pkh_narasumber_sedia_waktu
			,	v_pkh_narasumber_keterangan
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_NARSUM_PKH;
	/* end insert into t_sekolah_pkh_narasumber */
END
$$

delimiter ;

