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
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String 		kd_tahun_ajaran	= (String) session.getAttribute("kd.tahun_pelajaran");
	String		data			= "{rows:[";
	ResultSet	rs				= null;
	int			i				= 0;

	q	=" select	a.kd_tahun_ajaran"
		+" ,		a.kd_kel_mata_pelajaran"
		+" ,		b.nm_kel_mata_pelajaran"
		+" ,		a.jumlah_tetap"
		+" ,		a.jumlah_tak_tetap"
		+" ,		a.jumlah_butuh"
		+" from		t_pegawai_guru_kebutuhan	as a"
		+" ,		r_kel_mata_pelajaran		as b"
		+" where	a.kd_kel_mata_pelajaran		= b.kd_kel_mata_pelajaran"
		+" and		a.kd_tahun_ajaran			= '" + kd_tahun_ajaran + "'"
		+" order by	a.kd_kel_mata_pelajaran";
	
	rs	= db_stmt.executeQuery(q);

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="{ kd_tahun_ajaran : '"+ rs.getString("kd_tahun_ajaran") + "'"
				+ ", kd_kel_mata_pelajaran : '"+ rs.getString("kd_kel_mata_pelajaran") + "'"
				+ ", nm_kel_mata_pelajaran :\""+ rs.getString("nm_kel_mata_pelajaran") +"\""
				+ ", jumlah_tetap : "+ rs.getString("jumlah_tetap")
				+ ", jumlah_tak_tetap : "+ rs.getString("jumlah_tak_tetap")
				+ ", jumlah_butuh : "+ rs.getString("jumlah_butuh")
				+ "}";
	}	
	data += "]}";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
