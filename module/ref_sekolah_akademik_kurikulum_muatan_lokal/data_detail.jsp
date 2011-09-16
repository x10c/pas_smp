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

	String kd_kurikulum			= request.getParameter("kd_kurikulum");
	String kd_tingkat_kelas		= request.getParameter("kd_tingkat_kelas");
	
	String q=" select	distinct"
			+"			kd_kurikulum"
			+" ,		kd_tingkat_kelas"
			+" ,		kd_periode_belajar"
			+" ,		kd_mata_pelajaran_diajarkan"
			+" ,		status_ciri_khas"
			+" ,		uan"
			+" ,		elemen"
			+" from		t_kur_kurikulum"
			+" where	kd_kurikulum		= '" + kd_kurikulum + "'"
			+" and		kd_tingkat_kelas	= '" + kd_tingkat_kelas + "'"
			+" and		kd_periode_belajar	= '1'"
			+" and		left(kd_mata_pelajaran_diajarkan,2)	= '16'"
			+" order by	tanggal_akses";
	
	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="['"+ rs.getString("kd_kurikulum") + "'"
				+ ",'"+ rs.getString("kd_tingkat_kelas") +"'"
				+ ",'"+ rs.getString("kd_periode_belajar") +"'"
				+ ",'"+ rs.getString("kd_mata_pelajaran_diajarkan") +"'"
				+ ",'"+ rs.getString("status_ciri_khas") +"'"
				+ ",'"+ rs.getString("uan") +"'"
				+ ", "+ rs.getString("elemen")
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
