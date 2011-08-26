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
			+" ,		no_urut"
			+" ,		no_urut as no_urut_old"
			+" ,		id_penyakit"
			+" ,		tahun_sakit"
			+" ,		lama_sakit"
			+" ,		keterangan"
			+" from		t_siswa_rwyt_sakit"
			+" where	nis	= '" + nis + "'"
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
		data 	+="['"+ rs.getString("nis") + "'"
				+ ","+ rs.getString("no_urut")
				+ ","+ rs.getString("no_urut_old")
				+ ","+ rs.getString("id_penyakit")
				+ ","+ rs.getString("tahun_sakit")
				+ ","+ rs.getString("lama_sakit")
				+ ",'"+ rs.getString("keterangan") + "']";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
