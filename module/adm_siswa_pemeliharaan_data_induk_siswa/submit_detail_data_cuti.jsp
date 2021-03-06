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
	String tanggal			= request.getParameter("tanggal");
	String tanggal_old		= request.getParameter("tanggal_old");
	String tanggal_masuk	= request.getParameter("tanggal_masuk");
	String keterangan		= request.getParameter("keterangan");
	String username			= (String) session.getAttribute("user.id");
	String q;

	if (tanggal_masuk.equals("")){
		tanggal_masuk = "null";
	} else {
		tanggal_masuk = "cast('" + tanggal_masuk + "' as date)";
	}

	switch (dml) {
	case 2:
		q	="  insert into t_siswa_cuti"
			+"( id_siswa"
			+", tanggal"
			+", tanggal_masuk"
			+", keterangan"
			+", username)"
			+"  values("
			+"   "+ id_siswa
			+", cast('"+ tanggal +"' as date)"
			+",  "+ tanggal_masuk
			+", '"+ keterangan + "'"
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_siswa_cuti"
			+" set		tanggal			= cast('"+ tanggal +"' as date)"
			+" ,		tanggal_masuk	= "+ tanggal_masuk
			+" ,		keterangan		= '"+ keterangan + "'"
			+" ,		username		= '"+ username +"'"
			+" where	id_siswa		=  "+ id_siswa
			+" and		tanggal			= '"+ tanggal_old + "'";
		break;
	case 4:
		q 	= " delete	from t_siswa_cuti"
			+ " where	id_siswa	=  "+ id_siswa
			+ " and		tanggal		= '"+ tanggal + "'";
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
