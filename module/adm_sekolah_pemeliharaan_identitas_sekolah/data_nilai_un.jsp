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
	+" ,		nilai_un_indo"
	+" ,		nilai_un_mat"
	+" ,		nilai_un_ing"
	+" ,		nilai_un_ipa"
	+" from		k_sekolah_lism "
	+" where	kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Penggunaan Laboratorium tidak ditemukan!'}");
		return;
	}

	data	="{ kd_tahun_ajaran	: '"+ rs.getString("kd_tahun_ajaran") + "'"
			+", nilai_un_indo : "+ rs.getString("nilai_un_indo")
			+", nilai_un_mat : "+ rs.getString("nilai_un_mat")
			+", nilai_un_ing : "+ rs.getString("nilai_un_ing")
			+", nilai_un_ipa : "+ rs.getString("nilai_un_ipa");

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
