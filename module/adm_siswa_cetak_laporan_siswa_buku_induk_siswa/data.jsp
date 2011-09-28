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

	String kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");
	String start				= request.getParameter("start");
	String limit				= request.getParameter("limit");
	
	String q=" select	a.id_siswa"
			+" ,		a.nis"
			+" ,		a.nm_siswa"
			+" ,		c.nm_tingkat_kelas"
			+" from		t_siswa			as a"
			+" ,		t_siswa_tingkat	as b"
			+" ,		r_tingkat_kelas	as c"
			+" where	a.id_siswa			= b.id_siswa"
			+" and		b.kd_tingkat_kelas	= c.kd_tingkat_kelas"
			+" and		b.kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'"
			+" order by b.kd_tingkat_kelas, a.nis";
	
	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="["+ rs.getString("id_siswa")
				+ ",'"+ rs.getString("nis") + "'"
				+ ",\""+ rs.getString("nm_siswa") +"\""
				+ ",'"+ rs.getString("nm_tingkat_kelas") + "'"
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
