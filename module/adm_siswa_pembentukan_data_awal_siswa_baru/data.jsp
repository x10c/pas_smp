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
	
	String 		id_siswa		= request.getParameter("id_siswa");

	ResultSet	rs;
	String		q;
	String		data;

	q=" select	*"
	 +" from	t_siswa"
	 +" where	id_siswa	= '" + id_siswa + "'";
	
	rs	= db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Siswa tidak ditemukan!'}");
		return;
	}
	
	data 	="{ id_siswa : '"+ rs.getString("id_siswa") + "'"
			+ ", nis : '"+ rs.getString("nis") + "'"
			+ ", nm_siswa : '"+ rs.getString("nm_siswa") + "'"
			+ ", nm_panggilan : '"+ rs.getString("nm_panggilan") + "'"
			+ ", kd_jenis_kelamin : '"+ rs.getString("kd_jenis_kelamin") + "'"
			+ ", kota_lahir : '"+ rs.getString("kota_lahir") + "'"
			+ ", tanggal_lahir : '"+ rs.getString("tanggal_lahir") + "'"
			+ ", alamat : '"+ rs.getString("alamat") + "'"
			+ ", rt : '"+ rs.getString("rt") + "'"
			+ ", rw : '"+ rs.getString("rw") + "'"
			+ ", kd_pos : '"+ rs.getString("kd_pos") + "'"
			+ ", kd_gol_darah : '"+ rs.getString("kd_gol_darah") + "'"
			+ ", kd_agama : '"+ rs.getString("kd_agama") + "'"
			+ ", no_telp : '"+ rs.getString("no_telp") + "'"
			+ ", no_hp : '"+ rs.getString("no_hp") + "'"
			+ ", status_siswa : '"+ rs.getString("status_siswa") + "'"
			+ ", asal_sd : "+ rs.getString("asal_sd")
			+ ", asal_smp : "+ rs.getString("asal_smp")
			+ ", kd_tingkat_kelas : '"+ rs.getString("kd_tingkat_kelas") + "'"
			+ ", diterima_tanggal : '"+ rs.getString("diterima_tanggal") + "'"
			+ ", pindah_alasan : '"+ rs.getString("pindah_alasan") + "'"
			+ ", nilai : "+ rs.getString("nilai")
			+ ", status_entri : '"+ rs.getString("status_entri") + "'"
			+ ", username : '"+ rs.getString("username") + "'"
			+ ", tanggal_akses : '"+ rs.getString("tanggal_akses") +"'}";
	
	rs.close();
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
