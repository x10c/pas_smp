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
	
	String 		nip		= request.getParameter("nip");

	String q=" select	nip"
			+" ,		no_urut"
			+" ,		nm_keluarga"
			+" ,		kd_hub_keluarga"
			+" ,		alamat"
			+" from		t_pegawai_keluarga"
			+" where	nip	= " + nip
			+" order by	no_urut";
	
	ResultSet	rs		= db_stmt.executeQuery(q);
	int			i		= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="["+ rs.getString("nip")
				+ ","+ rs.getString("no_urut")
				+ ",'"+ rs.getString("nm_keluarga") + "'"
				+ ",'"+ rs.getString("kd_hub_keluarga") + "'"
				+ ",'"+ rs.getString("alamat") + "']";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
