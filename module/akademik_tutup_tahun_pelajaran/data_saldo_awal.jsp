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

	Statement	db_stmt		= db_con.createStatement();
	Statement	db_stmt2 	= db_con.createStatement();

	String kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");
	String kd_periode_belajar	= (String) session.getAttribute("kd.periode_belajar");

	ResultSet	rs		= null;
	ResultSet	rs2		= null;
	String		q		= "";
	String		q2		= "";
	String		data;
	int 		kd_tahun_tambah		= 0;
	String 		kd_tahun_pelajaran	= "";
	
	kd_tahun_tambah 	= Integer.parseInt(kd_tahun_ajaran) + 1;
	kd_tahun_pelajaran	= kd_tahun_tambah + "";

	q	=" select	count(*) as jumlah"
		+" ,		'" + kd_periode_belajar + "' as kd_periode_belajar"
		+" ,		ifnull(saldo_awal,0) as saldo_awal"
		+" from		t_sekolah_saldo_awal"
		+" where	kd_tahun_ajaran	= '" + kd_tahun_pelajaran + "'";

	q2	=" select	count(*) as jumlah_data"
		+" from		t_sekolah_saldo_awal"
		+" where	kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'";
		
	rs	= db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Saldo Awal tidak ditemukan!'}");
		return;
	}

	rs2	= db_stmt2.executeQuery(q2);

	if (!rs2.next()) {
		out.print("{ success: false"
		+", info:'Data Saldo Awal tidak ditemukan!'}");
		return;
	}

	data 	="{ jumlah : " + rs.getString("jumlah")
			+",	kd_periode_belajar : '" + rs.getString("kd_periode_belajar") +"'"
			+",	saldo_awal : " + rs.getString("saldo_awal")
			+",	jumlah_data : " + rs2.getString("jumlah_data") + "}";
	
	rs.close();
	rs2.close();
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
