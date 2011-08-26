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

	String kd_kel_program_studi = request.getParameter("kd_kel_program_studi");
	
	String q=" select	kd_kel_program_studi"
			+" ,		kd_program_studi"
			+" ,		nm_program_studi"
			+" from		r_program_studi"
			+" where	kd_kel_program_studi = '" + kd_kel_program_studi + "'"
			+" and		kd_program_studi not in ('0000','9999')"
			+" order by	nm_program_studi";
	
	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="['"+ rs.getString("kd_kel_program_studi") + "'"
				+ ",'"+ rs.getString("kd_program_studi") + "'"
				+ ",\""+ rs.getString("nm_program_studi") +"\""
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
