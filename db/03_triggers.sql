use PAS_SMP;


drop trigger if exists K_SEKOLAH_KEUANGAN_AIR;

delimiter $$

create trigger K_SEKOLAH_KEUANGAN_AIR after insert
on K_SEKOLAH_KEUANGAN for each row
begin
	declare v__do tinyint default 0;
	
	select	count(*)
	into 	v__do
	from 	t_sekolah_saldo_awal
    where   kd_tahun_ajaran = new.kd_tahun_ajaran;
	
	if v__do = 0 then
        insert into t_sekolah_saldo_awal values(new.kd_tahun_ajaran, new.saldo_awal, 0, new.username, now());
    else
        update  t_sekolah_saldo_awal
        set     saldo_awal      = new.saldo_awal
        where   kd_tahun_ajaran = new.kd_tahun_ajaran;
	end if;
end
$$

delimiter ;


drop trigger if exists K_SEKOLAH_KEUANGAN_AUR;

delimiter $$

create trigger K_SEKOLAH_KEUANGAN_AUR after update
on K_SEKOLAH_KEUANGAN for each row
begin
	declare v__do tinyint default 0;
	
	select	count(*)
	into 	v__do
	from 	t_sekolah_saldo_awal
    where   kd_tahun_ajaran = old.kd_tahun_ajaran;
	
	if v__do > 0 then
        update  t_sekolah_saldo_awal
        set     saldo_awal      = new.saldo_akhir
        where   kd_tahun_ajaran = old.kd_tahun_ajaran;
	end if;
end
$$

delimiter ;


drop trigger if exists K_SEKOLAH_KEUANGAN_BDR;

delimiter $$

create trigger K_SEKOLAH_KEUANGAN_BDR before delete
on K_SEKOLAH_KEUANGAN for each row
begin
    insert into __AUTH values('ditpsmp');
end
$$

delimiter ;


drop trigger if exists K_SEKOLAH_KEUANGAN_BUR;

delimiter $$

create trigger K_SEKOLAH_KEUANGAN_BUR before update
on K_SEKOLAH_KEUANGAN for each row
begin
    IF old.STATUS_AKHIR = 1 THEN
        insert into __AUTH values('ditpsmp');
    END IF;
end
$$

delimiter ;


drop trigger if exists R_ASAL_SEKOLAH_BUR;

delimiter $$

create trigger R_ASAL_SEKOLAH_BUR before update
on R_ASAL_SEKOLAH for each row
begin
	SET new.ASAL_SD = old.ASAL_SD;
   
	IF new.NM_SEKOLAH IS NULL OR TRIM(new.NM_SEKOLAH) = '' THEN 
		SET new.NM_SEKOLAH = old.NM_SEKOLAH;
	END IF;
end
$$

delimiter ;


drop trigger if exists R_EKSTRAKURIKULER_BUR;

delimiter $$

create trigger R_EKSTRAKURIKULER_BUR before update
on R_EKSTRAKURIKULER for each row
begin
    SET new.ID_EKSTRAKURIKULER = old.ID_EKSTRAKURIKULER;

    IF new.NM_EKSTRAKURIKULER IS NULL OR TRIM(new.NM_EKSTRAKURIKULER) = '' THEN
        SET new.NM_EKSTRAKURIKULER = old.NM_EKSTRAKURIKULER;
    END IF;
end
$$

delimiter ;


drop trigger if exists R_GOL_PEKERJAAN_ORTU_BUR;

delimiter $$

create trigger R_GOL_PEKERJAAN_ORTU_BUR before update
on R_GOL_PEKERJAAN_ORTU for each row
begin
    IF OLD.KD_PEKERJAAN_ORTU = '9' THEN
        SET new.ID_GOL_PEKERJAAN_ORTU = old.ID_GOL_PEKERJAAN_ORTU;

        IF new.NM_GOL_PEKERJAAN_ORTU IS NULL OR TRIM(new.NM_GOL_PEKERJAAN_ORTU) = '' THEN
            SET new.NM_GOL_PEKERJAAN_ORTU = old.NM_GOL_PEKERJAAN_ORTU;
        END IF;
    ELSE
        INSERT INTO __AUTH VALUES('ditpsmp');
    END IF;
end
$$

delimiter ;


drop trigger if exists R_HOBI_BUR;

delimiter $$

create trigger R_HOBI_BUR before update
on R_HOBI for each row
begin
    SET new.ID_HOBI = old.ID_HOBI;
   
    IF new.NM_HOBI IS NULL OR TRIM(new.NM_HOBI) = '' THEN
        SET new.NM_HOBI = old.NM_HOBI;
    END IF;
end
$$

delimiter ;


drop trigger if exists R_JENIS_LOMBA_BUR;

delimiter $$

create trigger R_JENIS_LOMBA_BUR before update
on R_JENIS_LOMBA for each row
begin
    SET new.ID_JENIS_LOMBA = old.ID_JENIS_LOMBA;

    IF new.NM_JENIS_LOMBA IS NULL OR TRIM(new.NM_JENIS_LOMBA) = '' THEN
        SET new.NM_JENIS_LOMBA = old.NM_JENIS_LOMBA;
    END IF;
end
$$

delimiter ;


drop trigger if exists R_JENIS_PKH_BUR;

delimiter $$

create trigger R_JENIS_PKH_BUR before update
on R_JENIS_PKH for each row
begin
    SET new.ID_JENIS_PKH = old.ID_JENIS_PKH;

    IF new.NM_JENIS_PKH IS NULL OR TRIM(new.NM_JENIS_PKH) = '' THEN
        SET new.NM_JENIS_PKH = old.NM_JENIS_PKH;
    END IF;
end
$$

delimiter ;


drop trigger if exists R_MATA_PELAJARAN_DIAJARKAN_BIR;

delimiter $$

create trigger R_MATA_PELAJARAN_DIAJARKAN_BIR before insert
on R_MATA_PELAJARAN_DIAJARKAN for each row
begin
	declare	vc_mulok 	char(2);
	declare vi_mulok 	int;
	declare v_max		smallint unsigned;
	
	if new.KD_KEL_MATA_PELAJARAN = '16' then
		select	ifnull(KD_MULOK, '16')
		into	vc_mulok
		from	__ver;
		
		select	ifnull(max(KD_MATA_PELAJARAN_DIAJARKAN), 16000)
		into	vi_mulok
		from	r_mata_pelajaran_diajarkan
		where	left(KD_MATA_PELAJARAN_DIAJARKAN, 2) = vc_mulok;
		
		set vi_mulok = vi_mulok + 1;
		set new.KD_MATA_PELAJARAN_DIAJARKAN = vi_mulok;

    	select	ifnull(max(ORDER_RAPOR),0) + 1
    	into	v_max
    	from	r_mata_pelajaran_diajarkan;
	
    	set new.ORDER_RAPOR = v_max;
    end if;
end
$$

delimiter ;


drop trigger if exists R_NILAI_AFEKTIF_BUR;

delimiter $$

create trigger R_NILAI_AFEKTIF_BUR before update
on R_NILAI_AFEKTIF for each row
begin
    set new.ID_NILAI_AFEKTIF = old.ID_NILAI_AFEKTIF;
    
    IF new.NM_NILAI_AFEKTIF IS NULL OR TRIM(new.NM_NILAI_AFEKTIF) = '' THEN
        SET new.NM_NILAI_AFEKTIF = old.NM_NILAI_AFEKTIF;
    END IF;
end
$$

delimiter ;


drop trigger if exists R_PENATARAN_BUR;

delimiter $$

create trigger R_PENATARAN_BUR before update
on R_PENATARAN for each row
begin
    set new.ID_PENATARAN = old.ID_PENATARAN;

    if new.NM_PENATARAN is null or TRIM(new.NM_PENATARAN) = '' then
        set new.NM_PENATARAN = old.NM_PENATARAN;
    end if;
    end
$$

delimiter ;


drop trigger if exists R_PENYAKIT_BUR;

delimiter $$

create trigger R_PENYAKIT_BUR before update
on R_PENYAKIT for each row
begin
    SET new.ID_PENYAKIT = old.ID_PENYAKIT;

    IF new.NM_PENYAKIT IS NULL OR TRIM(new.NM_PENYAKIT) = '' THEN
        SET new.NM_PENYAKIT = old.NM_PENYAKIT;
    END IF;
end
$$

delimiter ;


drop trigger if exists R_SANKSI_BUR;

delimiter $$

create trigger R_SANKSI_BUR before update
on R_SANKSI for each row
begin
    SET new.ID_SANKSI = old.ID_SANKSI;

    IF new.NM_SANKSI IS NULL OR TRIM(new.NM_SANKSI) = '' THEN
        SET new.NM_SANKSI = old.NM_SANKSI;
    END IF;
end
$$

delimiter ;


drop trigger if exists R_SEKOLAH_SETINGKAT_BUR;

delimiter $$

create trigger R_SEKOLAH_SETINGKAT_BUR before update
on R_SEKOLAH_SETINGKAT for each row
begin
	set new.ASAL_SMP = old.ASAL_SMP;
   
	IF new.NM_SEKOLAH IS NULL OR TRIM(new.NM_SEKOLAH) = '' THEN 
		SET new.NM_SEKOLAH = old.NM_SEKOLAH;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_NILAI_NEM_BIR;

delimiter $$

create trigger T_NILAI_NEM_BIR before insert
on T_NILAI_NEM for each row
begin
    DECLARE v_nis VARCHAR(25);
	DECLARE v_ids BIGINT UNSIGNED;

	IF new.NIS IS NOT NULL THEN
		SELECT F_SISWA_NIS(new.NIS) INTO v_ids;

		SET new.ID_SISWA = v_ids;
	END IF;

    IF new.ID_SISWA IS NOT NULL THEN
        SELECT  NIS
        INTO    v_nis
        FROM    T_SISWA
        WHERE   ID_SISWA = new.ID_SISWA;
        
        SET new.NIS = v_nis;
    END IF;
end
$$

delimiter ;


drop trigger if exists T_NILAI_NEM_BUR;

delimiter $$

create trigger T_NILAI_NEM_BUR before update
on T_NILAI_NEM for each row
begin
	IF new.NILAI IS NULL THEN
		SET new.NILAI       = old.NILAI;
        SET new.NILAI_HURUF = old.NILAI_HURUF;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_NILAI_RAPOR_AIR;

delimiter $$

create trigger T_NILAI_RAPOR_AIR after insert
on T_NILAI_RAPOR for each row
begin
    CALL SP_INSERT_RAPOR(new.ID_SISWA, new.KD_TAHUN_AJARAN, new.KD_TINGKAT_KELAS, new.KD_ROMBEL, new.KD_PERIODE_BELAJAR, new.USERNAME, new.TANGGAL_AKSES);
end
$$

delimiter ;


drop trigger if exists T_NILAI_RAPOR_BIR;

delimiter $$

create trigger T_NILAI_RAPOR_BIR before insert
on T_NILAI_RAPOR for each row
begin
    DECLARE v_nis VARCHAR(25);
	DECLARE v_ids BIGINT UNSIGNED;

	IF new.NIS IS NOT NULL THEN
		SELECT F_SISWA_NIS(new.NIS) INTO v_ids;

		SET new.ID_SISWA = v_ids;
	END IF;

	IF new.ID_SISWA IS NOT NULL THEN
		SELECT	NIS
		INTO	v_nis
		FROM	T_SISWA
		WHERE	ID_SISWA = new.ID_SISWA;
		
		SET new.NIS = v_nis;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_NILAI_RAPOR_BUR;

delimiter $$

create trigger T_NILAI_RAPOR_BUR before update
on T_NILAI_RAPOR for each row
begin
	IF new.SAKIT IS NULL THEN
		SET new.SAKIT = old.SAKIT;
	END IF;

	IF new.IJIN IS NULL THEN
		SET new.IJIN = old.IJIN;
	END IF;

	IF new.ABSEN IS NULL THEN
		SET new.ABSEN = old.ABSEN;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_NILAI_RAPOR_EKSTRA_BIR;

delimiter $$

