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

	int dml 					= Integer.parseInt(request.getParameter("dml_type"));
	String id_jenis_lomba		= request.getParameter("id_jenis_lomba");
	String nm_jenis_lomba		= request.getParameter("nm_jenis_lomba");
	String status_jenis_lomba	= request.getParameter("status_jenis_lomba");
	String jenis_lomba			= request.getParameter("jenis_lomba");
	String username				= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into r_jenis_lomba (nm_jenis_lomba, status_jenis_lomba, jenis_lomba, username)"
			+" values ('"+ nm_jenis_lomba +"', "+ status_jenis_lomba +", '" + jenis_lomba +"', '" + username +"')";
		break;
	case 3:
		q	=" update	r_jenis_lomba"
			+" set		nm_jenis_lomba		= '"+ nm_jenis_lomba +"'"
			+" ,		status_jenis_lomba	= "+ status_jenis_lomba
			+" ,		jenis_lomba			= '"+ jenis_lomba +"'"
			+" ,		username			= '"+ username +"'"
			+" where	id_jenis_lomba		= "+ id_jenis_lomba;
		break;
	case 4:
		q = " delete from r_jenis_lomba where id_jenis_lomba = "+ id_jenis_lomba;
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
