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
			+" ,		id_ruang_kelas"
			+" ,		nm_ruang_kelas"
			+" ,		kd_ruang"
			+" ,		kd_kepemilikan"
			+" ,		kd_kondisi_ruangan"
			+" ,		kapasitas"
			+" ,		panjang"
			+" ,		lebar"
			+" ,		luas"
			+" ,		keterangan"
			+" from		t_sekolah_ruang"
			+" where	kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'"
			+" order by	kd_ruang, nm_ruang_kelas";
	
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
				+ ","+ rs.getString("id_ruang_kelas")
				+ ",\""+ rs.getString("nm_ruang_kelas") +"\""
				+ ",'"+ rs.getString("kd_ruang") + "'"
				+ ",'"+ rs.getString("kd_kepemilikan") +"'"
				+ ",'"+ rs.getString("kd_kondisi_ruangan") +"'"
				+ ","+ rs.getString("kapasitas")
				+ ","+ rs.getString("panjang")
				+ ","+ rs.getString("lebar")
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
