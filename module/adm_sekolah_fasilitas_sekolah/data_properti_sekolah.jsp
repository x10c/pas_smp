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
			+" ,		kd_penggunaan_tanah"
			+" ,		kd_penggunaan_tanah as kd_penggunaan_tanah_old"
			+" ,		kd_kepemilikan"
			+" ,		kd_kepemilikan as kd_kepemilikan_old"
			+" ,		kd_sertifikat"
			+" ,		kd_sertifikat as kd_sertifikat_old"
			+" ,		luas"
			+" ,		keterangan"
			+" from		t_sekolah_properti"
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
				+ ",'"+ rs.getString("kd_penggunaan_tanah") +"'"
				+ ",'"+ rs.getString("kd_penggunaan_tanah_old") +"'"
				+ ",'"+ rs.getString("kd_kepemilikan") + "'"
				+ ",'"+ rs.getString("kd_kepemilikan_old") +"'"
				+ ",'"+ rs.getString("kd_sertifikat") +"'"
				+ ",'"+ rs.getString("kd_sertifikat_old") + "'"
				+ ","+ rs.getString("luas")
				+ ",\""+ rs.getString("keterangan") +"\""
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
