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

	int dml 								= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran					= request.getParameter("kd_tahun_ajaran");
	String id_pegawai						= request.getParameter("id_pegawai");
	String kd_mata_pelajaran_diajarkan		= request.getParameter("kd_mata_pelajaran_diajarkan");
	String kd_mata_pelajaran_diajarkan_old	= request.getParameter("kd_mata_pelajaran_diajarkan_old");
	String username							= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into t_pegawai_mengajar (kd_tahun_ajaran, id_pegawai, kd_mata_pelajaran_diajarkan, username)"
			+" values ('"+ kd_tahun_ajaran +"', "+ id_pegawai +", '"+ kd_mata_pelajaran_diajarkan +"', '"+ username +"')";
		break;
	case 3:
		q	=" update	t_pegawai_mengajar"
			+" set		kd_mata_pelajaran_diajarkan	= '"+ kd_mata_pelajaran_diajarkan +"'"
			+" ,		username					= '"+ username +"'"
			+" where	kd_tahun_ajaran				= '"+ kd_tahun_ajaran +"'"
			+" and		id_pegawai					=  "+ id_pegawai
			+" and		kd_mata_pelajaran_diajarkan	= '"+ kd_mata_pelajaran_diajarkan_old +"'";
		break;
	case 4:
		q	= " delete	from t_pegawai_mengajar"
			+ " where	kd_tahun_ajaran 			= '"+ kd_tahun_ajaran + "'"
			+ " and		id_pegawai 					=  "+ id_pegawai
			+ " and 	kd_mata_pelajaran_diajarkan = '"+ kd_mata_pelajaran_diajarkan + "'";
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
	
	String		err_msg = props.getProperty("" + e.getErrorCode() + "");
	
	if (err_msg == null){
		out.print("{success:false,info:'" + e.getErrorCode() + " = Kesalahan operasi, silahkan hubungi direktorat.'}");
	} else {
		out.print("{success:false,info:'" + e.getErrorCode() + " = " + err_msg + "'}");
	}
}
%>
