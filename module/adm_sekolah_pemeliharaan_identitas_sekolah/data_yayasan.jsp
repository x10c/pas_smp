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

	String 		kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");
	
	ResultSet	rs;
	String		q;
	String		data;

	q=" select	kd_tahun_ajaran"
	+" ,		kd_akreditasi"
	+" ,		ifnull(no_data_sekolah, '') as no_data_sekolah"
	+" ,		nm_yayasan"
	+" ,		jalan_yayasan"
	+" ,		id_propinsi"
	+" ,		id_kabupaten"
	+" ,		id_kecamatan"
	+" ,		kd_desa_yayasan"
	+" ,		no_akte_yayasan"
	+" ,		tanggal_akte_yayasan"
	+" ,		kd_kel_yayasan"
	+" from		t_sekolah_sk_swasta "
	+" where	kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Yayasan tidak ditemukan!'}");
		return;
	}

	data	="{ kd_tahun_ajaran	: '"+ rs.getString("kd_tahun_ajaran") + "'"
			+", kd_akreditasi : '"+ rs.getString("kd_akreditasi") + "'"
			+", no_data_sekolah : '"+ rs.getString("no_data_sekolah") + "'"
			+", nm_yayasan : '"+ rs.getString("nm_yayasan") + "'"
			+", jalan_yayasan : '"+ rs.getString("jalan_yayasan") + "'"
			+", id_propinsi : "+ rs.getString("id_propinsi")
			+", id_kabupaten : "+ rs.getString("id_kabupaten")
			+", id_kecamatan : "+ rs.getString("id_kecamatan")
			+", kd_desa_yayasan : '"+ rs.getString("kd_desa_yayasan") + "'"
			+", no_akte_yayasan : '"+ rs.getString("no_akte_yayasan") + "'"
			+", tanggal_akte_yayasan : '"+ rs.getString("tanggal_akte_yayasan") + "'"
			+", kd_kel_yayasan : '"+ rs.getString("kd_kel_yayasan") + "'";

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
