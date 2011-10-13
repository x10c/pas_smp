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

File		outputFile	= new File("C:\\27 - " + kd_tahun_ajaran + "_" + npsn + "_A_SEKOLAH_FASILITAS_09.XML");
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
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '31'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_31_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '31'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_31_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '31'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_31_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '31'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_31_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '31'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_31_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '31'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_31_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '32'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_32_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '32'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_32_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '32'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_32_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '32'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_32_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '32'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_32_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '32'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_32_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '33'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_33_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '33'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_33_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '33'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_33_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '33'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_33_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '33'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_33_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '33'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_33_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '34'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_34_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '34'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_34_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '34'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_34_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '34'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_34_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '34'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_34_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '34'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_34_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '42'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_35_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '42'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_35_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '42'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_35_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '42'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_35_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '42'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_35_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '42'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_35_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '43'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_36_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '43'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_36_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '43'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_36_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '43'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_36_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '43'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_36_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '43'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_36_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '44'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_37_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '44'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_37_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '44'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_37_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '44'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_37_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '44'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_37_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '44'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_37_02"
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
		outFile.write("<JLR_31_01_01>" + rs.getString("JLR_31_01_01") + "</JLR_31_01_01>" + cLf);
		outFile.write("<JLR_31_01_02>" + rs.getString("JLR_31_01_02") + "</JLR_31_01_02>" + cLf);
		outFile.write("<JLR_31_01_03>" + rs.getString("JLR_31_01_03") + "</JLR_31_01_03>" + cLf);
		outFile.write("<JLR_31_01_04>" + rs.getString("JLR_31_01_04") + "</JLR_31_01_04>" + cLf);
		outFile.write("<JLR_31_01_05>" + rs.getString("JLR_31_01_05") + "</JLR_31_01_05>" + cLf);
		outFile.write("<JLR_31_02>"    + rs.getString("JLR_31_02")    + "</JLR_31_02>"    + cLf);
		outFile.write("<JLR_32_01_01>" + rs.getString("JLR_32_01_01") + "</JLR_32_01_01>" + cLf);
		outFile.write("<JLR_32_01_02>" + rs.getString("JLR_32_01_02") + "</JLR_32_01_02>" + cLf);
		outFile.write("<JLR_32_01_03>" + rs.getString("JLR_32_01_03") + "</JLR_32_01_03>" + cLf);
		outFile.write("<JLR_32_01_04>" + rs.getString("JLR_32_01_04") + "</JLR_32_01_04>" + cLf);
		outFile.write("<JLR_32_01_05>" + rs.getString("JLR_32_01_05") + "</JLR_32_01_05>" + cLf);
		outFile.write("<JLR_32_02>"    + rs.getString("JLR_32_02")    + "</JLR_32_02>"    + cLf);
		outFile.write("<JLR_33_01_01>" + rs.getString("JLR_33_01_01") + "</JLR_33_01_01>" + cLf);
		outFile.write("<JLR_33_01_02>" + rs.getString("JLR_33_01_02") + "</JLR_33_01_02>" + cLf);
		outFile.write("<JLR_33_01_03>" + rs.getString("JLR_33_01_03") + "</JLR_33_01_03>" + cLf);
		outFile.write("<JLR_33_01_04>" + rs.getString("JLR_33_01_04") + "</JLR_33_01_04>" + cLf);
		outFile.write("<JLR_33_01_05>" + rs.getString("JLR_33_01_05") + "</JLR_33_01_05>" + cLf);
		outFile.write("<JLR_33_02>"    + rs.getString("JLR_33_02")    + "</JLR_33_02>"    + cLf);
		outFile.write("<JLR_34_01_01>" + rs.getString("JLR_34_01_01") + "</JLR_34_01_01>" + cLf);
		outFile.write("<JLR_34_01_02>" + rs.getString("JLR_34_01_02") + "</JLR_34_01_02>" + cLf);
		outFile.write("<JLR_34_01_03>" + rs.getString("JLR_34_01_03") + "</JLR_34_01_03>" + cLf);
		outFile.write("<JLR_34_01_04>" + rs.getString("JLR_34_01_04") + "</JLR_34_01_04>" + cLf);
		outFile.write("<JLR_34_01_05>" + rs.getString("JLR_34_01_05") + "</JLR_34_01_05>" + cLf);
		outFile.write("<JLR_34_02>"    + rs.getString("JLR_34_02")    + "</JLR_34_02>"    + cLf);
		outFile.write("<JLR_35_01_01>" + rs.getString("JLR_35_01_01") + "</JLR_35_01_01>" + cLf);
		outFile.write("<JLR_35_01_02>" + rs.getString("JLR_35_01_02") + "</JLR_35_01_02>" + cLf);
		outFile.write("<JLR_35_01_03>" + rs.getString("JLR_35_01_03") + "</JLR_35_01_03>" + cLf);
		outFile.write("<JLR_35_01_04>" + rs.getString("JLR_35_01_04") + "</JLR_35_01_04>" + cLf);
		outFile.write("<JLR_35_01_05>" + rs.getString("JLR_35_01_05") + "</JLR_35_01_05>" + cLf);
		outFile.write("<JLR_35_02>"    + rs.getString("JLR_35_02")    + "</JLR_35_02>"    + cLf);
		outFile.write("<JLR_36_01_01>" + rs.getString("JLR_36_01_01") + "</JLR_36_01_01>" + cLf);
		outFile.write("<JLR_36_01_02>" + rs.getString("JLR_36_01_02") + "</JLR_36_01_02>" + cLf);
		outFile.write("<JLR_36_01_03>" + rs.getString("JLR_36_01_03") + "</JLR_36_01_03>" + cLf);
		outFile.write("<JLR_36_01_04>" + rs.getString("JLR_36_01_04") + "</JLR_36_01_04>" + cLf);
		outFile.write("<JLR_36_01_05>" + rs.getString("JLR_36_01_05") + "</JLR_36_01_05>" + cLf);
		outFile.write("<JLR_36_02>"    + rs.getString("JLR_36_02")    + "</JLR_36_02>"    + cLf);
		outFile.write("<JLR_37_01_01>" + rs.getString("JLR_37_01_01") + "</JLR_37_01_01>" + cLf);
		outFile.write("<JLR_37_01_02>" + rs.getString("JLR_37_01_02") + "</JLR_37_01_02>" + cLf);
		outFile.write("<JLR_37_01_03>" + rs.getString("JLR_37_01_03") + "</JLR_37_01_03>" + cLf);
		outFile.write("<JLR_37_01_04>" + rs.getString("JLR_37_01_04") + "</JLR_37_01_04>" + cLf);
		outFile.write("<JLR_37_01_05>" + rs.getString("JLR_37_01_05") + "</JLR_37_01_05>" + cLf);
		outFile.write("<JLR_37_02>"    + rs.getString("JLR_37_02")    + "</JLR_37_02>"    + cLf);
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
