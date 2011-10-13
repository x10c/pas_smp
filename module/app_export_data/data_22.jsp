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

File		outputFile	= new File("C:\\22 - " + kd_tahun_ajaran + "_" + npsn + "_A_SEKOLAH_FASILITAS_04.XML");
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
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '21'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_21_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '21'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_21_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '21'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_21_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '21'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_21_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '21'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_21_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '21'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_21_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '22'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_22_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '22'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_22_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '22'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_22_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '22'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_22_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '22'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_22_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '22'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_22_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '23'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_23_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '23'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_23_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '23'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_23_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '23'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_23_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '23'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_23_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '23'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_23_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '24'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_24_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '24'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_24_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '24'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_24_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '24'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_24_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '24'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_24_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '24'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_24_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '25'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_25_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '25'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_25_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '25'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_25_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '25'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_25_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '25'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_25_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '25'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_25_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '26'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_26_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '26'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_26_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '26'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_26_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '26'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_26_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '26'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_26_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '26'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_26_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '27'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_27_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '27'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_27_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '27'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_27_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '27'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_27_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '27'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_27_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '27'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_27_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '28'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_28_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '28'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_28_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '28'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_28_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '28'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_28_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '28'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_28_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '28'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_28_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '29'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_29_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '29'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_29_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '29'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_29_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '29'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_29_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '29'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_29_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '29'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_29_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '30'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_30_01_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '30'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_30_01_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '30'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_30_01_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '30'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_30_01_04"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '30'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_30_01_05"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '30'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JRG_30_02"
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
		outFile.write("<JRG_21_01_01>" + rs.getString("JRG_21_01_01") + "</JRG_21_01_01>" + cLf);
		outFile.write("<JRG_21_01_02>" + rs.getString("JRG_21_01_02") + "</JRG_21_01_02>" + cLf);
		outFile.write("<JRG_21_01_03>" + rs.getString("JRG_21_01_03") + "</JRG_21_01_03>" + cLf);
		outFile.write("<JRG_21_01_04>" + rs.getString("JRG_21_01_04") + "</JRG_21_01_04>" + cLf);
		outFile.write("<JRG_21_01_05>" + rs.getString("JRG_21_01_05") + "</JRG_21_01_05>" + cLf);
		outFile.write("<JRG_21_02>"    + rs.getString("JRG_21_02")    + "</JRG_21_02>"    + cLf);
		outFile.write("<JRG_22_01_01>" + rs.getString("JRG_22_01_01") + "</JRG_22_01_01>" + cLf);
		outFile.write("<JRG_22_01_02>" + rs.getString("JRG_22_01_02") + "</JRG_22_01_02>" + cLf);
		outFile.write("<JRG_22_01_03>" + rs.getString("JRG_22_01_03") + "</JRG_22_01_03>" + cLf);
		outFile.write("<JRG_22_01_04>" + rs.getString("JRG_22_01_04") + "</JRG_22_01_04>" + cLf);
		outFile.write("<JRG_22_01_05>" + rs.getString("JRG_22_01_05") + "</JRG_22_01_05>" + cLf);
		outFile.write("<JRG_22_02>"    + rs.getString("JRG_22_02")    + "</JRG_22_02>"    + cLf);
		outFile.write("<JRG_23_01_01>" + rs.getString("JRG_23_01_01") + "</JRG_23_01_01>" + cLf);
		outFile.write("<JRG_23_01_02>" + rs.getString("JRG_23_01_02") + "</JRG_23_01_02>" + cLf);
		outFile.write("<JRG_23_01_03>" + rs.getString("JRG_23_01_03") + "</JRG_23_01_03>" + cLf);
		outFile.write("<JRG_23_01_04>" + rs.getString("JRG_23_01_04") + "</JRG_23_01_04>" + cLf);
		outFile.write("<JRG_23_01_05>" + rs.getString("JRG_23_01_05") + "</JRG_23_01_05>" + cLf);
		outFile.write("<JRG_23_02>"    + rs.getString("JRG_23_02")    + "</JRG_23_02>"    + cLf);
		outFile.write("<JRG_24_01_01>" + rs.getString("JRG_24_01_01") + "</JRG_24_01_01>" + cLf);
		outFile.write("<JRG_24_01_02>" + rs.getString("JRG_24_01_02") + "</JRG_24_01_02>" + cLf);
		outFile.write("<JRG_24_01_03>" + rs.getString("JRG_24_01_03") + "</JRG_24_01_03>" + cLf);
		outFile.write("<JRG_24_01_04>" + rs.getString("JRG_24_01_04") + "</JRG_24_01_04>" + cLf);
		outFile.write("<JRG_24_01_05>" + rs.getString("JRG_24_01_05") + "</JRG_24_01_05>" + cLf);
		outFile.write("<JRG_24_02>"    + rs.getString("JRG_24_02")    + "</JRG_24_02>"    + cLf);
		outFile.write("<JRG_25_01_01>" + rs.getString("JRG_25_01_01") + "</JRG_25_01_01>" + cLf);
		outFile.write("<JRG_25_01_02>" + rs.getString("JRG_25_01_02") + "</JRG_25_01_02>" + cLf);
		outFile.write("<JRG_25_01_03>" + rs.getString("JRG_25_01_03") + "</JRG_25_01_03>" + cLf);
		outFile.write("<JRG_25_01_04>" + rs.getString("JRG_25_01_04") + "</JRG_25_01_04>" + cLf);
		outFile.write("<JRG_25_01_05>" + rs.getString("JRG_25_01_05") + "</JRG_25_01_05>" + cLf);
		outFile.write("<JRG_25_02>"    + rs.getString("JRG_25_02")    + "</JRG_25_02>"    + cLf);
		outFile.write("<JRG_26_01_01>" + rs.getString("JRG_26_01_01") + "</JRG_26_01_01>" + cLf);
		outFile.write("<JRG_26_01_02>" + rs.getString("JRG_26_01_02") + "</JRG_26_01_02>" + cLf);
		outFile.write("<JRG_26_01_03>" + rs.getString("JRG_26_01_03") + "</JRG_26_01_03>" + cLf);
		outFile.write("<JRG_26_01_04>" + rs.getString("JRG_26_01_04") + "</JRG_26_01_04>" + cLf);
		outFile.write("<JRG_26_01_05>" + rs.getString("JRG_26_01_05") + "</JRG_26_01_05>" + cLf);
		outFile.write("<JRG_26_02>"    + rs.getString("JRG_26_02")    + "</JRG_26_02>"    + cLf);
		outFile.write("<JRG_27_01_01>" + rs.getString("JRG_27_01_01") + "</JRG_27_01_01>" + cLf);
		outFile.write("<JRG_27_01_02>" + rs.getString("JRG_27_01_02") + "</JRG_27_01_02>" + cLf);
		outFile.write("<JRG_27_01_03>" + rs.getString("JRG_27_01_03") + "</JRG_27_01_03>" + cLf);
		outFile.write("<JRG_27_01_04>" + rs.getString("JRG_27_01_04") + "</JRG_27_01_04>" + cLf);
		outFile.write("<JRG_27_01_05>" + rs.getString("JRG_27_01_05") + "</JRG_27_01_05>" + cLf);
		outFile.write("<JRG_27_02>"    + rs.getString("JRG_27_02")    + "</JRG_27_02>"    + cLf);
		outFile.write("<JRG_28_01_01>" + rs.getString("JRG_28_01_01") + "</JRG_28_01_01>" + cLf);
		outFile.write("<JRG_28_01_02>" + rs.getString("JRG_28_01_02") + "</JRG_28_01_02>" + cLf);
		outFile.write("<JRG_28_01_03>" + rs.getString("JRG_28_01_03") + "</JRG_28_01_03>" + cLf);
		outFile.write("<JRG_28_01_04>" + rs.getString("JRG_28_01_04") + "</JRG_28_01_04>" + cLf);
		outFile.write("<JRG_28_01_05>" + rs.getString("JRG_28_01_05") + "</JRG_28_01_05>" + cLf);
		outFile.write("<JRG_28_02>"    + rs.getString("JRG_28_02")    + "</JRG_28_02>"    + cLf);
		outFile.write("<JRG_29_01_01>" + rs.getString("JRG_29_01_01") + "</JRG_29_01_01>" + cLf);
		outFile.write("<JRG_29_01_02>" + rs.getString("JRG_29_01_02") + "</JRG_29_01_02>" + cLf);
		outFile.write("<JRG_29_01_03>" + rs.getString("JRG_29_01_03") + "</JRG_29_01_03>" + cLf);
		outFile.write("<JRG_29_01_04>" + rs.getString("JRG_29_01_04") + "</JRG_29_01_04>" + cLf);
		outFile.write("<JRG_29_01_05>" + rs.getString("JRG_29_01_05") + "</JRG_29_01_05>" + cLf);
		outFile.write("<JRG_29_02>"    + rs.getString("JRG_29_02")    + "</JRG_29_02>"    + cLf);
		outFile.write("<JRG_30_01_01>" + rs.getString("JRG_30_01_01") + "</JRG_30_01_01>" + cLf);
		outFile.write("<JRG_30_01_02>" + rs.getString("JRG_30_01_02") + "</JRG_30_01_02>" + cLf);
		outFile.write("<JRG_30_01_03>" + rs.getString("JRG_30_01_03") + "</JRG_30_01_03>" + cLf);
		outFile.write("<JRG_30_01_04>" + rs.getString("JRG_30_01_04") + "</JRG_30_01_04>" + cLf);
		outFile.write("<JRG_30_01_05>" + rs.getString("JRG_30_01_05") + "</JRG_30_01_05>" + cLf);
		outFile.write("<JRG_30_02>"    + rs.getString("JRG_30_02")    + "</JRG_30_02>"    + cLf);
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
