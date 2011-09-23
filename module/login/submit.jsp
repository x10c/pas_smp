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
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");

	if (db_con == null || db_con.isClosed()) {
		String db_url = (String) session.getAttribute("db.url");

		if (db_url == null) {
			response.sendRedirect(request.getContextPath());
			return;
		}

		Class.forName("com.mysql.jdbc.Driver");

		db_con = DriverManager.getConnection(db_url);

		session.setAttribute("db.con", (Object) db_con);
	}

	Statement db_stmt = db_con.createStatement();

	String user = request.getParameter("user");
	String pass = request.getParameter("pass");

	q	=" select	username"
		+" from   __auth	"
		+" where  username	= '"+ user +"'"
		+" and    password	= '"+ pass +"'";

	ResultSet rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{success:false"
			+ ",info:'Nama User atau Kata Kunci tidak diketahui!'}");
		rs.close();
		return;
	}

	String get_user = rs.getString("username");

	rs.close();

	if (!get_user.equals(user)) {
		out.print("{success:false"
			+ ",info:'Nama User atau Kata Kunci tidak diketahui!'}");
		return;
	}

	/* save user to session */
	session.setAttribute("user.id", get_user);

	out.print("{success:true,info:'User logged in!'}");
}
catch (Exception e) {
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
