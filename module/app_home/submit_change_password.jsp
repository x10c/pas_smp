<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.Properties" %>
<%@ page import = "java.io.FileInputStream" %>
<%@ page import = "java.io.File" %>
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
} catch (SQLException e) {
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
