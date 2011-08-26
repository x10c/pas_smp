<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	
	String 		kd_tahun_ajaran	= (String) session.getAttribute("kd.tahun_pelajaran");
	String 		no_urut			= request.getParameter("no_urut");

	ResultSet	rs;
	String		q;
	String		data;

	q=" select	kd_tahun_ajaran"
	+" ,		no_urut"
	+" ,		nm_narasumber"
	+" ,		tanggal_lahir"
	+" ,		kd_tingkat_ijazah"
	+" ,		kd_program_studi"
	+" ,		id_gol_pekerjaan_ortu"
	+" ,		bidang_keahlian"
	+" ,		sedia_waktu"
	+" ,		keterangan"
	+" from		t_sekolah_pkh_narasumber"
	+" where	kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'"
	+" and		no_urut			= " + no_urut;
	
	rs	= db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Narasumber PKH tidak ditemukan!'}");
		return;
	}
	
	data 	="{ kd_tahun_ajaran : '"+ rs.getString("kd_tahun_ajaran") + "'"
			+ ", no_urut : "+ rs.getString("no_urut")
			+ ", nm_narasumber : '"+ rs.getString("nm_narasumber") + "'"
			+ ", tanggal_lahir : '"+ rs.getString("tanggal_lahir") + "'"
			+ ", kd_tingkat_ijazah : '"+ rs.getString("kd_tingkat_ijazah") + "'"
			+ ", kd_program_studi : '"+ rs.getString("kd_program_studi") + "'"
			+ ", id_gol_pekerjaan_ortu : "+ rs.getString("id_gol_pekerjaan_ortu")
			+ ", bidang_keahlian : '"+ rs.getString("bidang_keahlian") + "'"
			+ ", sedia_waktu : "+ rs.getString("sedia_waktu")
			+ ", keterangan : '"+ rs.getString("keterangan") +"'}";
	
	rs.close();
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
