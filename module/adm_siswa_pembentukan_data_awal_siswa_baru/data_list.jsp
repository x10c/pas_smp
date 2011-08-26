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

	String q=" select	a.nis"
			+" ,		a.no_induk"
			+" ,		a.nisn"
			+" ,		a.nm_siswa"
			+" ,		a.alamat"
			+" from		t_siswa			as a"
			+" ,		((select nis, kd_tahun_ajaran from t_siswa_tingkat where kd_tahun_ajaran = '" + kd_tahun_ajaran + "')"
			+" 	union 	 (select nis, kd_tahun_ajaran from t_siswa_tingkat_thn where kd_tahun_ajaran = '" + kd_tahun_ajaran + "')"
			+" 	union 	 (select nis, kd_tahun_ajaran from t_siswa_tingkat_thn_baru where kd_tahun_ajaran = '" + kd_tahun_ajaran + "')) as b"
			+" where	a.nis	= b.nis"
			+" and		a.status_siswa	in ('0')"
			+" order by	a.no_induk";
	
	ResultSet	rs		= db_stmt.executeQuery(q);
	int			i		= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="['"+ rs.getString("nis") + "'"
				+ ",'"+ rs.getString("no_induk") + "'"
				+ ",'"+ rs.getString("nisn") + "'"
				+ ",\""+ rs.getString("nm_siswa") +"\""
				+ ",\""+ rs.getString("alamat") +"\""
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
