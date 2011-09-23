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
	
	String kd_tahun_ajaran	= request.getParameter("kd_tahun_ajaran");
	String kd_tingkat_kelas	= request.getParameter("kd_tingkat_kelas");

	String q=" select	a.kd_rombel"
			+" ,		b.nm_pegawai"
			+" from		t_pegawai_rombel	as a"
			+" ,		t_pegawai			as b"
			+" where	a.id_pegawai		= b.id_pegawai"
			+" and		a.kd_tingkat_kelas	in ('01','02','03')"
			+" and		a.kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'"
			+" and		a.kd_tingkat_kelas	= '" + kd_tingkat_kelas + "'"
			+" order by	a.kd_rombel";
	
	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="['"+ rs.getString("kd_rombel") + "'"
				+  ",\""+ rs.getString("nm_pegawai") +"\""
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
