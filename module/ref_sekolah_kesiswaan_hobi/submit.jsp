<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.Properties" %>
<%@ page import = "java.io.FileInputStream" %>
<%@ page import = "java.io.File" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int dml 			= Integer.parseInt(request.getParameter("dml_type"));
	String id_hobi		= request.getParameter("id_hobi");
	String nm_hobi		= request.getParameter("nm_hobi");
	String kd_kel_hobi	= request.getParameter("kd_kel_hobi");
	String username		= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into r_hobi (nm_hobi, kd_kel_hobi, username)"
			+" values ('"+ nm_hobi +"', '"+ kd_kel_hobi +"', '" + username +"')";
		break;
	case 3:
		q	=" update	r_hobi"
			+" set		nm_hobi		= '"+ nm_hobi +"'"
			+" ,		kd_kel_hobi	= '"+ kd_kel_hobi +"'"
			+" ,		username	= '"+ username +"'"
			+" where	id_hobi		= "+ id_hobi;
		break;
	case 4:
		q = " delete from r_hobi where id_hobi = "+ id_hobi;
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (SQLException e){
	Properties	props	= new Properties();
	
	props.load(new FileInputStream(application.getRealPath("WEB-INF"+File.separator+"error.properties")));
	
	String		err_msg = props.getProperty("" + e.getErrorCode() + "");
	
	if (err_msg == null){
		out.print("{success:false,info:'" + e.getErrorCode() + " = Kesalahan operasi, silahkan hubungi direktorat.'}");
	} else {
		out.print("{success:false,info:'" + e.getErrorCode() + " = " + err_msg + "'}");
	}
}
%>
