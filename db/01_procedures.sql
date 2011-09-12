USE PAS_SMP;


DELIMITER $$

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
					,	v_kur
					,	pic1_prd
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
	DECLARE v_urt TINYINT UNSIGNED;
	DECLARE v_nma VARCHAR(50);
	DECLARE v_nrk VARCHAR(20);
	DECLARE v_bnk VARCHAR(50);
	DECLARE v_cbg VARCHAR(50);
	DECLARE v_gun CHAR(1);
	DECLARE v_mlk CHAR(1);
	DECLARE v_srt CHAR(1);
	DECLARE v_pjg DECIMAL(5,2);
	DECLARE v_lbr DECIMAL(5,2);
	DECLARE v_lua DECIMAL(9,2);
	DECLARE v_ktr VARCHAR(255);
	DECLARE v_lkp CHAR(2);
	DECLARE v_jml INTEGER;
	DECLARE v_nmr VARCHAR(50);
	DECLARE v_rng CHAR(2);
	DECLARE v_kon CHAR(1);
	DECLARE v_kap SMALLINT UNSIGNED;
	DECLARE v_mtp CHAR(5);
	DECLARE v_jgr TINYINT;
	DECLARE v_egr TINYINT;
	DECLARE v_jsw TINYINT;
	DECLARE v_esw TINYINT;
	DECLARE v_jpg TINYINT;
	DECLARE v_epg TINYINT;
	DECLARE v_pro DECIMAL(6,2);
	DECLARE v_pkk SMALLINT;
	DECLARE v_mmd SMALLINT;
	DECLARE v_nip SMALLINT UNSIGNED;
	DECLARE v_tng CHAR(1);
	DECLARE v_nmp VARCHAR(50);
	DECLARE v_tmp VARCHAR(50);
	DECLARE v_tgl DATE;
	DECLARE v_kel CHAR(1);
	DECLARE v_umr SMALLINT UNSIGNED;
	DECLARE v_usa CHAR(2);
	DECLARE v_ddk TINYINT UNSIGNED;
	DECLARE v_pkt TINYINT UNSIGNED;
	DECLARE v_ajb TINYINT UNSIGNED;
	DECLARE v_ujb TINYINT UNSIGNED;
	DECLARE v_ttr TINYINT UNSIGNED;
	DECLARE v_sts CHAR(1);
	DECLARE v_jpk TINYINT UNSIGNED;
	DECLARE v_taw SMALLINT UNSIGNED;
	DECLARE v_pjm SMALLINT UNSIGNED;
	DECLARE v_hev CHAR(1);
	DECLARE v_jba SMALLINT UNSIGNED;
	DECLARE v_jri SMALLINT UNSIGNED;
	DECLARE v_jse SMALLINT UNSIGNED;
	DECLARE v_jbe SMALLINT UNSIGNED;
	DECLARE v_ijz CHAR(2);
	DECLARE v_prd CHAR(4);
	DECLARE v_krj TINYINT UNSIGNED;
	DECLARE v_bid VARCHAR(50);
	DECLARE v_wkt TINYINT UNSIGNED;

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
		,		KETERANGAN
		, 		PANJANG
		, 		LEBAR
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
		SELECT	KD_MATA_PELAJARAN
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
		FROM 	T_SEKOLAH_MITRA_PKH
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

	DECLARE C_GURU_PKH CURSOR FOR
		SELECT	NIP
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

	OPEN C_REKENING;

	REPEAT
		FETCH C_REKENING INTO v_urt, v_nma, v_nrk, v_bnk, v_cbg;

		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_REKENING
			VALUES (
				pic2_new
			, 	v_urt
			, 	v_nma
			, 	v_nrk
			, 	v_bnk
			, 	v_cbg
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;
	
	CLOSE C_REKENING;

	SET v__do = 0;

	OPEN C_PROPERTI;

	REPEAT
		FETCH C_PROPERTI INTO v_gun, v_mlk, v_srt, v_lua, v_ktr;

		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_PROPERTI
			VALUES (
				pic2_new
			, 	v_gun
			, 	v_mlk
			, 	v_srt
			, 	v_lua
			, 	v_ktr
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;
	
	CLOSE C_PROPERTI;

	SET v__do = 0;

	OPEN C_RUANG;

	REPEAT
		FETCH C_RUANG INTO v_nmr, v_rng, v_mlk, v_kon, v_kap, v_ktr, v_pjg, v_lbr;
	  
		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_RUANG
			VALUES (
				NULL
			, 	pic2_new
			, 	v_nmr
			, 	v_rng
			, 	v_mlk
			, 	v_kon
			, 	v_kap
			, 	v_pjg
			, 	v_lbr
			,	v_pjg * v_lbr
			, 	v_ktr
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_RUANG;

	SET v__do = 0;

	OPEN C_PERLENGKAPAN;

	REPEAT
		FETCH C_PERLENGKAPAN INTO v_lkp, v_jml;

		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_PERLENGKAPAN
			VALUES (
				pic2_new
			, 	v_lkp
			, 	v_jml
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_PERLENGKAPAN;

	SET v__do = 0;

	OPEN C_PERLENGKAPAN_KBM;

	REPEAT
		FETCH C_PERLENGKAPAN_KBM INTO v_lkp, v_jml;
	  
		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_PERLENGKAPAN_KBM
			VALUES(
				pic2_new
			, 	v_lkp
			, 	v_jml
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_PERLENGKAPAN_KBM;

	SET v__do = 0;

	OPEN C_BUALPEN;

	REPEAT
		FETCH C_BUALPEN INTO v_mtp, v_jgr, v_egr, v_jsw, v_esw, v_jpg, v_epg, v_pro, v_pkk, v_mmd;

		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_BUALPEN
			VALUES (
				pic2_new
			, 	v_mtp
			, 	v_jgr
			, 	v_egr
			, 	v_jsw
			, 	v_esw
			, 	v_jpg
			,	v_epg
			, 	v_pro
			, 	v_pkk
			, 	v_mmd
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_BUALPEN;

	SET v__do = 0;

	OPEN C_GURU;

	REPEAT
		FETCH C_GURU INTO v_nip, v_tng, v_nmp, v_tmp, v_tgl, v_kel, v_umr, v_usa, v_ddk, v_pkt, v_ajb, v_ujb, v_ttr, v_sts;

		IF NOT v__do THEN
			INSERT INTO T_PEGAWAI_AKTIF
			VALUES (
				pic2_new
			, 	v_nip
			, 	v_tng
			, 	v_nmp
			, 	v_tmp
			, 	v_tgl
			, 	v_kel
			,	v_umr
			, 	v_usa
			, 	v_ddk
			, 	v_pkt
			, 	v_ajb
			, 	v_ujb
			, 	v_ttr
			, 	v_sts
			,	'0'
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_GURU;

	SET v__do = 0;

	OPEN C_GIAT_PKH;

	REPEAT
		FETCH C_GIAT_PKH INTO v_urt, v_jpk, v_taw, v_pjm, v_hev, v_ktr;

		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_PKH_KEGIATAN
			VALUES (
				pic2_new
			, 	v_urt
			, 	v_jpk
			, 	v_taw
			, 	v_pjm
			, 	v_hev
			,	v_ktr
			, 	pivx_usr
			,	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_GIAT_PKH;

	SET v__do = 0;

	OPEN C_ALAT_PKH;

	REPEAT
		FETCH C_ALAT_PKH INTO v_urt, v_nma, v_jba, v_jri, v_jse, v_jbe;

		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_PKH_ALAT
			VALUES (
				pic2_new
			, 	v_urt
			, 	v_nma
			, 	v_jba
			, 	v_jri
			, 	v_jse
			, 	v_jbe
			, 	pivx_usr
			,	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_ALAT_PKH;

	SET v__do = 0;

	OPEN C_MITRA_PKH;

	REPEAT
		FETCH C_MITRA_PKH INTO v_urt, v_nma, v_ktr;

		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_PKH_MITRA
			VALUES(
				pic2_new
			, 	v_urt
			, 	v_nma
			, 	v_ktr
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_MITRA_PKH;

	SET v__do = 0;

	OPEN C_GURU_PKH;

	REPEAT
		FETCH C_GURU_PKH INTO v_nip;

		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_PKH_GURU
			VALUES (
				pic2_new
			, 	v_nip
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_GURU_PKH;

	SET v__do = 0;

	OPEN C_NARSUM_PKH;

	REPEAT
		FETCH C_NARSUM_PKH INTO v_urt, v_nma, v_tgl, v_ijz, v_prd, v_krj, v_bid, v_wkt, v_ktr;

		IF NOT v__do THEN
			INSERT INTO T_SEKOLAH_PKH_NARSUMBER
			VALUES (
				pic2_new
			, 	v_urt
			, 	v_nma
			, 	v_tgl
			, 	v_ijz
			, 	v_prd
			, 	v_krj
			, 	v_bid
			, 	v_wkt
			,	v_ktr
			, 	pivx_usr
			, 	pits_tgl);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_NARSUM_PKH;
END
$$

delimiter ;

