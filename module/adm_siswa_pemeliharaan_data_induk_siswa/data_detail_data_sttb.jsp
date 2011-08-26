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
	
	String 		nis		= request.getParameter("nis");

	String q=" select	nis"
			+" ,		kd_matpel_before"
			+" ,		kd_matpel_before as kd_matpel_before_old"
			+" ,		nilai"
			+" from		t_siswa_sttb_before"
			+" where	nis	= '" + nis + "'"
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
		data 	+="['"+ rs.getString("nis") + "'"
				+ ",'"+ rs.getString("kd_matpel_before") + "'"
				+ ",'"+ rs.getString("kd_matpel_before_old") + "'"
				+ ","+ rs.getString("nilai") + "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
