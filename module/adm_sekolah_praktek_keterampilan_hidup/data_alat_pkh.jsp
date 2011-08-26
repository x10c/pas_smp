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
	
	String 		kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");

	String q=" select	kd_tahun_ajaran"
			+" ,		no_urut"
			+" ,		no_urut as no_urut_old"
			+" ,		nm_alat"
			+" ,		jumlah_baik"
			+" ,		jumlah_ringan"
			+" ,		jumlah_sedang"
			+" ,		jumlah_berat"
			+" from		t_sekolah_pkh_alat"
			+" where	kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'"
			+" order by	no_urut";
	
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
				+ ","+ rs.getString("no_urut")
				+ ","+ rs.getString("no_urut_old")
				+ ",'"+ rs.getString("nm_alat") +"'"
				+ ","+ rs.getString("jumlah_baik")
				+ ","+ rs.getString("jumlah_ringan")
				+ ","+ rs.getString("jumlah_sedang")
				+ ","+ rs.getString("jumlah_berat")
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
