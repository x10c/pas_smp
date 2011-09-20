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
	
	String 		id_pegawai		= request.getParameter("id_pegawai");

	String q=" select	id_pegawai"
			+" ,		kd_mata_pelajaran_diajarkan"
			+" ,		kd_mata_pelajaran_diajarkan as kd_mata_pelajaran_diajarkan_old"
			+" ,		tahun_mulai_ajar"
			+" from		t_pegawai_rwyt_ajar"
			+" where	id_pegawai	= " + id_pegawai
			+" order by	tanggal_akses";
	
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
				+ ",'"+ rs.getString("kd_mata_pelajaran_diajarkan") + "'"
				+ ",'"+ rs.getString("kd_mata_pelajaran_diajarkan_old") + "'"
				+ ","+ rs.getString("tahun_mulai_ajar") + "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
