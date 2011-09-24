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
String q = "";
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int dml 				= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran	= (String) session.getAttribute("kd.tahun_pelajaran");
	String nilai_un_indo	= request.getParameter("nilai_un_indo");
	String nilai_un_mat		= request.getParameter("nilai_un_mat");
	String nilai_un_ing		= request.getParameter("nilai_un_ing");
	String nilai_un_ipa		= request.getParameter("nilai_un_ipa");
	String username			= (String) session.getAttribute("user.id");

	switch (dml) {
	case 2:
		q	=" insert into k_sekolah_lism"
			+" (kd_tahun_ajaran"
			+", nilai_un_indo"
			+", nilai_un_mat"
			+", nilai_un_ing"
			+", nilai_un_ipa"
			+", username)"
			+"  values ("
			+" '"+ kd_tahun_ajaran +"'"
			+", "+ nilai_un_indo
			+", "+ nilai_un_mat
			+", "+ nilai_un_ing
			+", "+ nilai_un_ipa
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	k_sekolah_lism"
			+" set		nilai_un_indo	= "+ nilai_un_indo
			+" ,		nilai_un_mat	= "+ nilai_un_mat
			+" ,		nilai_un_ing	= "+ nilai_un_ing
			+" ,		nilai_un_ipa	= "+ nilai_un_ipa
			+" ,		username		= '"+ username +"'"
			+" where	kd_tahun_ajaran	= '"+ kd_tahun_ajaran +"'";
		break;
	case 4:
		q	= " delete	from k_sekolah_lism"
			+ " where	kd_tahun_ajaran = '"+ kd_tahun_ajaran + "'";
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
