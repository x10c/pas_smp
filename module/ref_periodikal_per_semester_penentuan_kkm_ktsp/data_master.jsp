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
			+" ,		c.kd_kurikulum"
			+" ,		b.kd_periode_belajar"
			+" ,		a.id_pegawai"
			+" ,		a.id_ruang_kelas"
			+" ,		a.keterangan"
			+" ,		d.nm_tingkat_kelas"
			+" ,		e.nm_pegawai"
			+" ,		f.nm_ruang_kelas"
			+" from		t_pegawai_rombel		as a"
			+" ,		r_periode_belajar		as b"
			+" ,		t_sekolah_jurusan		as c"
			+" ,		r_tingkat_kelas			as d"
			+" ,		t_pegawai				as e"
			+" ,		t_sekolah_ruang			as f"
			+" where	c.kd_tahun_ajaran		= a.kd_tahun_ajaran"
			+" and		c.kd_tingkat_kelas		= a.kd_tingkat_kelas"
			+" and		c.kd_kurikulum			= '02'"
			+" and		d.kd_tingkat_kelas		= a.kd_tingkat_kelas"
			+" and		e.id_pegawai			= a.id_pegawai"
			+" and		f.id_ruang_kelas		= a.id_ruang_kelas"
			+" and		a.kd_tahun_ajaran		= '" + kd_tahun_ajaran + "'"
			+" and		b.kd_periode_belajar	= '" + kd_periode_belajar + "'"
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
				+ ",'"+ rs.getString("kd_kurikulum") + "'"
				+ ",'"+ rs.getString("kd_periode_belajar") + "'"
				+ ","+ rs.getString("id_pegawai")
				+ ","+ rs.getString("id_ruang_kelas")
				+ ",\""+ rs.getString("keterangan") +"\""
				+ ",'"+ rs.getString("nm_tingkat_kelas") + "'"
				+ ",\""+ rs.getString("nm_pegawai") +"\""
				+ ",\""+ rs.getString("nm_ruang_kelas") +"\""
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
