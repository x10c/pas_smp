<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
String q = "";
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

	String		data			= "{rows:[";
	ResultSet	rs				= null;
	int			i				= 0;

	q	=" select	a.kd_tahun_ajaran"
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
	
	rs	= db_stmt.executeQuery(q);

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}

		data 	+="{ kd_tahun_ajaran : '"+ rs.getString("kd_tahun_ajaran") + "'"
				+ ", kd_tingkat_kelas : '"+ rs.getString("kd_tingkat_kelas") + "'"
				+ ", kd_rombel : '"+ rs.getString("kd_rombel") + "'"
				+ ", id_siswa : "+ rs.getString("id_siswa")
				+ ", nis : '"+ rs.getString("nis") + "'"
				+ ", nm_siswa :\""+ rs.getString("nm_siswa") +"\""
				+ ", kd_lulus : '"+ rs.getString("kd_lulus") + "'"
				+ ", no_ijazah : '"+ rs.getString("no_ijazah") +"'"
				+ "}";
	}	
	data += "]}";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
