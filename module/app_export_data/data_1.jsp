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

File		outputFile	= new File("C:\\01 - " + kd_tahun_ajaran + "_" + npsn + "_A_TAHUN_WILAYAH_SEKOLAH.XML");
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
		+" ,		NM_SEKOLAH"
		+" ,		KD_STATUS_SEKOLAH"
		+" ,		KD_BENTUK_SEKOLAH"
		+" ,		KD_JENIS_SEKOLAH"
		+" ,		KD_WAKTU_PENYELENGGARAAN"
		+" ,		KD_KLASIFIKASI_SEKOLAH"
		+" FROM		t_sekolah_identitas"
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
		outFile.write("<NM_SEKOLAH>" + rs.getString("NM_SEKOLAH") + "</NM_SEKOLAH>" + cLf);
		outFile.write("<KD_STATUS_SEKOLAH>" + rs.getString("KD_STATUS_SEKOLAH") + "</KD_STATUS_SEKOLAH>" + cLf);
		outFile.write("<KD_BENTUK_SEKOLAH>" + rs.getString("KD_BENTUK_SEKOLAH") + "</KD_BENTUK_SEKOLAH>" + cLf);
		outFile.write("<KD_JENIS_SEKOLAH>" + rs.getString("KD_JENIS_SEKOLAH") + "</KD_JENIS_SEKOLAH>" + cLf);
		outFile.write("<KD_WAKTU_PENYELENGGARAAN>" + rs.getString("KD_WAKTU_PENYELENGGARAAN") + "</KD_WAKTU_PENYELENGGARAAN>" + cLf);
		outFile.write("<KD_KLASIFIKASI_SEKOLAH>" + rs.getString("KD_KLASIFIKASI_SEKOLAH") + "</KD_KLASIFIKASI_SEKOLAH>" + cLf);
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
