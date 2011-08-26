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
			+" ,		id_jenis_lomba"
			+" ,		id_jenis_lomba as id_jenis_lomba_old"
			+" ,		kd_tingkat_prestasi"
			+" ,		kd_tingkat_prestasi as kd_tingkat_prestasi_old"
			+" ,		tanggal_prestasi"
			+" ,		tanggal_prestasi as tanggal_prestasi_old"
			+" ,		juara_ke"
			+" ,		keterangan"
			+" from		t_pegawai_prestasi"
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
				+ ","+ rs.getString("id_jenis_lomba")
				+ ","+ rs.getString("id_jenis_lomba_old")
				+ ",'"+ rs.getString("kd_tingkat_prestasi") + "'"
				+ ",'"+ rs.getString("kd_tingkat_prestasi_old") + "'"
				+ ",'"+ rs.getString("tanggal_prestasi") + "'"
				+ ",'"+ rs.getString("tanggal_prestasi_old") + "'"
				+ ","+ rs.getString("juara_ke")
				+ ",'"+ rs.getString("keterangan") + "']";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
