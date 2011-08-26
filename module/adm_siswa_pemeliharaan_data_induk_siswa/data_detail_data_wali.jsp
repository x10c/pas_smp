<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String 		nis		= request.getParameter("nis");
	
	ResultSet	rs;
	String		q;
	String		data;

	q=" select	*"
	 +" from	t_siswa_ortu "
	 +" where	kd_jenis_ortu	= '3'"
	 +" and		nis				= '" + nis + "'";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Ibu Siswa tidak ditemukan!'}");
		return;
	}

	data	="{ nis	: '"+ rs.getString("nis") + "'"
			+", kd_jenis_ortu : '"+ rs.getString("kd_jenis_ortu") + "'"
			+", kd_jenis_kelamin : '"+ rs.getString("kd_jenis_kelamin") + "'"
			+", status_hub : '"+ rs.getString("status_hub") + "'"
			+", nm_ortu : '"+ rs.getString("nm_ortu") + "'"
			+", alamat : '"+ rs.getString("alamat") + "'"
			+", rt : '"+ rs.getString("rt") + "'"
			+", rw : '"+ rs.getString("rw") + "'"
			+", kd_pos : '"+ rs.getString("kd_pos") + "'"
			+", id_propinsi : "+ rs.getString("id_propinsi")
			+", id_kabupaten : "+ rs.getString("id_kabupaten")
			+", no_telp : '"+ rs.getString("no_telp") + "'"
			+", no_hp : '"+ rs.getString("no_hp") + "'"
			+", kota_lahir : '"+ rs.getString("kota_lahir") + "'"
			+", tanggal_lahir : '"+ rs.getString("tanggal_lahir") + "'"
			+", kd_agama : '"+ rs.getString("kd_agama") + "'"
			+", kd_status_nikah : '"+ rs.getString("kd_status_nikah") + "'"
			+", kewarganegaraan : '"+ rs.getString("kewarganegaraan") + "'"
			+", kd_tingkat_ijazah : '"+ rs.getString("kd_tingkat_ijazah") + "'"
			+", id_gol_pekerjaan_ortu : "+ rs.getString("id_gol_pekerjaan_ortu")
			+", gaji : "+ rs.getString("gaji")
			+", status_hidup : '"+ rs.getString("status_hidup") + "'"
			+", tahun_meninggal : "+ rs.getString("tahun_meninggal")
			+", username : '"+ rs.getString("username") + "'"
			+", tanggal_akses : '"+ rs.getString("tanggal_akses") + "'"
			+", no_induk : '"+ rs.getString("no_induk") + "'";

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
