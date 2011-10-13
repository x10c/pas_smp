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

File		outputFile	= new File("C:\\21 - " + kd_tahun_ajaran + "_" + npsn + "_A_SEKOLAH_FASILITAS_03.XML");
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
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '11'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_11_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '11'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_11_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '11'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_11_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '11'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_11_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '11'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_11_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '11'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_11_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '12'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_12_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '12'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_12_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '12'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_12_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '12'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_12_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '12'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_12_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '12'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_12_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '13'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_13_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '13'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_13_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '13'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_13_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '13'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_13_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '13'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_13_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '13'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_13_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '14'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_14_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '14'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_14_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '14'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_14_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '14'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_14_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '14'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_14_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '14'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_14_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '15'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_15_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '15'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_15_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '15'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_15_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '15'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_15_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '15'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_15_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '15'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_15_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '16'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_16_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '16'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_16_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '16'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_16_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '16'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_16_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '16'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_16_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '16'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_16_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '17'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_17_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '17'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_17_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '17'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_17_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '17'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_17_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '17'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_17_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '17'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_17_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '18'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_18_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '18'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_18_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '18'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_18_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '18'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_18_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '18'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_18_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '18'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_18_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '19'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_19_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '19'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_19_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '19'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_19_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '19'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_19_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '19'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_19_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '19'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_19_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '20'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_20_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '20'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_20_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '20'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_20_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '20'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_20_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '20'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_20_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '20'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_20_02"
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
		outFile.write("<JRG_11_01_01>" + rs.getString("JRG_11_01_01") + "</JRG_11_01_01>" + cLf);
		outFile.write("<JRG_11_01_02>" + rs.getString("JRG_11_01_02") + "</JRG_11_01_02>" + cLf);
		outFile.write("<JRG_11_01_03>" + rs.getString("JRG_11_01_03") + "</JRG_11_01_03>" + cLf);
		outFile.write("<JRG_11_01_04>" + rs.getString("JRG_11_01_04") + "</JRG_11_01_04>" + cLf);
		outFile.write("<JRG_11_01_05>" + rs.getString("JRG_11_01_05") + "</JRG_11_01_05>" + cLf);
		outFile.write("<JRG_11_02>"    + rs.getString("JRG_11_02")    + "</JRG_11_02>"    + cLf);
		outFile.write("<JRG_12_01_01>" + rs.getString("JRG_12_01_01") + "</JRG_12_01_01>" + cLf);
		outFile.write("<JRG_12_01_02>" + rs.getString("JRG_12_01_02") + "</JRG_12_01_02>" + cLf);
		outFile.write("<JRG_12_01_03>" + rs.getString("JRG_12_01_03") + "</JRG_12_01_03>" + cLf);
		outFile.write("<JRG_12_01_04>" + rs.getString("JRG_12_01_04") + "</JRG_12_01_04>" + cLf);
		outFile.write("<JRG_12_01_05>" + rs.getString("JRG_12_01_05") + "</JRG_12_01_05>" + cLf);
		outFile.write("<JRG_12_02>"    + rs.getString("JRG_12_02")    + "</JRG_12_02>"    + cLf);
		outFile.write("<JRG_13_01_01>" + rs.getString("JRG_13_01_01") + "</JRG_13_01_01>" + cLf);
		outFile.write("<JRG_13_01_02>" + rs.getString("JRG_13_01_02") + "</JRG_13_01_02>" + cLf);
		outFile.write("<JRG_13_01_03>" + rs.getString("JRG_13_01_03") + "</JRG_13_01_03>" + cLf);
		outFile.write("<JRG_13_01_04>" + rs.getString("JRG_13_01_04") + "</JRG_13_01_04>" + cLf);
		outFile.write("<JRG_13_01_05>" + rs.getString("JRG_13_01_05") + "</JRG_13_01_05>" + cLf);
		outFile.write("<JRG_13_02>"    + rs.getString("JRG_13_02")    + "</JRG_13_02>"    + cLf);
		outFile.write("<JRG_14_01_01>" + rs.getString("JRG_14_01_01") + "</JRG_14_01_01>" + cLf);
		outFile.write("<JRG_14_01_02>" + rs.getString("JRG_14_01_02") + "</JRG_14_01_02>" + cLf);
		outFile.write("<JRG_14_01_03>" + rs.getString("JRG_14_01_03") + "</JRG_14_01_03>" + cLf);
		outFile.write("<JRG_14_01_04>" + rs.getString("JRG_14_01_04") + "</JRG_14_01_04>" + cLf);
		outFile.write("<JRG_14_01_05>" + rs.getString("JRG_14_01_05") + "</JRG_14_01_05>" + cLf);
		outFile.write("<JRG_14_02>"    + rs.getString("JRG_14_02")    + "</JRG_14_02>"    + cLf);
		outFile.write("<JRG_15_01_01>" + rs.getString("JRG_15_01_01") + "</JRG_15_01_01>" + cLf);
		outFile.write("<JRG_15_01_02>" + rs.getString("JRG_15_01_02") + "</JRG_15_01_02>" + cLf);
		outFile.write("<JRG_15_01_03>" + rs.getString("JRG_15_01_03") + "</JRG_15_01_03>" + cLf);
		outFile.write("<JRG_15_01_04>" + rs.getString("JRG_15_01_04") + "</JRG_15_01_04>" + cLf);
		outFile.write("<JRG_15_01_05>" + rs.getString("JRG_15_01_05") + "</JRG_15_01_05>" + cLf);
		outFile.write("<JRG_15_02>"    + rs.getString("JRG_15_02")    + "</JRG_15_02>"    + cLf);
		outFile.write("<JRG_16_01_01>" + rs.getString("JRG_16_01_01") + "</JRG_16_01_01>" + cLf);
		outFile.write("<JRG_16_01_02>" + rs.getString("JRG_16_01_02") + "</JRG_16_01_02>" + cLf);
		outFile.write("<JRG_16_01_03>" + rs.getString("JRG_16_01_03") + "</JRG_16_01_03>" + cLf);
		outFile.write("<JRG_16_01_04>" + rs.getString("JRG_16_01_04") + "</JRG_16_01_04>" + cLf);
		outFile.write("<JRG_16_01_05>" + rs.getString("JRG_16_01_05") + "</JRG_16_01_05>" + cLf);
		outFile.write("<JRG_16_02>"    + rs.getString("JRG_16_02")    + "</JRG_16_02>"    + cLf);
		outFile.write("<JRG_17_01_01>" + rs.getString("JRG_17_01_01") + "</JRG_17_01_01>" + cLf);
		outFile.write("<JRG_17_01_02>" + rs.getString("JRG_17_01_02") + "</JRG_17_01_02>" + cLf);
		outFile.write("<JRG_17_01_03>" + rs.getString("JRG_17_01_03") + "</JRG_17_01_03>" + cLf);
		outFile.write("<JRG_17_01_04>" + rs.getString("JRG_17_01_04") + "</JRG_17_01_04>" + cLf);
		outFile.write("<JRG_17_01_05>" + rs.getString("JRG_17_01_05") + "</JRG_17_01_05>" + cLf);
		outFile.write("<JRG_17_02>"    + rs.getString("JRG_17_02")    + "</JRG_17_02>"    + cLf);
		outFile.write("<JRG_18_01_01>" + rs.getString("JRG_18_01_01") + "</JRG_18_01_01>" + cLf);
		outFile.write("<JRG_18_01_02>" + rs.getString("JRG_18_01_02") + "</JRG_18_01_02>" + cLf);
		outFile.write("<JRG_18_01_03>" + rs.getString("JRG_18_01_03") + "</JRG_18_01_03>" + cLf);
		outFile.write("<JRG_18_01_04>" + rs.getString("JRG_18_01_04") + "</JRG_18_01_04>" + cLf);
		outFile.write("<JRG_18_01_05>" + rs.getString("JRG_18_01_05") + "</JRG_18_01_05>" + cLf);
		outFile.write("<JRG_18_02>"    + rs.getString("JRG_18_02")    + "</JRG_18_02>"    + cLf);
		outFile.write("<JRG_19_01_01>" + rs.getString("JRG_19_01_01") + "</JRG_19_01_01>" + cLf);
		outFile.write("<JRG_19_01_02>" + rs.getString("JRG_19_01_02") + "</JRG_19_01_02>" + cLf);
		outFile.write("<JRG_19_01_03>" + rs.getString("JRG_19_01_03") + "</JRG_19_01_03>" + cLf);
		outFile.write("<JRG_19_01_04>" + rs.getString("JRG_19_01_04") + "</JRG_19_01_04>" + cLf);
		outFile.write("<JRG_19_01_05>" + rs.getString("JRG_19_01_05") + "</JRG_19_01_05>" + cLf);
		outFile.write("<JRG_19_02>"    + rs.getString("JRG_19_02")    + "</JRG_19_02>"    + cLf);
		outFile.write("<JRG_20_01_01>" + rs.getString("JRG_20_01_01") + "</JRG_20_01_01>" + cLf);
		outFile.write("<JRG_20_01_02>" + rs.getString("JRG_20_01_02") + "</JRG_20_01_02>" + cLf);
		outFile.write("<JRG_20_01_03>" + rs.getString("JRG_20_01_03") + "</JRG_20_01_03>" + cLf);
		outFile.write("<JRG_20_01_04>" + rs.getString("JRG_20_01_04") + "</JRG_20_01_04>" + cLf);
		outFile.write("<JRG_20_01_05>" + rs.getString("JRG_20_01_05") + "</JRG_20_01_05>" + cLf);
		outFile.write("<JRG_20_02>"    + rs.getString("JRG_20_02")    + "</JRG_20_02>"    + cLf);
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
