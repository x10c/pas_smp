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

File		outputFile	= new File("C:\\02 - " + kd_tahun_ajaran + "_" + npsn + "_A_SEKOLAH.XML");
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
		+" 		FROM 	t_pegawai_rombel"
		+" 		WHERE	KD_TINGKAT_KELAS	= '01'"
		+" 		AND		KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS RMB_01"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM 	t_pegawai_rombel"
		+" 		WHERE	KD_TINGKAT_KELAS	= '02'"
		+" 		AND		KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS RMB_02"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM 	t_pegawai_rombel"
		+" 		WHERE	KD_TINGKAT_KELAS	= '03'"
		+" 		AND		KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS RMB_03"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM 	t_siswa_tingkat"
		+" 		WHERE	KD_STATUS_SISWA		IN ('0','3','4')"
		+" 		AND		KD_TINGKAT_KELAS 	= '03'"
		+" 		AND		KD_JENIS_KELAMIN 	= '1'"
		+" 		AND		KD_EBTA 			= '1'"
		+" 		AND		KD_TAHUN_AJARAN 	= RIGHT('00' + CAST((CAST('" + kd_tahun_ajaran + "' AS SIGNED)-1) AS CHAR), 2)"
		+" 		) AS PST_UN_L"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM 	t_siswa_tingkat"
		+" 		WHERE	KD_STATUS_SISWA		IN ('0','3','4')"
		+" 		AND		KD_TINGKAT_KELAS 	= '03'"
		+" 		AND		KD_JENIS_KELAMIN 	= '2'"
		+" 		AND		KD_EBTA 			= '1'"
		+" 		AND		KD_TAHUN_AJARAN 	= RIGHT('00' + CAST((CAST('" + kd_tahun_ajaran + "' AS SIGNED)-1) AS CHAR), 2)"
		+" 		) AS PST_UN_P"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM 	t_siswa_tingkat"
		+" 		WHERE	KD_STATUS_SISWA		IN ('0','3','4')"
		+" 		AND		KD_TINGKAT_KELAS 	= '03'"
		+" 		AND		KD_JENIS_KELAMIN 	= '1'"
		+" 		AND		KD_EBTA 			= '1'"
		+" 		AND		KD_LULUS 			= '1'"
		+" 		AND		KD_TAHUN_AJARAN 	= RIGHT('00' + CAST((CAST('" + kd_tahun_ajaran + "' AS SIGNED)-1) AS CHAR), 2)"
		+" 		) AS LLS_L"
		+" ,		("
		+" 		SELECT	COUNT(*)"
		+" 		FROM 	t_siswa_tingkat"
		+" 		WHERE	KD_STATUS_SISWA		IN ('0','3','4')"
		+" 		AND		KD_TINGKAT_KELAS 	= '03'"
		+" 		AND		KD_JENIS_KELAMIN 	= '2'"
		+" 		AND		KD_EBTA 			= '1'"
		+" 		AND		KD_LULUS 			= '1'"
		+" 		AND		KD_TAHUN_AJARAN 	= RIGHT('00' + CAST((CAST('" + kd_tahun_ajaran + "' AS SIGNED)-1) AS CHAR), 2)"
		+" 		) AS LLS_P"
		+" ,		4 AS JML_UN"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(nilai_un_indo), 0.00)"
		+" 		FROM 	k_sekolah_lism"
		+" 		WHERE	KD_TAHUN_AJARAN 	= RIGHT('00' + CAST((CAST('" + kd_tahun_ajaran + "' AS SIGNED)-1) AS CHAR), 2)"
		+" 		) AS NIL_UN_INDO"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(nilai_un_mat), 0.00)"
		+" 		FROM 	k_sekolah_lism"
		+" 		WHERE	KD_TAHUN_AJARAN 	= RIGHT('00' + CAST((CAST('" + kd_tahun_ajaran + "' AS SIGNED)-1) AS CHAR), 2)"
		+" 		) AS NIL_UN_MAT"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(nilai_un_ing), 0.00)"
		+" 		FROM 	k_sekolah_lism"
		+" 		WHERE	KD_TAHUN_AJARAN 	= RIGHT('00' + CAST((CAST('" + kd_tahun_ajaran + "' AS SIGNED)-1) AS CHAR), 2)"
		+" 		) AS NIL_UN_ING"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(nilai_un_ipa), 0.00)"
		+" 		FROM 	k_sekolah_lism"
		+" 		WHERE	KD_TAHUN_AJARAN 	= RIGHT('00' + CAST((CAST('" + kd_tahun_ajaran + "' AS SIGNED)-1) AS CHAR), 2)"
		+" 		) AS NIL_UN_IPA"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(jml_jam_lab_ipa), 0)"
		+" 		FROM 	k_sekolah_lism"
		+" 		WHERE	KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS LAB_IPA"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(jml_jam_lab_kimia), 0)"
		+" 		FROM 	k_sekolah_lism"
		+" 		WHERE	KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS LAB_KIMIA"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(jml_jam_lab_fisika), 0)"
		+" 		FROM 	k_sekolah_lism"
		+" 		WHERE	KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS LAB_FISIKA"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(jml_jam_lab_biologi), 0)"
		+" 		FROM 	k_sekolah_lism"
		+" 		WHERE	KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS LAB_BIOLOGI"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(jml_jam_lab_bahasa), 0)"
		+" 		FROM 	k_sekolah_lism"
		+" 		WHERE	KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS LAB_BAHASA"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(jml_jam_lab_ips), 0)"
		+" 		FROM 	k_sekolah_lism"
		+" 		WHERE	KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS LAB_IPS"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(jml_jam_lab_komputer), 0)"
		+" 		FROM 	k_sekolah_lism"
		+" 		WHERE	KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS LAB_KOMPUTER"
		+" ,		("
		+" 		SELECT	IFNULL(SUM(jml_jam_lab_multimedia), 0)"
		+" 		FROM 	k_sekolah_lism"
		+" 		WHERE	KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS LAB_MULTIMEDIA"
		+" FROM 	t_sekolah_identitas"
		+" WHERE	KD_TAHUN_AJARAN = '" + kd_tahun_ajaran + "'";

	ResultSet	rs	= db_stmt.executeQuery(q);

	outFile.write("<DATA>" + cLf);
	
	while (rs.next()){
		outFile.write("<DATA_ROW>" + cLf);
		outFile.write("<KD_TAHUN_AJARAN>" + rs.getString("KD_TAHUN_AJARAN") + "</KD_TAHUN_AJARAN>" + cLf);
		outFile.write("<ID_PROPINSI>" + rs.getString("ID_PROPINSI") + "</ID_PROPINSI>" + cLf);
		outFile.write("<ID_KABUPATEN>" + rs.getString("ID_KABUPATEN") + "</ID_KABUPATEN>" + cLf);
		outFile.write("<ID_KECAMATAN>" + rs.getString("ID_KECAMATAN") + "</ID_KECAMATAN>" + cLf);
		outFile.write("<NPSN>" + rs.getString("NPSN") + "</NPSN>" + cLf);
		outFile.write("<RMB_01>" + rs.getString("RMB_01") + "</RMB_01>" + cLf);
		outFile.write("<RMB_02>" + rs.getString("RMB_02") + "</RMB_02>" + cLf);
		outFile.write("<RMB_03>" + rs.getString("RMB_03") + "</RMB_03>" + cLf);
		outFile.write("<PST_UN_L>" + rs.getString("PST_UN_L") + "</PST_UN_L>" + cLf);
		outFile.write("<PST_UN_P>" + rs.getString("PST_UN_P") + "</PST_UN_P>" + cLf);
		outFile.write("<LLS_L>" + rs.getString("LLS_L") + "</LLS_L>" + cLf);
		outFile.write("<LLS_P>" + rs.getString("LLS_P") + "</LLS_P>" + cLf);
		outFile.write("<JML_UN>" + rs.getString("JML_UN") + "</JML_UN>" + cLf);
		outFile.write("<NIL_UN_INDO>" + rs.getString("NIL_UN_INDO") + "</NIL_UN_INDO>" + cLf);
		outFile.write("<NIL_UN_MAT>" + rs.getString("NIL_UN_MAT") + "</NIL_UN_MAT>" + cLf);
		outFile.write("<NIL_UN_ING>" + rs.getString("NIL_UN_ING") + "</NIL_UN_ING>" + cLf);
		outFile.write("<NIL_UN_IPA>" + rs.getString("NIL_UN_IPA") + "</NIL_UN_IPA>" + cLf);
		outFile.write("<LAB_IPA>" + rs.getString("LAB_IPA") + "</LAB_IPA>" + cLf);
		outFile.write("<LAB_KIMIA>" + rs.getString("LAB_KIMIA") + "</LAB_KIMIA>" + cLf);
		outFile.write("<LAB_FISIKA>" + rs.getString("LAB_FISIKA") + "</LAB_FISIKA>" + cLf);
		outFile.write("<LAB_BIOLOGI>" + rs.getString("LAB_BIOLOGI") + "</LAB_BIOLOGI>" + cLf);
		outFile.write("<LAB_BAHASA>" + rs.getString("LAB_BAHASA") + "</LAB_BAHASA>" + cLf);
		outFile.write("<LAB_IPS>" + rs.getString("LAB_IPS") + "</LAB_IPS>" + cLf);
		outFile.write("<LAB_KOMPUTER>" + rs.getString("LAB_KOMPUTER") + "</LAB_KOMPUTER>" + cLf);
		outFile.write("<LAB_MULTIMEDIA>" + rs.getString("LAB_MULTIMEDIA") + "</LAB_MULTIMEDIA>" + cLf);
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
