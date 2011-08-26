<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String q=" select	a.id_gol_pekerjaan_ortu"
			+" ,		concat(b.nm_pekerjaan_ortu, ' - ', a.nm_gol_pekerjaan_ortu) as nm_gol_pekerjaan_ortu"
			+" from		r_gol_pekerjaan_ortu	as a"
			+" ,		r_pekerjaan_ortu		as b"
			+" where	a.kd_pekerjaan_ortu		= b.kd_pekerjaan_ortu"
			+" order by	a.id_gol_pekerjaan_ortu";
	
	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="["+ rs.getString("id_gol_pekerjaan_ortu")
				+  ",\""+ rs.getString("nm_gol_pekerjaan_ortu") +"\""
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
