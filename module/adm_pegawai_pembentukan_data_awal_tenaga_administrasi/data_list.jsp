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

	String q=" select	a.id_pegawai"
			+" ,		a.nip"
			+" ,		a.nuptk"
			+" ,		a.nm_pegawai"
			+" ,		a.alamat"
			+" from		t_pegawai		as a"
			+" ,		t_pegawai_aktif	as b"
			+" where	a.kd_jenis_ketenagaan 	in ('2')"
			+" and		a.id_pegawai 			= b.id_pegawai"
			+" and		b.status_aktif			= '1'"
			+" and		b.kd_tahun_ajaran		= '" + kd_tahun_ajaran + "'"
			+" order by	a.nm_pegawai";
	
	ResultSet	rs		= db_stmt.executeQuery(q);
	int			i		= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="["+ rs.getString("id_pegawai")
				+ ",'"+ rs.getString("nip") + "'"
				+ ",'"+ rs.getString("nuptk") + "'"
				+ ",'"+ rs.getString("nm_pegawai") + "'"
				+ ",'"+ rs.getString("alamat") + "']";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
