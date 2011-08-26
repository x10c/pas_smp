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
	 +" from	t_siswa_putus "
	 +" where	nis	= '" + nis + "'";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Putus Sekolah Siswa tidak ditemukan!'}");
		return;
	}

	data	="{ nis	: '"+ rs.getString("nis") + "'"
			+", tanggal_keluar : '"+ rs.getString("tanggal_keluar") + "'"
			+", alasan_keluar : '"+ rs.getString("alasan_keluar") + "'"
			+", username : '"+ rs.getString("username") + "'"
			+", tanggal_akses : '"+ rs.getString("tanggal_akses") + "'";

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
