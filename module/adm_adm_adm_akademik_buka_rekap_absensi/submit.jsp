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
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int dml 					= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");
	String kd_periode_belajar	= (String) session.getAttribute("kd.periode_belajar");
	String username				= (String) session.getAttribute("user.id");
	String q					= "";
	String q2					= "";

	int	periode_belajar	= Integer.parseInt(kd_periode_belajar) - 1;
	kd_periode_belajar	= periode_belajar + "";
	
	switch (dml) {
	case 5:
		q	=" update	t_pegawai_rombel"
			+" set		status_naik_kelas	= '" + kd_periode_belajar + "'"
			+" ,		username			= 'ditpsmp'";
			+" where	kd_tahun_ajaran		= '" + kd_tahun_ajaran + "'";

		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate(q);
	
	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e){
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