create trigger T_NILAI_RAPOR_EKSTRA_BIR before insert
on T_NILAI_RAPOR_EKSTRA for each row
begin
    DECLARE v_nis VARCHAR(25);
	DECLARE v_ids BIGINT UNSIGNED;

	IF new.NIS IS NOT NULL THEN
		SELECT F_SISWA_NIS(new.NIS) INTO v_ids;

		SET new.ID_SISWA = v_ids;
	END IF;

	IF new.ID_SISWA IS NOT NULL THEN
		SELECT	NIS
		INTO	v_nis
		FROM	T_SISWA
		WHERE	ID_SISWA = new.ID_SISWA;
		
		SET new.NIS = v_nis;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_NILAI_RAPOR_KEPRIBADIAN_BIR;

delimiter $$

create trigger T_NILAI_RAPOR_KEPRIBADIAN_BIR before insert
on T_NILAI_RAPOR_KEPRIBADIAN for each row
begin
    DECLARE v_nis VARCHAR(25);
	DECLARE v_ids BIGINT UNSIGNED;

	IF new.NIS IS NOT NULL THEN
		SELECT F_SISWA_NIS(new.NIS) INTO v_ids;

		SET new.ID_SISWA = v_ids;
	END IF;

	IF new.ID_SISWA IS NOT NULL THEN
		SELECT	NIS
		INTO	v_nis
		FROM	T_SISWA
		WHERE	ID_SISWA = new.ID_SISWA;
		
		SET new.NIS = v_nis;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_NILAI_RAPOR_NILAI_BIR;

delimiter $$

create trigger T_NILAI_RAPOR_NILAI_BIR before insert
on T_NILAI_RAPOR_NILAI for each row
begin
    DECLARE v_nis VARCHAR(25);
	DECLARE v_ids BIGINT UNSIGNED;

	IF new.NIS IS NOT NULL THEN
		SELECT F_SISWA_NIS(new.NIS) INTO v_ids;

		SET new.ID_SISWA = v_ids;
	END IF;

	IF new.ID_SISWA IS NOT NULL THEN
		SELECT	NIS
		INTO	v_nis
		FROM	T_SISWA
		WHERE	ID_SISWA = new.ID_SISWA;
		
		SET new.NIS = v_nis;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_NILAI_RAPOR_NILAI_BUR;

delimiter $$

create trigger T_NILAI_RAPOR_NILAI_BUR before update
on T_NILAI_RAPOR_NILAI for each row
begin
	IF new.KKM IS NULL THEN
		SET new.KKM = old.KKM;
	END IF;
	
	IF new.NILAI IS NULL THEN
		SET new.NILAI = old.NILAI;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_NILAI_STTB_BIR;

delimiter $$

create trigger T_NILAI_STTB_BIR before insert
on T_NILAI_STTB for each row
begin
    DECLARE v_nis VARCHAR(25);
	DECLARE v_ids BIGINT UNSIGNED;

	IF new.NIS IS NOT NULL THEN
		SELECT F_SISWA_NIS(new.NIS) INTO v_ids;

		SET new.ID_SISWA = v_ids;
	END IF;

	IF new.ID_SISWA IS NOT NULL THEN
		SELECT	NIS
		INTO	v_nis
		FROM	T_SISWA
		WHERE	ID_SISWA = new.ID_SISWA;
		
		SET new.NIS = v_nis;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_NILAI_STTB_BUR;

delimiter $$

create trigger T_NILAI_STTB_BUR before update
on T_NILAI_STTB for each row
begin
	IF new.NILAI IS NULL THEN
		SET new.NILAI       = old.NILAI;
        SET new.NILAI_HURUF = old.NILAI_HURUF;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_AIR;

delimiter $$

create trigger T_PEGAWAI_AIR after insert
on T_PEGAWAI for each row
begin
	DECLARE v__do INT DEFAULT 0;
	DECLARE v_thn CHAR(2);

	DECLARE C_THN CURSOR FOR
		SELECT	KD_TAHUN_AJARAN
		FROM	T_SEKOLAH_IDENTITAS
		WHERE	KD_TAHUN_AJARAN >= F_KD_TAHUN_AJARAN(NOW());
	
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET v__do = 1;

	OPEN C_THN;

	REPEAT
		FETCH C_THN INTO v_thn;
		
		IF NOT v__do THEN
			INSERT INTO T_PEGAWAI_AKTIF
			VALUES(
				v_thn
			,	new.ID_PEGAWAI
			,	new.NIP
			,	new.KD_JENIS_KETENAGAAN
			,	new.NM_PEGAWAI
			,	new.KOTA_LAHIR
			,	new.TANGGAL_LAHIR
			,	new.KD_JENIS_KELAMIN
			,	0
			,	'00'
			,	0
			,	0
			,	0
			,	0
			,	0
			,	'1'
			,	'1'
			,	new.USERNAME
			,	new.TANGGAL_AKSES);
		END IF;
	UNTIL v__do END REPEAT;

	CLOSE C_THN;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_AUR;

delimiter $$

create trigger T_PEGAWAI_AUR after update
on T_PEGAWAI for each row
begin
	IF new.NIP <> old.NIP THEN
		UPDATE	T_PEGAWAI_AKTIF
		SET		NIP					= new.NIP
		,		USERNAME 			= new.USERNAME
		WHERE 	ID_PEGAWAI 			= old.ID_PEGAWAI
		AND		KD_TAHUN_AJARAN 	= F_KD_TAHUN_AJARAN(NOW());
	END IF;
	
	IF new.KD_JENIS_KETENAGAAN <> old.KD_JENIS_KETENAGAAN THEN
		UPDATE	T_PEGAWAI_AKTIF
		SET		KD_JENIS_KETENAGAAN	= new.KD_JENIS_KETENAGAAN
		,		USERNAME 			= new.USERNAME
		WHERE 	ID_PEGAWAI 			= old.ID_PEGAWAI
		AND		KD_TAHUN_AJARAN 	= F_KD_TAHUN_AJARAN(NOW());
	END IF;

	IF new.NM_PEGAWAI <> old.NM_PEGAWAI THEN
		UPDATE	T_PEGAWAI_AKTIF
		SET		NM_PEGAWAI			= new.NM_PEGAWAI
		,		USERNAME 			= new.USERNAME
		WHERE 	ID_PEGAWAI 			= old.ID_PEGAWAI
		AND		KD_TAHUN_AJARAN 	= F_KD_TAHUN_AJARAN(NOW());
	END IF;

	IF new.KOTA_LAHIR <> old.KOTA_LAHIR THEN
		UPDATE	T_PEGAWAI_AKTIF
		SET		KOTA_LAHIR			= new.KOTA_LAHIR
		,		USERNAME 			= new.USERNAME
		WHERE 	ID_PEGAWAI 			= old.ID_PEGAWAI
		AND		KD_TAHUN_AJARAN 	= F_KD_TAHUN_AJARAN(NOW());
	END IF;

	IF new.TANGGAL_LAHIR <> old.TANGGAL_LAHIR THEN
		UPDATE	T_PEGAWAI_AKTIF
		SET		TANGGAL_LAHIR		= new.TANGGAL_LAHIR
		,		USERNAME 			= new.USERNAME
		WHERE 	ID_PEGAWAI 			= old.ID_PEGAWAI
		AND		KD_TAHUN_AJARAN 	= F_KD_TAHUN_AJARAN(NOW());
	END IF;

	IF new.KD_JENIS_KELAMIN <> old.KD_JENIS_KELAMIN THEN
		UPDATE	T_PEGAWAI_AKTIF
		SET		KD_JENIS_KELAMIN	= new.KD_JENIS_KELAMIN
		,		USERNAME 			= new.USERNAME
		WHERE 	ID_PEGAWAI 			= old.ID_PEGAWAI
		AND		KD_TAHUN_AJARAN 	= F_KD_TAHUN_AJARAN(NOW());
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_AKTIF_BIR;

delimiter $$

create trigger T_PEGAWAI_AKTIF_BIR before insert
on T_PEGAWAI_AKTIF for each row
begin
    DECLARE v_nip VARCHAR(18);
	DECLARE v_idp SMALLINT UNSIGNED;

	IF new.NIP IS NOT NULL THEN
		SELECT F_PEGAWAI_NIP(new.NIP) INTO v_idp;

		SET new.ID_PEGAWAI = v_idp;
	END IF;

	IF new.ID_PEGAWAI IS NOT NULL THEN
		SELECT	NIP
		INTO	v_nip
		FROM	T_PEGAWAI
		WHERE	ID_PEGAWAI = new.ID_PEGAWAI;

		SET new.NIP = v_nip;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_DIDIK_FORMAL_BIR;

delimiter $$

create trigger T_PEGAWAI_DIDIK_FORMAL_BIR before insert
on T_PEGAWAI_DIDIK_FORMAL for each row
begin
    DECLARE v_nip VARCHAR(18);
	DECLARE v_idp SMALLINT UNSIGNED;

	IF new.NIP IS NOT NULL THEN
		SELECT F_PEGAWAI_NIP(new.NIP) INTO v_idp;

		SET new.ID_PEGAWAI = v_idp;
	END IF;

	IF new.ID_PEGAWAI IS NOT NULL THEN
		SELECT	NIP
		INTO	v_nip
		FROM	T_PEGAWAI
		WHERE	ID_PEGAWAI = new.ID_PEGAWAI;

		SET new.NIP = v_nip;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_DIDIK_FORMAL_BUR;

delimiter $$

create trigger T_PEGAWAI_DIDIK_FORMAL_BUR before update
on T_PEGAWAI_DIDIK_FORMAL for each row
begin
	IF new.KD_STATUS_LULUS IS NULL THEN
		SET new.KD_STATUS_LULUS = old.KD_STATUS_LULUS;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_GURU_KEBUTUHAN_BUR;

delimiter $$

create trigger T_PEGAWAI_GURU_KEBUTUHAN_BUR before update
on T_PEGAWAI_GURU_KEBUTUHAN for each row
begin
	IF new.JUMLAH_TETAP IS NULL THEN
		SET new.JUMLAH_TETAP = old.JUMLAH_TETAP;
	END IF;

	IF new.JUMLAH_TAK_TETAP IS NULL THEN
		SET new.JUMLAH_TAK_TETAP = old.JUMLAH_TAK_TETAP;
	END IF;

	IF new.JUMLAH_BUTUH IS NULL THEN
		SET new.JUMLAH_BUTUH = old.JUMLAH_BUTUH;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_KELUARGA_BIR;

delimiter $$

create trigger T_PEGAWAI_KELUARGA_BIR before insert
on T_PEGAWAI_KELUARGA for each row
begin
    DECLARE v_nip VARCHAR(18);
	DECLARE v_idp SMALLINT UNSIGNED;

	IF new.NIP IS NOT NULL THEN
		SELECT F_PEGAWAI_NIP(new.NIP) INTO v_idp;

		SET new.ID_PEGAWAI = v_idp;
	END IF;

	IF new.ID_PEGAWAI IS NOT NULL THEN
		SELECT	NIP
		INTO	v_nip
		FROM	T_PEGAWAI
		WHERE	ID_PEGAWAI = new.ID_PEGAWAI;

		SET new.NIP = v_nip;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_MENGAJAR_BIR;

delimiter $$

create trigger T_PEGAWAI_MENGAJAR_BIR before insert
on T_PEGAWAI_MENGAJAR for each row
begin
    DECLARE v_nip VARCHAR(18);
	DECLARE v_idp SMALLINT UNSIGNED;

	IF new.NIP IS NOT NULL THEN
		SELECT F_PEGAWAI_NIP(new.NIP) INTO v_idp;

		SET new.ID_PEGAWAI = v_idp;
	END IF;

	IF new.ID_PEGAWAI IS NOT NULL THEN
		SELECT	NIP
		INTO	v_nip
		FROM	T_PEGAWAI
		WHERE	ID_PEGAWAI = new.ID_PEGAWAI;

		SET new.NIP = v_nip;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_MENGAJAR_BUR;

delimiter $$

create trigger T_PEGAWAI_MENGAJAR_BUR before update
on T_PEGAWAI_MENGAJAR for each row
begin
    IF new.TAHUN_MULAI_AJAR IS NULL THEN
		SET new.TAHUN_MULAI_AJAR = old.TAHUN_MULAI_AJAR;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_PENATARAN_BIR;

delimiter $$

