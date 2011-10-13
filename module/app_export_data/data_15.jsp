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

File		outputFile	= new File("C:\\15 - " + kd_tahun_ajaran + "_" + npsn + "_A_SEKOLAH_PEGAWAI_10.XML");
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
		+" 		SELECT		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_SLTA_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_01_01_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_SLTA_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_01_01_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_GURU_D1_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_02_01_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_GURU_D1_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_02_01_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_NONGURU_D1_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_02_02_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_NONGURU_D1_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_02_02_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_GURU_D2_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_03_01_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_GURU_D2_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_03_01_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_NONGURU_D2_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_03_02_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_NONGURU_D2_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_03_02_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_GURU_D3_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_04_01_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_GURU_D3_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_04_01_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_NONGURU_D3_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_04_02_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_NONGURU_D3_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_04_02_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_GURU_S1_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_05_01_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_GURU_S1_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_05_01_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_NONGURU_S1_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_05_02_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_NONGURU_S1_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_05_02_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_GURU_S2_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_06_01_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_GURU_S2_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_06_01_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_NONGURU_S2_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_06_02_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_NONGURU_S2_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_06_02_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_S3_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_07_01_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_ijazah_tertinggi.GURUDAERAH_S3_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_ijazah_tertinggi 	ON v_pegawai_ijazah_tertinggi.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GBD_IJZ_07_01_P"
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
		outFile.write("<GBD_IJZ_01_01_L>" + rs.getString("GBD_IJZ_01_01_L") + "</GBD_IJZ_01_01_L>" + cLf);
		outFile.write("<GBD_IJZ_01_01_P>" + rs.getString("GBD_IJZ_01_01_P") + "</GBD_IJZ_01_01_P>" + cLf);
		outFile.write("<GBD_IJZ_02_01_L>" + rs.getString("GBD_IJZ_02_01_L") + "</GBD_IJZ_02_01_L>" + cLf);
		outFile.write("<GBD_IJZ_02_01_P>" + rs.getString("GBD_IJZ_02_01_P") + "</GBD_IJZ_02_01_P>" + cLf);
		outFile.write("<GBD_IJZ_02_02_L>" + rs.getString("GBD_IJZ_02_02_L") + "</GBD_IJZ_02_02_L>" + cLf);
		outFile.write("<GBD_IJZ_02_02_P>" + rs.getString("GBD_IJZ_02_02_P") + "</GBD_IJZ_02_02_P>" + cLf);
		outFile.write("<GBD_IJZ_03_01_L>" + rs.getString("GBD_IJZ_03_01_L") + "</GBD_IJZ_03_01_L>" + cLf);
		outFile.write("<GBD_IJZ_03_01_P>" + rs.getString("GBD_IJZ_03_01_P") + "</GBD_IJZ_03_01_P>" + cLf);
		outFile.write("<GBD_IJZ_03_02_L>" + rs.getString("GBD_IJZ_03_02_L") + "</GBD_IJZ_03_02_L>" + cLf);
		outFile.write("<GBD_IJZ_03_02_P>" + rs.getString("GBD_IJZ_03_02_P") + "</GBD_IJZ_03_02_P>" + cLf);
		outFile.write("<GBD_IJZ_04_01_L>" + rs.getString("GBD_IJZ_04_01_L") + "</GBD_IJZ_04_01_L>" + cLf);
		outFile.write("<GBD_IJZ_04_01_P>" + rs.getString("GBD_IJZ_04_01_P") + "</GBD_IJZ_04_01_P>" + cLf);
		outFile.write("<GBD_IJZ_04_02_L>" + rs.getString("GBD_IJZ_04_02_L") + "</GBD_IJZ_04_02_L>" + cLf);
		outFile.write("<GBD_IJZ_04_02_P>" + rs.getString("GBD_IJZ_04_02_P") + "</GBD_IJZ_04_02_P>" + cLf);
		outFile.write("<GBD_IJZ_05_01_L>" + rs.getString("GBD_IJZ_05_01_L") + "</GBD_IJZ_05_01_L>" + cLf);
		outFile.write("<GBD_IJZ_05_01_P>" + rs.getString("GBD_IJZ_05_01_P") + "</GBD_IJZ_05_01_P>" + cLf);
		outFile.write("<GBD_IJZ_05_02_L>" + rs.getString("GBD_IJZ_05_02_L") + "</GBD_IJZ_05_02_L>" + cLf);
		outFile.write("<GBD_IJZ_05_02_P>" + rs.getString("GBD_IJZ_05_02_P") + "</GBD_IJZ_05_02_P>" + cLf);
		outFile.write("<GBD_IJZ_06_01_L>" + rs.getString("GBD_IJZ_06_01_L") + "</GBD_IJZ_06_01_L>" + cLf);
		outFile.write("<GBD_IJZ_06_01_P>" + rs.getString("GBD_IJZ_06_01_P") + "</GBD_IJZ_06_01_P>" + cLf);
		outFile.write("<GBD_IJZ_06_02_L>" + rs.getString("GBD_IJZ_06_02_L") + "</GBD_IJZ_06_02_L>" + cLf);
		outFile.write("<GBD_IJZ_06_02_P>" + rs.getString("GBD_IJZ_06_02_P") + "</GBD_IJZ_06_02_P>" + cLf);
		outFile.write("<GBD_IJZ_07_01_L>" + rs.getString("GBD_IJZ_07_01_L") + "</GBD_IJZ_07_01_L>" + cLf);
		outFile.write("<GBD_IJZ_07_01_P>" + rs.getString("GBD_IJZ_07_01_P") + "</GBD_IJZ_07_01_P>" + cLf);
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
