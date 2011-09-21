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

	String kd_tahun_ajaran	= request.getParameter("kd_tahun_ajaran");
	String kd_tingkat_kelas	= request.getParameter("kd_tingkat_kelas");
	
	String q=" select	kd_tahun_ajaran"
			+" ,		kd_tingkat_kelas"
			+" ,		kd_rombel"
			+" ,		kd_rombel as kd_rombel_old"
			+" ,		id_ruang_kelas"
			+" ,		id_pegawai"
			+" ,		id_pegawai_bk"
			+" ,		keterangan"
			+" from		t_pegawai_rombel"
			+" where	kd_tahun_ajaran		= '" + kd_tahun_ajaran + "'"
			+" and		kd_tingkat_kelas	= '" + kd_tingkat_kelas + "'"
			+" order by	kd_tahun_ajaran, kd_tingkat_kelas, kd_rombel";
	
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
				+ ",'"+ rs.getString("kd_tingkat_kelas") +"'"
				+ ",'"+ rs.getString("kd_rombel") +"'"
				+ ",'"+ rs.getString("kd_rombel_old") +"'"
				+ ","+ rs.getString("id_ruang_kelas")
				+ ","+ rs.getString("id_pegawai")
				+ ","+ rs.getString("id_pegawai_bk")
				+ ",'"+ rs.getString("keterangan") +"']";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
