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
	String nm_software		= request.getParameter("nm_software");
	String nm_software_old	= request.getParameter("nm_software_old");
	String jumlah_lisensi	= request.getParameter("jumlah_lisensi");
	String jumlah_bajak		= request.getParameter("jumlah_bajak");
	String keterangan		= request.getParameter("keterangan");
	String username			= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into t_sekolah_software (kd_tahun_ajaran, nm_software, jumlah_lisensi, jumlah_bajak, keterangan, username)"
			+" values ('"+ kd_tahun_ajaran +"', '"+ nm_software +"', "+ jumlah_lisensi +", "+ jumlah_bajak +", '"+ keterangan +"', '"+ username +"')";
		break;
	case 3:
		q	=" update	t_sekolah_software"
			+" set		nm_software		= '"+ nm_software + "'"
			+" ,		jumlah_lisensi	=  "+ jumlah_lisensi
			+" ,		jumlah_bajak	=  "+ jumlah_bajak
			+" ,		keterangan		= '"+ keterangan +"'"
			+" ,		username		= '"+ username +"'"
			+" where	kd_tahun_ajaran	= '"+ kd_tahun_ajaran + "'"
			+" and		nm_software		= '"+ nm_software_old + "'";
		break;
	case 4:
		q 	= " delete	from t_sekolah_software"
			+ " where	kd_tahun_ajaran	= '"+ kd_tahun_ajaran + "'"
			+ " and		nm_software		= '"+ nm_software + "'";
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
