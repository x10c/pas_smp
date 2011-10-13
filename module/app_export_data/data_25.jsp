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

File		outputFile	= new File("C:\\25 - " + kd_tahun_ajaran + "_" + npsn + "_A_SEKOLAH_FASILITAS_07.XML");
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
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '11'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_11_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '11'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_11_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '11'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_11_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '11'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_11_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '11'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_11_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '11'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_11_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '12'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_12_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '12'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_12_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '12'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_12_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '12'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_12_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '12'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_12_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '12'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_12_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '13'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_13_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '13'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_13_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '13'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_13_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '13'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_13_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '13'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_13_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '13'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_13_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '14'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_14_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '14'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_14_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '14'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_14_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '14'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_14_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '14'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_14_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '14'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_14_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '15'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_15_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '15'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_15_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '15'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_15_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '15'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_15_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '15'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_15_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '15'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_15_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '16'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_16_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '16'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_16_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '16'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_16_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '16'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_16_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '16'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_16_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '16'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_16_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '17'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_17_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '17'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_17_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '17'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_17_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '17'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_17_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '17'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_17_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '17'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_17_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '18'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_18_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '18'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_18_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '18'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_18_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '18'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_18_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '18'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_18_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '18'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_18_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '19'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_19_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '19'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_19_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '19'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_19_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '19'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_19_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '19'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_19_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '19'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_19_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '20'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_20_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '20'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_20_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '20'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_20_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '20'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_20_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '20'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_20_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '20'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_20_02"
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
		outFile.write("<JLR_11_01_01>" + rs.getString("JLR_11_01_01") + "</JLR_11_01_01>" + cLf);
		outFile.write("<JLR_11_01_02>" + rs.getString("JLR_11_01_02") + "</JLR_11_01_02>" + cLf);
		outFile.write("<JLR_11_01_03>" + rs.getString("JLR_11_01_03") + "</JLR_11_01_03>" + cLf);
		outFile.write("<JLR_11_01_04>" + rs.getString("JLR_11_01_04") + "</JLR_11_01_04>" + cLf);
		outFile.write("<JLR_11_01_05>" + rs.getString("JLR_11_01_05") + "</JLR_11_01_05>" + cLf);
		outFile.write("<JLR_11_02>"    + rs.getString("JLR_11_02")    + "</JLR_11_02>"    + cLf);
		outFile.write("<JLR_12_01_01>" + rs.getString("JLR_12_01_01") + "</JLR_12_01_01>" + cLf);
		outFile.write("<JLR_12_01_02>" + rs.getString("JLR_12_01_02") + "</JLR_12_01_02>" + cLf);
		outFile.write("<JLR_12_01_03>" + rs.getString("JLR_12_01_03") + "</JLR_12_01_03>" + cLf);
		outFile.write("<JLR_12_01_04>" + rs.getString("JLR_12_01_04") + "</JLR_12_01_04>" + cLf);
		outFile.write("<JLR_12_01_05>" + rs.getString("JLR_12_01_05") + "</JLR_12_01_05>" + cLf);
		outFile.write("<JLR_12_02>"    + rs.getString("JLR_12_02")    + "</JLR_12_02>"    + cLf);
		outFile.write("<JLR_13_01_01>" + rs.getString("JLR_13_01_01") + "</JLR_13_01_01>" + cLf);
		outFile.write("<JLR_13_01_02>" + rs.getString("JLR_13_01_02") + "</JLR_13_01_02>" + cLf);
		outFile.write("<JLR_13_01_03>" + rs.getString("JLR_13_01_03") + "</JLR_13_01_03>" + cLf);
		outFile.write("<JLR_13_01_04>" + rs.getString("JLR_13_01_04") + "</JLR_13_01_04>" + cLf);
		outFile.write("<JLR_13_01_05>" + rs.getString("JLR_13_01_05") + "</JLR_13_01_05>" + cLf);
		outFile.write("<JLR_13_02>"    + rs.getString("JLR_13_02")    + "</JLR_13_02>"    + cLf);
		outFile.write("<JLR_14_01_01>" + rs.getString("JLR_14_01_01") + "</JLR_14_01_01>" + cLf);
		outFile.write("<JLR_14_01_02>" + rs.getString("JLR_14_01_02") + "</JLR_14_01_02>" + cLf);
		outFile.write("<JLR_14_01_03>" + rs.getString("JLR_14_01_03") + "</JLR_14_01_03>" + cLf);
		outFile.write("<JLR_14_01_04>" + rs.getString("JLR_14_01_04") + "</JLR_14_01_04>" + cLf);
		outFile.write("<JLR_14_01_05>" + rs.getString("JLR_14_01_05") + "</JLR_14_01_05>" + cLf);
		outFile.write("<JLR_14_02>"    + rs.getString("JLR_14_02")    + "</JLR_14_02>"    + cLf);
		outFile.write("<JLR_15_01_01>" + rs.getString("JLR_15_01_01") + "</JLR_15_01_01>" + cLf);
		outFile.write("<JLR_15_01_02>" + rs.getString("JLR_15_01_02") + "</JLR_15_01_02>" + cLf);
		outFile.write("<JLR_15_01_03>" + rs.getString("JLR_15_01_03") + "</JLR_15_01_03>" + cLf);
		outFile.write("<JLR_15_01_04>" + rs.getString("JLR_15_01_04") + "</JLR_15_01_04>" + cLf);
		outFile.write("<JLR_15_01_05>" + rs.getString("JLR_15_01_05") + "</JLR_15_01_05>" + cLf);
		outFile.write("<JLR_15_02>"    + rs.getString("JLR_15_02")    + "</JLR_15_02>"    + cLf);
		outFile.write("<JLR_16_01_01>" + rs.getString("JLR_16_01_01") + "</JLR_16_01_01>" + cLf);
		outFile.write("<JLR_16_01_02>" + rs.getString("JLR_16_01_02") + "</JLR_16_01_02>" + cLf);
		outFile.write("<JLR_16_01_03>" + rs.getString("JLR_16_01_03") + "</JLR_16_01_03>" + cLf);
		outFile.write("<JLR_16_01_04>" + rs.getString("JLR_16_01_04") + "</JLR_16_01_04>" + cLf);
		outFile.write("<JLR_16_01_05>" + rs.getString("JLR_16_01_05") + "</JLR_16_01_05>" + cLf);
		outFile.write("<JLR_16_02>"    + rs.getString("JLR_16_02")    + "</JLR_16_02>"    + cLf);
		outFile.write("<JLR_17_01_01>" + rs.getString("JLR_17_01_01") + "</JLR_17_01_01>" + cLf);
		outFile.write("<JLR_17_01_02>" + rs.getString("JLR_17_01_02") + "</JLR_17_01_02>" + cLf);
		outFile.write("<JLR_17_01_03>" + rs.getString("JLR_17_01_03") + "</JLR_17_01_03>" + cLf);
		outFile.write("<JLR_17_01_04>" + rs.getString("JLR_17_01_04") + "</JLR_17_01_04>" + cLf);
		outFile.write("<JLR_17_01_05>" + rs.getString("JLR_17_01_05") + "</JLR_17_01_05>" + cLf);
		outFile.write("<JLR_17_02>"    + rs.getString("JLR_17_02")    + "</JLR_17_02>"    + cLf);
		outFile.write("<JLR_18_01_01>" + rs.getString("JLR_18_01_01") + "</JLR_18_01_01>" + cLf);
		outFile.write("<JLR_18_01_02>" + rs.getString("JLR_18_01_02") + "</JLR_18_01_02>" + cLf);
		outFile.write("<JLR_18_01_03>" + rs.getString("JLR_18_01_03") + "</JLR_18_01_03>" + cLf);
		outFile.write("<JLR_18_01_04>" + rs.getString("JLR_18_01_04") + "</JLR_18_01_04>" + cLf);
		outFile.write("<JLR_18_01_05>" + rs.getString("JLR_18_01_05") + "</JLR_18_01_05>" + cLf);
		outFile.write("<JLR_18_02>"    + rs.getString("JLR_18_02")    + "</JLR_18_02>"    + cLf);
		outFile.write("<JLR_19_01_01>" + rs.getString("JLR_19_01_01") + "</JLR_19_01_01>" + cLf);
		outFile.write("<JLR_19_01_02>" + rs.getString("JLR_19_01_02") + "</JLR_19_01_02>" + cLf);
		outFile.write("<JLR_19_01_03>" + rs.getString("JLR_19_01_03") + "</JLR_19_01_03>" + cLf);
		outFile.write("<JLR_19_01_04>" + rs.getString("JLR_19_01_04") + "</JLR_19_01_04>" + cLf);
		outFile.write("<JLR_19_01_05>" + rs.getString("JLR_19_01_05") + "</JLR_19_01_05>" + cLf);
		outFile.write("<JLR_19_02>"    + rs.getString("JLR_19_02")    + "</JLR_19_02>"    + cLf);
		outFile.write("<JLR_20_01_01>" + rs.getString("JLR_20_01_01") + "</JLR_20_01_01>" + cLf);
		outFile.write("<JLR_20_01_02>" + rs.getString("JLR_20_01_02") + "</JLR_20_01_02>" + cLf);
		outFile.write("<JLR_20_01_03>" + rs.getString("JLR_20_01_03") + "</JLR_20_01_03>" + cLf);
		outFile.write("<JLR_20_01_04>" + rs.getString("JLR_20_01_04") + "</JLR_20_01_04>" + cLf);
		outFile.write("<JLR_20_01_05>" + rs.getString("JLR_20_01_05") + "</JLR_20_01_05>" + cLf);
		outFile.write("<JLR_20_02>"    + rs.getString("JLR_20_02")    + "</JLR_20_02>"    + cLf);
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
