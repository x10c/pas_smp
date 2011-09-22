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
	
	String 		id_siswa		= request.getParameter("id_siswa");

	String q=" select	id_siswa"
			+" ,		tanggal"
			+" ,		tanggal as tanggal_old"
			+" ,		tanggal_masuk"
			+" ,		keterangan"
			+" from		t_siswa_cuti"
			+" where	id_siswa	= '" + id_siswa + "'"
			+" order by	tanggal";
	
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
				+ ",'"+ rs.getString("tanggal") + "'"
				+ ",'"+ rs.getString("tanggal_old") + "'"
				+ ",'"+ rs.getString("tanggal_masuk") + "'"
				+ ",'"+ rs.getString("keterangan") + "']";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
