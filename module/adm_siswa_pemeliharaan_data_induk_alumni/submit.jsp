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
	String id_siswa			= request.getParameter("id_siswa");
	String lanjut_di		= request.getParameter("lanjut_di");
	String tanggal_bekerja	= request.getParameter("tanggal_bekerja");
	String nm_perusahaan	= request.getParameter("nm_perusahaan");
	String username			= (String) session.getAttribute("user.id");
	String q;

	if (tanggal_bekerja.equals("")){
		tanggal_bekerja = "null";
	} else {
		tanggal_bekerja = "cast('" + tanggal_bekerja + "' as date)";
	}

	switch (dml) {
	case 3:
		q	=" update	t_siswa_alumni"
			+" set		lanjut_di		= '"+ lanjut_di +"'"
			+" ,		tanggal_bekerja	=  "+ tanggal_bekerja
			+" ,		nm_perusahaan	= '"+ nm_perusahaan +"'"
			+" ,		username		= '"+ username +"'"
			+" where	id_siswa		=  "+ id_siswa;
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
