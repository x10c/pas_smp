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
	String kd_penggunaan_tanah		= request.getParameter("kd_penggunaan_tanah");
	String kd_penggunaan_tanah_old	= request.getParameter("kd_penggunaan_tanah_old");
	String kd_kepemilikan			= request.getParameter("kd_kepemilikan");
	String kd_kepemilikan_old		= request.getParameter("kd_kepemilikan_old");
	String kd_sertifikat			= request.getParameter("kd_sertifikat");
	String kd_sertifikat_old		= request.getParameter("kd_sertifikat_old");
	String luas						= request.getParameter("luas");
	String keterangan				= request.getParameter("keterangan");
	String username					= (String) session.getAttribute("user.id");
	String q;

	if(luas.equals("")){
		luas = "0";
	}
	switch (dml) {
	case 2:
		q	=" insert into t_sekolah_properti (kd_tahun_ajaran, kd_penggunaan_tanah, kd_kepemilikan, kd_sertifikat, luas, keterangan, username)"
			+" values ('"+ kd_tahun_ajaran +"', '"+ kd_penggunaan_tanah +"', '"+ kd_kepemilikan +"', '"+ kd_sertifikat +"', "+ luas +", '"+ keterangan +"', '" + username +"')";
		break;
	case 3:
		q	=" update	t_sekolah_properti"
			+" set		kd_penggunaan_tanah	= '"+ kd_penggunaan_tanah +"'"
			+" ,		kd_kepemilikan		= '"+ kd_kepemilikan +"'"
			+" ,		kd_sertifikat		= '"+ kd_sertifikat + "'"
			+" ,		luas				=  "+ luas
			+" ,		keterangan			= '"+ keterangan +"'"
			+" ,		username			= '"+ username +"'"
			+" where	kd_tahun_ajaran		= '"+ kd_tahun_ajaran + "'"
			+" and		kd_penggunaan_tanah	= '"+ kd_penggunaan_tanah_old + "'"
			+" and		kd_kepemilikan		= '"+ kd_kepemilikan_old + "'"
			+" and		kd_sertifikat		= '"+ kd_sertifikat_old + "'";
		break;
	case 4:
		q 	= " delete	from t_sekolah_properti"
			+ " where	kd_tahun_ajaran		= '"+ kd_tahun_ajaran + "'"
			+ " and		kd_penggunaan_tanah	= '"+ kd_penggunaan_tanah_old + "'"
			+ " and		kd_kepemilikan		= '"+ kd_kepemilikan_old + "'"
			+ " and		kd_sertifikat		= '"+ kd_sertifikat_old + "'";
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
