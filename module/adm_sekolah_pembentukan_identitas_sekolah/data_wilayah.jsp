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

	ResultSet	rs;
	String		q;
	String		data;

	q=" select	a.id_propinsi"
	+" ,		b.id_kabupaten"
	+" from		r_propinsi	as a"
	+" ,		r_kabupaten	as b"
	+" where	a.status_pilih	= '1'"
	+" and		b.status_pilih	= '1'";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Wilayah tidak ditemukan!'}");
		return;
	}

	data	="{ id_propinsi	: "+ rs.getString("id_propinsi")
			+", id_kabupaten : "+ rs.getString("id_kabupaten");

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
