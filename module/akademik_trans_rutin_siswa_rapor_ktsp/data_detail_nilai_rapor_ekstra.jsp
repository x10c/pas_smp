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
	
	String 		kd_tahun_ajaran				= request.getParameter("kd_tahun_ajaran");
	String 		kd_tingkat_kelas			= request.getParameter("kd_tingkat_kelas");
	String 		kd_rombel					= request.getParameter("kd_rombel");
	String 		kd_periode_belajar			= request.getParameter("kd_periode_belajar");
	
	String q=" select	a.id_siswa"
			+" ,		a.id_siswa as id_siswa_old"
			+" ,		a.id_ekstrakurikuler"
			+" ,		a.id_ekstrakurikuler as id_ekstrakurikuler_old"
			+" ,		a.nilai"
			+" ,		a.keterangan"
			+" ,		b.nis"
			+" from		t_nilai_rapor_ekstra	as a"
			+" ,		t_siswa					as b"
			+" where	a.id_siswa						= b.id_siswa"
			+" and		a.kd_tahun_ajaran				= '" + kd_tahun_ajaran + "'"
			+" and		a.kd_tingkat_kelas				= '" + kd_tingkat_kelas + "'"
			+" and		a.kd_rombel						= '" + kd_rombel + "'"
			+" and		a.kd_periode_belajar			= '" + kd_periode_belajar + "'"
			+" order by	b.nis";
	
	ResultSet	rs		= db_stmt.executeQuery(q);
	int			i		= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="["+ rs.getString("id_siswa")
				+ ","+ rs.getString("id_siswa_old")
				+ ","+ rs.getString("id_ekstrakurikuler")
				+ ","+ rs.getString("id_ekstrakurikuler_old")
				+ ","+ rs.getString("nilai")
				+  ",\""+ rs.getString("keterangan") +"\""
				+ ",'"+ rs.getString("nis") + "'"
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
