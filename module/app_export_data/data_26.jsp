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

File		outputFile	= new File("C:\\26 - " + kd_tahun_ajaran + "_" + npsn + "_A_SEKOLAH_FASILITAS_08.XML");
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
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '21'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_21_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '21'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_21_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '21'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_21_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '21'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_21_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '21'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_21_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '21'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_21_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '22'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_22_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '22'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_22_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '22'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_22_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '22'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_22_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '22'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_22_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '22'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_22_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '23'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_23_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '23'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_23_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '23'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_23_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '23'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_23_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '23'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_23_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '23'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_23_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '24'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_24_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '24'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_24_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '24'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_24_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '24'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_24_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '24'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_24_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '24'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_24_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '25'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_25_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '25'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_25_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '25'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_25_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '25'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_25_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '25'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_25_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '25'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_25_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '26'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_26_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '26'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_26_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '26'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_26_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '26'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_26_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '26'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_26_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '26'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_26_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '27'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_27_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '27'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_27_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '27'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_27_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '27'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_27_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '27'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_27_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '27'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_27_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '28'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_28_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '28'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_28_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '28'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_28_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '28'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_28_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '28'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_28_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '28'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_28_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '29'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_29_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '29'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_29_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '29'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_29_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '29'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_29_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '29'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_29_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '29'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_29_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '30'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '1'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_30_01_01"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '30'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_30_01_02"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '30'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '3'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_30_01_03"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '30'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '4'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_30_01_04"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '30'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '1'"
		+" 		AND		t_sekolah_ruang.KD_KONDISI_RUANGAN	= '5'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_30_01_05"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(T_SEKOLAH_RUANG.LUAS),0)"
		+" 		FROM	t_sekolah_ruang"
		+" 		WHERE	t_sekolah_ruang.KD_RUANG 			= '30'"
		+" 		AND		t_sekolah_ruang.KD_KEPEMILIKAN		= '2'"
		+" 		AND		t_sekolah_ruang.KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "'"
		+" 		) AS JLR_30_02"
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
		outFile.write("<JLR_21_01_01>" + rs.getString("JLR_21_01_01") + "</JLR_21_01_01>" + cLf);
		outFile.write("<JLR_21_01_02>" + rs.getString("JLR_21_01_02") + "</JLR_21_01_02>" + cLf);
		outFile.write("<JLR_21_01_03>" + rs.getString("JLR_21_01_03") + "</JLR_21_01_03>" + cLf);
		outFile.write("<JLR_21_01_04>" + rs.getString("JLR_21_01_04") + "</JLR_21_01_04>" + cLf);
		outFile.write("<JLR_21_01_05>" + rs.getString("JLR_21_01_05") + "</JLR_21_01_05>" + cLf);
		outFile.write("<JLR_21_02>"    + rs.getString("JLR_21_02")    + "</JLR_21_02>"    + cLf);
		outFile.write("<JLR_22_01_01>" + rs.getString("JLR_22_01_01") + "</JLR_22_01_01>" + cLf);
		outFile.write("<JLR_22_01_02>" + rs.getString("JLR_22_01_02") + "</JLR_22_01_02>" + cLf);
		outFile.write("<JLR_22_01_03>" + rs.getString("JLR_22_01_03") + "</JLR_22_01_03>" + cLf);
		outFile.write("<JLR_22_01_04>" + rs.getString("JLR_22_01_04") + "</JLR_22_01_04>" + cLf);
		outFile.write("<JLR_22_01_05>" + rs.getString("JLR_22_01_05") + "</JLR_22_01_05>" + cLf);
		outFile.write("<JLR_22_02>"    + rs.getString("JLR_22_02")    + "</JLR_22_02>"    + cLf);
		outFile.write("<JLR_23_01_01>" + rs.getString("JLR_23_01_01") + "</JLR_23_01_01>" + cLf);
		outFile.write("<JLR_23_01_02>" + rs.getString("JLR_23_01_02") + "</JLR_23_01_02>" + cLf);
		outFile.write("<JLR_23_01_03>" + rs.getString("JLR_23_01_03") + "</JLR_23_01_03>" + cLf);
		outFile.write("<JLR_23_01_04>" + rs.getString("JLR_23_01_04") + "</JLR_23_01_04>" + cLf);
		outFile.write("<JLR_23_01_05>" + rs.getString("JLR_23_01_05") + "</JLR_23_01_05>" + cLf);
		outFile.write("<JLR_23_02>"    + rs.getString("JLR_23_02")    + "</JLR_23_02>"    + cLf);
		outFile.write("<JLR_24_01_01>" + rs.getString("JLR_24_01_01") + "</JLR_24_01_01>" + cLf);
		outFile.write("<JLR_24_01_02>" + rs.getString("JLR_24_01_02") + "</JLR_24_01_02>" + cLf);
		outFile.write("<JLR_24_01_03>" + rs.getString("JLR_24_01_03") + "</JLR_24_01_03>" + cLf);
		outFile.write("<JLR_24_01_04>" + rs.getString("JLR_24_01_04") + "</JLR_24_01_04>" + cLf);
		outFile.write("<JLR_24_01_05>" + rs.getString("JLR_24_01_05") + "</JLR_24_01_05>" + cLf);
		outFile.write("<JLR_24_02>"    + rs.getString("JLR_24_02")    + "</JLR_24_02>"    + cLf);
		outFile.write("<JLR_25_01_01>" + rs.getString("JLR_25_01_01") + "</JLR_25_01_01>" + cLf);
		outFile.write("<JLR_25_01_02>" + rs.getString("JLR_25_01_02") + "</JLR_25_01_02>" + cLf);
		outFile.write("<JLR_25_01_03>" + rs.getString("JLR_25_01_03") + "</JLR_25_01_03>" + cLf);
		outFile.write("<JLR_25_01_04>" + rs.getString("JLR_25_01_04") + "</JLR_25_01_04>" + cLf);
		outFile.write("<JLR_25_01_05>" + rs.getString("JLR_25_01_05") + "</JLR_25_01_05>" + cLf);
		outFile.write("<JLR_25_02>"    + rs.getString("JLR_25_02")    + "</JLR_25_02>"    + cLf);
		outFile.write("<JLR_26_01_01>" + rs.getString("JLR_26_01_01") + "</JLR_26_01_01>" + cLf);
		outFile.write("<JLR_26_01_02>" + rs.getString("JLR_26_01_02") + "</JLR_26_01_02>" + cLf);
		outFile.write("<JLR_26_01_03>" + rs.getString("JLR_26_01_03") + "</JLR_26_01_03>" + cLf);
		outFile.write("<JLR_26_01_04>" + rs.getString("JLR_26_01_04") + "</JLR_26_01_04>" + cLf);
		outFile.write("<JLR_26_01_05>" + rs.getString("JLR_26_01_05") + "</JLR_26_01_05>" + cLf);
		outFile.write("<JLR_26_02>"    + rs.getString("JLR_26_02")    + "</JLR_26_02>"    + cLf);
		outFile.write("<JLR_27_01_01>" + rs.getString("JLR_27_01_01") + "</JLR_27_01_01>" + cLf);
		outFile.write("<JLR_27_01_02>" + rs.getString("JLR_27_01_02") + "</JLR_27_01_02>" + cLf);
		outFile.write("<JLR_27_01_03>" + rs.getString("JLR_27_01_03") + "</JLR_27_01_03>" + cLf);
		outFile.write("<JLR_27_01_04>" + rs.getString("JLR_27_01_04") + "</JLR_27_01_04>" + cLf);
		outFile.write("<JLR_27_01_05>" + rs.getString("JLR_27_01_05") + "</JLR_27_01_05>" + cLf);
		outFile.write("<JLR_27_02>"    + rs.getString("JLR_27_02")    + "</JLR_27_02>"    + cLf);
		outFile.write("<JLR_28_01_01>" + rs.getString("JLR_28_01_01") + "</JLR_28_01_01>" + cLf);
		outFile.write("<JLR_28_01_02>" + rs.getString("JLR_28_01_02") + "</JLR_28_01_02>" + cLf);
		outFile.write("<JLR_28_01_03>" + rs.getString("JLR_28_01_03") + "</JLR_28_01_03>" + cLf);
		outFile.write("<JLR_28_01_04>" + rs.getString("JLR_28_01_04") + "</JLR_28_01_04>" + cLf);
		outFile.write("<JLR_28_01_05>" + rs.getString("JLR_28_01_05") + "</JLR_28_01_05>" + cLf);
		outFile.write("<JLR_28_02>"    + rs.getString("JLR_28_02")    + "</JLR_28_02>"    + cLf);
		outFile.write("<JLR_29_01_01>" + rs.getString("JLR_29_01_01") + "</JLR_29_01_01>" + cLf);
		outFile.write("<JLR_29_01_02>" + rs.getString("JLR_29_01_02") + "</JLR_29_01_02>" + cLf);
		outFile.write("<JLR_29_01_03>" + rs.getString("JLR_29_01_03") + "</JLR_29_01_03>" + cLf);
		outFile.write("<JLR_29_01_04>" + rs.getString("JLR_29_01_04") + "</JLR_29_01_04>" + cLf);
		outFile.write("<JLR_29_01_05>" + rs.getString("JLR_29_01_05") + "</JLR_29_01_05>" + cLf);
		outFile.write("<JLR_29_02>"    + rs.getString("JLR_29_02")    + "</JLR_29_02>"    + cLf);
		outFile.write("<JLR_30_01_01>" + rs.getString("JLR_30_01_01") + "</JLR_30_01_01>" + cLf);
		outFile.write("<JLR_30_01_02>" + rs.getString("JLR_30_01_02") + "</JLR_30_01_02>" + cLf);
		outFile.write("<JLR_30_01_03>" + rs.getString("JLR_30_01_03") + "</JLR_30_01_03>" + cLf);
		outFile.write("<JLR_30_01_04>" + rs.getString("JLR_30_01_04") + "</JLR_30_01_04>" + cLf);
		outFile.write("<JLR_30_01_05>" + rs.getString("JLR_30_01_05") + "</JLR_30_01_05>" + cLf);
		outFile.write("<JLR_30_02>"    + rs.getString("JLR_30_02")    + "</JLR_30_02>"    + cLf);
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
