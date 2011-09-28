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

	String kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");
	String kd_periode_belajar	= (String) session.getAttribute("kd.periode_belajar");
	
	String q=" select	a.kd_tahun_ajaran"
			+" ,		a.kd_tingkat_kelas"
			+" ,		a.kd_rombel"
			+" ,		'" + kd_periode_belajar + "' as kd_periode_belajar"
			+" ,		b.nm_tingkat_kelas"
			+" ,		c.nm_pegawai"
			+" ,		d.nm_ruang_kelas"
			+" from		t_pegawai_rombel	as a"
			+" ,		r_tingkat_kelas		as b"
			+" ,		t_pegawai			as c"
			+" ,		t_sekolah_ruang		as d"
			+" where	a.kd_tingkat_kelas	= b.kd_tingkat_kelas"
			+" and		a.id_pegawai		= c.id_pegawai"
			+" and		a.kd_tahun_ajaran	= d.kd_tahun_ajaran"
			+" and		a.id_ruang_kelas	= d.id_ruang_kelas"
			+" and		a.kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'"
			+" order by	a.kd_tingkat_kelas, a.kd_rombel";
	
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
				+ ",'"+ rs.getString("kd_tingkat_kelas") + "'"
				+ ",'"+ rs.getString("kd_rombel") + "'"
				+ ",'"+ rs.getString("kd_periode_belajar") + "'"
				+ ",'"+ rs.getString("nm_tingkat_kelas") + "'"
				+ ",\""+ rs.getString("nm_pegawai") +"\""
				+ ",'"+ rs.getString("nm_ruang_kelas") + "'"
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
