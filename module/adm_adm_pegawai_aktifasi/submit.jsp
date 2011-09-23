<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "org.json.*" %>
<%
String q = "";
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String 		kd_tahun_ajaran	= (String) session.getAttribute("kd.tahun_pelajaran");
	String 		username		= (String) session.getAttribute("user.id");
	JSONArray	rows			= new JSONArray((String) request.getParameter("rows"));
	JSONObject	row;
	int			i,j;
	String		id_pegawai, status_aktif;
	
	j = rows.length();
	for (i = 0; i < j; i++) {
		row				= rows.getJSONObject(i);
		id_pegawai		= row.getString("id_pegawai");
		status_aktif	= row.getString("status_aktif");
		
		if (status_aktif.equals("false")){
			status_aktif = "0";
		} else {
			status_aktif = "1";
		}
		
		q	=" update t_pegawai_aktif"
			+" set		status_aktif	= '" + status_aktif + "'"
			+" ,		username		= '" + username + "'"
			+" where	kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'"
			+" and		id_pegawai		=  " + id_pegawai;
		
		db_stmt.executeUpdate(q);
	}

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'", "\\'") +"'}");
}
%>
