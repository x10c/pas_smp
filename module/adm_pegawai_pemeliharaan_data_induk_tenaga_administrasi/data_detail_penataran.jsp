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
	+" ,		id_penataran"
	+" ,		kd_penyelenggara_penataran"
	+" ,		kd_jenis_penataran"
	+" ,		kd_jenis_peserta_penataran"
	+" ,		tanggal_awal"
	+" ,		tanggal_akhir"
	+" ,		jam"
	+" from		t_pegawai_penataran"
	+" where	nip			= " + nip
	+" and		no_urut		= " + no_urut;
	
	rs	= db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Penataran tidak ditemukan!'}");
		return;
	}
	
	data 	="{ nip : "+ rs.getString("nip")
			+ ", no_urut : "+ rs.getString("no_urut")
			+ ", id_penataran : "+ rs.getString("id_penataran")
			+ ", kd_penyelenggara_penataran : '"+ rs.getString("kd_penyelenggara_penataran") + "'"
			+ ", kd_jenis_penataran : '"+ rs.getString("kd_jenis_penataran") + "'"
			+ ", kd_jenis_peserta_penataran : '"+ rs.getString("kd_jenis_peserta_penataran") + "'"
			+ ", tanggal_awal : '"+ rs.getString("tanggal_awal") + "'"
			+ ", tanggal_akhir : "+ rs.getString("tanggal_akhir")
			+ ", jam : "+ rs.getString("jam") + "}";
	
	rs.close();
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
