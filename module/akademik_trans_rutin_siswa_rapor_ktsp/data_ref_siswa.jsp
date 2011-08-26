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

	String q=" select	nis"
			+" ,		concat(coalesce(nisn, no_induk), ' - ', nm_siswa) as list"
			+" from		v_siswa_no_induk"
			+" where	kd_tahun_ajaran		= '" + kd_tahun_ajaran + "'"
			+" and		kd_tingkat_kelas	= '" + kd_tingkat_kelas + "'"
			+" and		kd_rombel			= '" + kd_rombel + "'"
			+" order by	nis";
	
	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="['"+ rs.getString("nis") + "'"
				+  ",\""+ rs.getString("list") +"\""
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
