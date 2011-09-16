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
	+" ,		lanjut_jauh"
	+" ,		biaya"
	+" ,		transportasi"
	+" ,		geografi"
	+" ,		terpencil"
	+" ,		kurang_penting"
	+" ,		kerja"
	+" ,		menikah"
	+" ,		lain_lain"
	+" ,		keterangan"
	+" from		t_sekolah_do "
	+" where	kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Peringkat DO tidak ditemukan!'}");
		return;
	}

	data	="{ kd_tahun_ajaran	: '"+ rs.getString("kd_tahun_ajaran") + "'"
			+", lanjut_jauh : "+ rs.getString("lanjut_jauh")
			+", biaya : "+ rs.getString("biaya")
			+", transportasi : "+ rs.getString("transportasi")
			+", geografi : "+ rs.getString("geografi")
			+", terpencil : "+ rs.getString("terpencil")
			+", kurang_penting : "+ rs.getString("kurang_penting")
			+", kerja : "+ rs.getString("kerja")
			+", menikah : "+ rs.getString("menikah")
			+", lain_lain : "+ rs.getString("lain_lain")
			+", keterangan : \""+ rs.getString("keterangan") +"\"";

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
