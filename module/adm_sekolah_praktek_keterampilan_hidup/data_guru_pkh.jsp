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
			+" ,		id_pegawai"
			+" ,		id_pegawai as id_pegawai_old"
			+" ,		keterangan"
			+" from		t_sekolah_pkh_guru"
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
				+ ","+ rs.getString("id_pegawai")
				+ ","+ rs.getString("id_pegawai_old")
				+ ",'"+ rs.getString("keterangan") +"']";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
