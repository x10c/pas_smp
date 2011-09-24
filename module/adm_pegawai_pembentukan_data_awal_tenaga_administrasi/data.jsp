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
	String 		id_pegawai				= request.getParameter("id_pegawai");

	ResultSet	rs;
	String		q;
	String		data;

	q=" select	id_pegawai"
	+" ,		nip"
	+" ,		nuptk"
	+" ,		nm_pegawai"
	+" ,		inisial"
	+" ,		kota_lahir"
	+" ,		tanggal_lahir"
	+" ,		kd_jenis_kelamin"
	+" ,		kd_agama"
	+" ,		alamat"
	+" ,		kd_pos"
	+" ,		kd_gol_darah"
	+" ,		no_telp"
	+" ,		no_hp"
	+" ,		kd_status_nikah"
	+" ,		operasi_komputer"
	+" ,		kursus_komputer"
	+" ,		sertifikasi"
	+" from		t_pegawai"
	+" where	id_pegawai			= " + id_pegawai;
	
	rs	= db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Tenaga Administrasi tidak ditemukan!'}");
		return;
	}
	
	data 	= "{ id_pegawai : "+ rs.getString("id_pegawai")
			+ ", nip : '"+ rs.getString("nip") + "'"
			+ ", nuptk : '"+ rs.getString("nuptk") + "'"
			+ ", nm_pegawai : '"+ rs.getString("nm_pegawai") + "'"
			+ ", inisial : '"+ rs.getString("inisial") + "'"
			+ ", kota_lahir : '"+ rs.getString("kota_lahir") + "'"
			+ ", tanggal_lahir : '"+ rs.getString("tanggal_lahir") + "'"
			+ ", kd_jenis_kelamin : '"+ rs.getString("kd_jenis_kelamin") + "'"
			+ ", kd_agama : '"+ rs.getString("kd_agama") + "'"
			+ ", alamat : '"+ rs.getString("alamat") + "'"
			+ ", kd_pos : '"+ rs.getString("kd_pos") + "'"
			+ ", kd_gol_darah : '"+ rs.getString("kd_gol_darah") + "'"
			+ ", no_telp : '"+ rs.getString("no_telp") + "'"
			+ ", no_hp : '"+ rs.getString("no_hp") + "'"
			+ ", kd_status_nikah : '"+ rs.getString("kd_status_nikah") + "'"
			+ ", operasi_komputer : '"+ rs.getString("operasi_komputer") + "'"
			+ ", kursus_komputer : '"+ rs.getString("kursus_komputer") + "'"
			+ ", sertifikasi : '"+ rs.getString("sertifikasi") + "'}";
	
	rs.close();
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
