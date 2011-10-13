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

File		outputFile	= new File("C:\\07 - " + kd_tahun_ajaran + "_" + npsn + "_A_SEKOLAH_PEGAWAI_02.XML");
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
		+" 		SELECT		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_SLTA_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_01_01_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_SLTA_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_01_01_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_GURU_D1_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_02_01_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_GURU_D1_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_02_01_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_NONGURU_D1_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_02_02_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_NONGURU_D1_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_02_02_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_GURU_D2_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_03_01_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_GURU_D2_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_03_01_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_NONGURU_D2_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_03_02_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_NONGURU_D2_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_03_02_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_GURU_D3_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_04_01_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_GURU_D3_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_04_01_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_NONGURU_D3_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_04_02_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_NONGURU_D3_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_04_02_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_GURU_S1_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_05_01_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_GURU_S1_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_05_01_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_NONGURU_S1_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_05_02_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_NONGURU_S1_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_05_02_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_GURU_S2_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_06_01_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_GURU_S2_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_06_01_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_NONGURU_S2_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_06_02_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_NONGURU_S2_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_06_02_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_S3_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_07_01_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.KASEK_S3_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KIJZ_07_01_P"
		+" ,		0 AS GGOL_01_L"
		+" ,		0 AS GGOL_01_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.GURU_TTP_2_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GGOL_02_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.GURU_TTP_2_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GGOL_02_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.GURU_TTP_3_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GGOL_03_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.GURU_TTP_3_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GGOL_03_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.GURU_TTP_4_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GGOL_04_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.GURU_TTP_4_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GGOL_04_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.GURU_TTP_Y_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GGOL_05_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.GURU_TTP_Y_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GGOL_05_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.GURU_TAKTTP_PNS_L,0) + IFNULL(v_pegawai_status.GURU_TAKTTP_BPNS_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GGOL_06_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.GURU_TAKTTP_PNS_P,0) + IFNULL(v_pegawai_status.GURU_TAKTTP_BPNS_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GGOL_06_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.GURU_TAKTTP_PST_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GGOL_07_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.GURU_TAKTTP_PST_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GGOL_07_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.GURU_TAKTTP_DRH_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GGOL_08_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.GURU_TAKTTP_DRH_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GGOL_08_P"
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
		outFile.write("<KIJZ_01_01_L>" + rs.getString("KIJZ_01_01_L") + "</KIJZ_01_01_L>" + cLf);
		outFile.write("<KIJZ_01_01_P>" + rs.getString("KIJZ_01_01_P") + "</KIJZ_01_01_P>" + cLf);
		outFile.write("<KIJZ_02_01_L>" + rs.getString("KIJZ_02_01_L") + "</KIJZ_02_01_L>" + cLf);
		outFile.write("<KIJZ_02_01_P>" + rs.getString("KIJZ_02_01_P") + "</KIJZ_02_01_P>" + cLf);
		outFile.write("<KIJZ_02_02_L>" + rs.getString("KIJZ_02_02_L") + "</KIJZ_02_02_L>" + cLf);
		outFile.write("<KIJZ_02_02_P>" + rs.getString("KIJZ_02_02_P") + "</KIJZ_02_02_P>" + cLf);
		outFile.write("<KIJZ_03_01_L>" + rs.getString("KIJZ_03_01_L") + "</KIJZ_03_01_L>" + cLf);
		outFile.write("<KIJZ_03_01_P>" + rs.getString("KIJZ_03_01_P") + "</KIJZ_03_01_P>" + cLf);
		outFile.write("<KIJZ_03_02_L>" + rs.getString("KIJZ_03_02_L") + "</KIJZ_03_02_L>" + cLf);
		outFile.write("<KIJZ_03_02_P>" + rs.getString("KIJZ_03_02_P") + "</KIJZ_03_02_P>" + cLf);
		outFile.write("<KIJZ_04_01_L>" + rs.getString("KIJZ_04_01_L") + "</KIJZ_04_01_L>" + cLf);
		outFile.write("<KIJZ_04_01_P>" + rs.getString("KIJZ_04_01_P") + "</KIJZ_04_01_P>" + cLf);
		outFile.write("<KIJZ_04_02_L>" + rs.getString("KIJZ_04_02_L") + "</KIJZ_04_02_L>" + cLf);
		outFile.write("<KIJZ_04_02_P>" + rs.getString("KIJZ_04_02_P") + "</KIJZ_04_02_P>" + cLf);
		outFile.write("<KIJZ_05_01_L>" + rs.getString("KIJZ_05_01_L") + "</KIJZ_05_01_L>" + cLf);
		outFile.write("<KIJZ_05_01_P>" + rs.getString("KIJZ_05_01_P") + "</KIJZ_05_01_P>" + cLf);
		outFile.write("<KIJZ_05_02_L>" + rs.getString("KIJZ_05_02_L") + "</KIJZ_05_02_L>" + cLf);
		outFile.write("<KIJZ_05_02_P>" + rs.getString("KIJZ_05_02_P") + "</KIJZ_05_02_P>" + cLf);
		outFile.write("<KIJZ_06_01_L>" + rs.getString("KIJZ_06_01_L") + "</KIJZ_06_01_L>" + cLf);
		outFile.write("<KIJZ_06_01_P>" + rs.getString("KIJZ_06_01_P") + "</KIJZ_06_01_P>" + cLf);
		outFile.write("<KIJZ_06_02_L>" + rs.getString("KIJZ_06_02_L") + "</KIJZ_06_02_L>" + cLf);
		outFile.write("<KIJZ_06_02_P>" + rs.getString("KIJZ_06_02_P") + "</KIJZ_06_02_P>" + cLf);
		outFile.write("<KIJZ_07_01_L>" + rs.getString("KIJZ_07_01_L") + "</KIJZ_07_01_L>" + cLf);
		outFile.write("<KIJZ_07_01_P>" + rs.getString("KIJZ_07_01_P") + "</KIJZ_07_01_P>" + cLf);
		outFile.write("<GGOL_01_L>" + rs.getString("GGOL_01_L") + "</GGOL_01_L>" + cLf);
		outFile.write("<GGOL_01_P>" + rs.getString("GGOL_01_P") + "</GGOL_01_P>" + cLf);
		outFile.write("<GGOL_02_L>" + rs.getString("GGOL_02_L") + "</GGOL_02_L>" + cLf);
		outFile.write("<GGOL_02_P>" + rs.getString("GGOL_02_P") + "</GGOL_02_P>" + cLf);
		outFile.write("<GGOL_03_L>" + rs.getString("GGOL_03_L") + "</GGOL_03_L>" + cLf);
		outFile.write("<GGOL_03_P>" + rs.getString("GGOL_03_P") + "</GGOL_03_P>" + cLf);
		outFile.write("<GGOL_04_L>" + rs.getString("GGOL_04_L") + "</GGOL_04_L>" + cLf);
		outFile.write("<GGOL_04_P>" + rs.getString("GGOL_04_P") + "</GGOL_04_P>" + cLf);
		outFile.write("<GGOL_05_L>" + rs.getString("GGOL_05_L") + "</GGOL_05_L>" + cLf);
		outFile.write("<GGOL_05_P>" + rs.getString("GGOL_05_P") + "</GGOL_05_P>" + cLf);
		outFile.write("<GGOL_06_L>" + rs.getString("GGOL_06_L") + "</GGOL_06_L>" + cLf);
		outFile.write("<GGOL_06_P>" + rs.getString("GGOL_06_P") + "</GGOL_06_P>" + cLf);
		outFile.write("<GGOL_07_L>" + rs.getString("GGOL_07_L") + "</GGOL_07_L>" + cLf);
		outFile.write("<GGOL_07_P>" + rs.getString("GGOL_07_P") + "</GGOL_07_P>" + cLf);
		outFile.write("<GGOL_08_L>" + rs.getString("GGOL_08_L") + "</GGOL_08_L>" + cLf);
		outFile.write("<GGOL_08_P>" + rs.getString("GGOL_08_P") + "</GGOL_08_P>" + cLf);
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
