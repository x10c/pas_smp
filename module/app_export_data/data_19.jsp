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

File		outputFile	= new File("C:\\19 - " + kd_tahun_ajaran + "_" + npsn + "_A_SEKOLAH_FASILITAS_01.XML");
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
		+" 		SELECT		IFNULL(SUM(t_sekolah_properti.LUAS),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_properti 	ON	t_sekolah_properti.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 										AND	t_sekolah_properti.KD_SERTIFIKAT = '1'"
		+" 										AND	t_sekolah_properti.KD_KEPEMILIKAN = '1'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS LTS_01_01"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(t_sekolah_properti.LUAS),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_properti 	ON 	t_sekolah_properti.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 										AND	t_sekolah_properti.KD_SERTIFIKAT = '2'"
		+" 										AND	t_sekolah_properti.KD_KEPEMILIKAN = '1'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS LTS_01_02"
		+" ,		("
		+" 		SELECT 		IFNULL(SUM(t_sekolah_properti.LUAS),0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_properti 	ON 	t_sekolah_properti.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 										AND	t_sekolah_properti.KD_KEPEMILIKAN = '2'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS LTS_02"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_properti.LUAS,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_properti 	ON 	t_sekolah_properti.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 										AND	t_sekolah_properti.KD_PENGGUNAAN_TANAH = '1'"
		+" 										AND	t_sekolah_properti.KD_SERTIFIKAT = '1'"
		+" 										AND	t_sekolah_properti.KD_KEPEMILIKAN = '1'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PGN_01_01_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_properti.LUAS,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_properti 	ON 	t_sekolah_properti.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 										AND	t_sekolah_properti.KD_PENGGUNAAN_TANAH = '1'"
		+" 										AND	t_sekolah_properti.KD_SERTIFIKAT = '2'"
		+" 										AND	t_sekolah_properti.KD_KEPEMILIKAN = '1'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PGN_01_01_02"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_properti.LUAS,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_properti 	ON 	t_sekolah_properti.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 										AND	t_sekolah_properti.KD_PENGGUNAAN_TANAH = '1'"
		+" 										AND	t_sekolah_properti.KD_KEPEMILIKAN = '2'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PGN_01_02"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_properti.LUAS,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_properti 	ON 	t_sekolah_properti.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 										AND	t_sekolah_properti.KD_PENGGUNAAN_TANAH = '2'"
		+" 										AND	t_sekolah_properti.KD_SERTIFIKAT = '1'"
		+" 										AND	t_sekolah_properti.KD_KEPEMILIKAN = '1'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PGN_02_01_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_properti.LUAS,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_properti 	ON 	t_sekolah_properti.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 										AND	t_sekolah_properti.KD_PENGGUNAAN_TANAH = '2'"
		+" 										AND	t_sekolah_properti.KD_SERTIFIKAT = '2'"
		+" 										AND	t_sekolah_properti.KD_KEPEMILIKAN = '1'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PGN_02_01_02"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_properti.LUAS,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_properti 	ON 	t_sekolah_properti.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 										AND	t_sekolah_properti.KD_PENGGUNAAN_TANAH = '2'"
		+" 										AND	t_sekolah_properti.KD_KEPEMILIKAN = '2'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PGN_02_02"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_properti.LUAS,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_properti 	ON 	t_sekolah_properti.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 										AND	t_sekolah_properti.KD_PENGGUNAAN_TANAH = '3'"
		+" 										AND	t_sekolah_properti.KD_SERTIFIKAT = '1'"
		+" 										AND	t_sekolah_properti.KD_KEPEMILIKAN = '1'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PGN_03_01_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_properti.LUAS,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_properti 	ON 	t_sekolah_properti.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 										AND	t_sekolah_properti.KD_PENGGUNAAN_TANAH = '3'"
		+" 										AND	t_sekolah_properti.KD_SERTIFIKAT = '2'"
		+" 										AND	t_sekolah_properti.KD_KEPEMILIKAN = '1'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PGN_03_01_02"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_properti.LUAS,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_properti 	ON 	t_sekolah_properti.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 										AND	t_sekolah_properti.KD_PENGGUNAAN_TANAH = '3'"
		+" 										AND	t_sekolah_properti.KD_KEPEMILIKAN = '2'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PGN_03_02"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_properti.LUAS,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_properti 	ON 	t_sekolah_properti.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 										AND	t_sekolah_properti.KD_PENGGUNAAN_TANAH = '4'"
		+" 										AND	t_sekolah_properti.KD_SERTIFIKAT = '1'"
		+" 										AND	t_sekolah_properti.KD_KEPEMILIKAN = '1'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PGN_04_01_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_properti.LUAS,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_properti 	ON 	t_sekolah_properti.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 										AND	t_sekolah_properti.KD_PENGGUNAAN_TANAH = '4'"
		+" 										AND	t_sekolah_properti.KD_SERTIFIKAT = '2'"
		+" 										AND	t_sekolah_properti.KD_KEPEMILIKAN = '1'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PGN_04_01_02"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_properti.LUAS,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_properti 	ON 	t_sekolah_properti.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 										AND	t_sekolah_properti.KD_PENGGUNAAN_TANAH = '4'"
		+" 										AND	t_sekolah_properti.KD_KEPEMILIKAN = '2'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PGN_04_02"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_properti.LUAS,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_properti 	ON 	t_sekolah_properti.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 										AND	t_sekolah_properti.KD_PENGGUNAAN_TANAH = '7'"
		+" 										AND	t_sekolah_properti.KD_SERTIFIKAT = '1'"
		+" 										AND	t_sekolah_properti.KD_KEPEMILIKAN = '1'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PGN_05_01_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_properti.LUAS,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_properti 	ON 	t_sekolah_properti.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 										AND	t_sekolah_properti.KD_PENGGUNAAN_TANAH = '7'"
		+" 										AND	t_sekolah_properti.KD_SERTIFIKAT = '2'"
		+" 										AND	t_sekolah_properti.KD_KEPEMILIKAN = '1'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PGN_05_01_02"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_properti.LUAS,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_properti 	ON 	t_sekolah_properti.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 										AND	t_sekolah_properti.KD_PENGGUNAAN_TANAH = '7'"
		+" 										AND	t_sekolah_properti.KD_KEPEMILIKAN = '2'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PGN_05_02"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_perlengkapan.JUMLAH,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_perlengkapan	ON	t_sekolah_perlengkapan.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 											AND	t_sekolah_perlengkapan.KD_PERLENGKAPAN_SEKOLAH = '01'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PRL_ADM_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_perlengkapan.JUMLAH,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_perlengkapan	ON	t_sekolah_perlengkapan.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 											AND	t_sekolah_perlengkapan.KD_PERLENGKAPAN_SEKOLAH = '02'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PRL_ADM_02"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_perlengkapan.JUMLAH,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_perlengkapan	ON	t_sekolah_perlengkapan.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 											AND	t_sekolah_perlengkapan.KD_PERLENGKAPAN_SEKOLAH = '04'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PRL_ADM_03"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_perlengkapan.JUMLAH,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_perlengkapan	ON	t_sekolah_perlengkapan.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 											AND	t_sekolah_perlengkapan.KD_PERLENGKAPAN_SEKOLAH = '05'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PRL_ADM_04"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_perlengkapan.JUMLAH,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_perlengkapan	ON	t_sekolah_perlengkapan.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 											AND	t_sekolah_perlengkapan.KD_PERLENGKAPAN_SEKOLAH = '06'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PRL_ADM_05"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_perlengkapan.JUMLAH,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_perlengkapan	ON	t_sekolah_perlengkapan.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 											AND	t_sekolah_perlengkapan.KD_PERLENGKAPAN_SEKOLAH = '07'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PRL_ADM_06"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_perlengkapan.JUMLAH,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_perlengkapan	ON	t_sekolah_perlengkapan.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 											AND	t_sekolah_perlengkapan.KD_PERLENGKAPAN_SEKOLAH = '10'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PRL_ADM_07"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_perlengkapan.JUMLAH,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_perlengkapan	ON	t_sekolah_perlengkapan.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 											AND	t_sekolah_perlengkapan.KD_PERLENGKAPAN_SEKOLAH = '11'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PRL_ADM_08"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_perlengkapan.JUMLAH,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_perlengkapan	ON	t_sekolah_perlengkapan.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 											AND	t_sekolah_perlengkapan.KD_PERLENGKAPAN_SEKOLAH = '12'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PRL_ADM_09"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_perlengkapan.JUMLAH,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_perlengkapan	ON	t_sekolah_perlengkapan.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 											AND	t_sekolah_perlengkapan.KD_PERLENGKAPAN_SEKOLAH = '13'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PRL_ADM_10"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_perlengkapan.JUMLAH,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_perlengkapan	ON	t_sekolah_perlengkapan.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 											AND	t_sekolah_perlengkapan.KD_PERLENGKAPAN_SEKOLAH = '14'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PRL_ADM_11"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_perlengkapan_kbm.JUMLAH,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_perlengkapan_kbm	ON	t_sekolah_perlengkapan_kbm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_sekolah_perlengkapan_kbm.KD_PERLENGKAPAN_SEKOLAH = '15'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PRL_KBM_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_perlengkapan_kbm.JUMLAH,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_perlengkapan_kbm	ON	t_sekolah_perlengkapan_kbm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_sekolah_perlengkapan_kbm.KD_PERLENGKAPAN_SEKOLAH = '16'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PRL_KBM_02"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_perlengkapan_kbm.JUMLAH,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_perlengkapan_kbm	ON	t_sekolah_perlengkapan_kbm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_sekolah_perlengkapan_kbm.KD_PERLENGKAPAN_SEKOLAH = '17'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PRL_KBM_03"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_perlengkapan_kbm.JUMLAH,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_perlengkapan_kbm	ON	t_sekolah_perlengkapan_kbm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_sekolah_perlengkapan_kbm.KD_PERLENGKAPAN_SEKOLAH = '20'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PRL_KBM_04"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_perlengkapan_kbm.JUMLAH,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_perlengkapan_kbm	ON	t_sekolah_perlengkapan_kbm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_sekolah_perlengkapan_kbm.KD_PERLENGKAPAN_SEKOLAH = '21'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PRL_KBM_05"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_perlengkapan_kbm.JUMLAH,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_perlengkapan_kbm	ON	t_sekolah_perlengkapan_kbm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_sekolah_perlengkapan_kbm.KD_PERLENGKAPAN_SEKOLAH = '22'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PRL_KBM_06"
		+" ,		("
		+" 		SELECT 		IFNULL(t_sekolah_perlengkapan_kbm.JUMLAH,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_sekolah_perlengkapan_kbm	ON	t_sekolah_perlengkapan_kbm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_sekolah_perlengkapan_kbm.KD_PERLENGKAPAN_SEKOLAH = '23'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS PRL_KBM_07"
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
		outFile.write("<LTS_01_01>" + rs.getString("LTS_01_01") + "</LTS_01_01>" + cLf);
		outFile.write("<LTS_01_02>" + rs.getString("LTS_01_02") + "</LTS_01_02>" + cLf);
		outFile.write("<LTS_02>" + rs.getString("LTS_02") + "</LTS_02>" + cLf);
		outFile.write("<PGN_01_01_01>" + rs.getString("PGN_01_01_01") + "</PGN_01_01_01>" + cLf);
		outFile.write("<PGN_01_01_02>" + rs.getString("PGN_01_01_02") + "</PGN_01_01_02>" + cLf);
		outFile.write("<PGN_01_02>" + rs.getString("PGN_01_02") + "</PGN_01_02>" + cLf);
		outFile.write("<PGN_02_01_01>" + rs.getString("PGN_02_01_01") + "</PGN_02_01_01>" + cLf);
		outFile.write("<PGN_02_01_02>" + rs.getString("PGN_02_01_02") + "</PGN_02_01_02>" + cLf);
		outFile.write("<PGN_02_02>" + rs.getString("PGN_02_02") + "</PGN_02_02>" + cLf);
		outFile.write("<PGN_03_01_01>" + rs.getString("PGN_03_01_01") + "</PGN_03_01_01>" + cLf);
		outFile.write("<PGN_03_01_02>" + rs.getString("PGN_03_01_02") + "</PGN_03_01_02>" + cLf);
		outFile.write("<PGN_03_02>" + rs.getString("PGN_03_02") + "</PGN_03_02>" + cLf);
		outFile.write("<PGN_04_01_01>" + rs.getString("PGN_04_01_01") + "</PGN_04_01_01>" + cLf);
		outFile.write("<PGN_04_01_02>" + rs.getString("PGN_04_01_02") + "</PGN_04_01_02>" + cLf);
		outFile.write("<PGN_04_02>" + rs.getString("PGN_04_02") + "</PGN_04_02>" + cLf);
		outFile.write("<PGN_05_01_01>" + rs.getString("PGN_05_01_01") + "</PGN_05_01_01>" + cLf);
		outFile.write("<PGN_05_01_02>" + rs.getString("PGN_05_01_02") + "</PGN_05_01_02>" + cLf);
		outFile.write("<PGN_05_02>" + rs.getString("PGN_05_02") + "</PGN_05_02>" + cLf);
		outFile.write("<PRL_ADM_01>" + rs.getString("PRL_ADM_01") + "</PRL_ADM_01>" + cLf);
		outFile.write("<PRL_ADM_02>" + rs.getString("PRL_ADM_02") + "</PRL_ADM_02>" + cLf);
		outFile.write("<PRL_ADM_03>" + rs.getString("PRL_ADM_03") + "</PRL_ADM_03>" + cLf);
		outFile.write("<PRL_ADM_04>" + rs.getString("PRL_ADM_04") + "</PRL_ADM_04>" + cLf);
		outFile.write("<PRL_ADM_05>" + rs.getString("PRL_ADM_05") + "</PRL_ADM_05>" + cLf);
		outFile.write("<PRL_ADM_06>" + rs.getString("PRL_ADM_06") + "</PRL_ADM_06>" + cLf);
		outFile.write("<PRL_ADM_07>" + rs.getString("PRL_ADM_07") + "</PRL_ADM_07>" + cLf);
		outFile.write("<PRL_ADM_08>" + rs.getString("PRL_ADM_08") + "</PRL_ADM_08>" + cLf);
		outFile.write("<PRL_ADM_09>" + rs.getString("PRL_ADM_09") + "</PRL_ADM_09>" + cLf);
		outFile.write("<PRL_ADM_10>" + rs.getString("PRL_ADM_10") + "</PRL_ADM_10>" + cLf);
		outFile.write("<PRL_ADM_11>" + rs.getString("PRL_ADM_11") + "</PRL_ADM_11>" + cLf);
		outFile.write("<PRL_KBM_01>" + rs.getString("PRL_KBM_01") + "</PRL_KBM_01>" + cLf);
		outFile.write("<PRL_KBM_02>" + rs.getString("PRL_KBM_02") + "</PRL_KBM_02>" + cLf);
		outFile.write("<PRL_KBM_03>" + rs.getString("PRL_KBM_03") + "</PRL_KBM_03>" + cLf);
		outFile.write("<PRL_KBM_04>" + rs.getString("PRL_KBM_04") + "</PRL_KBM_04>" + cLf);
		outFile.write("<PRL_KBM_05>" + rs.getString("PRL_KBM_05") + "</PRL_KBM_05>" + cLf);
		outFile.write("<PRL_KBM_06>" + rs.getString("PRL_KBM_06") + "</PRL_KBM_06>" + cLf);
		outFile.write("<PRL_KBM_07>" + rs.getString("PRL_KBM_07") + "</PRL_KBM_07>" + cLf);
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