create trigger T_PEGAWAI_PENATARAN_BIR before insert
on T_PEGAWAI_PENATARAN for each row
begin
    DECLARE v_nip VARCHAR(18);
	DECLARE v_idp SMALLINT UNSIGNED;

	IF new.NIP IS NOT NULL THEN
		SELECT F_PEGAWAI_NIP(new.NIP) INTO v_idp;

		SET new.ID_PEGAWAI = v_idp;
	END IF;

	IF new.ID_PEGAWAI IS NOT NULL THEN
		SELECT	NIP
		INTO	v_nip
		FROM	T_PEGAWAI
		WHERE	ID_PEGAWAI = new.ID_PEGAWAI;

		SET new.NIP = v_nip;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_PENGHARGAAN_BIR;

delimiter $$

create trigger T_PEGAWAI_PENGHARGAAN_BIR before insert
on T_PEGAWAI_PENGHARGAAN for each row
begin
    DECLARE v_nip VARCHAR(18);
	DECLARE v_idp SMALLINT UNSIGNED;

	IF new.NIP IS NOT NULL THEN
		SELECT F_PEGAWAI_NIP(new.NIP) INTO v_idp;

		SET new.ID_PEGAWAI = v_idp;
	END IF;

	IF new.ID_PEGAWAI IS NOT NULL THEN
		SELECT	NIP
		INTO	v_nip
		FROM	T_PEGAWAI
		WHERE	ID_PEGAWAI = new.ID_PEGAWAI;

		SET new.NIP = v_nip;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_PRESTASI_BIR;

delimiter $$

create trigger T_PEGAWAI_PRESTASI_BIR before insert
on T_PEGAWAI_PRESTASI for each row
begin
    DECLARE v_nip VARCHAR(18);
	DECLARE v_idp SMALLINT UNSIGNED;

	IF new.NIP IS NOT NULL THEN
		SELECT F_PEGAWAI_NIP(new.NIP) INTO v_idp;

		SET new.ID_PEGAWAI = v_idp;
	END IF;

	IF new.ID_PEGAWAI IS NOT NULL THEN
		SELECT	NIP
		INTO	v_nip
		FROM	T_PEGAWAI
		WHERE	ID_PEGAWAI = new.ID_PEGAWAI;

		SET new.NIP = v_nip;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_ROMBEL_AIR;

delimiter $$

create trigger T_PEGAWAI_ROMBEL_AIR after insert
on T_PEGAWAI_ROMBEL for each row
begin
    CALL SP_INSERT_KKM(new.KD_TAHUN_AJARAN, new.KD_TINGKAT_KELAS, new.KD_ROMBEL, new.USERNAME, new.TANGGAL_AKSES);
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_ROMBEL_AUR;

delimiter $$

create trigger T_PEGAWAI_ROMBEL_AUR after update
on T_PEGAWAI_ROMBEL for each row
begin
	DECLARE v_csp BIGINT UNSIGNED;

	SELECT	COUNT(*)
	INTO	v_csp
	FROM	t_kur_kkm_matpel
	WHERE	KD_TAHUN_AJARAN		= old.KD_TAHUN_AJARAN
	AND		KD_TINGKAT_KELAS	= old.KD_TINGKAT_KELAS
	AND		KD_ROMBEL			= old.KD_ROMBEL;
	
	IF v_csp = 0 THEN
		CALL SP_INSERT_KKM(new.KD_TAHUN_AJARAN, new.KD_TINGKAT_KELAS, new.KD_ROMBEL, new.USERNAME, new.TANGGAL_AKSES);
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_ROMBEL_BDR;

delimiter $$

create trigger T_PEGAWAI_ROMBEL_BDR before delete
on T_PEGAWAI_ROMBEL for each row
begin
	DELETE
	FROM	T_KUR_KKM_MATPEL
	WHERE	KD_TAHUN_AJARAN		= old.KD_TAHUN_AJARAN
	AND		KD_TINGKAT_KELAS	= old.KD_TINGKAT_KELAS
	AND		KD_ROMBEL			= old.KD_ROMBEL;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_ROMBEL_BIR;

delimiter $$

create trigger T_PEGAWAI_ROMBEL_BIR before insert
on T_PEGAWAI_ROMBEL for each row
begin
    DECLARE v_nip VARCHAR(18);
	DECLARE v_idp SMALLINT UNSIGNED;

	IF new.NIP IS NOT NULL THEN
		SELECT F_PEGAWAI_NIP(new.NIP) INTO v_idp;

		SET new.ID_PEGAWAI = v_idp;
	END IF;

	IF new.ID_PEGAWAI IS NOT NULL THEN
		SELECT	NIP
		INTO	v_nip
		FROM	T_PEGAWAI
		WHERE	ID_PEGAWAI = new.ID_PEGAWAI;

		SET new.NIP = v_nip;
	END IF;

	IF new.NIP_BK IS NOT NULL THEN
		SELECT F_PEGAWAI_NIP(new.NIP_BK) INTO v_idp;

		SET new.ID_PEGAWAI_BK = v_idp;
	END IF;

	IF new.ID_PEGAWAI_BK IS NOT NULL THEN
		SELECT	NIP
		INTO	v_nip
		FROM	T_PEGAWAI
		WHERE	ID_PEGAWAI = new.ID_PEGAWAI_BK;

		SET new.NIP_BK = v_nip;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_ROMBEL_BUR;

delimiter $$

create trigger T_PEGAWAI_ROMBEL_BUR before update
on T_PEGAWAI_ROMBEL for each row
begin
	DECLARE v_ada SMALLINT UNSIGNED;

	IF new.STATUS_NAIK_KELAS IS NULL THEN
		SET new.STATUS_NAIK_KELAS = old.STATUS_NAIK_KELAS;
	END IF;

	IF new.STATUS_NAIK_KELAS = '1' OR new.STATUS_NAIK_KELAS = '2' THEN
		SELECT	COUNT(*)
		INTO	v_ada
		FROM	T_NILAI_RAPOR
		WHERE	KD_TAHUN_AJARAN 	= old.KD_TAHUN_AJARAN
		AND		KD_TINGKAT_KELAS 	= old.KD_TINGKAT_KELAS
		AND		KD_ROMBEL 			= old.KD_ROMBEL
		AND		KD_PERIODE_BELAJAR 	= new.STATUS_NAIK_KELAS;
	  
		IF v_ada = 0 THEN
			IF new.STATUS_NAIK_KELAS = '1' THEN
				INSERT INTO T_NILAI_RAPOR(
					ID_SISWA
				,	NIS
				,	KD_TAHUN_AJARAN
				,	KD_TINGKAT_KELAS
				,	KD_ROMBEL
				,	KD_PERIODE_BELAJAR
				,	ID_AHLAK
				,	ID_PRIBADI
				,	SAKIT
				,	IJIN
				,	ABSEN
				,	TANGGAL_DIBERIKAN
				,	USERNAME)
				(	SELECT 
						ID_SISWA
					,	NIS
					,	KD_TAHUN_AJARAN
					,	KD_TINGKAT_KELAS
					,	KD_ROMBEL
					,	new.STATUS_NAIK_KELAS
					,	1
					,	1
					,	0
					,	0
					,	0
					,	new.TANGGAL_SEMESTER_1
					,	new.USERNAME
					FROM	T_SISWA_TINGKAT A
					WHERE	( A.ID_SISWA IN ( 
											SELECT	ID_SISWA
											FROM	T_SISWA
											WHERE	STATUS_SISWA IN ('0','2','3') 
											) 
							)
					AND		( A.KD_TAHUN_AJARAN		= old.KD_TAHUN_AJARAN )
					AND		( A.KD_TINGKAT_KELAS 	= old.KD_TINGKAT_KELAS )
					AND		( A.KD_ROMBEL 			= old.KD_ROMBEL ) 
				);
			END IF;

			IF new.STATUS_NAIK_KELAS = '2' THEN
				INSERT INTO T_NILAI_RAPOR(
					ID_SISWA
				,	NIS
				,	KD_TAHUN_AJARAN
				,	KD_TINGKAT_KELAS
				,	KD_ROMBEL
				,	KD_PERIODE_BELAJAR
				,	ID_AHLAK
				,	ID_PRIBADI
				,	SAKIT
				,	IJIN
				,	ABSEN
				,	TANGGAL_DIBERIKAN
				,	USERNAME)
				(	SELECT 
						ID_SISWA
					,	NIS
					,	KD_TAHUN_AJARAN
					,	KD_TINGKAT_KELAS
					,	KD_ROMBEL
					,	new.STATUS_NAIK_KELAS
					,	1
					,	1
					,	0
					,	0
					,	0
					,	new.TANGGAL_SEMESTER_2
					,	new.USERNAME
					FROM	T_SISWA_TINGKAT A
					WHERE	( A.ID_SISWA IN ( 
											SELECT	ID_SISWA
											FROM	T_SISWA
											WHERE	STATUS_SISWA IN ('0','2','3') 
											) 
							)
					AND		( A.KD_TAHUN_AJARAN		= old.KD_TAHUN_AJARAN )
					AND		( A.KD_TINGKAT_KELAS 	= old.KD_TINGKAT_KELAS )
					AND		( A.KD_ROMBEL 			= old.KD_ROMBEL ) 
				);
			END IF;
		END IF;
	ELSE
	    IF new.STATUS_NAIK_KELAS = '3' THEN
		    SET new.TANGGAL_SEMESTER_1 = NOW();
		    SET new.TANGGAL_SEMESTER_2 = NOW();
        ELSE
            SET new.STATUS_NAIK_KELAS = old.STATUS_NAIK_KELAS;
        END IF;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_RWYT_AJAR_BIR;

delimiter $$

create trigger T_PEGAWAI_RWYT_AJAR_BIR before insert
on T_PEGAWAI_RWYT_AJAR for each row
begin
    DECLARE v_nip VARCHAR(18);
	DECLARE v_idp SMALLINT UNSIGNED;

	IF new.NIP IS NOT NULL THEN
		SELECT F_PEGAWAI_NIP(new.NIP) INTO v_idp;

		SET new.ID_PEGAWAI = v_idp;
	END IF;

	IF new.ID_PEGAWAI IS NOT NULL THEN
		SELECT	NIP
		INTO	v_nip
		FROM	T_PEGAWAI
		WHERE	ID_PEGAWAI = new.ID_PEGAWAI;

		SET new.NIP = v_nip;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_RWYT_JABATAN_AIR;

delimiter $$

create trigger T_PEGAWAI_RWYT_JABATAN_AIR after insert
on T_PEGAWAI_RWYT_JABATAN for each row
begin
	DECLARE v__do INT DEFAULT 0;
	DECLARE v_cnt INT DEFAULT 0;
	DECLARE v_nam VARCHAR(50);
	DECLARE v_kod CHAR(2);

	DECLARE C_THN CURSOR FOR
		SELECT	KD_TAHUN_AJARAN
		FROM	T_SEKOLAH_IDENTITAS
		WHERE	KD_TAHUN_AJARAN >= F_KD_TAHUN_AJARAN(new.TMT_SK);
		
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET v__do = 1;

	IF new.STATUS_JABATAN = '0' THEN
		IF new.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24') THEN
			SELECT	A.NM_PEGAWAI
			INTO	v_nam
			FROM	T_PEGAWAI		AS A
			WHERE	A.ID_PEGAWAI	= new.ID_PEGAWAI;

			OPEN C_THN;
			
			REPEAT
				FETCH C_THN INTO v_kod;
            
				IF NOT v__do THEN
					SELECT	COUNT(*)
					INTO	v_cnt
					FROM	T_SEKOLAH_KEPALA
					WHERE	KD_TAHUN_AJARAN = v_kod
					AND		ID_PEGAWAI = new.ID_PEGAWAI;

					IF v_cnt = 0 THEN
						INSERT INTO T_SEKOLAH_KEPALA
						VALUES(
							v_kod
						,	new.ID_PEGAWAI
						,	new.NIP
						,	v_nam
						,	new.NO_SK
						,	new.TANGGAL_SK
						,	new.TMT_SK);
					ELSE
						UPDATE	T_SEKOLAH_KEPALA
						SET		NO_SK		= new.NO_SK
						,		TANGGAL_SK	= new.TANGGAL_SK
						,		TMT_SK		= new.TMT_SK
						WHERE	KD_TAHUN_AJARAN = v_kod
						AND		ID_PEGAWAI 		= new.ID_PEGAWAI;
					END IF;
				END IF;
			UNTIL v__do END REPEAT;
		
			CLOSE C_THN;
		END IF;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_RWYT_JABATAN_AUR;

delimiter $$

