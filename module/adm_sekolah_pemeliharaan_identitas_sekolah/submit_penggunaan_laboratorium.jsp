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

	int dml 						= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran			= (String) session.getAttribute("kd.tahun_pelajaran");
	String jml_jam_lab_ipa			= request.getParameter("jml_jam_lab_ipa");
	String jml_jam_lab_kimia		= request.getParameter("jml_jam_lab_kimia");
	String jml_jam_lab_fisika		= request.getParameter("jml_jam_lab_fisika");
	String jml_jam_lab_biologi		= request.getParameter("jml_jam_lab_biologi");
	String jml_jam_lab_bahasa		= request.getParameter("jml_jam_lab_bahasa");
	String jml_jam_lab_ips			= request.getParameter("jml_jam_lab_ips");
	String jml_jam_lab_komputer		= request.getParameter("jml_jam_lab_komputer");
	String jml_jam_lab_multimedia	= request.getParameter("jml_jam_lab_multimedia");
	String username					= (String) session.getAttribute("user.id");

	switch (dml) {
	case 2:
		q	=" insert into k_sekolah_lism"
			+" (kd_tahun_ajaran"
			+", jml_jam_lab_ipa"
			+", jml_jam_lab_kimia"
			+", jml_jam_lab_fisika"
			+", jml_jam_lab_biologi"
			+", jml_jam_lab_bahasa"
			+", jml_jam_lab_ips"
			+", jml_jam_lab_komputer"
			+", jml_jam_lab_multimedia"
			+", username)"
			+"  values ("
			+" '"+ kd_tahun_ajaran +"'"
			+", "+ jml_jam_lab_ipa
			+", "+ jml_jam_lab_kimia
			+", "+ jml_jam_lab_fisika
			+", "+ jml_jam_lab_biologi
			+", "+ jml_jam_lab_bahasa
			+", "+ jml_jam_lab_ips
			+", "+ jml_jam_lab_komputer
			+", "+ jml_jam_lab_multimedia
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	k_sekolah_lism"
			+" set		jml_jam_lab_ipa			= "+ jml_jam_lab_ipa
			+" ,		jml_jam_lab_kimia		= "+ jml_jam_lab_kimia
			+" ,		jml_jam_lab_fisika		= "+ jml_jam_lab_fisika
			+" ,		jml_jam_lab_biologi		= "+ jml_jam_lab_biologi
			+" ,		jml_jam_lab_bahasa		= "+ jml_jam_lab_bahasa
			+" ,		jml_jam_lab_ips			= "+ jml_jam_lab_ips
			+" ,		jml_jam_lab_komputer	= "+ jml_jam_lab_komputer
			+" ,		jml_jam_lab_multimedia	= "+ jml_jam_lab_multimedia
			+" ,		username				= '"+ username +"'"
			+" where	kd_tahun_ajaran			= '"+ kd_tahun_ajaran +"'";
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
