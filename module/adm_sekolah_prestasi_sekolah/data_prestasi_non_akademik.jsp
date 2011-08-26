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
	
	String 		kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");

	String q=" select	a.kd_tahun_ajaran"
			+" ,		a.id_jenis_lomba"
			+" ,		a.id_jenis_lomba as id_jenis_lomba_old"
			+" ,		a.kd_tingkat_prestasi"
			+" ,		a.kd_tingkat_prestasi as kd_tingkat_prestasi_old"
			+" ,		a.tanggal_prestasi"
			+" ,		a.tanggal_prestasi as tanggal_prestasi_old"
			+" ,		a.juara_ke"
			+" ,		a.keterangan"
			+" from		t_sekolah_prestasi	as a"
			+" ,		r_jenis_lomba		as b"
			+" where	a.id_jenis_lomba	= b.id_jenis_lomba"
			+" and		b.jenis_lomba		= '0'"
			+" and		a.kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'"
			+" order by	a.tanggal_akses asc";
	
	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="['"+ rs.getString("kd_tahun_ajaran") + "'"
				+ ","+ rs.getString("id_jenis_lomba")
				+ ","+ rs.getString("id_jenis_lomba_old")
				+ ",'"+ rs.getString("kd_tingkat_prestasi") + "'"
				+ ",'"+ rs.getString("kd_tingkat_prestasi_old") +"'"
				+ ",'"+ rs.getString("tanggal_prestasi") +"'"
				+ ",'"+ rs.getString("tanggal_prestasi_old") +"'"
				+ ","+ rs.getString("juara_ke")
				+ ",\""+ rs.getString("keterangan") +"\""
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