create trigger T_PEGAWAI_RWYT_JABATAN_AUR after update
on T_PEGAWAI_RWYT_JABATAN for each row
begin
	DECLARE v__do INT DEFAULT 0;
	DECLARE v_cnt INT DEFAULT 0;
	DECLARE v_nam VARCHAR(50);
	DECLARE v_kod CHAR(2);

	DECLARE C_THN CURSOR FOR
		SELECT	KD_TAHUN_AJARAN
		FROM	T_SEKOLAH_IDENTITAS
		WHERE	KD_TAHUN_AJARAN >= F_KD_TAHUN_AJARAN(new.TMT_SK);
		
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET v__do = 1;
	
	IF new.STATUS_JABATAN = '0' THEN
		IF new.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24') AND old.KD_JENIS_PEGAWAI NOT IN ('15','20','21','22','23','24') THEN
			SELECT	A.NM_PEGAWAI
			INTO	v_nam
			FROM	T_PEGAWAI		AS A
			WHERE	A.ID_PEGAWAI	= new.ID_PEGAWAI;
		  
			OPEN C_THN;
			
			REPEAT
				FETCH C_THN INTO v_kod;
				
				IF NOT v__do THEN
					SELECT	COUNT(*)
					INTO	v_cnt
					FROM	T_SEKOLAH_KEPALA
					WHERE	KD_TAHUN_AJARAN = v_kod
					AND		ID_PEGAWAI 		= new.ID_PEGAWAI;
				
					IF v_cnt = 0 THEN
						INSERT INTO T_SEKOLAH_KEPALA
						VALUES(
							v_kod
						, 	new.ID_PEGAWAI
						, 	new.NIP
						, 	v_nam
						,	new.NO_SK
						,	new.TANGGAL_SK
						,	new.TMT_SK);
					ELSE
						UPDATE T_SEKOLAH_KEPALA
						SET	NO_SK		= new.NO_SK
						,	TANGGAL_SK	= new.TANGGAL_SK
						,	TMT_SK 		= new.TMT_SK
						WHERE	KD_TAHUN_AJARAN = v_kod
						AND		ID_PEGAWAI = new.ID_PEGAWAI;
					END IF;
				END IF;
			UNTIL v__do END REPEAT;
			
			CLOSE C_THN;
		ELSE
			IF old.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24') AND new.KD_JENIS_PEGAWAI NOT IN ('15','20','21','22','23','24') THEN
				DELETE
				FROM	T_SEKOLAH_KEPALA
				WHERE	ID_PEGAWAI	= old.ID_PEGAWAI
				AND		NO_SK 		= old.NO_SK
				AND		TANGGAL_SK	= old.TANGGAL_SK
				AND		TMT_SK 		= old.TMT_SK;
			ELSE
				IF (new.KD_JENIS_PEGAWAI = old.KD_JENIS_PEGAWAI) THEN
					UPDATE	T_SEKOLAH_KEPALA
					SET	NO_SK 		= new.NO_SK
					,	TANGGAL_SK	= new.TANGGAL_SK
					,	TMT_SK		= old.TMT_SK
					WHERE	ID_PEGAWAI	= old.ID_PEGAWAI
					AND		NO_SK 		= old.NO_SK
					AND		TANGGAL_SK	= old.TANGGAL_SK
					AND		TMT_SK 		= old.TMT_SK;
				END IF;
			END IF;
		END IF;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_RWYT_JABATAN_BDR;

delimiter $$

create trigger T_PEGAWAI_RWYT_JABATAN_BDR before delete
on T_PEGAWAI_RWYT_JABATAN for each row
begin
	IF old.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24') THEN
		DELETE
		FROM	T_SEKOLAH_KEPALA
		WHERE	ID_PEGAWAI	= old.ID_PEGAWAI
		AND		NO_SK 		= old.NO_SK
		AND		TANGGAL_SK	= old.TANGGAL_SK
		AND		TMT_SK 		= old.TMT_SK;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_RWYT_JABATAN_BIR;

delimiter $$

create trigger T_PEGAWAI_RWYT_JABATAN_BIR before insert
on T_PEGAWAI_RWYT_JABATAN for each row
begin
    DECLARE v_nip VARCHAR(18);
	DECLARE v_idp SMALLINT UNSIGNED;

	IF new.NIP IS NOT NULL THEN
		SELECT F_PEGAWAI_NIP(new.NIP) INTO v_idp;

		SET new.ID_PEGAWAI = v_idp;
	END IF;

	IF new.ID_PEGAWAI IS NOT NULL THEN
		SELECT	NIP
		INTO	v_nip
		FROM	T_PEGAWAI
		WHERE	ID_PEGAWAI = new.ID_PEGAWAI;

		SET new.NIP = v_nip;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_PEGAWAI_RWYT_PANGKAT_BIR;

delimiter $$

create trigger T_PEGAWAI_RWYT_PANGKAT_BIR before insert
on T_PEGAWAI_RWYT_PANGKAT for each row
begin
    DECLARE v_nip VARCHAR(18);
	DECLARE v_idp SMALLINT UNSIGNED;

	IF new.NIP IS NOT NULL THEN
		SELECT F_PEGAWAI_NIP(new.NIP) INTO v_idp;

		SET new.ID_PEGAWAI = v_idp;
	END IF;

	IF new.ID_PEGAWAI IS NOT NULL THEN
		SELECT	NIP
		INTO	v_nip
		FROM	T_PEGAWAI
		WHERE	ID_PEGAWAI = new.ID_PEGAWAI;

		SET new.NIP = v_nip;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_SEKOLAH_BANTUAN_BIR;

delimiter $$

create trigger T_SEKOLAH_BANTUAN_BIR before insert
on T_SEKOLAH_BANTUAN for each row
begin
    SET new.TAHUN_BANTUAN = YEAR(NOW());
end
$$

delimiter ;


drop trigger if exists T_SEKOLAH_BANTUAN_BUR;

delimiter $$

create trigger T_SEKOLAH_BANTUAN_BUR before update
on T_SEKOLAH_BANTUAN for each row
begin
    IF new.JUMLAH_DANA IS NULL THEN
        SET new.JUMLAH_DANA = old.JUMLAH_DANA;
    END IF;

    IF new.DANA_PENDAMPING IS NULL THEN
        SET new.DANA_PENDAMPING = old.DANA_PENDAMPING;
   END IF;
end
$$

delimiter ;


drop trigger if exists T_SEKOLAH_IDENTITAS_AIR;

delimiter $$

