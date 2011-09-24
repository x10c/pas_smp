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

	int dml 					= Integer.parseInt(request.getParameter("dml_type"));
	String asal_smp				= request.getParameter("asal_smp");
	String id_propinsi			= request.getParameter("id_propinsi");
	String id_kabupaten			= request.getParameter("id_kabupaten");
	String nm_sekolah			= request.getParameter("nm_sekolah");
	String kd_jenis_sekolah		= request.getParameter("kd_jenis_sekolah");
	String kd_status_sekolah	= request.getParameter("kd_status_sekolah");
	String alamat_sekolah		= request.getParameter("alamat_sekolah");
	String no_telp				= request.getParameter("no_telp");
	String username				= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into r_sekolah_setingkat (id_propinsi, id_kabupaten, nm_sekolah, kd_jenis_sekolah, kd_status_sekolah, alamat_sekolah, no_telp, username)"
			+" values ("+ id_propinsi +", "+ id_kabupaten +", '" + nm_sekolah +"', '" + kd_jenis_sekolah +"', '"+ kd_status_sekolah +"', '"+ alamat_sekolah +"', '"+ no_telp +"', '"+ username +"')";
		break;
	case 3:
		q	=" update	r_sekolah_setingkat"
			+" set		id_propinsi			= "+ id_propinsi
			+" ,		id_kabupaten		= "+ id_kabupaten
			+" ,		nm_sekolah			= '"+ nm_sekolah +"'"
			+" ,		kd_jenis_sekolah	= '"+ kd_jenis_sekolah +"'"
			+" ,		kd_status_sekolah	= '"+ kd_status_sekolah +"'"
			+" ,		alamat_sekolah		= '"+ alamat_sekolah +"'"
			+" ,		no_telp				= '"+ no_telp +"'"
			+" ,		username			= '"+ username +"'"
			+" where	asal_smp				= "+ asal_smp;
		break;
	case 4:
		q = " delete from r_sekolah_setingkat where asal_smp = "+ asal_smp;
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
