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

	String kd_tahun_ajaran		= request.getParameter("kd_tahun_ajaran");
	String kd_tingkat_kelas		= request.getParameter("kd_tingkat_kelas");
	String kd_rombel			= request.getParameter("kd_rombel");
	String kd_kurikulum			= request.getParameter("kd_kurikulum");
	String kd_periode_belajar	= request.getParameter("kd_periode_belajar");
	
	String q=" select	a.kd_tahun_ajaran"
			+" ,		a.kd_tingkat_kelas"
			+" ,		a.kd_rombel"
			+" ,		a.kd_kurikulum"
			+" ,		a.kd_periode_belajar"
			+" ,		a.kd_mata_pelajaran_diajarkan"
			+" ,		a.kkm"
			+" ,		b.nm_mata_pelajaran_diajarkan"
			+" from		t_kur_kkm_matpel			as a"
			+" ,		r_mata_pelajaran_diajarkan	as b"
			+" where	a.kd_mata_pelajaran_diajarkan	= b.kd_mata_pelajaran_diajarkan"
			+" and		a.kd_tahun_ajaran				= '" + kd_tahun_ajaran + "'"
			+" and		a.kd_tingkat_kelas				= '" + kd_tingkat_kelas + "'"
			+" and		a.kd_rombel						= '" + kd_rombel + "'"
			+" and		a.kd_kurikulum					= '" + kd_kurikulum + "'"
			+" and		a.kd_periode_belajar			= '" + kd_periode_belajar + "'";
	
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
				+ ",'"+ rs.getString("kd_tingkat_kelas") + "'"
				+ ",'"+ rs.getString("kd_rombel") +"'"
				+ ",'"+ rs.getString("kd_kurikulum") +"'"
				+ ",'"+ rs.getString("kd_periode_belajar") +"'"
				+ ",'"+ rs.getString("kd_mata_pelajaran_diajarkan") +"'"
				+ ","+ rs.getString("kkm")
				+ ",'"+ rs.getString("nm_mata_pelajaran_diajarkan") +"']";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
