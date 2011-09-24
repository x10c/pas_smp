<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.Properties" %>
<%@ page import = "java.io.FileInputStream" %>
<%@ page import = "java.io.File" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int dml 						= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran			= (String) session.getAttribute("kd.tahun_pelajaran");
	String kd_sumber_listrik		= request.getParameter("kd_sumber_listrik");
	String kd_sumber_listrik_old	= request.getParameter("kd_sumber_listrik_old");
	String kd_daya_listrik			= request.getParameter("kd_daya_listrik");
	String kd_daya_listrik_old		= request.getParameter("kd_daya_listrik_old");
	String kd_voltase				= request.getParameter("kd_voltase");
	String kd_voltase_old			= request.getParameter("kd_voltase_old");
	String username					= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into t_sekolah_pemakaian_listrik (kd_tahun_ajaran, kd_sumber_listrik, kd_daya_listrik, kd_voltase, username)"
			+" values ('"+ kd_tahun_ajaran +"', '"+ kd_sumber_listrik +"', '"+ kd_daya_listrik +"', '"+ kd_voltase +"', '" + username +"')";
		break;
	case 3:
		q	=" update	t_sekolah_pemakaian_listrik"
			+" set		kd_sumber_listrik	= '"+ kd_sumber_listrik +"'"
			+" ,		kd_daya_listrik		= '"+ kd_daya_listrik +"'"
			+" ,		kd_voltase			= '"+ kd_voltase + "'"
			+" ,		username			= '"+ username +"'"
			+" where	kd_tahun_ajaran		= '"+ kd_tahun_ajaran + "'"
			+" and		kd_sumber_listrik	= '"+ kd_sumber_listrik_old + "'"
			+" and		kd_daya_listrik		= '"+ kd_daya_listrik_old + "'"
			+" and		kd_voltase			= '"+ kd_voltase_old + "'";
		break;
	case 4:
		q 	= " delete	from t_sekolah_pemakaian_listrik"
			+ " where	kd_tahun_ajaran		= '"+ kd_tahun_ajaran + "'"
			+ " and		kd_sumber_listrik	= '"+ kd_sumber_listrik + "'"
			+ " and		kd_daya_listrik		= '"+ kd_daya_listrik + "'"
			+ " and		kd_voltase			= '"+ kd_voltase + "'";
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (SQLException e){
	Properties	props	= new Properties();
	
	props.load(new FileInputStream(application.getRealPath("WEB-INF"+File.separator+"error.properties")));
	
	String		err_msg = props.getProperty("" + e.getErrorCode() + "");
	
	if (err_msg == null){
		out.print("{success:false,info:'" + e.getErrorCode() + " = Kesalahan operasi, silahkan hubungi direktorat.'}");
	} else {
		out.print("{success:false,info:'" + e.getErrorCode() + " = " + err_msg + "'}");
	}
}
%>
