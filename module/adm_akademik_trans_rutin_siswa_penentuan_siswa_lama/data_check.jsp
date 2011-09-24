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

	String kd_tahun_ajaran		= request.getParameter("kd_tahun_ajaran");
	String kd_tingkat_kelas		= request.getParameter("kd_tingkat_kelas");

	ResultSet	rs;
	String		q;
	String		data;

	q	=" select	count(*) as jumlah"
		+" from		t_siswa_tingkat_thn		as a"
		+" ,		r_tingkat_kelas			as b"
		+" ,		t_siswa					as c"
		+" where	a.kd_tingkat_kelas	= b.kd_tingkat_kelas"
		+" and		a.id_siswa			= c.id_siswa"
		+" and		a.kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'"
		+" and		a.kd_tingkat_kelas	= '" + kd_tingkat_kelas + "'"
		+" and		a.kd_tingkat_kelas	is not null"
		+" and		a.id_siswa			in (select id_siswa from t_siswa_tingkat)";
			
	rs	= db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Jumlah tidak ditemukan!'}");
		return;
	}

	data 	="{ jumlah : " + rs.getString("jumlah") +"}";
	
	rs.close();
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
