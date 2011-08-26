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
	
	String 		nip		= request.getParameter("nip");
	String 		no_urut	= request.getParameter("no_urut");

	ResultSet	rs;
	String		q;
	String		data;

	q=" select	nip"
	+" ,		no_urut"
	+" ,		kd_tingkat_ijazah"
	+" ,		nm_instansi_penddkn"
	+" ,		kd_program_studi"
	+" ,		kd_akreditasi"
	+" ,		tahun_mulai"
	+" ,		kd_status_lulus"
	+" ,		tahun_selesai"
	+" ,		no_ijazah"
	+" ,		tanggal_ijazah"
	+" from		t_pegawai_didik_formal"
	+" where	nip			= " + nip
	+" and		no_urut		= " + no_urut;
	
	rs	= db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Pendidikan Formal tidak ditemukan!'}");
		return;
	}
	
	data 	="{ nip : "+ rs.getString("nip")
			+ ", no_urut : "+ rs.getString("no_urut")
			+ ", kd_tingkat_ijazah : '"+ rs.getString("kd_tingkat_ijazah") + "'"
			+ ", nm_instansi_penddkn : '"+ rs.getString("nm_instansi_penddkn") + "'"
			+ ", kd_program_studi : '"+ rs.getString("kd_program_studi") + "'"
			+ ", kd_akreditasi : '"+ rs.getString("kd_akreditasi") + "'"
			+ ", tahun_mulai : "+ rs.getString("tahun_mulai")
			+ ", kd_status_lulus : '"+ rs.getString("kd_status_lulus") + "'"
			+ ", tahun_selesai : "+ rs.getString("tahun_selesai")
			+ ", no_ijazah : '"+ rs.getString("no_ijazah") + "'"
			+ ", tanggal_ijazah : '"+ rs.getString("tanggal_ijazah") + "'}";
	
	rs.close();
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
