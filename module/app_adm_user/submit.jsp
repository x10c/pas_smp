<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import = "java.sql.*" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int dml 			= Integer.parseInt(request.getParameter("dml_type"));
	String username		= request.getParameter("username");
	String id_grup		= request.getParameter("id_grup");
	String password		= request.getParameter("password");
	String status_user	= request.getParameter("status_user");
	String q;

	switch (dml) {
	case 2:
		q	="  insert into __auth"
			+"  values("
			+"  '"+ username + "'"
			+",  "+ id_grup
			+", '"+ password + "'"
			+",  "+ status_user +")";
		break;
	case 3:
		q	=" update	__auth"
			+" set		id_grup		=  "+ id_grup
			+" ,		password	= '"+ password + "'"
			+" ,		status_user	=  "+ status_user
			+" where	username	= '"+ username + "'";
		break;
	case 4:
		q 	= " delete	from __auth"
			+ " where	username	= '"+ username + "'";
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'", "\\'") +"'}");
}
%>
