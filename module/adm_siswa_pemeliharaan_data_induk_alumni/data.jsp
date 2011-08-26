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

	String q=" select	a.nis"
			+" ,		b.no_induk"
			+" ,		b.nm_siswa"
			+" ,		a.no_stl_lulus"
			+" ,		a.tahun_lulus"
			+" ,		a.lanjut_di"
			+" ,		a.tanggal_bekerja"
			+" ,		a.nm_perusahaan"
			+" from		t_siswa_alumni	as a"
			+" ,		t_siswa			as b"
			+" where	a.nis	= b.nis"
			+" order by	a.tahun_lulus desc, b.nm_siswa";
	
	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="['"+ rs.getString("nis") + "'"
				+ ",'"+ rs.getString("no_induk") +"'"
				+ ",'"+ rs.getString("nm_siswa") +"'"
				+ ",'"+ rs.getString("no_stl_lulus") +"'"
				+ ","+ rs.getString("tahun_lulus")
				+ ",'"+ rs.getString("lanjut_di") + "'"
				+ ",'"+ rs.getString("tanggal_bekerja") + "'"
				+ ",'"+ rs.getString("nm_perusahaan") +"']";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
