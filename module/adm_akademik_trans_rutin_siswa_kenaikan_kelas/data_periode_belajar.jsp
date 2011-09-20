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

	String kd_periode_belajar	= (String) session.getAttribute("kd.periode_belajar");

	ResultSet	rs;
	String		q;
	String		data;

	q	=" select	kd_periode_belajar"
		+" from		r_periode_belajar"
		+" where	kd_periode_belajar	= '" + kd_periode_belajar + "'";
	
	rs	= db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Periode Belajar tidak ditemukan!'}");
		return;
	}

	data 	="{ kd_periode_belajar : '" + rs.getString("kd_periode_belajar") +"'}";
	
	rs.close();
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
