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

	String 		kd_tahun_ajaran		= request.getParameter("kd_tahun_ajaran");
	String 		kd_tingkat_kelas	= request.getParameter("kd_tingkat_kelas");
	String 		kd_rombel			= request.getParameter("kd_rombel");
	String 		username			= (String) session.getAttribute("user.id");
	JSONArray	rows				= new JSONArray((String) request.getParameter("rows"));
	JSONObject	row;
	int			i,j;
	String		id_siswa, kd_ebta, no_uan;
	
	j = rows.length();
	for (i = 0; i < j; i++) {
		row			= rows.getJSONObject(i);
		id_siswa	= row.getString("id_siswa");
		kd_ebta		= row.getString("kd_ebta");
		no_uan		= row.getString("no_uan");
		
		if (kd_ebta.equals("false")){
			kd_ebta = "0";
		} else {
			kd_ebta = "1";
		}
		
		q	=" update	t_siswa_tingkat"
			+" set		kd_ebta		= '" + kd_ebta + "'"
			+" ,		no_uan		= '" + no_uan + "'"
			+" ,		username	= '" + username + "'"
			+" where	kd_tahun_ajaran		= '" + kd_tahun_ajaran + "'"
			+" and		kd_tingkat_kelas	= '" + kd_tingkat_kelas + "'"
			+" and		kd_rombel			= '" + kd_rombel + "'"
			+" and		id_siswa			=  " + id_siswa;
		
		db_stmt.executeUpdate(q);
	}

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'", "\\'") +"'}");
}
%>
