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

	Statement	db_stmt	= db_con.createStatement();

	String id_propinsi 	= request.getParameter("id_propinsi");
	
	String q= " select	a.id_propinsi"
			+ " ,      	a.id_kabupaten"
			+ " ,      	b.nm_kabupaten"
			+ " from   	t_propinsi_kabupaten	as a"
			+ " ,		r_kabupaten				as b"
			+ " where	((a.tahun_akhir is null) or (a.tahun_akhir = ''))"
			+ " and		(a.id_kabupaten = b.id_kabupaten)"
			+ " and		(a.id_propinsi = " + id_propinsi + ")"
			+ " order by b.nm_kabupaten";

	ResultSet	rs = db_stmt.executeQuery(q);
	int		i = 0;
	String		data = "[";

	while (rs.next()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+= "["+ rs.getString("id_propinsi")
			+  ","+ rs.getString("id_kabupaten")
			+  ",\""+ rs.getString("nm_kabupaten") +"\""
			+  "]";
	}

	data += "]";

	out.print(data);

	rs.close();
	db_stmt.close();
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
