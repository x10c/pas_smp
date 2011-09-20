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

	String kd_tahun_ajaran	= request.getParameter("kd_tahun_ajaran");
	String kd_tingkat_kelas	= request.getParameter("kd_tingkat_kelas");
	String kd_rombel		= request.getParameter("kd_rombel");

	ResultSet	rs;
	String		q;
	String		data;

	q	=" select	status_naik_kelas"
		+" from		t_pegawai_rombel"
		+" where	kd_tahun_ajaran		= '" + kd_tahun_ajaran + "'"
		+" and		kd_tingkat_kelas	= '" + kd_tingkat_kelas + "'"
		+" and		kd_rombel			= '" + kd_rombel + "'";
	
	rs	= db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Status Naik Kelas tidak ditemukan!'}");
		return;
	}

	data 	="{ status_naik_kelas : '" + rs.getString("status_naik_kelas") +"'}";
	
	rs.close();
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
