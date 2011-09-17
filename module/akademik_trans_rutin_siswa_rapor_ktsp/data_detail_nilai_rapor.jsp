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
	
	String 		kd_tahun_ajaran		= request.getParameter("kd_tahun_ajaran");
	String 		kd_tingkat_kelas	= request.getParameter("kd_tingkat_kelas");
	String 		kd_rombel			= request.getParameter("kd_rombel");
	String 		kd_periode_belajar	= request.getParameter("kd_periode_belajar");

	String q=" select	a.id_siswa"
			+" ,		a.id_ahlak"
			+" ,		a.id_pribadi"
			+" ,		a.sakit"
			+" ,		a.ijin"
			+" ,		a.absen"
			+" ,		a.catatan"
			+" ,		b.nis"
			+" ,		b.nm_siswa"
			+" from		t_nilai_rapor	as a"
			+" ,		t_siswa			as b"
			+" where	a.id_siswa				= b.id_siswa"
			+" and		a.kd_tahun_ajaran		= '" + kd_tahun_ajaran + "'"
			+" and		a.kd_tingkat_kelas		= '" + kd_tingkat_kelas + "'"
			+" and		a.kd_rombel				= '" + kd_rombel + "'"
			+" and		a.kd_periode_belajar	= '" + kd_periode_belajar + "'"
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
				+ ","+ rs.getString("id_ahlak")
				+ ","+ rs.getString("id_pribadi")
				+ ","+ rs.getString("sakit")
				+ ","+ rs.getString("ijin")
				+ ","+ rs.getString("absen")
				+  ",\""+ rs.getString("catatan") +"\""
				+ ",'"+ rs.getString("nis") + "'"
				+  ",\""+ rs.getString("nm_siswa") +"\""
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
