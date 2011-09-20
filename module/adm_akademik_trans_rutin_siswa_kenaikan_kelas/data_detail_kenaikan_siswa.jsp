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
	
	String 		kd_tahun_ajaran		= request.getParameter("kd_tahun_ajaran");
	String 		kd_tingkat_kelas	= request.getParameter("kd_tingkat_kelas");
	String 		kd_rombel			= request.getParameter("kd_rombel");

	String q=" select	a.kd_tahun_ajaran"
			+" ,		a.kd_tingkat_kelas"
			+" ,		a.kd_rombel"
			+" ,		a.id_siswa"
			+" ,		b.nis"
			+" ,		b.nm_siswa"
			+" ,		a.kd_lulus"
			+" ,		a.no_ijazah"
			+" from		t_siswa_tingkat	as a"
			+" ,		t_siswa			as b"
			+" where	a.id_siswa			= b.id_siswa"
			+" and		a.kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'"
			+" and		a.kd_tingkat_kelas	= '" + kd_tingkat_kelas + "'"
			+" and		a.kd_rombel			= '" + kd_rombel + "'"
			+" and		a.kd_status_siswa	in ('0','1','3','4')"
			+" order by	b.nm_siswa";
	
	ResultSet	rs		= db_stmt.executeQuery(q);
	int			i		= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="['"+ rs.getString("kd_tahun_ajaran") + "'"
				+ ",'"+ rs.getString("kd_tingkat_kelas") + "'"
				+ ",'"+ rs.getString("kd_rombel") + "'"
				+ ","+ rs.getString("id_siswa")
				+ ",'"+ rs.getString("nis") + "'"
				+ ",'"+ rs.getString("nm_siswa") + "'"
				+ ",'"+ rs.getString("kd_lulus") + "'"
				+ ",'"+ rs.getString("no_ijazah") + "']";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
