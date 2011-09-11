<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - m.shulhan (ms@kilabit.org)
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

	ResultSet	rs;
	Statement	db_stmt	= db_con.createStatement();
	String		id_user	= (String) session.getAttribute("user.id");
	String		lama	= request.getParameter("lama");
	String		baru	= request.getParameter("baru");

	q	=" select	username"
		+" from		__auth"
		+" where	username	= '"+ id_user +"'"
		+" and		password	= '"+ lama +"'";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{success:false,info:'Password lama Anda salah!'}");
		return;
	}

	rs.close();

	q	=" update	__auth"
		+" set		password	= '"+ baru +"'"
		+" where	username	= '"+ id_user +"'";

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
