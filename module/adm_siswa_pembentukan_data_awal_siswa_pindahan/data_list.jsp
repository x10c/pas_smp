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

	String q=" select	a.id_siswa"
			+" ,		a.nis"
			+" ,		a.nm_siswa"
			+" ,		a.asal_smp"
			+" ,		a.alamat"
			+" from		t_siswa			as a"
			+" ,		((select id_siswa, kd_tahun_ajaran from t_siswa_tingkat where kd_tahun_ajaran = '" + kd_tahun_ajaran + "')"
			+" 	union 	 (select id_siswa, kd_tahun_ajaran from t_siswa_tingkat_thn where kd_tahun_ajaran = '" + kd_tahun_ajaran + "')) as b"
			+" where	a.id_siswa	= b.id_siswa"
			+" and		a.status_siswa	in ('2','3')"
			+" order by	a.nis";
	
	ResultSet	rs		= db_stmt.executeQuery(q);
	int			i		= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="['"+ rs.getString("id_siswa") + "'"
				+ ",'"+ rs.getString("nis") + "'"
				+ ",\""+ rs.getString("nm_siswa") +"\""
				+ ","+ rs.getString("asal_smp")
				+ ",\""+ rs.getString("alamat") +"\""
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
