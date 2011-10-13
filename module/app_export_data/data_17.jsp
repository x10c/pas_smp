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

File		outputFile	= new File("C:\\17 - " + kd_tahun_ajaran + "_" + npsn + "_A_SEKOLAH_PEGAWAI_12.XML");
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
		+" 		SELECT		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TETAP,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '01'"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_01_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TAK_TETAP,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan 	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '01'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_01_02"
		+" ,		("
		+" 		SELECT		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TETAP,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '13'"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_02_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TAK_TETAP,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan 	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '13'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_02_02"
		+" ,		("
		+" 		SELECT		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TETAP,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '02'"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_03_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TAK_TETAP,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan 	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '02'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_03_02"
		+" ,		("
		+" 		SELECT		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TETAP,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '04'"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_04_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TAK_TETAP,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan 	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '04'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_04_02"
		+" ,		("
		+" 		SELECT		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TETAP,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '15'"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_05_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TAK_TETAP,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan 	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '15'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_05_02"
		+" ,		("
		+" 		SELECT		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TETAP,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '03'"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_06_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TAK_TETAP,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan 	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '03'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_06_02"
		+" ,		("
		+" 		SELECT		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TETAP,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '29'"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_07_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TAK_TETAP,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan 	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '29'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_07_02"
		+" ,		("
		+" 		SELECT		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TETAP,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '30'"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_08_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TAK_TETAP,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan 	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '30'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_08_02"
		+" ,		("
		+" 		SELECT		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TETAP,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '22'"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_09_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TAK_TETAP,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan 	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '22'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_09_02"
		+" ,		("
		+" 		SELECT		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TETAP,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '11'"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_10_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TAK_TETAP,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan 	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '11'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_10_02"
		+" ,		("
		+" 		SELECT		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TETAP,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '19'"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_11_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TAK_TETAP,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan 	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '19'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_11_02"
		+" ,		("
		+" 		SELECT		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TETAP,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '21'"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_12_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TAK_TETAP,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan 	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '21'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_12_02"
		+" ,		("
		+" 		SELECT		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TETAP,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '16'"
		+" 		WHERE		r_tahun_ajaran.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_13_01"
		+" ,		("
		+" 		SELECT 		IFNULL(t_pegawai_guru_kebutuhan.JUMLAH_TAK_TETAP,0)"
		+" 		FROM		r_tahun_ajaran"
		+" 		LEFT JOIN 	t_pegawai_guru_kebutuhan 	ON	t_pegawai_guru_kebutuhan.KD_TAHUN_AJARAN 		= r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 												AND	t_pegawai_guru_kebutuhan.KD_KEL_MATA_PELAJARAN 	= '16'"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS GRU_13_02"
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
		outFile.write("<GRU_01_01>" + rs.getString("GRU_01_01") + "</GRU_01_01>" + cLf);
		outFile.write("<GRU_01_02>" + rs.getString("GRU_01_02") + "</GRU_01_02>" + cLf);
		outFile.write("<GRU_02_01>" + rs.getString("GRU_02_01") + "</GRU_02_01>" + cLf);
		outFile.write("<GRU_02_02>" + rs.getString("GRU_02_02") + "</GRU_02_02>" + cLf);
		outFile.write("<GRU_03_01>" + rs.getString("GRU_03_01") + "</GRU_03_01>" + cLf);
		outFile.write("<GRU_03_02>" + rs.getString("GRU_03_02") + "</GRU_03_02>" + cLf);
		outFile.write("<GRU_04_01>" + rs.getString("GRU_04_01") + "</GRU_04_01>" + cLf);
		outFile.write("<GRU_04_02>" + rs.getString("GRU_04_02") + "</GRU_04_02>" + cLf);
		outFile.write("<GRU_05_01>" + rs.getString("GRU_05_01") + "</GRU_05_01>" + cLf);
		outFile.write("<GRU_05_02>" + rs.getString("GRU_05_02") + "</GRU_05_02>" + cLf);
		outFile.write("<GRU_06_01>" + rs.getString("GRU_06_01") + "</GRU_06_01>" + cLf);
		outFile.write("<GRU_06_02>" + rs.getString("GRU_06_02") + "</GRU_06_02>" + cLf);
		outFile.write("<GRU_07_01>" + rs.getString("GRU_07_01") + "</GRU_07_01>" + cLf);
		outFile.write("<GRU_07_02>" + rs.getString("GRU_07_02") + "</GRU_07_02>" + cLf);
		outFile.write("<GRU_08_01>" + rs.getString("GRU_08_01") + "</GRU_08_01>" + cLf);
		outFile.write("<GRU_08_02>" + rs.getString("GRU_08_02") + "</GRU_08_02>" + cLf);
		outFile.write("<GRU_09_01>" + rs.getString("GRU_09_01") + "</GRU_09_01>" + cLf);
		outFile.write("<GRU_09_02>" + rs.getString("GRU_09_02") + "</GRU_09_02>" + cLf);
		outFile.write("<GRU_10_01>" + rs.getString("GRU_10_01") + "</GRU_10_01>" + cLf);
		outFile.write("<GRU_10_02>" + rs.getString("GRU_10_02") + "</GRU_10_02>" + cLf);
		outFile.write("<GRU_11_01>" + rs.getString("GRU_11_01") + "</GRU_11_01>" + cLf);
		outFile.write("<GRU_11_02>" + rs.getString("GRU_11_02") + "</GRU_11_02>" + cLf);
		outFile.write("<GRU_12_01>" + rs.getString("GRU_12_01") + "</GRU_12_01>" + cLf);
		outFile.write("<GRU_12_02>" + rs.getString("GRU_12_02") + "</GRU_12_02>" + cLf);
		outFile.write("<GRU_13_01>" + rs.getString("GRU_13_01") + "</GRU_13_01>" + cLf);
		outFile.write("<GRU_13_02>" + rs.getString("GRU_13_02") + "</GRU_13_02>" + cLf);
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
