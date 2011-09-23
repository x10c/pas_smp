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
	String kd_tahun_ajaran	= (String) session.getAttribute("kd.tahun_pelajaran");
	String no_urut			= request.getParameter("no_urut");
	String no_urut_old		= request.getParameter("no_urut_old");
	String nm_alat			= request.getParameter("nm_alat");
	String jumlah_baik		= request.getParameter("jumlah_baik");
	String jumlah_ringan	= request.getParameter("jumlah_ringan");
	String jumlah_sedang	= request.getParameter("jumlah_sedang");
	String jumlah_berat		= request.getParameter("jumlah_berat");
	String username			= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into t_sekolah_pkh_alat (kd_tahun_ajaran, no_urut, nm_alat, jumlah_baik, jumlah_ringan, jumlah_sedang, jumlah_berat, username)"
			+" values ('"+ kd_tahun_ajaran +"', "+ no_urut +", '"+ nm_alat +"', "+ jumlah_baik +", "+ jumlah_ringan +", "+ jumlah_sedang +", "+ jumlah_berat +", '" + username +"')";
		break;
	case 3:
		q	=" update	t_sekolah_pkh_alat"
			+" set		no_urut			= "+ no_urut
			+" ,		nm_alat			= '"+ nm_alat +"'"
			+" ,		jumlah_baik		= "+ jumlah_baik
			+" ,		jumlah_ringan	= "+ jumlah_ringan
			+" ,		jumlah_sedang	= "+ jumlah_sedang
			+" ,		jumlah_berat	= "+ jumlah_berat
			+" ,		username		= '"+ username +"'"
			+" where	kd_tahun_ajaran	= '"+ kd_tahun_ajaran + "'"
			+" and		no_urut			= "+ no_urut_old;
		break;
	case 4:
		q 	= " delete	from t_sekolah_pkh_alat"
			+ " where	kd_tahun_ajaran	= '"+ kd_tahun_ajaran + "'"
			+ " and		no_urut			= "+ no_urut;
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
