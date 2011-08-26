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
	+" ,		nm_keluarga"
	+" ,		kd_hub_keluarga"
	+" ,		prop_lahir"
	+" ,		kota_lahir"
	+" ,		tanggal_lahir"
	+" ,		kd_jenis_kelamin"
	+" ,		kd_gol_darah"
	+" ,		kd_agama"
	+" ,		kd_status_nikah"
	+" ,		tanggal_menikah"
	+" ,		tahun_meninggal"
	+" ,		alamat"
	+" from		t_pegawai_keluarga"
	+" where	nip			= " + nip
	+" and		no_urut		= " + no_urut;
	
	rs	= db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Keluarga tidak ditemukan!'}");
		return;
	}
	
	data 	="{ nip : "+ rs.getString("nip")
			+ ", no_urut : "+ rs.getString("no_urut")
			+ ", nm_keluarga : '"+ rs.getString("nm_keluarga") + "'"
			+ ", kd_hub_keluarga : '"+ rs.getString("kd_hub_keluarga") + "'"
			+ ", prop_lahir : '"+ rs.getString("prop_lahir") + "'"
			+ ", kota_lahir : '"+ rs.getString("kota_lahir") + "'"
			+ ", tanggal_lahir : '"+ rs.getString("tanggal_lahir") + "'"
			+ ", kd_jenis_kelamin : '"+ rs.getString("kd_jenis_kelamin") + "'"
			+ ", kd_gol_darah : '"+ rs.getString("kd_gol_darah") + "'"
			+ ", kd_agama : '"+ rs.getString("kd_agama") + "'"
			+ ", kd_status_nikah : '"+ rs.getString("kd_status_nikah") + "'"
			+ ", tanggal_menikah : '"+ rs.getString("tanggal_menikah") + "'"
			+ ", tahun_meninggal : "+ rs.getString("tahun_meninggal")
			+ ", alamat : '"+ rs.getString("alamat") +"'}";
	
	rs.close();
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