create trigger T_SEKOLAH_IDENTITAS_AIR after insert
on T_SEKOLAH_IDENTITAS for each row
begin
	DECLARE v_don INT;
	DECLARE v_thn CHAR(2);
	DECLARE v_jml TINYINT UNSIGNED;
	DECLARE v_skd VARCHAR(30);
	DECLARE v_tgd DATE;
	DECLARE v_kdd CHAR(1);
	DECLARE v_ska VARCHAR(30);
	DECLARE v_tga DATE;
	DECLARE v_skk VARCHAR(30);
	DECLARE v_tgk DATE;
	DECLARE v_skr VARCHAR(30);
	DECLARE v_tgr DATE;
	DECLARE v_akr CHAR(1);
	DECLARE v_ema VARCHAR(50);
	DECLARE v_web VARCHAR(50);
	DECLARE v_kll DECIMAL(18,2);
	DECLARE v_pgr DECIMAL(18,2);
	DECLARE v_bng DECIMAL(10,2);
	DECLARE v_abn DECIMAL(10,2);
	DECLARE v_buk SMALLINT UNSIGNED;
	DECLARE v_opr SMALLINT UNSIGNED;
	DECLARE v_ren SMALLINT UNSIGNED;
	DECLARE v_bjr DECIMAL(7,4);
	DECLARE v_ltg DECIMAL(7,4);
	DECLARE v_dts CHAR(10);
	DECLARE v_nmy VARCHAR(50);
	DECLARE v_kly CHAR(2);
	DECLARE v_akt VARCHAR(30);
	DECLARE v_tak DATE;
	DECLARE v_jly VARCHAR(50);
	DECLARE v_pro TINYINT UNSIGNED;
	DECLARE v_kab SMALLINT UNSIGNED;
	DECLARE v_kec SMALLINT UNSIGNED;
	DECLARE v_dsy VARCHAR(50);
	DECLARE v_tly VARCHAR(30);
	DECLARE v_nip VARCHAR(18);
	DECLARE v_nam VARCHAR(50);
	DECLARE v_skp VARCHAR(15);
	DECLARE v_tgp DATE;
	DECLARE v_tmt DATE;
	DECLARE v_sbl CHAR(1);
	DECLARE v_dyl CHAR(1);
	DECLARE v_vol CHAR(1);
	DECLARE v_nok VARCHAR(20);
	DECLARE v_kpk VARCHAR(25);
	DECLARE v_urt SMALLINT UNSIGNED;
	DECLARE v_cnt TINYINT UNSIGNED;
	DECLARE v_sld DECIMAL(18,2);
	DECLARE v_lkp CHAR(2);
	DECLARE v_mpl CHAR(5);
	DECLARE v_kel CHAR(2);
	DECLARE v_idp SMALLINT UNSIGNED;
	
	DECLARE c_lkp CURSOR FOR
		SELECT	kd_perlengkapan_sekolah
		FROM	r_perlengkapan_sekolah
		WHERE	kd_perlengkapan_sekolah < '15';
		
	DECLARE c_kbm CURSOR FOR
		SELECT	kd_perlengkapan_sekolah
		FROM	r_perlengkapan_sekolah
		WHERE	kd_perlengkapan_sekolah > '14';

	DECLARE c_mpl CURSOR FOR
		SELECT	kd_mata_pelajaran_diajarkan
		FROM	r_mata_pelajaran_diajarkan;

	DECLARE c_kel CURSOR FOR
		SELECT	kd_kel_mata_pelajaran
		FROM	r_kel_mata_pelajaran
		WHERE	kd_kel_mata_pelajaran IN ('01', '02', '03', '04', '11', '13', '15', '16', '19', '21', '22', '29', '30');

	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET v_don = 1;
	
	SELECT	IFNULL(MAX(KD_TAHUN_AJARAN),'XX')
	INTO	v_thn
	FROM	T_SEKOLAH_IDENTITAS
	WHERE	KD_TAHUN_AJARAN < new.KD_TAHUN_AJARAN;

	IF v_thn <> 'XX' THEN
		SELECT	COUNT(*)
		INTO	v_jml
		FROM	T_SEKOLAH_SK
		WHERE	KD_TAHUN_AJARAN = v_thn;
		
		IF v_jml > 0 THEN
			SELECT
				NO_SK_PENDIRIAN
			,	TANGGAL_SK_PENDIRIAN
			,	KD_KETERANGAN_SK
			,	NO_AKHIR_SK_STATUS
			,	TANGGAL_AKHIR_SK_STATUS
			,	NO_SK_AKREDITASI_AKHIR
			,	TANGGAL_SK_AKREDITASI_AKHIR
			,	KD_AKREDITASI
			INTO
				v_skd
			,	v_tgd
			,	v_kdd
			,	v_ska
			,	v_tga
			,	v_skk
			,	v_tgk
			,	v_skr
			,	v_tgr
			,	v_akr
			FROM	T_SEKOLAH_SK
			WHERE	KD_TAHUN_AJARAN = v_thn;

			INSERT INTO T_SEKOLAH_SK
            VALUES (
				new.KD_TAHUN_AJARAN
			,	v_skd
			,	v_tgd
			,	v_kdd
			,	v_ska
			,	v_tga
			,	v_skk
			,	v_tgk
			,	v_skr
			,	v_tgr
			,	v_akr
			,	new.USERNAME
			,	new.TANGGAL_AKSES);
		END IF;
		
		SELECT	COUNT(*)
		INTO	v_jml
		FROM	T_SEKOLAH_INFO
		WHERE	KD_TAHUN_AJARAN = v_thn;

		IF v_jml > 0 THEN
			SELECT
				EMAIL
			,	WEBSITE
			,	KELILING_TANAH
			,	DIPAGAR_PERMANEN
			,	LUAS_SIAP_BANGUN
			,	LUAS_ATAS_SIAP_BANGUN
			,	TAHUN_DIBUKA
			,	TAHUN_OPERASI
			,	TAHUN_AKHIR_RENOV
			,	BUJUR
			,	LINTANG
			INTO
				v_ema
			,	v_web
			,	v_kll
			, 	v_pgr
			, 	v_bng
			, 	v_abn
			, 	v_buk
			, 	v_opr
			,	v_ren
			, 	v_bjr
			, 	v_ltg
			FROM T_SEKOLAH_INFO
			WHERE KD_TAHUN_AJARAN = v_thn;
			
			INSERT INTO T_SEKOLAH_INFO
			VALUES (
				new.KD_TAHUN_AJARAN
			, 	v_ema
			,	v_web
			, 	v_kll
			, 	v_pgr
			, 	v_bng
			,	v_abn
			, 	v_buk
			, 	v_opr
			, 	v_ren
			,	v_bjr
			, 	v_ltg
			,	new.USERNAME
			, 	new.TANGGAL_AKSES);
		END IF;

		IF new.KD_STATUS_SEKOLAH = '2' THEN
			SELECT	COUNT(*)
			INTO	v_jml
			FROM	T_SEKOLAH_SK_SWASTA
			WHERE	KD_TAHUN_AJARAN = v_thn;
         
			IF v_jml > 0 THEN
				SELECT 
					KD_AKREDITASI
				, 	NO_DATA_SEKOLAH
				, 	NM_YAYASAN
				,	KD_KEL_YAYASAN
				,	NO_AKTE_YAYASAN
				,	TANGGAL_AKTE_YAYASAN
				, 	JALAN_YAYASAN
				, 	ID_PROPINSI
				,	ID_KABUPATEN
				,	ID_KECAMATAN
				,	KD_DESA_YAYASAN
				, 	NO_TELP
				INTO 
					v_akr
				, 	v_dts
				, 	v_nmy
				, 	v_kly
				, 	v_akt
				, 	v_tak
				, 	v_jly
				, 	v_pro
				, 	v_kab
				,	v_kec
				, 	v_dsy
				, 	v_tly
				FROM	T_SEKOLAH_SK_SWASTA
				WHERE	KD_TAHUN_AJARAN = v_thn;

				INSERT INTO T_SEKOLAH_SK_SWASTA
				VALUES (
					new.KD_TAHUN_AJARAN
				, 	v_akr
				, 	v_dts
				, 	v_kly
				, 	v_nmy
				, 	v_akt
				,	v_tak
				, 	v_jly
				, 	v_pro
				, 	v_kab
				, 	v_kec
				, 	v_dsy
				, 	v_tly
				, 	new.USERNAME
				,	new.TANGGAL_AKSES);
			END IF;
		END IF;
		
		SELECT	COUNT(*)
		INTO	v_jml
		FROM	T_SEKOLAH_KEPALA
		WHERE	KD_TAHUN_AJARAN = v_thn;

		IF v_jml > 0 THEN
			SELECT DISTINCT 
				ID_PEGAWAI
			,	NIP
			, 	NM_PEGAWAI
			, 	NO_SK
			, 	TANGGAL_SK
			, 	TMT_SK
			INTO
				v_idp
			,	v_nip
			, 	v_nam
			, 	v_skp
			, 	v_tgp
			, 	v_tmt
			FROM T_SEKOLAH_KEPALA
			WHERE TMT_SK =	( 
							SELECT	MAX(TMT_SK) AS tgl
							FROM	T_SEKOLAH_KEPALA
                            WHERE	KD_TAHUN_AJARAN = v_thn
							);
							
			INSERT INTO T_SEKOLAH_KEPALA
            VALUES (
				new.KD_TAHUN_AJARAN
			,	v_idp
			,	v_nip
			,	v_nam
			,	v_skp
			,	v_tgp
			,	v_tmt);
		END IF;
		
		SELECT	COUNT(*)
		INTO	v_jml
		FROM	T_SEKOLAH_PEMAKAIAN_LISTRIK
		WHERE	KD_TAHUN_AJARAN = v_thn;
		
		IF v_jml > 0 THEN
			SELECT	KD_SUMBER_LISTRIK
			, 		KD_DAYA_LISTRIK
			, 		KD_VOLTASE
			INTO 	v_sbl
			,		v_dyl
			,		v_vol
			FROM	T_SEKOLAH_PEMAKAIAN_LISTRIK
			WHERE	KD_TAHUN_AJARAN = v_thn;
			
			INSERT INTO T_SEKOLAH_PEMAKAIAN_LISTRIK
            VALUES(
				new.KD_TAHUN_AJARAN
			, 	v_sbl
			, 	v_dyl
			, 	v_vol
			, 	new.USERNAME
			,	new.TANGGAL_AKSES);
		END IF;
      
		CALL sp_insert_sekolah(v_thn, new.KD_TAHUN_AJARAN, new.USERNAME, new.TANGGAL_AKSES);
	END IF;
	
	SET v_don = 0;
	
	OPEN c_kel;
	
	REPEAT
		FETCH c_kel INTO v_kel;
      
		IF NOT v_don THEN
			INSERT INTO T_PEGAWAI_GURU_KEBUTUHAN
			VALUES(
				new.kd_tahun_ajaran
			,	v_kel
			, 	0
			, 	0
			, 	0
			,	'pas'
			,	NOW());
		END IF;
	UNTIL v_don END REPEAT;
	
	CLOSE c_kel;
	
	INSERT INTO k_sekolah_lism
	VALUES (
		new.KD_TAHUN_AJARAN
	,	0
	, 	0
	, 	0
	, 	0
	, 	0
	, 	0
	, 	0
	,	0
	, 	0
	, 	0
	, 	0
	, 	0
	, 	0
	, 	'pas'
	, 	NOW());

	INSERT INTO k_sekolah_passing_grade 
	VALUES(
		new.KD_TAHUN_AJARAN
	,	0
	,	0
	,	0
	,	0
	,	0
	,	0
	,	0
	,	0
	,	0
	,	0
	,	'pas'
	,	NOW());

	INSERT INTO t_sekolah_ancam_do VALUES(new.kd_tahun_ajaran, '01', 0, 'pas', NOW());
	INSERT INTO t_sekolah_ancam_do VALUES(new.kd_tahun_ajaran, '02', 0, 'pas', NOW());
	INSERT INTO t_sekolah_ancam_do VALUES(new.kd_tahun_ajaran, '03', 0, 'pas', NOW());
	
	INSERT INTO t_sekolah_do VALUES(new.kd_tahun_ajaran, 1, 2, 3, 4, 5, 6, 7, 8, 9, '', 'pas', NOW());
	
	INSERT INTO t_sekolah_jurusan VALUES(new.kd_tahun_ajaran, '01', '02', 'pas', NOW());
	INSERT INTO t_sekolah_jurusan VALUES(new.kd_tahun_ajaran, '02', '02', 'pas', NOW());
	INSERT INTO t_sekolah_jurusan VALUES(new.kd_tahun_ajaran, '03', '02', 'pas', NOW());
	
	SELECT	COUNT(*)
	INTO	v_cnt
	FROM	k_sekolah_keuangan;

	IF v_cnt = 0 THEN
		INSERT INTO k_sekolah_keuangan 
		VALUES (
			new.KD_TAHUN_AJARAN
		, 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		, 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		, 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		,	0, 0, 0, 0, 0, 0, 0, 0, 0, '0'
		,	'pas'
		,	NOW());
	ELSE
		SELECT	saldo_akhir
		INTO	v_sld
		FROM	k_sekolah_keuangan
		WHERE	kd_tahun_ajaran = (SELECT MAX(kd_tahun_ajaran) FROM k_sekolah_keuangan);
		
		INSERT INTO k_sekolah_keuangan 
		VALUES (
			new.KD_TAHUN_AJARAN
		, 	v_sld, 0, 0, 0, 0, 0, 0, 0, 0, 0
		, 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		, 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		,	0, 0, 0, 0, 0, 0, 0, 0, 0, '0'
		,	'pas'
		,	NOW());
	END IF;
	
	SELECT	COUNT(*)
	INTO 	v_cnt
	FROM 	t_sekolah_perlengkapan
	WHERE 	kd_tahun_ajaran = new.kd_tahun_ajaran;

	IF v_cnt = 0 THEN
		SET v_don = 0;
	  
		OPEN c_lkp;
	  
		REPEAT
			FETCH c_lkp INTO v_lkp;
		 
			IF NOT v_don THEN
				INSERT INTO t_sekolah_perlengkapan VALUES(new.kd_tahun_ajaran, v_lkp, 0, 'pas', NOW());
			END IF;
		UNTIL v_don END REPEAT;
		
		CLOSE c_lkp;
	  
		SET v_don = 0;
	  
		OPEN c_kbm;
	  
		REPEAT
			FETCH c_kbm INTO v_lkp;
		 
			IF NOT v_don THEN
				INSERT INTO t_sekolah_perlengkapan_kbm VALUES(new.kd_tahun_ajaran, v_lkp, 0, 'pas', NOW());
			END IF;
		UNTIL v_don END REPEAT;
		
		CLOSE c_kbm;
	  
		SET v_don = 0;
	  
		OPEN c_mpl;
	  
		REPEAT
			FETCH c_mpl INTO v_mpl;
		 
			IF NOT v_don THEN
				INSERT INTO t_sekolah_bualpen VALUES(new.kd_tahun_ajaran, v_mpl, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'pas', NOW());
			END IF;
		UNTIL v_don END REPEAT;
		
		CLOSE c_mpl;
		
		INSERT INTO t_sekolah_pemakaian_listrik VALUES (new.kd_tahun_ajaran, '1', '1', '1', 'pas', NOW());
	END IF;
end
$$

delimiter ;


drop trigger if exists T_SEKOLAH_IDENTITAS_BUR;

delimiter $$

create trigger T_SEKOLAH_IDENTITAS_BUR before update
on T_SEKOLAH_IDENTITAS for each row
begin
	DECLARE v_ubh TINYINT;
    DECLARE v_cnt TINYINT;

	IF ((new.KD_STATUS_SEKOLAH = old.KD_STATUS_SEKOLAH) OR (new.KD_STATUS_SEKOLAH = '1') AND (old.KD_STATUS_SEKOLAH = '2')) THEN
		SET v_ubh = 0;
	  
		IF old.NM_SEKOLAH <> new.NM_SEKOLAH THEN
			SET v_ubh = 1;
		END IF;

        IF old.NPSN <> new.NPSN THEN
            SET v_ubh = v_ubh + 10;
        END IF;

		IF old.KD_STATUS_SEKOLAH <> new.KD_STATUS_SEKOLAH THEN
			SET v_ubh = v_ubh + 100;
		 
			DELETE 
			FROM	T_SEKOLAH_SK_SWASTA
			WHERE	KD_TAHUN_AJARAN = old.KD_TAHUN_AJARAN;
		END IF;
	  
		IF old.JALAN <> new.JALAN THEN
			SET v_ubh = v_ubh + 1000;
		END IF;
	  
		IF old.ID_PROPINSI <> new.ID_PROPINSI THEN
			SET v_ubh = v_ubh + 10000;
		END IF;
	  
		IF old.ID_KABUPATEN <> new.ID_KABUPATEN THEN
			SET v_ubh = v_ubh + 100000;
		END IF;
	  
		IF old.ID_KECAMATAN <> new.ID_KECAMATAN THEN
			SET v_ubh = v_ubh + 1000000;
		END IF;
	  
		IF v_ubh > 0 THEN
            SELECT  COUNT(*)
            INTO    v_cnt
            FROM    T_SEKOLAH_BERUBAH
            WHERE   KD_TAHUN_AJARAN = new.KD_TAHUN_AJARAN;

            IF v_cnt = 0 THEN
    			INSERT INTO T_SEKOLAH_BERUBAH
    			VALUES(
    				new.KD_TAHUN_AJARAN
    			, 	old.NM_SEKOLAH
    			, 	old.NPSN
    			,	old.KD_STATUS_SEKOLAH
    			,	old.JALAN
    			, 	old.ID_PROPINSI
    			, 	old.ID_KABUPATEN
    			,	old.ID_KECAMATAN);
            ELSE
                IF v_ubh > 999999 THEN
                    UPDATE  T_SEKOLAH_BERUBAH
                    SET     ID_KECAMATAN    = old.ID_KECAMATAN
                    WHERE   KD_TAHUN_AJARAN = new.KD_TAHUN_AJARAN;

                    SET v_ubh = v_ubh - 1000000;
                END IF;

                IF v_ubh > 99999 THEN
                	UPDATE	T_SEKOLAH_BERUBAH
                	SET		ID_KABUPATEN 	= old.ID_KABUPATEN
                	WHERE	KD_TAHUN_AJARAN = new.KD_TAHUN_AJARAN;

                	SET v_ubh = v_ubh - 100000;
                END IF;

                IF v_ubh > 9999 THEN
                	UPDATE	T_SEKOLAH_BERUBAH
                	SET		ID_PROPINSI 	= old.ID_PROPINSI
                	WHERE	KD_TAHUN_AJARAN = new.KD_TAHUN_AJARAN;

                	SET v_ubh = v_ubh - 10000;
                END IF;

                IF v_ubh > 999 THEN
                	UPDATE	T_SEKOLAH_BERUBAH
                	SET		ALAMAT_LAMA 	= old.JALAN
                	WHERE	KD_TAHUN_AJARAN = new.KD_TAHUN_AJARAN;

                	SET v_ubh = v_ubh - 1000;
                END IF;

                IF v_ubh > 99 THEN
                	UPDATE 	T_SEKOLAH_BERUBAH
                	SET 	KD_STATUS_SEKOLAH	= old.KD_STATUS_SEKOLAH
                	WHERE 	KD_TAHUN_AJARAN		= new.KD_TAHUN_AJARAN;

                	SET v_ubh = v_ubh - 100;
                END IF;

                IF v_ubh > 9 THEN
                	UPDATE	T_SEKOLAH_BERUBAH
                	SET		NPSN_LAMA 		= old.NPSN
                	WHERE	KD_TAHUN_AJARAN = new.KD_TAHUN_AJARAN;

                	SET v_ubh = v_ubh - 10;
                END IF;

                IF v_ubh = 1 THEN
                	UPDATE	T_SEKOLAH_BERUBAH
                	SET 	NM_SEKOLAH_LAMA = old.NM_SEKOLAH
                	WHERE 	KD_TAHUN_AJARAN = new.KD_TAHUN_AJARAN;
                END IF;
            END IF;
		END IF;
	ELSE
        INSERT INTO __AUTH VALUES('ditpsmp');
	END IF;
