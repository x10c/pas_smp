<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement db_stmt = db_con.createStatement();

	q	=" select"
		+" 			kd_tahun_ajaran"
		+" ,		nm_tahun_ajaran"
		+" from		r_tahun_ajaran"
		+" where	cast(left(nm_tahun_ajaran,4) as signed) <= year(now())"
		+" order by	kd_tahun_ajaran desc";

	ResultSet	rs		= db_stmt.executeQuery(q);
	String		data	= "[";
	int			i		= 0;

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i = 1;
		}
		data+= "['"+ rs.getString("kd_tahun_ajaran") +"'"
			+  ",\""+ rs.getString("nm_tahun_ajaran") +"\""
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
