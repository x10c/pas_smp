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
	String kd_perlengkapan_sekolah	= request.getParameter("kd_perlengkapan_sekolah");
	String jumlah					= request.getParameter("jumlah");
	String username					= (String) session.getAttribute("user.id");
	String q;

	if(jumlah.equals("")){
		jumlah = "0";
	}
	switch (dml) {
	case 2:
		q	=" insert into t_sekolah_perlengkapan (kd_tahun_ajaran, kd_perlengkapan_sekolah, jumlah, username)"
			+" values ('"+ kd_tahun_ajaran +"', '"+ kd_perlengkapan_sekolah +"', "+ jumlah +", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_sekolah_perlengkapan"
			+" set		jumlah					= "+ jumlah
			+" ,		username				= '"+ username +"'"
			+" where	kd_tahun_ajaran			= '"+ kd_tahun_ajaran + "'"
			+" and		kd_perlengkapan_sekolah	= '"+ kd_perlengkapan_sekolah + "'";
		break;
	case 4:
		q 	= " delete	from t_sekolah_perlengkapan"
			+ " where	kd_tahun_ajaran			= '"+ kd_tahun_ajaran + "'"
			+ " and		kd_perlengkapan_sekolah	= '"+ kd_perlengkapan_sekolah + "'";
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