end
$$

delimiter ;


drop trigger if exists T_SEKOLAH_PERLENGKAPAN_BUR;

delimiter $$

create trigger T_SEKOLAH_PERLENGKAPAN_BUR before update
on T_SEKOLAH_PERLENGKAPAN for each row
begin
    IF new.JUMLAH IS NULL THEN
        SET new.JUMLAH = old.JUMLAH;
    END IF;
end
$$

delimiter ;


drop trigger if exists T_SEKOLAH_PERLENGKAPAN_KBM_BUR;

delimiter $$

create trigger T_SEKOLAH_PERLENGKAPAN_KBM_BUR before update
on T_SEKOLAH_PERLENGKAPAN_KBM for each row
begin
    IF new.JUMLAH IS NULL THEN
        SET new.JUMLAH = old.JUMLAH;
    END IF;
end
$$

delimiter ;


drop trigger if exists T_SEKOLAH_PROPERTI_BUR;

delimiter $$

create trigger T_SEKOLAH_PROPERTI_BUR before update
on T_SEKOLAH_PROPERTI for each row
begin
    IF new.LUAS IS NULL THEN
        SET new.LUAS = old.LUAS;
    END IF;
end
$$

delimiter ;


drop trigger if exists T_SEKOLAH_RUANG_BUR;

delimiter $$

create trigger T_SEKOLAH_RUANG_BUR before update
on T_SEKOLAH_RUANG for each row
begin
    IF new.KAPASITAS IS NULL THEN
        SET new. KAPASITAS = old. KAPASITAS;
    END IF;

    IF new.PANJANG IS NULL THEN
        SET new.PANJANG = old.PANJANG;
    END IF;
   
    IF new.LEBAR IS NULL THEN
        SET new.LEBAR = old.LEBAR;
    END IF;

    IF new.LUAS IS NULL THEN
        SET new.LUAS = old.LUAS;
    END IF;
end
$$

delimiter ;


drop trigger if exists T_SEKOLAH_SALDO_AWAL_BIR;

delimiter $$

create trigger T_SEKOLAH_SALDO_AWAL_BIR before insert
on T_SEKOLAH_SALDO_AWAL for each row
begin
	DECLARE v__do INT DEFAULT 0;
	DECLARE v_sal DECIMAL(18,2);
	DECLARE v_trm DECIMAL(18,2);
	DECLARE v_klr DECIMAL(18,2);
	DECLARE v_sld DECIMAL(18,2);
	
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET v__do = 1;

	SELECT	COUNT(*)
	INTO	v__do
	FROM	T_SEKOLAH_IDENTITAS
	WHERE	KD_TAHUN_AJARAN = new.KD_TAHUN_AJARAN;

	IF v__do = 0 THEN
		INSERT INTO T_SEKOLAH_IDENTITAS
		SELECT
			new.KD_TAHUN_AJARAN
		,	NPSN
		,	KD_STATUS_SEKOLAH
		,	KD_BENTUK_SEKOLAH
		,	KD_JENIS_SEKOLAH
		,	NM_SEKOLAH
		,	JALAN
		,	KD_POS
		,	KD_DAERAH
		,	ID_PROPINSI
		,	ID_KABUPATEN
		,	ID_KECAMATAN
		,	KD_DESA
		,	KD_AREA
		,	NO_TELP
		,	NO_FAX
		,	JARAK_SKL_SJNS
		,	KD_WAKTU_PENYELENGGARAAN
		,	KD_TYPE_SEKOLAH
		,	KD_KLASIFIKASI_SEKOLAH
		,	KATEGORI
		,	KD_KLASIFIKASI_GEOGRAFIS
		,	new.USERNAME
		,	new.TANGGAL_AKSES
		FROM
			T_SEKOLAH_IDENTITAS
		WHERE
			KD_TAHUN_AJARAN	=	(
								SELECT	MAX(KD_TAHUN_AJARAN)
								FROM	T_SEKOLAH_IDENTITAS
								WHERE	KD_TAHUN_AJARAN < new.KD_TAHUN_AJARAN
								);
	END IF;
end
$$

delimiter ;


drop trigger if exists T_SISWA_AIR;

delimiter $$

create trigger T_SISWA_AIR after insert
on T_SISWA for each row
begin
	IF new.STATUS_ENTRI = '0' THEN
		IF new.STATUS_SISWA = '0' THEN
			INSERT INTO T_SISWA_TINGKAT_THN_BARU
			VALUES(
				new.ID_SISWA
			,	F_KD_TAHUN_AJARAN(new.DITERIMA_TANGGAL)
			,	new.KD_TINGKAT_KELAS
			,	NULL
			,	new.USERNAME
			,	new.TANGGAL_AKSES);
		ELSE
			INSERT INTO T_SISWA_TINGKAT_THN
			VALUES(
				new.ID_SISWA
			,	F_KD_TAHUN_AJARAN(new.DITERIMA_TANGGAL)
			,	new.KD_TINGKAT_KELAS
			,	NULL
			,	new.STATUS_SISWA
			,	new.USERNAME
			,	new.TANGGAL_AKSES);         
		END IF;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_SISWA_BDR;

delimiter $$

create trigger T_SISWA_BDR before delete
on T_SISWA for each row
begin
    DELETE FROM T_SISWA_TINGKAT_THN WHERE ID_SISWA = old.ID_SISWA;
    
    DELETE FROM T_SISWA_TINGKAT_THN_BARU WHERE ID_SISWA = old.ID_SISWA;
end
$$

delimiter ;


drop trigger if exists T_SISWA_BIR;

delimiter $$

create trigger T_SISWA_BIR before insert
on T_SISWA for each row
begin
	DECLARE v_smp SMALLINT UNSIGNED;
	DECLARE v_kab SMALLINT UNSIGNED;
	DECLARE v_asl SMALLINT UNSIGNED;

	IF new.DITERIMA_TANGGAL IS NULL OR new.DITERIMA_TANGGAL = '1818-09-09' THEN
		SET new.DITERIMA_TANGGAL = NOW();
	END IF;

	IF new.ASAL_SD IS NULL AND new.ASAL_SMP IS NULL AND new.KD_TINGKAT_KELAS = '01' THEN
		SET new.STATUS_SISWA = '0';
	ELSE
		IF new.ASAL_SD IS NOT NULL THEN
			SET new.STATUS_SISWA = '0';
		ELSE
			IF new.ASAL_SMP IS NULL THEN
				SET new.STATUS_SISWA = '2';
			ELSE
				SELECT	id_kabupaten
				INTO	v_smp
				FROM	T_SEKOLAH_IDENTITAS
				WHERE	KD_TAHUN_AJARAN = F_KD_TAHUN_AJARAN(new.DITERIMA_TANGGAL);
			
				SELECT	id_kabupaten
				INTO	v_kab
				FROM	R_SEKOLAH_SETINGKAT
				WHERE	ASAL_SMP = new.ASAL_SMP;
			
				IF v_smp = v_kab THEN
					SET new.STATUS_SISWA = '2';
				ELSE
					SET new.STATUS_SISWA = '3';
				END IF;
			END IF;
		END IF;
	END IF;

	IF new.STATUS_SISWA IS NULL THEN
		SET new.STATUS_SISWA = '0';
	END IF;

	IF new.KD_TINGKAT_KELAS IS NULL THEN
		SET new.KD_TINGKAT_KELAS = '01';
	END IF;

	IF new.NM_PANGGILAN IS NULL THEN
		SET new.NM_PANGGILAN = LEFT(new.NM_SISWA,20);
	END IF;

	IF new.NILAI IS NULL THEN
		SET new.NILAI = 0;
	END IF;

	IF new.ASAL_SD is null THEN
		SELECT	MIN(ASAL_SD)
		INTO	v_asl
		FROM	R_ASAL_SEKOLAH;

		set new.ASAL_SD = v_asl;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_SISWA_BUR;

delimiter $$

