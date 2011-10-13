<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
String	kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");
String	npsn				= request.getParameter("npsn");
String	id_propinsi			= request.getParameter("id_propinsi");
String	id_kabupaten		= request.getParameter("id_kabupaten");
String	id_kecamatan		= request.getParameter("id_kecamatan");

String 	q	= "";
int		iLf	= 10;
char	cLf	= (char)iLf;

File		outputFile	= new File("C:\\05 - " + kd_tahun_ajaran + "_" + npsn + "_A_SEKOLAH_SISWA_03.XML");
outputFile.createNewFile();
FileWriter	outFile		= new FileWriter(outputFile);

outFile.write("<?xml version='1.0' encoding='UTF-8'?>" + cLf);
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	
	q	=" SELECT	KD_TAHUN_AJARAN"
		+" ,		ID_PROPINSI"
		+" ,		ID_KABUPATEN"
		+" ,		ID_KECAMATAN"
		+" ,		NPSN"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mengulang.U1L, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mengulang	ON v_siswa_jml_mengulang.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ULG_01_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mengulang.U1P, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mengulang	ON v_siswa_jml_mengulang.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ULG_01_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mengulang.U2L, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mengulang	ON v_siswa_jml_mengulang.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ULG_02_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mengulang.U2P, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mengulang	ON v_siswa_jml_mengulang.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ULG_02_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mengulang.U3L, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mengulang	ON v_siswa_jml_mengulang.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ULG_03_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mengulang.U3P, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mengulang	ON v_siswa_jml_mengulang.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ULG_03_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_putus_sekolah.U1L, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_putus_sekolah	ON v_siswa_jml_putus_sekolah.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PTS_01_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_putus_sekolah.U1P, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_putus_sekolah	ON v_siswa_jml_putus_sekolah.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PTS_01_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_putus_sekolah.U2L, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_putus_sekolah	ON v_siswa_jml_putus_sekolah.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PTS_02_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_putus_sekolah.U2P, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_putus_sekolah	ON v_siswa_jml_putus_sekolah.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PTS_02_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_putus_sekolah.U3L, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_putus_sekolah	ON v_siswa_jml_putus_sekolah.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PTS_03_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_putus_sekolah.U3P, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_putus_sekolah	ON v_siswa_jml_putus_sekolah.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PTS_03_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mutasi.KOTAINI_1L, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mutasi	ON v_siswa_jml_mutasi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS MTS_01_01_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mutasi.KOTAINI_1P, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mutasi	ON v_siswa_jml_mutasi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS MTS_01_01_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mutasi.KOTALAIN_1L, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mutasi	ON v_siswa_jml_mutasi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS MTS_01_02_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mutasi.KOTALAIN_1P, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mutasi	ON v_siswa_jml_mutasi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS MTS_01_02_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mutasi.KELUAR_1L, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mutasi	ON v_siswa_jml_mutasi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS MTS_01_03_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mutasi.KELUAR_1P, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mutasi	ON v_siswa_jml_mutasi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS MTS_01_03_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mutasi.KOTAINI_2L, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mutasi	ON v_siswa_jml_mutasi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS MTS_02_01_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mutasi.KOTAINI_2P, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mutasi	ON v_siswa_jml_mutasi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS MTS_02_01_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mutasi.KOTALAIN_2L, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mutasi	ON v_siswa_jml_mutasi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS MTS_02_02_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mutasi.KOTALAIN_2P, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mutasi	ON v_siswa_jml_mutasi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS MTS_02_02_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mutasi.KELUAR_2L, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mutasi	ON v_siswa_jml_mutasi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS MTS_02_03_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mutasi.KELUAR_2P, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mutasi	ON v_siswa_jml_mutasi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS MTS_02_03_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mutasi.KOTAINI_3L, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mutasi	ON v_siswa_jml_mutasi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS MTS_03_01_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mutasi.KOTAINI_3P, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mutasi	ON v_siswa_jml_mutasi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS MTS_03_01_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mutasi.KOTALAIN_3L, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mutasi	ON v_siswa_jml_mutasi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS MTS_03_02_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mutasi.KOTALAIN_3P, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mutasi	ON v_siswa_jml_mutasi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS MTS_03_02_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mutasi.KELUAR_3L, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mutasi	ON v_siswa_jml_mutasi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS MTS_03_03_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_siswa_jml_mutasi.KELUAR_3P, 0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_siswa_jml_mutasi	ON v_siswa_jml_mutasi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS MTS_03_03_P"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(k_sekolah_passing_grade.RENC_TERM), 0)"
		+" 		FROM	k_sekolah_passing_grade"
		+" 		WHERE	k_sekolah_passing_grade.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS RENC"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(k_sekolah_passing_grade.JML_DAFT_L), 0)"
		+" 		FROM	k_sekolah_passing_grade"
		+" 		WHERE	k_sekolah_passing_grade.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PEND_L"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(k_sekolah_passing_grade.JML_DAFT_P), 0)"
		+" 		FROM	k_sekolah_passing_grade"
		+" 		WHERE	k_sekolah_passing_grade.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PEND_P"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(k_sekolah_passing_grade.JML_TERM_SD_L), 0)"
		+" 		FROM	k_sekolah_passing_grade"
		+" 		WHERE	k_sekolah_passing_grade.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ASL_SD_L"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(k_sekolah_passing_grade.JML_TERM_SD_P), 0)"
		+" 		FROM	k_sekolah_passing_grade"
		+" 		WHERE	k_sekolah_passing_grade.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ASL_SD_P"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(k_sekolah_passing_grade.JML_TERM_MI_L), 0)"
		+" 		FROM	k_sekolah_passing_grade"
		+" 		WHERE	k_sekolah_passing_grade.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ASL_MI_L"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(k_sekolah_passing_grade.JML_TERM_MI_P), 0)"
		+" 		FROM	k_sekolah_passing_grade"
		+" 		WHERE	k_sekolah_passing_grade.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ASL_MI_P"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(k_sekolah_passing_grade.JML_TERM_PKT_L), 0)"
		+" 		FROM	k_sekolah_passing_grade"
		+" 		WHERE	k_sekolah_passing_grade.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ASL_PKT_L"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(k_sekolah_passing_grade.JML_TERM_PKT_P), 0)"
		+" 		FROM	k_sekolah_passing_grade"
		+" 		WHERE	k_sekolah_passing_grade.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ASL_PKT_P"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_siswa_tingkat"
		+" 		,		t_siswa"
		+" 		,		t_siswa_info"
		+" 		WHERE	t_siswa_tingkat.ID_SISWA			= t_siswa.ID_SISWA"
		+" 		AND		t_siswa_info.ID_SISWA				= t_siswa.ID_SISWA"
		+" 		AND		t_siswa.STATUS_SISWA				NOT IN ('1','4','6')"
		+" 		AND		t_siswa_tingkat.KD_TINGKAT_KELAS	= '01'"
		+" 		AND		t_siswa_tingkat.KD_JENIS_KELAMIN	= '1'"
		+" 		AND		t_siswa_info.KD_KETUNAAN			<> '00'"
		+" 		AND		t_siswa_tingkat.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) CAT_01_L"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_siswa_tingkat"
		+" 		,		t_siswa"
		+" 		,		t_siswa_info"
		+" 		WHERE	t_siswa_tingkat.ID_SISWA			= t_siswa.ID_SISWA"
		+" 		AND		t_siswa_info.ID_SISWA				= t_siswa.ID_SISWA"
		+" 		AND		t_siswa.STATUS_SISWA				NOT IN ('1','4','6')"
		+" 		AND		t_siswa_tingkat.KD_TINGKAT_KELAS	= '01'"
		+" 		AND		t_siswa_tingkat.KD_JENIS_KELAMIN	= '2'"
		+" 		AND		t_siswa_info.KD_KETUNAAN			<> '00'"
		+" 		AND		t_siswa_tingkat.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) CAT_01_P"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_siswa_tingkat"
		+" 		,		t_siswa"
		+" 		,		t_siswa_info"
		+" 		WHERE	t_siswa_tingkat.ID_SISWA			= t_siswa.ID_SISWA"
		+" 		AND		t_siswa_info.ID_SISWA				= t_siswa.ID_SISWA"
		+" 		AND		t_siswa.STATUS_SISWA				NOT IN ('1','4','6')"
		+" 		AND		t_siswa_tingkat.KD_TINGKAT_KELAS	= '02'"
		+" 		AND		t_siswa_tingkat.KD_JENIS_KELAMIN	= '1'"
		+" 		AND		t_siswa_info.KD_KETUNAAN			<> '00'"
		+" 		AND		t_siswa_tingkat.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) CAT_02_L"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_siswa_tingkat"
		+" 		,		t_siswa"
		+" 		,		t_siswa_info"
		+" 		WHERE	t_siswa_tingkat.ID_SISWA			= t_siswa.ID_SISWA"
		+" 		AND		t_siswa_info.ID_SISWA				= t_siswa.ID_SISWA"
		+" 		AND		t_siswa.STATUS_SISWA				NOT IN ('1','4','6')"
		+" 		AND		t_siswa_tingkat.KD_TINGKAT_KELAS	= '02'"
		+" 		AND		t_siswa_tingkat.KD_JENIS_KELAMIN	= '2'"
		+" 		AND		t_siswa_info.KD_KETUNAAN			<> '00'"
		+" 		AND		t_siswa_tingkat.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) CAT_02_P"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_siswa_tingkat"
		+" 		,		t_siswa"
		+" 		,		t_siswa_info"
		+" 		WHERE	t_siswa_tingkat.ID_SISWA			= t_siswa.ID_SISWA"
		+" 		AND		t_siswa_info.ID_SISWA				= t_siswa.ID_SISWA"
		+" 		AND		t_siswa.STATUS_SISWA				NOT IN ('1','4','6')"
		+" 		AND		t_siswa_tingkat.KD_TINGKAT_KELAS	= '03'"
		+" 		AND		t_siswa_tingkat.KD_JENIS_KELAMIN	= '1'"
		+" 		AND		t_siswa_info.KD_KETUNAAN			<> '00'"
		+" 		AND		t_siswa_tingkat.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) CAT_03_L"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_siswa_tingkat"
		+" 		,		t_siswa"
		+" 		,		t_siswa_info"
		+" 		WHERE	t_siswa_tingkat.ID_SISWA			= t_siswa.ID_SISWA"
		+" 		AND		t_siswa_info.ID_SISWA				= t_siswa.ID_SISWA"
		+" 		AND		t_siswa.STATUS_SISWA				NOT IN ('1','4','6')"
		+" 		AND		t_siswa_tingkat.KD_TINGKAT_KELAS	= '03'"
		+" 		AND		t_siswa_tingkat.KD_JENIS_KELAMIN	= '2'"
		+" 		AND		t_siswa_info.KD_KETUNAAN			<> '00'"
		+" 		AND		t_siswa_tingkat.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) CAT_03_P"
		+" FROM	t_sekolah_identitas"
		+" WHERE	KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'";
	
	ResultSet	rs	= db_stmt.executeQuery(q);

	outFile.write("<DATA>" + cLf);
	
	while (rs.next()){
		outFile.write("<DATA_ROW>" + cLf);
		outFile.write("<KD_TAHUN_AJARAN>" + rs.getString("KD_TAHUN_AJARAN") + "</KD_TAHUN_AJARAN>" + cLf);
		outFile.write("<ID_PROPINSI>" + rs.getString("ID_PROPINSI") + "</ID_PROPINSI>" + cLf);
		outFile.write("<ID_KABUPATEN>" + rs.getString("ID_KABUPATEN") + "</ID_KABUPATEN>" + cLf);
		outFile.write("<ID_KECAMATAN>" + rs.getString("ID_KECAMATAN") + "</ID_KECAMATAN>" + cLf);
		outFile.write("<NPSN>" + rs.getString("NPSN") + "</NPSN>" + cLf);
		outFile.write("<ULG_01_L>" + rs.getString("ULG_01_L") + "</ULG_01_L>" + cLf);
		outFile.write("<ULG_01_P>" + rs.getString("ULG_01_P") + "</ULG_01_P>" + cLf);
		outFile.write("<ULG_02_L>" + rs.getString("ULG_02_L") + "</ULG_02_L>" + cLf);
		outFile.write("<ULG_02_P>" + rs.getString("ULG_02_P") + "</ULG_02_P>" + cLf);
		outFile.write("<ULG_03_L>" + rs.getString("ULG_03_L") + "</ULG_03_L>" + cLf);
		outFile.write("<ULG_03_P>" + rs.getString("ULG_03_P") + "</ULG_03_P>" + cLf);
		outFile.write("<PTS_01_L>" + rs.getString("PTS_01_L") + "</PTS_01_L>" + cLf);
		outFile.write("<PTS_01_P>" + rs.getString("PTS_01_P") + "</PTS_01_P>" + cLf);
		outFile.write("<PTS_02_L>" + rs.getString("PTS_02_L") + "</PTS_02_L>" + cLf);
		outFile.write("<PTS_02_P>" + rs.getString("PTS_02_P") + "</PTS_02_P>" + cLf);
		outFile.write("<PTS_03_L>" + rs.getString("PTS_03_L") + "</PTS_03_L>" + cLf);
		outFile.write("<PTS_03_P>" + rs.getString("PTS_03_P") + "</PTS_03_P>" + cLf);
		outFile.write("<MTS_01_01_L>" + rs.getString("MTS_01_01_L") + "</MTS_01_01_L>" + cLf);
		outFile.write("<MTS_01_01_P>" + rs.getString("MTS_01_01_P") + "</MTS_01_01_P>" + cLf);
		outFile.write("<MTS_01_02_L>" + rs.getString("MTS_01_02_L") + "</MTS_01_02_L>" + cLf);
		outFile.write("<MTS_01_02_P>" + rs.getString("MTS_01_02_P") + "</MTS_01_02_P>" + cLf);
		outFile.write("<MTS_01_03_L>" + rs.getString("MTS_01_03_L") + "</MTS_01_03_L>" + cLf);
		outFile.write("<MTS_01_03_P>" + rs.getString("MTS_01_03_P") + "</MTS_01_03_P>" + cLf);
		outFile.write("<MTS_02_01_L>" + rs.getString("MTS_02_01_L") + "</MTS_02_01_L>" + cLf);
		outFile.write("<MTS_02_01_P>" + rs.getString("MTS_02_01_P") + "</MTS_02_01_P>" + cLf);
		outFile.write("<MTS_02_02_L>" + rs.getString("MTS_02_02_L") + "</MTS_02_02_L>" + cLf);
		outFile.write("<MTS_02_02_P>" + rs.getString("MTS_02_02_P") + "</MTS_02_02_P>" + cLf);
		outFile.write("<MTS_02_03_L>" + rs.getString("MTS_02_03_L") + "</MTS_02_03_L>" + cLf);
		outFile.write("<MTS_02_03_P>" + rs.getString("MTS_02_03_P") + "</MTS_02_03_P>" + cLf);
		outFile.write("<RENC>" + rs.getString("RENC") + "</RENC>" + cLf);
		outFile.write("<PEND_L>" + rs.getString("PEND_L") + "</PEND_L>" + cLf);
		outFile.write("<PEND_P>" + rs.getString("PEND_P") + "</PEND_P>" + cLf);
		outFile.write("<ASL_SD_L>" + rs.getString("ASL_SD_L") + "</ASL_SD_L>" + cLf);
		outFile.write("<ASL_SD_P>" + rs.getString("ASL_SD_P") + "</ASL_SD_P>" + cLf);
		outFile.write("<ASL_MI_L>" + rs.getString("ASL_MI_L") + "</ASL_MI_L>" + cLf);
		outFile.write("<ASL_MI_P>" + rs.getString("ASL_MI_P") + "</ASL_MI_P>" + cLf);
		outFile.write("<ASL_PKT_L>" + rs.getString("ASL_PKT_L") + "</ASL_PKT_L>" + cLf);
		outFile.write("<ASL_PKT_P>" + rs.getString("ASL_PKT_P") + "</ASL_PKT_P>" + cLf);
		outFile.write("<CAT_01_L>" + rs.getString("CAT_01_L") + "</CAT_01_L>" + cLf);
		outFile.write("<CAT_01_P>" + rs.getString("CAT_01_P") + "</CAT_01_P>" + cLf);
		outFile.write("<CAT_02_L>" + rs.getString("CAT_02_L") + "</CAT_02_L>" + cLf);
		outFile.write("<CAT_02_P>" + rs.getString("CAT_02_P") + "</CAT_02_P>" + cLf);
		outFile.write("<CAT_03_L>" + rs.getString("CAT_03_L") + "</CAT_03_L>" + cLf);
		outFile.write("<CAT_03_P>" + rs.getString("CAT_03_P") + "</CAT_03_P>" + cLf);
		outFile.write("</DATA_ROW>" + cLf);
	}	
	
	outFile.write("</DATA>" + cLf);
	
	rs.close();
	outFile.close();
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
	outFile.close();
}
%>
