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

	String 		id_siswa		= request.getParameter("id_siswa");
	
	ResultSet	rs;
	String		q;
	String		data;

	q=" select	*"
	 +" from	t_siswa_putus "
	 +" where	id_siswa	= '" + id_siswa + "'";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Putus Sekolah Siswa tidak ditemukan!'}");
		return;
	}

	data	="{ id_siswa	: '"+ rs.getString("id_siswa") + "'"
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