create trigger T_SISWA_BUR before update
on T_SISWA for each row
begin
	DECLARE v_jumlah TINYINT;
	DECLARE v_boolea TINYINT;
	DECLARE v_thnajr CHAR(2);
	DECLARE v_status CHAR(1);
	DECLARE v_usiaol CHAR(2);
	DECLARE v_asalol CHAR(2);
	DECLARE v_tahunx SMALLINT;
	DECLARE v_usiasw CHAR(2);
	DECLARE v_asalsk CHAR(2);

	IF old.STATUS_SISWA <> '6' THEN
		SELECT	COUNT(*)
		INTO	v_boolea
		FROM	T_SISWA_TINGKAT
		WHERE	ID_SISWA = old.ID_SISWA
		AND		KD_TAHUN_AJARAN	IN	(
									SELECT	MAX(KD_TAHUN_AJARAN)
									FROM	T_SISWA_TINGKAT
									WHERE	ID_SISWA = old.ID_SISWA
									);
	  
		IF v_boolea > 0 THEN
			SELECT	KD_TAHUN_AJARAN
			,		KD_USIA_SISWA
			,		KD_ASAL_SISWA
			INTO	v_thnajr
			,		v_usiaol
			,		v_asalol
			FROM	T_SISWA_TINGKAT
			WHERE	ID_SISWA = old.ID_SISWA
			AND		KD_TAHUN_AJARAN	IN	(
										SELECT	MAX(KD_TAHUN_AJARAN)
										FROM	T_SISWA_TINGKAT
										WHERE 	ID_SISWA = new.ID_SISWA
										);
		END IF;

		IF new.ID_SISWA <> old.ID_SISWA THEN
			IF v_thnajr IS NOT NULL THEN
				SET v_boolea = 0;
			END IF;

			IF v_boolea = 1 THEN
				SELECT	COUNT(*)
				INTO	v_jumlah
				FROM	T_SISWA_ORTU
				WHERE	ID_SISWA = old.ID_SISWA;
			
				IF v_jumlah > 0 THEN
					SET v_boolea = 0;
				END IF;
			END IF;

			IF v_boolea = 1 THEN
				SELECT	COUNT(*)
				INTO	v_jumlah
				FROM	T_SISWA_HOBI
				WHERE	ID_SISWA = old.ID_SISWA;
			 
				IF v_jumlah > 0 THEN
					SET v_boolea = 0;
				END IF;
			END IF;
		 
			IF v_boolea = 1 THEN
				SELECT	COUNT(*)
				INTO	v_jumlah
				FROM	T_SISWA_PUTUS
				WHERE	ID_SISWA = old.ID_SISWA;
				
				IF v_jumlah > 0 THEN
					SET v_boolea = 0;
				END IF;
			END IF;
		 
			IF v_boolea = 1 THEN
				SELECT	COUNT(*)
				INTO	v_jumlah
				FROM	T_SISWA_PINDAH
				WHERE	ID_SISWA = old.ID_SISWA;
				
				IF v_jumlah > 0 THEN
					SET v_boolea = 0;
				END IF;
			END IF;
		 
			IF v_boolea = 1 THEN
				SELECT	COUNT(*)
				INTO	v_jumlah
				FROM	T_SISWA_CUTI
				WHERE	ID_SISWA = old.ID_SISWA;
				
				IF v_jumlah > 0 THEN
					SET v_boolea = 0;
				END IF;
			END IF;
		 
			IF v_boolea = 1 THEN
				SELECT	COUNT(*)
				INTO	v_jumlah
				FROM	T_SISWA_ALUMNI
				WHERE	ID_SISWA = old.ID_SISWA;
				
				IF v_jumlah > 0 THEN
					SET v_boolea = 0;
				END IF;
			END IF;
		 
			IF v_boolea = 1 THEN
				SELECT	COUNT(*)
				INTO	v_jumlah
				FROM	T_SISWA_BEASISWA
				WHERE	ID_SISWA = old.ID_SISWA;
				
				IF v_jumlah > 0 THEN
					SET v_boolea = 0;
				END IF;
			END IF;
		END IF;
	  
		IF v_boolea = 1 THEN
			SELECT	COUNT(*)
			INTO	v_jumlah
			FROM	T_SISWA_TINGKAT_THN
			WHERE	ID_SISWA = old.ID_SISWA;
			 
			IF v_jumlah > 0 THEN
				UPDATE	T_SISWA_TINGKAT_THN
				SET		ID_SISWA 			= new.ID_SISWA
				,		KD_TAHUN_AJARAN 	= F_KD_TAHUN_AJARAN(new.DITERIMA_TANGGAL)
				,		KD_TINGKAT_KELAS 	= new.KD_TINGKAT_KELAS
				WHERE	ID_SISWA = old.ID_SISWA;
			END IF;
		ELSE
			SET new.ID_SISWA = old.ID_SISWA;

			UPDATE	T_SISWA_TINGKAT_THN
			SET		KD_TAHUN_AJARAN		= F_KD_TAHUN_AJARAN(new.DITERIMA_TANGGAL)
			,		KD_TINGKAT_KELAS 	= new.KD_TINGKAT_KELAS
			WHERE	ID_SISWA = old.ID_SISWA;
		END IF;
	  
		IF new.KD_GOL_DARAH IS NULL THEN
			SET new.KD_GOL_DARAH = old.KD_GOL_DARAH;
		END IF;
		  
		IF new.STATUS_SISWA IS NULL THEN
			SET new.STATUS_SISWA = old.STATUS_SISWA;
		END IF;
		  
		IF new.KD_TINGKAT_KELAS IS NULL THEN
			SET new.KD_TINGKAT_KELAS = old.KD_TINGKAT_KELAS;
		END IF;
		  
		IF new.DITERIMA_TANGGAL IS NULL THEN
			SET new.DITERIMA_TANGGAL = old.DITERIMA_TANGGAL;
		END IF;
		  
		IF new.NM_PANGGILAN IS NULL THEN
			SET new.NM_PANGGILAN = old.NM_PANGGILAN;
		END IF;
		  
		IF new.NILAI IS NULL THEN
			SET new.NILAI = old.NILAI;
		END IF;
	  
		IF old.STATUS_SISWA <> new.STATUS_SISWA THEN
			IF (( old.STATUS_SISWA <> '0' ) AND ( old.STATUS_SISWA <> '2' ) AND ( old.STATUS_SISWA <> '3' )) THEN
				CASE old.STATUS_SISWA
					WHEN '1' THEN
						DELETE FROM T_SISWA_PUTUS WHERE ID_SISWA = old.ID_SISWA;
					WHEN '4' THEN
						DELETE FROM T_SISWA_PINDAH WHERE ID_SISWA = old.ID_SISWA;
					WHEN '5' THEN
						DELETE FROM T_SISWA_CUTI WHERE ID_SISWA = old.ID_SISWA;
				END CASE;
			END IF;

			CASE new.STATUS_SISWA
				WHEN '0' THEN
					SET v_status = '0';
				WHEN '1' THEN
					SET v_status = '2';
				WHEN '2' THEN
					SET v_status = '3';
				WHEN '3' THEN
					SET v_status = '4';
				WHEN '4' THEN
					SET v_status = '5';
				WHEN '5' THEN
					SET v_status = '1';
				WHEN '6' THEN
					INSERT INTO T_SISWA_ALUMNI
					VALUES(old.ID_SISWA, old.NIS, YEAR(NOW()), NULL, NULL, NULL, NULL, NULL, new.USERNAME, new.TANGGAL_AKSES);
			END CASE;
			 
			IF new.STATUS_SISWA <> '6' THEN
				IF v_thnajr IS NOT NULL THEN
					UPDATE	T_SISWA_TINGKAT
					SET		KD_STATUS_SISWA = v_status
					WHERE	ID_SISWA 		= new.ID_SISWA
					AND		KD_TAHUN_AJARAN = v_thnajr;
				END IF;
			END IF;
		END IF;
	  
		IF old.KD_JENIS_KELAMIN <> new.KD_JENIS_KELAMIN THEN
			IF v_thnajr IS NOT NULL THEN
				UPDATE	T_SISWA_TINGKAT
				SET		KD_JENIS_KELAMIN 	= new.KD_JENIS_KELAMIN
				WHERE	ID_SISWA 			= new.ID_SISWA
				AND		KD_TAHUN_AJARAN 	= v_thnajr;
			END IF;
		END IF;
	  
		IF old.KD_AGAMA <> new.KD_AGAMA THEN
			IF v_thnajr IS NOT NULL THEN
				UPDATE	T_SISWA_TINGKAT
				SET		KD_AGAMA 		= new.KD_AGAMA
				WHERE	ID_SISWA 		= new.ID_SISWA
				AND		KD_TAHUN_AJARAN = v_thnajr;
			END IF;
		END IF;
	  
		IF old.TANGGAL_LAHIR <> new.TANGGAL_LAHIR THEN
			IF v_thnajr IS NOT NULL THEN
				SELECT	CAST(LEFT(NM_TAHUN_AJARAN,4) AS DECIMAL)
				INTO	v_tahunx
				FROM	R_TAHUN_AJARAN
				WHERE	KD_TAHUN_AJARAN = v_thnajr;
				
				SET v_usiasw = RIGHT('00'+CAST(v_tahunx-YEAR(new.TANGGAL_LAHIR) AS CHAR),2);
				
				IF v_usiaol <> v_usiasw THEN
					UPDATE	T_SISWA_TINGKAT
					SET		KD_USIA_SISWA 	= v_usiasw
					WHERE	ID_SISWA 		= new.ID_SISWA
					AND		KD_TAHUN_AJARAN	= v_thnajr;
				END IF;
			END IF;
		END IF;
	  
		IF old.ASAL_SD <> new.ASAL_SD THEN
			IF v_thnajr IS NOT NULL THEN
				SELECT	KD_JENIS_SEKOLAH
				INTO	v_asalsk
				FROM	R_ASAL_SEKOLAH
				WHERE	ASAL_SD = new.ASAL_SD;
				
				IF v_asalol <> v_asalsk THEN
					UPDATE	T_SISWA_TINGKAT
					SET		KD_ASAL_SISWA 	= v_asalsk
					WHERE	ID_SISWA 		= new.ID_SISWA
					AND		KD_TAHUN_AJARAN = v_thnajr;
				END IF;
			END IF;
		END IF;
	ELSE
		SET new.NIS = old.NIS;
		SET new.NM_SISWA = old.NM_SISWA;
		SET new.NM_PANGGILAN = old.NM_PANGGILAN;
		SET new.KD_JENIS_KELAMIN = old.KD_JENIS_KELAMIN;
		SET new.KOTA_LAHIR = old.KOTA_LAHIR;
		SET new.TANGGAL_LAHIR = old.TANGGAL_LAHIR;
		SET new.ALAMAT = old.ALAMAT;
		SET new.RT = old.RT;
		SET new.RW = old.RW;
		SET new.KD_POS = old.KD_POS;
		SET new.KD_GOL_DARAH = old.KD_GOL_DARAH;
		SET new.KD_AGAMA = old.KD_AGAMA;
		SET new.NO_TELP = old.NO_TELP;
		SET new.NO_HP = old.NO_HP;
		SET new.STATUS_SISWA = old.STATUS_SISWA;
		SET new.KD_TINGKAT_KELAS = old.KD_TINGKAT_KELAS;
		SET new.DITERIMA_TANGGAL = old.DITERIMA_TANGGAL;
		SET new.PINDAH_ALASAN = old.PINDAH_ALASAN;
		SET new.ASAL_SD = old.ASAL_SD;
		SET new.ASAL_SMP = old.ASAL_SMP;
		SET new.NILAI = old.NILAI;		
	END IF;
end
$$

delimiter ;


drop trigger if exists T_SISWA_ALUMNI_BIR;

delimiter $$

create trigger T_SISWA_ALUMNI_BIR before insert
on T_SISWA_ALUMNI for each row
begin
    DECLARE v_nis VARCHAR(25);
	DECLARE v_ids BIGINT UNSIGNED;

	IF new.NIS IS NOT NULL THEN
		SELECT F_SISWA_NIS(new.NIS) INTO v_ids;
	  
		SET new.ID_SISWA = v_ids;
	END IF;

	IF new.ID_SISWA IS NOT NULL THEN
		SELECT	NIS
		INTO	v_nis
		FROM	T_SISWA
		WHERE	ID_SISWA = new.ID_SISWA;
		
		SET new.NIS = v_nis;
	END IF;

    SET new.TAHUN_LULUS = YEAR(NOW());
end
$$

delimiter ;


drop trigger if exists T_SISWA_BEASISWA_BIR;

delimiter $$

create trigger T_SISWA_BEASISWA_BIR before insert
on T_SISWA_BEASISWA for each row
begin
    DECLARE v_nis VARCHAR(25);
	DECLARE v_ids BIGINT UNSIGNED;

	IF new.NIS IS NOT NULL THEN
		SELECT F_SISWA_NIS(new.NIS) INTO v_ids;
	  
		SET new.ID_SISWA = v_ids;
	END IF;

	IF new.ID_SISWA IS NOT NULL THEN
		SELECT	NIS
		INTO	v_nis
		FROM	T_SISWA
		WHERE	ID_SISWA = new.ID_SISWA;
		
		SET new.NIS = v_nis;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_SISWA_BEASISWA_BUR;

delimiter $$

create trigger T_SISWA_BEASISWA_BUR before update
on T_SISWA_BEASISWA for each row
begin
	IF new.JUMLAH_BEASISWA_PER_BULAN IS NULL THEN
		SET new.JUMLAH_BEASISWA_PER_BULAN = old.JUMLAH_BEASISWA_PER_BULAN;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_SISWA_CUTI_BDR;

delimiter $$

create trigger T_SISWA_CUTI_BDR before delete
on T_SISWA_CUTI for each row
begin
    UPDATE  T_SISWA
    SET     STATUS_SISWA = old.STATUS_ASAL
    WHERE   ID_SISWA = old.ID_SISWA;
end
$$

delimiter ;


drop trigger if exists T_SISWA_CUTI_BIR;

delimiter $$

create trigger T_SISWA_CUTI_BIR before insert
on T_SISWA_CUTI for each row
begin
    DECLARE v_sts CHAR(1);
    DECLARE v_nis VARCHAR(25);
	DECLARE v_ids BIGINT UNSIGNED;

	IF new.NIS IS NOT NULL THEN
		SELECT F_SISWA_NIS(new.NIS) INTO v_ids;
	  
		SET new.ID_SISWA = v_ids;
	END IF;

	IF new.ID_SISWA IS NOT NULL THEN
		SELECT	NIS
		INTO	v_nis
		FROM	T_SISWA
		WHERE	ID_SISWA = new.ID_SISWA;
		
		SET new.NIS = v_nis;
	END IF;
    
    SELECT  STATUS_SISWA
    INTO    v_sts
    FROM    T_SISWA
    WHERE   ID_SISWA = new.ID_SISWA;

    SET new.STATUS_ASAL = v_sts;

    UPDATE T_SISWA SET STATUS_SISWA = '5' WHERE ID_SISWA = new.ID_SISWA;
