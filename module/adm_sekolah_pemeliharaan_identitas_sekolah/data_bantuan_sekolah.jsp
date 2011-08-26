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
			+" ,		kd_bantuan"
			+" ,		kd_bantuan as kd_bantuan_old"
			+" ,		tahun_bantuan"
			+" ,		sumber_bantuan"
			+" ,		sumber_bantuan as sumber_bantuan_old"
			+" ,		jumlah_dana"
			+" ,		dana_pendamping"
			+" ,		peruntukan_dana"
			+" from		t_sekolah_bantuan"
			+" where	kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'"
			+" order by	tanggal_akses asc";
	
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
				+ ",'"+ rs.getString("kd_bantuan") +"'"
				+ ",'"+ rs.getString("kd_bantuan_old") +"'"
				+ ","+ rs.getString("tahun_bantuan")
				+ ",\""+ rs.getString("sumber_bantuan") +"\""
				+ ",\""+ rs.getString("sumber_bantuan_old") +"\""
				+ ","+ rs.getString("jumlah_dana")
				+ ","+ rs.getString("dana_pendamping")
				+ ",\""+ rs.getString("peruntukan_dana") +"\""
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
