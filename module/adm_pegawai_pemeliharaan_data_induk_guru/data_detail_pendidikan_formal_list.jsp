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
			+" ,		kd_tingkat_ijazah"
			+" ,		nm_instansi_penddkn"
			+" ,		kd_program_studi"
			+" from		t_pegawai_didik_formal"
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
				+ ",'"+ rs.getString("kd_tingkat_ijazah") + "'"
				+ ",'"+ rs.getString("nm_instansi_penddkn") + "'"
				+ ",'"+ rs.getString("kd_program_studi") + "']";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
