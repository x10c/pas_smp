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
	String 		kd_mata_pelajaran_diajarkan	= request.getParameter("kd_mata_pelajaran_diajarkan");
	
	String		q_where = "";

	if (kd_mata_pelajaran_diajarkan.equals("16") || kd_mata_pelajaran_diajarkan.equals("13")){
		q_where = "and left(a.kd_mata_pelajaran_diajarkan, 2) = '" + kd_mata_pelajaran_diajarkan + "'";
	} else {
		q_where	= "and a.kd_mata_pelajaran_diajarkan = '" + kd_mata_pelajaran_diajarkan + "'";
	}
	
	String q=" select	a.id_siswa"
			+" ,		a.kd_kurikulum"
			+" ,		a.kd_mata_pelajaran_diajarkan"
			+" ,		a.nilai"
			+" ,		a.keterangan"
			+" ,		b.nis"
			+" ,		b.nm_siswa"
			+" ,		c.nm_mata_pelajaran_diajarkan"
			+" from		t_nilai_rapor_nilai			as a"
			+" ,		t_siswa						as b"
			+" ,		r_mata_pelajaran_diajarkan	as c"
			+" where	a.id_siswa						= b.id_siswa"
			+" and		a.kd_mata_pelajaran_diajarkan	= c.kd_mata_pelajaran_diajarkan"
			+" and		a.kd_tahun_ajaran				= '" + kd_tahun_ajaran + "'"
			+" and		a.kd_tingkat_kelas				= '" + kd_tingkat_kelas + "'"
			+" and		a.kd_rombel						= '" + kd_rombel + "'"
			+" and		a.kd_periode_belajar			= '" + kd_periode_belajar + "'"
			+  q_where
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
				+ ",'"+ rs.getString("kd_kurikulum") + "'"
				+ ",'"+ rs.getString("kd_mata_pelajaran_diajarkan") + "'"
				+ ","+ rs.getString("nilai")
				+  ",\""+ rs.getString("keterangan") +"\""
				+ ",'"+ rs.getString("nis") + "'"
				+  ",\""+ rs.getString("nm_siswa") +"\""
				+  ",\""+ rs.getString("nm_mata_pelajaran_diajarkan") +"\""
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
