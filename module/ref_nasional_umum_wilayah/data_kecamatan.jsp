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
	String id_kabupaten = request.getParameter("id_kabupaten");
	
	String q= " select	a.id_propinsi"
			+ " ,      	b.id_kabupaten"
			+ " ,      	b.id_kecamatan"
			+ " ,      	c.nm_kecamatan"
			+ " from   	r_propinsi				as a"
			+ " ,		t_kabupaten_kecamatan	as b"
			+ " ,		r_kecamatan				as c"
			+ " where	((b.tahun_akhir is null) or (b.tahun_akhir = ''))"
			+ " and		(b.id_kecamatan = c.id_kecamatan)"
			+ " and		(a.id_propinsi	= " + id_propinsi + ")"
			+ " and		(b.id_kabupaten	= " + id_kabupaten + ")"
			+ " order by c.nm_kecamatan";

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
			+  ","+ rs.getString("id_kecamatan")
			+  ",\""+ rs.getString("nm_kecamatan") +"\""
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
