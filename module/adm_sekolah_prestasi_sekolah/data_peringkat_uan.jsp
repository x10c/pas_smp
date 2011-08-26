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

	String q=" select	kd_tahun_ajaran"
			+" ,		kd_tingkat_prestasi"
			+" ,		kd_tingkat_prestasi as kd_tingkat_prestasi_old"
			+" ,		peringkat_sejenis"
			+" ,		peringkat_gabungan"
			+" from		t_sekolah_peringkat_uan"
			+" where	kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'"
			+" order by	kd_tingkat_prestasi";
	
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
				+ ",'"+ rs.getString("kd_tingkat_prestasi") + "'"
				+ ",'"+ rs.getString("kd_tingkat_prestasi_old") +"'"
				+ ","+ rs.getString("peringkat_sejenis")
				+ ","+ rs.getString("peringkat_gabungan")
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
