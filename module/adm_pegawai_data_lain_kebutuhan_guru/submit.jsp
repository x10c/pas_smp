<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import = "java.sql.*" %>
<%@ page import	= "java.util.Properties" %>
<%@ page import	= "java.io.FileInputStream" %>
<%@ page import	= "java.io.File" %>
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
	JSONObject	cols;
	String		keys[];
	int			i,j,l;
	String		kd_kel_mata_pelajaran, q_update, v;
	
	l = rows.length();
	for (i = 0; i < l; i++) {
		row						= rows.getJSONObject(i);
		kd_kel_mata_pelajaran	= row.getString("kd_kel_mata_pelajaran");
		cols					= row.getJSONObject("cols");
		keys					= JSONObject.getNames(cols);

		q_update	=" username		= '"+ username + "'";

		for (j = 0; j < cols.length(); j++) {
			v	= cols.getString(keys[j]);
			
			q_update	+= ","+ keys[j] +"="+ v;

			q	=" update	t_pegawai_guru_kebutuhan"
				+" set		"
				+  q_update
				+" where	kd_tahun_ajaran			= '" + kd_tahun_ajaran + "'"
				+" and		kd_kel_mata_pelajaran	= '" + kd_kel_mata_pelajaran + "'";
			
			db_stmt.executeUpdate(q);

		}
	}

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (SQLException e){
	Properties	props	= new Properties();
	
	props.load(new FileInputStream(application.getRealPath("WEB-INF"+File.separator+"error.properties")));

	String		err_msg	= props.getProperty("" + e.getErrorCode() + "");
	
	if (err_msg == null){
		out.print("{success:false,info:'" + e.getErrorCode() + " = Kesalahan operasi, silahkan hubungi direktorat.'}");
	} else {
		out.print("{success:false,info:'" + e.getErrorCode() + " = " + err_msg + "'}");
	}
}
%>
