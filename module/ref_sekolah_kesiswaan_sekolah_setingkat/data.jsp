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

	String q=" select	asal_smp"
			+" ,		id_propinsi as id_pro"
			+" ,		id_kabupaten as id_kab"
			+" ,		nm_sekolah"
			+" ,		kd_jenis_sekolah"
			+" ,		kd_status_sekolah"
			+" ,		alamat_sekolah"
			+" ,		no_telp"
			+" from		r_sekolah_setingkat"
			+" order by	id_propinsi, id_kabupaten, nm_sekolah";
	
	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="["+ rs.getString("asal_smp")
				+ ","+ rs.getString("id_pro")
				+ ","+ rs.getString("id_kab")
				+ ",\""+ rs.getString("nm_sekolah") +"\""
				+ ",'"+ rs.getString("kd_jenis_sekolah") + "'"
				+ ",'"+ rs.getString("kd_status_sekolah") + "'"
				+ ",\""+ rs.getString("alamat_sekolah") +"\""
				+ ",'"+ rs.getString("no_telp") +"']";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
