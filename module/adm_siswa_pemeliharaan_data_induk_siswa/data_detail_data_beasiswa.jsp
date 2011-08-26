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
	
	String 		kd_tahun_ajaran	= (String) session.getAttribute("kd.tahun_pelajaran");
	String 		nis				= request.getParameter("nis");

	String q=" select	nis"
			+" ,		kd_beasiswa"
			+" ,		kd_beasiswa as kd_beasiswa_old"
			+" ,		tahun_masuk"
			+" ,		tahun_masuk as tahun_masuk_old"
			+" ,		jumlah_beasiswa_per_bulan"
			+" ,		keterangan"
			+" from		t_siswa_beasiswa"
			+" where	nis				= '" + nis + "'"
			+" and		kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'"
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
		data 	+="['"+ rs.getString("nis") + "'"
				+ ",'"+ rs.getString("kd_beasiswa") + "'"
				+ ",'"+ rs.getString("kd_beasiswa_old") + "'"
				+ ","+ rs.getString("tahun_masuk")
				+ ","+ rs.getString("tahun_masuk_old")
				+ ","+ rs.getString("jumlah_beasiswa_per_bulan")
				+ ",'"+ rs.getString("keterangan") + "']";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
