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
	
	String q=" select	a.kd_tahun_ajaran"
			+" ,		a.kd_tingkat_kelas"
			+" ,		b.nm_tingkat_kelas"
			+" from		t_sekolah_jurusan		as a"
			+" ,		r_tingkat_kelas			as b"
			+" where	a.kd_tingkat_kelas		= b.kd_tingkat_kelas"
			+" and		a.kd_tahun_ajaran		= '" + kd_tahun_ajaran + "'"
			+" order by	a.kd_tingkat_kelas";
	
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
				+ ",'"+ rs.getString("nm_tingkat_kelas") +"']";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
