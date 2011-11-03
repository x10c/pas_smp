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

	int dml 							= Integer.parseInt(request.getParameter("dml_type"));
	String kd_kurikulum					= request.getParameter("kd_kurikulum");
	String kd_tingkat_kelas				= request.getParameter("kd_tingkat_kelas");
	String kd_periode_belajar			= request.getParameter("kd_periode_belajar");
	String kd_mata_pelajaran_diajarkan	= request.getParameter("kd_mata_pelajaran_diajarkan");
	String status_ciri_khas				= request.getParameter("status_ciri_khas");
	String uan							= request.getParameter("uan");
	String elemen						= request.getParameter("elemen");
	String username						= (String) session.getAttribute("user.id");
	String q;
	String q2 = "";

	switch (dml) {
	case 2:
		q	=" insert into t_kur_kurikulum (kd_kurikulum, kd_tingkat_kelas, kd_periode_belajar, kd_mata_pelajaran_diajarkan, status_ciri_khas, uan, elemen, username)"
			+" values ('"+ kd_kurikulum +"', '"+ kd_tingkat_kelas +"', '1', '"+ kd_mata_pelajaran_diajarkan +"', '"+ status_ciri_khas +"', '"+ uan +"', "+ elemen +", '" + username +"')";
		
		q2	=" insert into t_kur_kurikulum (kd_kurikulum, kd_tingkat_kelas, kd_periode_belajar, kd_mata_pelajaran_diajarkan, status_ciri_khas, uan, elemen, username)"
			+" values ('"+ kd_kurikulum +"', '"+ kd_tingkat_kelas +"', '2', '"+ kd_mata_pelajaran_diajarkan +"', '"+ status_ciri_khas +"', '"+ uan +"', "+ elemen +", '" + username +"')";
			
		break;
	case 3:
		q	=" update	t_kur_kurikulum"
			+" set		status_ciri_khas	= '"+ status_ciri_khas + "'"
			+" ,		uan					= '"+ uan + "'"
			+" ,		elemen				=  "+ elemen
			+" ,		username			= '"+ username +"'"
			+" where	kd_kurikulum				= '"+ kd_kurikulum +"'"
			+" and		kd_tingkat_kelas			= '"+ kd_tingkat_kelas +"'"
			+" and		kd_periode_belajar			= '"+ kd_periode_belajar +"'"
			+" and		kd_mata_pelajaran_diajarkan	= '"+ kd_mata_pelajaran_diajarkan +"'";
		break;
	case 4:
		q	= " delete	from t_kur_kurikulum"
			+" where	kd_kurikulum				= '"+ kd_kurikulum +"'"
			+" and		kd_tingkat_kelas			= '"+ kd_tingkat_kelas +"'"
			+" and		kd_periode_belajar			= '"+ kd_periode_belajar +"'"
			+" and		kd_mata_pelajaran_diajarkan	= '"+ kd_mata_pelajaran_diajarkan +"'";

		q2	= " delete	from t_kur_kurikulum"
			+" where	kd_kurikulum				= '"+ kd_kurikulum +"'"
			+" and		kd_tingkat_kelas			= '"+ kd_tingkat_kelas +"'"
			+" and		kd_periode_belajar			= '2'"
			+" and		kd_mata_pelajaran_diajarkan	= '"+ kd_mata_pelajaran_diajarkan +"'";

		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate(q);
	db_stmt.executeUpdate(q2);

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
