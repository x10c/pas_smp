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

	int dml 				= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran	= request.getParameter("kd_tahun_ajaran");
	String kd_tingkat_kelas	= request.getParameter("kd_tingkat_kelas");
	String kd_rombel		= request.getParameter("kd_rombel");
	String kd_rombel_old	= request.getParameter("kd_rombel_old");
	String id_ruang_kelas	= request.getParameter("id_ruang_kelas");
	String id_pegawai		= request.getParameter("id_pegawai");
	String id_pegawai_bk	= request.getParameter("id_pegawai_bk");
	String keterangan		= request.getParameter("keterangan");
	String username			= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into t_pegawai_rombel (kd_tahun_ajaran, kd_tingkat_kelas, kd_rombel, id_ruang_kelas, id_pegawai, id_pegawai_bk, keterangan, username)"
			+" values ('"+ kd_tahun_ajaran +"', '"+ kd_tingkat_kelas +"', '"+ kd_rombel +"', "+ id_ruang_kelas +", "+ id_pegawai +", "+ id_pegawai_bk +", '"+ keterangan +"', '" + username +"')";
		break;
	case 3:
		q	=" update	t_pegawai_rombel"
			+" set		kd_rombel		= '"+ kd_rombel +"'"
			+" ,		id_ruang_kelas	= "+ id_ruang_kelas
			+" ,		id_pegawai		= "+ nip
			+" ,		id_pegawai_bk	= "+ id_pegawai_bk
			+" ,		keterangan		= '"+ keterangan + "'"
			+" ,		username		= '"+ username +"'"
			+" where	kd_tahun_ajaran		= '"+ kd_tahun_ajaran +"'"
			+" and		kd_tingkat_kelas	= '"+ kd_tingkat_kelas +"'"
			+" and		kd_rombel			= '"+ kd_rombel_old +"'";
		break;
	case 4:
		q	= " delete	from t_pegawai_rombel"
			+ " where	kd_tahun_ajaran 	= '"+ kd_tahun_ajaran + "'"
			+ " and		kd_tingkat_kelas 	= '"+ kd_tingkat_kelas + "'"
			+ " and 	kd_rombel 			= '"+ kd_rombel + "'";
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