end
$$

delimiter ;


drop trigger if exists T_SISWA_HOBI_BIR;

delimiter $$

create trigger T_SISWA_HOBI_BIR before insert
on T_SISWA_HOBI for each row
begin
    DECLARE v_nis VARCHAR(25);
	DECLARE v_ids BIGINT UNSIGNED;

	IF new.NIS IS NOT NULL THEN
		SELECT F_SISWA_NIS(new.NIS) INTO v_ids;
	  
		SET new.ID_SISWA = v_ids;
	END IF;

	IF new.ID_SISWA IS NOT NULL THEN
		SELECT	NIS
		INTO	v_nis
		FROM	T_SISWA
		WHERE	ID_SISWA = new.ID_SISWA;
		
		SET new.NIS = v_nis;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_SISWA_INFO_BIR;

delimiter $$

create trigger T_SISWA_INFO_BIR before insert
on T_SISWA_INFO for each row
begin
    DECLARE v_nis VARCHAR(25);
	DECLARE v_ids BIGINT UNSIGNED;

	IF new.NIS IS NOT NULL THEN
		SELECT F_SISWA_NIS(new.NIS) INTO v_ids;
	  
		SET new.ID_SISWA = v_ids;
	END IF;

	IF new.ID_SISWA IS NOT NULL THEN
		SELECT	NIS
		INTO	v_nis
		FROM	T_SISWA
		WHERE	ID_SISWA = new.ID_SISWA;
		
		SET new.NIS = v_nis;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_SISWA_ORTU_BIR;

delimiter $$

create trigger T_SISWA_ORTU_BIR before insert
on T_SISWA_ORTU for each row
begin
    DECLARE v_nis VARCHAR(25);
	DECLARE v_ids BIGINT UNSIGNED;

	IF new.NIS IS NOT NULL THEN
		SELECT F_SISWA_NIS(new.NIS) INTO v_ids;
	  
		SET new.ID_SISWA = v_ids;
	END IF;

	IF new.ID_SISWA IS NOT NULL THEN
		SELECT	NIS
		INTO	v_nis
		FROM	T_SISWA
		WHERE	ID_SISWA = new.ID_SISWA;
		
		SET new.NIS = v_nis;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_SISWA_ORTU_BUR;

delimiter $$

create trigger T_SISWA_ORTU_BUR before update
on T_SISWA_ORTU for each row
begin
    IF new.GAJI IS NULL THEN
        SET new.GAJI = old.GAJI;
    END IF;

    IF new.STATUS_HIDUP IS NULL THEN
        SET new.STATUS_HIDUP = old.STATUS_HIDUP;
    END IF;
end
$$

delimiter ;


drop trigger if exists T_SISWA_PINDAH_BDR;

delimiter $$

create trigger T_SISWA_PINDAH_BDR before delete
on T_SISWA_PINDAH for each row
begin
    UPDATE  T_SISWA
    SET     STATUS_SISWA = old.STATUS_ASAL
    WHERE   ID_SISWA = old.ID_SISWA;
end
$$

delimiter ;


drop trigger if exists T_SISWA_PINDAH_BIR;

delimiter $$

create trigger T_SISWA_PINDAH_BIR before insert
on T_SISWA_PINDAH for each row
begin
    DECLARE v_sts CHAR(1);
    DECLARE v_nis VARCHAR(25);
	DECLARE v_ids BIGINT UNSIGNED;

	IF new.NIS IS NOT NULL THEN
		SELECT F_SISWA_NIS(new.NIS) INTO v_ids;
	  
		SET new.ID_SISWA = v_ids;
	END IF;

	IF new.ID_SISWA IS NOT NULL THEN
		SELECT	NIS
		INTO	v_nis
		FROM	T_SISWA
		WHERE	ID_SISWA = new.ID_SISWA;
		
		SET new.NIS = v_nis;
	END IF;
    
    SELECT  STATUS_SISWA
    INTO    v_sts
    FROM    T_SISWA
    WHERE   ID_SISWA = new.ID_SISWA;

    SET new.STATUS_ASAL = v_sts;

    UPDATE T_SISWA SET STATUS_SISWA = '4' WHERE ID_SISWA = new.ID_SISWA;
end
$$

delimiter ;


drop trigger if exists T_SISWA_PRESTASI_BIR;

delimiter $$

create trigger T_SISWA_PRESTASI_BIR before insert
on T_SISWA_PRESTASI for each row
begin
    DECLARE v_nis VARCHAR(25);
	DECLARE v_ids BIGINT UNSIGNED;

	IF new.NIS IS NOT NULL THEN
		SELECT F_SISWA_NIS(new.NIS) INTO v_ids;
	  
		SET new.ID_SISWA = v_ids;
	END IF;

	IF new.ID_SISWA IS NOT NULL THEN
		SELECT	NIS
		INTO	v_nis
		FROM	T_SISWA
		WHERE	ID_SISWA = new.ID_SISWA;
		
		SET new.NIS = v_nis;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_SISWA_PUTUS_BDR;

delimiter $$

create trigger T_SISWA_PUTUS_BDR before delete
on T_SISWA_PUTUS for each row
begin
    UPDATE  T_SISWA
    SET     STATUS_SISWA = old.STATUS_ASAL
    WHERE   ID_SISWA = old.ID_SISWA;
end
$$

delimiter ;


drop trigger if exists T_SISWA_PUTUS_BIR;

delimiter $$

create trigger T_SISWA_PUTUS_BIR before insert
on T_SISWA_PUTUS for each row
begin
    DECLARE v_sts CHAR(1);
    DECLARE v_nis VARCHAR(25);
	DECLARE v_ids BIGINT UNSIGNED;

	IF new.NIS IS NOT NULL THEN
		SELECT F_SISWA_NIS(new.NIS) INTO v_ids;
	  
		SET new.ID_SISWA = v_ids;
	END IF;

	IF new.ID_SISWA IS NOT NULL THEN
		SELECT	NIS
		INTO	v_nis
		FROM	T_SISWA
		WHERE	ID_SISWA = new.ID_SISWA;
		
		SET new.NIS = v_nis;
	END IF;
    
    SELECT  STATUS_SISWA
    INTO    v_sts
    FROM    T_SISWA
    WHERE   ID_SISWA = new.ID_SISWA;

    SET new.STATUS_ASAL = v_sts;

    UPDATE T_SISWA SET STATUS_SISWA = '1' WHERE ID_SISWA = new.ID_SISWA;
end
$$

delimiter ;


drop trigger if exists T_SISWA_RWYT_SAKIT_BIR;

delimiter $$

create trigger T_SISWA_RWYT_SAKIT_BIR before insert
on T_SISWA_RWYT_SAKIT for each row
begin
    DECLARE v_nis VARCHAR(25);
	DECLARE v_ids BIGINT UNSIGNED;

	IF new.NIS IS NOT NULL THEN
		SELECT F_SISWA_NIS(new.NIS) INTO v_ids;
	  
		SET new.ID_SISWA = v_ids;
	END IF;

	IF new.ID_SISWA IS NOT NULL THEN
		SELECT	NIS
		INTO	v_nis
		FROM	T_SISWA
		WHERE	ID_SISWA = new.ID_SISWA;
		
		SET new.NIS = v_nis;
	END IF;
end
$$

delimiter ;


drop trigger if exists T_SISWA_TINGKAT_BIR;

delimiter $$

create trigger T_SISWA_TINGKAT_BIR before insert
on T_SISWA_TINGKAT for each row
begin
	DECLARE v_nis VARCHAR(25);
	DECLARE v_ids BIGINT UNSIGNED;
	DECLARE v_ada TINYINT UNSIGNED;
	DECLARE v_sts CHAR(1);
	DECLARE v_sia DECIMAL;
	DECLARE v_agm CHAR(1);
	DECLARE v_klm CHAR(1);
	DECLARE v_asl CHAR(2);
	
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET v_sia = NULL;

	IF new.NIS IS NOT NULL THEN
		SELECT F_SISWA_NIS(new.NIS) INTO v_ids;
	  
		SET new.ID_SISWA = v_ids;
	END IF;

	IF new.ID_SISWA IS NOT NULL THEN
		SELECT	NIS
		INTO	v_nis
		FROM	T_SISWA
		WHERE	ID_SISWA = new.ID_SISWA;
	
		SET new.NIS = v_nis;
	END IF;

	SET v_sia = NULL;

	SELECT	'1'
	,		CAST(LEFT(C.NM_TAHUN_AJARAN,4) AS DECIMAL) - YEAR(B.TANGGAL_LAHIR)
	,		B.KD_AGAMA
	,		B.KD_JENIS_KELAMIN
	,		(
			SELECT	D.KD_JENIS_SEKOLAH
			FROM	R_ASAL_SEKOLAH D
			WHERE	D.ASAL_SD = B.ASAL_SD
			)
	INTO	v_sts
	,		v_sia
	,		v_agm
	,		v_klm
	,		v_asl
	FROM	T_SISWA_TINGKAT	AS A
	, 		T_SISWA 		AS B
	,		R_TAHUN_AJARAN	AS C
	WHERE	A.ID_SISWA 								= new.ID_SISWA
	AND		CAST(A.KD_TAHUN_AJARAN AS DECIMAL)+1	= CAST(new.KD_TAHUN_AJARAN AS DECIMAL)
	AND		A.KD_TINGKAT_KELAS 						= new.KD_TINGKAT_KELAS
	AND		B.ID_SISWA 								= A.ID_SISWA
	AND		C.KD_TAHUN_AJARAN 						= new.KD_TAHUN_AJARAN;

	IF v_sia IS NULL THEN
		SELECT	A.STATUS_SISWA
		,		CAST(LEFT(B.NM_TAHUN_AJARAN,4) AS DECIMAL) - YEAR(A.TANGGAL_LAHIR)
		,		A.KD_AGAMA
		,		A.KD_JENIS_KELAMIN
		,		(
				SELECT	D.KD_JENIS_SEKOLAH
				FROM	R_ASAL_SEKOLAH D
				WHERE	D.ASAL_SD = A.ASAL_SD
				)
		INTO	v_sts
		,		v_sia
		,		v_agm
		,		v_klm
		,		v_asl
		FROM	T_SISWA 		AS A
		,		R_TAHUN_AJARAN	AS B
		WHERE	A.ID_SISWA 			= new.ID_SISWA
		AND		B.KD_TAHUN_AJARAN 	= new.KD_TAHUN_AJARAN;
	  
		CASE v_sts
			WHEN '1' THEN
				SET v_sts = '2';
			WHEN '4' THEN
				SET v_sts = '5';
			WHEN '5' THEN
				SET v_sts = '1';
			ELSE IF v_sts = '2' OR v_sts = '3' THEN
				SELECT	COUNT(*)
				INTO	v_ada
				FROM	T_SISWA_TINGKAT
				WHERE	ID_SISWA = new.ID_SISWA;
			   
				IF v_ada = 0 THEN
					SET v_sts = LEFT(CAST((CAST(v_sts AS DECIMAL) + 1) AS CHAR),1);
				ELSE
					SET v_sts = '0';
				END IF;
			END IF;
		END CASE;
	END IF;

	IF v_sia > 12 AND v_sia < 22 THEN
		SET new.KD_USIA_SISWA = LEFT(CAST((v_sia + 1 ) AS CHAR),2);
	ELSE
		IF v_sia < 13 THEN
			SET new.KD_USIA_SISWA = '13';
		ELSE
			SET new.KD_USIA_SISWA = '23';
		END IF;
	END IF;

	SET new.KD_STATUS_SISWA = v_sts;

	SET new.KD_AGAMA = v_agm;

	SET new.KD_JENIS_KELAMIN = v_klm;

	SET new.KD_ASAL_SISWA = v_asl;

	SET new.KD_EBTA = '0';
end
$$

delimiter ;


drop trigger if exists T_SISWA_TINGKAT_BUR;

delimiter $$

create trigger T_SISWA_TINGKAT_BUR before update
on T_SISWA_TINGKAT for each row
begin
    IF new.KD_EBTA IS NULL THEN
        SET new.KD_EBTA = old.KD_EBTA;
    END IF;
end
$$

delimiter ;

