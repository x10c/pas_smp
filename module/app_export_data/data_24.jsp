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

File		outputFile	= new File("C:\\24 - " + kd_tahun_ajaran + "_" + npsn + "_A_SEKOLAH_FASILITAS_06.XML");
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
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '01'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_01_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '01'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_01_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '01'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_01_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '01'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_01_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '01'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_01_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '01'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '02'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_02_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '02'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_02_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '02'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_02_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '02'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_02_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '02'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_02_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '02'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_02_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '03'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_03_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '03'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_03_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '03'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_03_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '03'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_03_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '03'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_03_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '03'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_03_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '04'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_04_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '04'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_04_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '04'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_04_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '04'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_04_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '04'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_04_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '04'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_04_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '05'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_05_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '05'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_05_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '05'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_05_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '05'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_05_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '05'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_05_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '05'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_05_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '06'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_06_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '06'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_06_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '06'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_06_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '06'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_06_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '06'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_06_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '06'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_06_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '07'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_07_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '07'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_07_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '07'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_07_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '07'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_07_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '07'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_07_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '07'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_07_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '08'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_08_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '08'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_08_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '08'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_08_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '08'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_08_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '08'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_08_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '08'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_08_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '09'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_09_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '09'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_09_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '09'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_09_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '09'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_09_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '09'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_09_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '09'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_09_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '10'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_10_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '10'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_10_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '10'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_10_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '10'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_10_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '10'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_10_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '10'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_10_02"
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
		outFile.write("<JLR_01_01_01>" + rs.getString("JLR_01_01_01") + "</JLR_01_01_01>" + cLf);
		outFile.write("<JLR_01_01_02>" + rs.getString("JLR_01_01_02") + "</JLR_01_01_02>" + cLf);
		outFile.write("<JLR_01_01_03>" + rs.getString("JLR_01_01_03") + "</JLR_01_01_03>" + cLf);
		outFile.write("<JLR_01_01_04>" + rs.getString("JLR_01_01_04") + "</JLR_01_01_04>" + cLf);
		outFile.write("<JLR_01_01_05>" + rs.getString("JLR_01_01_05") + "</JLR_01_01_05>" + cLf);
		outFile.write("<JLR_01_02>"    + rs.getString("JLR_01_02")    + "</JLR_01_02>"    + cLf);
		outFile.write("<JLR_02_01_01>" + rs.getString("JLR_02_01_01") + "</JLR_02_01_01>" + cLf);
		outFile.write("<JLR_02_01_02>" + rs.getString("JLR_02_01_02") + "</JLR_02_01_02>" + cLf);
		outFile.write("<JLR_02_01_03>" + rs.getString("JLR_02_01_03") + "</JLR_02_01_03>" + cLf);
		outFile.write("<JLR_02_01_04>" + rs.getString("JLR_02_01_04") + "</JLR_02_01_04>" + cLf);
		outFile.write("<JLR_02_01_05>" + rs.getString("JLR_02_01_05") + "</JLR_02_01_05>" + cLf);
		outFile.write("<JLR_02_02>"    + rs.getString("JLR_02_02")    + "</JLR_02_02>"    + cLf);
		outFile.write("<JLR_03_01_01>" + rs.getString("JLR_03_01_01") + "</JLR_03_01_01>" + cLf);
		outFile.write("<JLR_03_01_02>" + rs.getString("JLR_03_01_02") + "</JLR_03_01_02>" + cLf);
		outFile.write("<JLR_03_01_03>" + rs.getString("JLR_03_01_03") + "</JLR_03_01_03>" + cLf);
		outFile.write("<JLR_03_01_04>" + rs.getString("JLR_03_01_04") + "</JLR_03_01_04>" + cLf);
		outFile.write("<JLR_03_01_05>" + rs.getString("JLR_03_01_05") + "</JLR_03_01_05>" + cLf);
		outFile.write("<JLR_03_02>"    + rs.getString("JLR_03_02")    + "</JLR_03_02>"    + cLf);
		outFile.write("<JLR_04_01_01>" + rs.getString("JLR_04_01_01") + "</JLR_04_01_01>" + cLf);
		outFile.write("<JLR_04_01_02>" + rs.getString("JLR_04_01_02") + "</JLR_04_01_02>" + cLf);
		outFile.write("<JLR_04_01_03>" + rs.getString("JLR_04_01_03") + "</JLR_04_01_03>" + cLf);
		outFile.write("<JLR_04_01_04>" + rs.getString("JLR_04_01_04") + "</JLR_04_01_04>" + cLf);
		outFile.write("<JLR_04_01_05>" + rs.getString("JLR_04_01_05") + "</JLR_04_01_05>" + cLf);
		outFile.write("<JLR_04_02>"    + rs.getString("JLR_04_02")    + "</JLR_04_02>"    + cLf);
		outFile.write("<JLR_05_01_01>" + rs.getString("JLR_05_01_01") + "</JLR_05_01_01>" + cLf);
		outFile.write("<JLR_05_01_02>" + rs.getString("JLR_05_01_02") + "</JLR_05_01_02>" + cLf);
		outFile.write("<JLR_05_01_03>" + rs.getString("JLR_05_01_03") + "</JLR_05_01_03>" + cLf);
		outFile.write("<JLR_05_01_04>" + rs.getString("JLR_05_01_04") + "</JLR_05_01_04>" + cLf);
		outFile.write("<JLR_05_01_05>" + rs.getString("JLR_05_01_05") + "</JLR_05_01_05>" + cLf);
		outFile.write("<JLR_05_02>"    + rs.getString("JLR_05_02")    + "</JLR_05_02>"    + cLf);
		outFile.write("<JLR_06_01_01>" + rs.getString("JLR_06_01_01") + "</JLR_06_01_01>" + cLf);
		outFile.write("<JLR_06_01_02>" + rs.getString("JLR_06_01_02") + "</JLR_06_01_02>" + cLf);
		outFile.write("<JLR_06_01_03>" + rs.getString("JLR_06_01_03") + "</JLR_06_01_03>" + cLf);
		outFile.write("<JLR_06_01_04>" + rs.getString("JLR_06_01_04") + "</JLR_06_01_04>" + cLf);
		outFile.write("<JLR_06_01_05>" + rs.getString("JLR_06_01_05") + "</JLR_06_01_05>" + cLf);
		outFile.write("<JLR_06_02>"    + rs.getString("JLR_06_02")    + "</JLR_06_02>"    + cLf);
		outFile.write("<JLR_07_01_01>" + rs.getString("JLR_07_01_01") + "</JLR_07_01_01>" + cLf);
		outFile.write("<JLR_07_01_02>" + rs.getString("JLR_07_01_02") + "</JLR_07_01_02>" + cLf);
		outFile.write("<JLR_07_01_03>" + rs.getString("JLR_07_01_03") + "</JLR_07_01_03>" + cLf);
		outFile.write("<JLR_07_01_04>" + rs.getString("JLR_07_01_04") + "</JLR_07_01_04>" + cLf);
		outFile.write("<JLR_07_01_05>" + rs.getString("JLR_07_01_05") + "</JLR_07_01_05>" + cLf);
		outFile.write("<JLR_07_02>"    + rs.getString("JLR_07_02")    + "</JLR_07_02>"    + cLf);
		outFile.write("<JLR_08_01_01>" + rs.getString("JLR_08_01_01") + "</JLR_08_01_01>" + cLf);
		outFile.write("<JLR_08_01_02>" + rs.getString("JLR_08_01_02") + "</JLR_08_01_02>" + cLf);
		outFile.write("<JLR_08_01_03>" + rs.getString("JLR_08_01_03") + "</JLR_08_01_03>" + cLf);
		outFile.write("<JLR_08_01_04>" + rs.getString("JLR_08_01_04") + "</JLR_08_01_04>" + cLf);
		outFile.write("<JLR_08_01_05>" + rs.getString("JLR_08_01_05") + "</JLR_08_01_05>" + cLf);
		outFile.write("<JLR_08_02>"    + rs.getString("JLR_08_02")    + "</JLR_08_02>"    + cLf);
		outFile.write("<JLR_09_01_01>" + rs.getString("JLR_09_01_01") + "</JLR_09_01_01>" + cLf);
		outFile.write("<JLR_09_01_02>" + rs.getString("JLR_09_01_02") + "</JLR_09_01_02>" + cLf);
		outFile.write("<JLR_09_01_03>" + rs.getString("JLR_09_01_03") + "</JLR_09_01_03>" + cLf);
		outFile.write("<JLR_09_01_04>" + rs.getString("JLR_09_01_04") + "</JLR_09_01_04>" + cLf);
		outFile.write("<JLR_09_01_05>" + rs.getString("JLR_09_01_05") + "</JLR_09_01_05>" + cLf);
		outFile.write("<JLR_09_02>"    + rs.getString("JLR_09_02")    + "</JLR_09_02>"    + cLf);
		outFile.write("<JLR_10_01_01>" + rs.getString("JLR_10_01_01") + "</JLR_10_01_01>" + cLf);
		outFile.write("<JLR_10_01_02>" + rs.getString("JLR_10_01_02") + "</JLR_10_01_02>" + cLf);
		outFile.write("<JLR_10_01_03>" + rs.getString("JLR_10_01_03") + "</JLR_10_01_03>" + cLf);
		outFile.write("<JLR_10_01_04>" + rs.getString("JLR_10_01_04") + "</JLR_10_01_04>" + cLf);
		outFile.write("<JLR_10_01_05>" + rs.getString("JLR_10_01_05") + "</JLR_10_01_05>" + cLf);
		outFile.write("<JLR_10_02>"    + rs.getString("JLR_10_02")    + "</JLR_10_02>"    + cLf);
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
