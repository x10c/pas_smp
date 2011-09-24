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

	Statement	db_stmt  = db_con.createStatement();
	Statement	db_stmt2 = db_con.createStatement();

	String kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");
	String kd_periode_belajar	= (String) session.getAttribute("kd.periode_belajar");

	ResultSet	rs;
	ResultSet	rs2 = null;
	String		q	= "";
	String		q2	= "";
	String		data;

	q	=" select	count(*) as jumlah"
		+" from		t_siswa_tingkat	as a"
		+" ,		t_siswa			as b"
		+" where	a.id_siswa			= b.id_siswa"
		+" and		a.id_siswa			in (select id_siswa from t_siswa where status_siswa in ('0','2','3'))"
		+" and		a.kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'";

	q2	=" select	distinct"
		+" 			status_naik_kelas"
		+" ,		'" + kd_periode_belajar + "' as kd_periode_belajar"
		+" from		t_pegawai_rombel"
		+" where	kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'";
		
	rs	= db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Jumlah tidak ditemukan!'}");
		return;
	}

	rs2	= db_stmt2.executeQuery(q2);
	
	if (!rs2.next()) {
		out.print("{ success: false"
		+", info:'Data Status Naik Kelas tidak ditemukan!'}");
		return;
	}
	
	data 	="{ jumlah : " + rs.getString("jumlah")
			+", status_naik_kelas : '" + rs2.getString("status_naik_kelas") +"'"
			+",	kd_periode_belajar : '" + rs2.getString("kd_periode_belajar") +"'}";

	rs.close();
	rs2.close();
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
