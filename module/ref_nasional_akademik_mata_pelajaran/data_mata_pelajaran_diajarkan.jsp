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

	String kd_kel_mata_pelajaran = request.getParameter("kd_kel_mata_pelajaran");
	
	String q=" select	kd_kel_mata_pelajaran"
			+" ,		kd_mata_pelajaran_diajarkan"
			+" ,		nm_mata_pelajaran_diajarkan"
			+" from		r_mata_pelajaran_diajarkan"
			+" where	(kd_kel_mata_pelajaran = '" + kd_kel_mata_pelajaran + "')"
			+" and		(kd_mata_pelajaran_diajarkan not in ('00000','99999'))"
			+" and		(kd_kel_mata_pelajaran not in (select kd_mulok from __ver))"
			+" order by	kd_mata_pelajaran_diajarkan";
	
	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="['"+ rs.getString("kd_kel_mata_pelajaran") + "'"
				+ ",'"+ rs.getString("kd_mata_pelajaran_diajarkan") + "'"
				+ ",\""+ rs.getString("nm_mata_pelajaran_diajarkan") +"\""
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
