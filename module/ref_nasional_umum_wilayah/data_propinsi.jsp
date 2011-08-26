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

	String kd_tahun_ajaran	= (String) session.getAttribute("kd.tahun_pelajaran");
	
	String q= " select	a.id_propinsi"
			+ " ,      	a.nm_propinsi"
			+ " from   	r_propinsi		as a"
			+ " ,		r_tahun_ajaran	as b"
			+ " where	(cast(a.tahun_awal as signed) <= cast(left(b.nm_tahun_ajaran,4) as signed))"
			+ " and		((cast(a.tahun_akhir as signed) >= cast(left(b.nm_tahun_ajaran,4) as signed)) or (a.tahun_akhir is null))"
			+ " and		 (b.kd_tahun_ajaran = '" + kd_tahun_ajaran + "')"
			+ " order by a.nm_propinsi";

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
			+  ",\""+ rs.getString("nm_propinsi") +"\""
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
