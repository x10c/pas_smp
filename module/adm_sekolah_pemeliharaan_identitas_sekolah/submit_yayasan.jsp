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
String q = "";
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int dml 					= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");
	String kd_akreditasi		= request.getParameter("kd_akreditasi");
	String no_data_sekolah		= request.getParameter("no_data_sekolah");
	String nm_yayasan			= request.getParameter("nm_yayasan");
	String jalan_yayasan		= request.getParameter("jalan_yayasan");
	String id_propinsi			= request.getParameter("id_propinsi");
	String id_kabupaten			= request.getParameter("id_kabupaten");
	String id_kecamatan			= request.getParameter("id_kecamatan");
	String kd_desa_yayasan		= request.getParameter("kd_desa_yayasan");
	String no_akte_yayasan		= request.getParameter("no_akte_yayasan");
	String tanggal_akte_yayasan	= request.getParameter("tanggal_akte_yayasan");
	String kd_kel_yayasan		= request.getParameter("kd_kel_yayasan");
	String username				= (String) session.getAttribute("user.id");

	switch (dml) {
	case 2:
		q	=" insert into t_sekolah_sk_swasta"
			+" (kd_tahun_ajaran"
			+", kd_akreditasi"
			+", no_data_sekolah"
			+", nm_yayasan"
			+", jalan_yayasan"
			+", id_propinsi"
			+", id_kabupaten"
			+", id_kecamatan"
			+", kd_desa_yayasan"
			+", no_akte_yayasan"
			+", tanggal_akte_yayasan"
			+", kd_kel_yayasan"
			+", username)"
			+"  values ("
			+"  '"+ kd_tahun_ajaran +"'"
			+", '"+ kd_akreditasi +"'"
			+", '"+ no_data_sekolah + "'"
			+", '"+ nm_yayasan +"'"
			+", '"+ jalan_yayasan +"'"
			+",  "+ id_propinsi
			+",  "+ id_kabupaten
			+",  "+ id_kecamatan
			+", '"+ kd_desa_yayasan +"'"
			+", '"+ no_akte_yayasan + "'"
			+", cast('"+ tanggal_akte_yayasan +"' as date)"
			+", '"+ kd_kel_yayasan + "'"
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_sekolah_sk_swasta"
			+" set		kd_akreditasi			= '"+ kd_akreditasi +"'"
			+" ,		no_data_sekolah			= '"+ no_data_sekolah + "'"
			+" ,		nm_yayasan				= '"+ nm_yayasan +"'"
			+" ,		jalan_yayasan			= '"+ jalan_yayasan +"'"
			+" ,		id_propinsi				= "+ id_propinsi
			+" ,		id_kabupaten			= "+ id_kabupaten
			+" ,		id_kecamatan			= "+ id_kecamatan
			+" ,		kd_desa_yayasan			= '"+ kd_desa_yayasan +"'"
			+" ,		no_akte_yayasan			= '"+ no_akte_yayasan + "'"
			+" ,		tanggal_akte_yayasan	= cast('"+ tanggal_akte_yayasan +"' as date)"
			+" ,		kd_kel_yayasan			= '"+ kd_kel_yayasan +"'"
			+" ,		username				= '"+ username +"'"
			+" where	kd_tahun_ajaran			= '"+ kd_tahun_ajaran +"'";
		break;
	case 4:
		q	= " delete	from t_sekolah_sk_swasta"
			+ " where	kd_tahun_ajaran = '"+ kd_tahun_ajaran + "'";
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
