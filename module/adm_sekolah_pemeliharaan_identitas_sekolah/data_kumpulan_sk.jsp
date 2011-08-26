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
	+" ,		no_sk_pendirian"
	+" ,		tanggal_sk_pendirian"
	+" ,		kd_keterangan_sk"
	+" ,		no_sk_akhir_status"
	+" ,		tanggal_sk_akhir_status"
	+" ,		no_sk_akreditasi"
	+" ,		tanggal_sk_akreditasi"
	+" ,		no_sk_akreditasi_akhir"
	+" ,		tanggal_sk_akreditasi_akhir"
	+" ,		kd_akreditasi"
	+" from		t_sekolah_sk "
	+" where	kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Kumpulan SK tidak ditemukan!'}");
		return;
	}

	data	="{ kd_tahun_ajaran	: '"+ rs.getString("kd_tahun_ajaran") + "'"
			+", no_sk_pendirian : '"+ rs.getString("no_sk_pendirian") + "'"
			+", tanggal_sk_pendirian : '"+ rs.getString("tanggal_sk_pendirian") + "'"
			+", kd_keterangan_sk : '"+ rs.getString("kd_keterangan_sk") + "'"
			+", no_sk_akhir_status : '"+ rs.getString("no_sk_akhir_status") + "'"
			+", tanggal_sk_akhir_status : '"+ rs.getString("tanggal_sk_akhir_status") + "'"
			+", no_sk_akreditasi : '"+ rs.getString("no_sk_akreditasi") + "'"
			+", tanggal_sk_akreditasi : '"+ rs.getString("tanggal_sk_akreditasi") + "'"
			+", no_sk_akreditasi_akhir : '"+ rs.getString("no_sk_akreditasi_akhir") + "'"
			+", tanggal_sk_akreditasi_akhir : '"+ rs.getString("tanggal_sk_akreditasi_akhir") + "'"
			+", kd_akreditasi : '"+ rs.getString("kd_akreditasi") + "'";

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
