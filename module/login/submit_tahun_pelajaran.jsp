<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
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

	Statement db_stmt 	= db_con.createStatement();
	ResultSet rs		= null;

	String tahun_pelajaran = request.getParameter("tahun_pelajaran");
	String periode_belajar = request.getParameter("periode_belajar");

	q	=" select	kd_tahun_ajaran"
		+" ,   		nm_tahun_ajaran"
		+" from   	r_tahun_ajaran	"
		+" where  	kd_tahun_ajaran	= '"+ tahun_pelajaran +"'";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{success:false"
			+ ",info:'Tahun Pelajaran tidak diketahui!'}");
		rs.close();
		return;
	}

	String get_tahun_pelajaran = rs.getString("kd_tahun_ajaran");
	String get_nama_tahun_pelajaran = rs.getString("nm_tahun_ajaran");

	q	=" select	kd_periode_belajar"
		+" ,   		nm_periode_belajar"
		+" from   	r_periode_belajar"
		+" where  	kd_periode_belajar	= '"+ periode_belajar +"'";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{success:false"
			+ ",info:'Periode Belajar tidak diketahui!'}");
		rs.close();
		return;
	}

	String get_periode_belajar = rs.getString("kd_periode_belajar");
	String get_nama_periode_belajar = rs.getString("nm_periode_belajar");

	rs.close();

	/* save to session */
	session.setAttribute("kd.tahun_pelajaran", get_tahun_pelajaran);
	session.setAttribute("nm.tahun_pelajaran", get_nama_tahun_pelajaran);

	session.setAttribute("kd.periode_belajar", get_periode_belajar);
	session.setAttribute("nm.periode_belajar", get_nama_periode_belajar);

	out.print("{success:true,info:'Tahun Pelajaran dan Periode Belajar telah di pilih!'}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
