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

File		outputFile	= new File("C:\\06 - " + kd_tahun_ajaran + "_" + npsn + "_A_SEKOLAH_PEGAWAI_01.XML");
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
		+" 		SELECT		IFNULL(v_pegawai_status.KASEK_TTP_2_L,0) + IFNULL(v_pegawai_status.KASEK_TTP_3_L,0) +"
		+" 					IFNULL(v_pegawai_status.KASEK_TTP_4_L,0) + IFNULL(v_pegawai_status.KASEK_TTP_Y_L,0) + "
		+" 					IFNULL(v_pegawai_status.KASEK_TAKTTP_PNS_L,0) + IFNULL(v_pegawai_status.KASEK_TAKTTP_BPNS_L,0) +"
		+" 					IFNULL(v_pegawai_status.KASEK_TAKTTP_PST_L,0) + IFNULL(v_pegawai_status.KASEK_TAKTTP_DRH_L,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_status	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KPS_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_pegawai_status.KASEK_TTP_2_P,0) + IFNULL(v_pegawai_status.KASEK_TTP_3_P,0) +"
		+" 					IFNULL(v_pegawai_status.KASEK_TTP_4_P,0) + IFNULL(v_pegawai_status.KASEK_TTP_Y_P,0) + "
		+" 					IFNULL(v_pegawai_status.KASEK_TAKTTP_PNS_P,0) + IFNULL(v_pegawai_status.KASEK_TAKTTP_BPNS_P,0) +"
		+" 					IFNULL(v_pegawai_status.KASEK_TAKTTP_PST_P,0) + IFNULL(v_pegawai_status.KASEK_TAKTTP_DRH_P,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_status	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KPS_P"
		+" ,		0 AS KGOL_01_L"
		+" ,		0 AS KGOL_01_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_pegawai_status.KASEK_TTP_2_L,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KGOL_02_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_pegawai_status.KASEK_TTP_2_P,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_status	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KGOL_02_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_pegawai_status.KASEK_TTP_3_L,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_status	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KGOL_03_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_pegawai_status.KASEK_TTP_3_P,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_status	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KGOL_03_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_pegawai_status.KASEK_TTP_4_L,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_status	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KGOL_04_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_pegawai_status.KASEK_TTP_4_P,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_status	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KGOL_04_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_pegawai_status.KASEK_TTP_Y_L,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_status	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KGOL_05_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_pegawai_status.KASEK_TTP_Y_P,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_status	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KGOL_05_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_pegawai_status.KASEK_TAKTTP_PNS_L,0) + IFNULL(v_pegawai_status.KASEK_TAKTTP_BPNS_L,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_status	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KGOL_06_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_pegawai_status.KASEK_TAKTTP_PNS_P,0) + IFNULL(v_pegawai_status.KASEK_TAKTTP_BPNS_P,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_status	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KGOL_06_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_pegawai_status.KASEK_TAKTTP_PST_L,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KGOL_07_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_pegawai_status.KASEK_TAKTTP_PST_P,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_status	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KGOL_07_P"
		+" ,		("
		+" 		SELECT		IFNULL(v_pegawai_status.KASEK_TAKTTP_DRH_L,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_status	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KGOL_08_L"
		+" ,		("
		+" 		SELECT		IFNULL(v_pegawai_status.KASEK_TAKTTP_DRH_P,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_status	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KGOL_08_P"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND v_pegawai_detil.UMUR < 20"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KUMR_01_L"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND v_pegawai_detil.UMUR < 20"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KUMR_01_P"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.UMUR >= 20"
		+" 								AND	v_pegawai_detil.UMUR < 30"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KUMR_02_L"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.UMUR >= 20"
		+" 								AND	v_pegawai_detil.UMUR < 30"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KUMR_02_P"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.UMUR >= 30"
		+" 								AND	v_pegawai_detil.UMUR < 40"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KUMR_03_L"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.UMUR >= 30"
		+" 								AND	v_pegawai_detil.UMUR < 40"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KUMR_03_P"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.UMUR >= 40"
		+" 								AND	v_pegawai_detil.UMUR < 50"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KUMR_04_L"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.UMUR >= 40"
		+" 								AND	v_pegawai_detil.UMUR < 50"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KUMR_04_P"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.UMUR >= 50"
		+" 								AND	v_pegawai_detil.UMUR < 60"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KUMR_05_L"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.UMUR >= 50"
		+" 								AND	v_pegawai_detil.UMUR < 60"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KUMR_05_P"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.UMUR >= 60"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KUMR_06_L"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.UMUR >= 60"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KUMR_06_P"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 5"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KMSK_01_L"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 5"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KMSK_01_P"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 5"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 10"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KMSK_02_L"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 5"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 10"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KMSK_02_P"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 10"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 15"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KMSK_03_L"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 10"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 15"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KMSK_03_P"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 15"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 20"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KMSK_04_L"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 15"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 20"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil	ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KMSK_04_P"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 20"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 25"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KMSK_05_L"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 20"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL < 25"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KMSK_05_P"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 25"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '1',1,0)),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KMSK_06_L"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(	IF(	v_pegawai_detil.KD_JENIS_PEGAWAI IN ('15','20','21','22','23','24')"
		+" 								AND	v_pegawai_detil.MS_KRJ_AWAL >= 25"
		+" 								AND	v_pegawai_detil.KD_JNS_KELAMIN = '2',1,0)),0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN	v_pegawai_detil ON v_pegawai_detil.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KMSK_06_P"
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
		outFile.write("<KPS_L>" + rs.getString("KPS_L") + "</KPS_L>" + cLf);
		outFile.write("<KPS_P>" + rs.getString("KPS_P") + "</KPS_P>" + cLf);
		outFile.write("<KGOL_01_L>" + rs.getString("KGOL_01_L") + "</KGOL_01_L>" + cLf);
		outFile.write("<KGOL_01_P>" + rs.getString("KGOL_01_P") + "</KGOL_01_P>" + cLf);
		outFile.write("<KGOL_02_L>" + rs.getString("KGOL_02_L") + "</KGOL_02_L>" + cLf);
		outFile.write("<KGOL_02_P>" + rs.getString("KGOL_02_P") + "</KGOL_02_P>" + cLf);
		outFile.write("<KGOL_03_L>" + rs.getString("KGOL_03_L") + "</KGOL_03_L>" + cLf);
		outFile.write("<KGOL_03_P>" + rs.getString("KGOL_03_P") + "</KGOL_03_P>" + cLf);
		outFile.write("<KGOL_04_L>" + rs.getString("KGOL_04_L") + "</KGOL_04_L>" + cLf);
		outFile.write("<KGOL_04_P>" + rs.getString("KGOL_04_P") + "</KGOL_04_P>" + cLf);
		outFile.write("<KGOL_05_L>" + rs.getString("KGOL_05_L") + "</KGOL_05_L>" + cLf);
		outFile.write("<KGOL_05_P>" + rs.getString("KGOL_05_P") + "</KGOL_05_P>" + cLf);
		outFile.write("<KGOL_06_L>" + rs.getString("KGOL_06_L") + "</KGOL_06_L>" + cLf);
		outFile.write("<KGOL_06_P>" + rs.getString("KGOL_06_P") + "</KGOL_06_P>" + cLf);
		outFile.write("<KGOL_07_L>" + rs.getString("KGOL_07_L") + "</KGOL_07_L>" + cLf);
		outFile.write("<KGOL_07_P>" + rs.getString("KGOL_07_P") + "</KGOL_07_P>" + cLf);
		outFile.write("<KGOL_08_L>" + rs.getString("KGOL_08_L") + "</KGOL_08_L>" + cLf);
		outFile.write("<KGOL_08_P>" + rs.getString("KGOL_08_P") + "</KGOL_08_P>" + cLf);
		outFile.write("<KUMR_01_L>" + rs.getString("KUMR_01_L") + "</KUMR_01_L>" + cLf);
		outFile.write("<KUMR_01_P>" + rs.getString("KUMR_01_P") + "</KUMR_01_P>" + cLf);
		outFile.write("<KUMR_02_L>" + rs.getString("KUMR_02_L") + "</KUMR_02_L>" + cLf);
		outFile.write("<KUMR_02_P>" + rs.getString("KUMR_02_P") + "</KUMR_02_P>" + cLf);
		outFile.write("<KUMR_03_L>" + rs.getString("KUMR_03_L") + "</KUMR_03_L>" + cLf);
		outFile.write("<KUMR_03_P>" + rs.getString("KUMR_03_P") + "</KUMR_03_P>" + cLf);
		outFile.write("<KUMR_04_L>" + rs.getString("KUMR_04_L") + "</KUMR_04_L>" + cLf);
		outFile.write("<KUMR_04_P>" + rs.getString("KUMR_04_P") + "</KUMR_04_P>" + cLf);
		outFile.write("<KUMR_05_L>" + rs.getString("KUMR_05_L") + "</KUMR_05_L>" + cLf);
		outFile.write("<KUMR_05_P>" + rs.getString("KUMR_05_P") + "</KUMR_05_P>" + cLf);
		outFile.write("<KUMR_06_L>" + rs.getString("KUMR_06_L") + "</KUMR_06_L>" + cLf);
		outFile.write("<KUMR_06_P>" + rs.getString("KUMR_06_P") + "</KUMR_06_P>" + cLf);
		outFile.write("<KMSK_01_L>" + rs.getString("KMSK_01_L") + "</KMSK_01_L>" + cLf);
		outFile.write("<KMSK_01_P>" + rs.getString("KMSK_01_P") + "</KMSK_01_P>" + cLf);
		outFile.write("<KMSK_02_L>" + rs.getString("KMSK_02_L") + "</KMSK_02_L>" + cLf);
		outFile.write("<KMSK_02_P>" + rs.getString("KMSK_02_P") + "</KMSK_02_P>" + cLf);
		outFile.write("<KMSK_03_L>" + rs.getString("KMSK_03_L") + "</KMSK_03_L>" + cLf);
		outFile.write("<KMSK_03_P>" + rs.getString("KMSK_03_P") + "</KMSK_03_P>" + cLf);
		outFile.write("<KMSK_04_L>" + rs.getString("KMSK_04_L") + "</KMSK_04_L>" + cLf);
		outFile.write("<KMSK_04_P>" + rs.getString("KMSK_04_P") + "</KMSK_04_P>" + cLf);
		outFile.write("<KMSK_05_L>" + rs.getString("KMSK_05_L") + "</KMSK_05_L>" + cLf);
		outFile.write("<KMSK_05_P>" + rs.getString("KMSK_05_P") + "</KMSK_05_P>" + cLf);
		outFile.write("<KMSK_06_L>" + rs.getString("KMSK_06_L") + "</KMSK_06_L>" + cLf);
		outFile.write("<KMSK_06_P>" + rs.getString("KMSK_06_P") + "</KMSK_06_P>" + cLf);
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
