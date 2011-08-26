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
			+" ,		kd_jenis_penghargaan"
			+" ,		kd_jenis_penghargaan as kd_jenis_penghargaan_old"
			+" ,		tanggal_penghargaan"
			+" ,		keterangan"
			+" from		t_pegawai_penghargaan"
			+" where	nip	= " + nip
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
		data 	+="["+ rs.getString("nip")
				+ ",'"+ rs.getString("kd_jenis_penghargaan") + "'"
				+ ",'"+ rs.getString("kd_jenis_penghargaan_old") + "'"
				+ ",'"+ rs.getString("tanggal_penghargaan") + "'"
				+ ",'"+ rs.getString("keterangan") + "']";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
