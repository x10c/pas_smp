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
	String id_pegawai		= request.getParameter("id_pegawai");
	
	String q=" select	kd_tahun_ajaran"
			+" ,		id_pegawai"
			+" ,		kd_mata_pelajaran_diajarkan"
			+" ,		kd_mata_pelajaran_diajarkan as kd_mata_pelajaran_diajarkan_old"
			+" from		t_pegawai_mengajar"
			+" where	kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'"
			+" and		id_pegawai		=  " + id_pegawai;
	
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
				+ ","+ rs.getString("id_pegawai")
				+ ",'"+ rs.getString("kd_mata_pelajaran_diajarkan") +"'"
				+ ",'"+ rs.getString("kd_mata_pelajaran_diajarkan_old") +"']";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
