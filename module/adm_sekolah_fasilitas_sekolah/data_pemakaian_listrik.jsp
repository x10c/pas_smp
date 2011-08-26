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
			+" ,		kd_sumber_listrik"
			+" ,		kd_sumber_listrik as kd_sumber_listrik_old"
			+" ,		kd_daya_listrik"
			+" ,		kd_daya_listrik as kd_daya_listrik_old"
			+" ,		kd_voltase"
			+" ,		kd_voltase as kd_voltase_old"
			+" from		t_sekolah_pemakaian_listrik"
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
				+ ",'"+ rs.getString("kd_sumber_listrik") +"'"
				+ ",'"+ rs.getString("kd_sumber_listrik_old") +"'"
				+ ",'"+ rs.getString("kd_daya_listrik") + "'"
				+ ",'"+ rs.getString("kd_daya_listrik_old") +"'"
				+ ",'"+ rs.getString("kd_voltase") +"'"
				+ ",'"+ rs.getString("kd_voltase_old") + "']";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
