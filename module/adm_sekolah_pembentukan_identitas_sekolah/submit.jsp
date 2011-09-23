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

	int dml 						= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran			= (String) session.getAttribute("kd.tahun_pelajaran");
	String npsn						= request.getParameter("npsn");
	String nm_sekolah				= request.getParameter("nm_sekolah");
	String kd_bentuk_sekolah		= request.getParameter("kd_bentuk_sekolah");
	String kd_jenis_sekolah			= request.getParameter("kd_jenis_sekolah");
	String kd_status_sekolah		= request.getParameter("kd_status_sekolah");
	String kd_waktu_penyelenggaraan	= request.getParameter("kd_waktu_penyelenggaraan");
	String jalan					= request.getParameter("jalan");
	String kd_desa					= request.getParameter("kd_desa");
	String kd_daerah				= request.getParameter("kd_daerah");
	String kd_klasifikasi_geografis	= request.getParameter("kd_klasifikasi_geografis");
	String id_propinsi				= request.getParameter("id_propinsi");
	String id_kabupaten				= request.getParameter("id_kabupaten");
	String id_kecamatan				= request.getParameter("id_kecamatan");
	String kd_pos					= request.getParameter("kd_pos");
	String kd_area					= request.getParameter("kd_area");
	String no_telp					= request.getParameter("no_telp");
	String no_fax					= request.getParameter("no_fax");
	String jarak_skl_sjns			= request.getParameter("jarak_skl_sjns");
	String kd_klasifikasi_sekolah	= request.getParameter("kd_klasifikasi_sekolah");
	String kategori					= request.getParameter("kategori");
	String username					= (String) session.getAttribute("user.id");

	if (jarak_skl_sjns.equals("")){
		jarak_skl_sjns = "0";
	}
	
	if (kd_klasifikasi_sekolah.equals("")){
		kd_klasifikasi_sekolah = null;
	}
	
	switch (dml) {
	case 2:
		q	=" insert into t_sekolah_identitas"
			+" (kd_tahun_ajaran"
			+", npsn"
			+", nm_sekolah"
			+", kd_bentuk_sekolah"
			+", kd_jenis_sekolah"
			+", kd_status_sekolah"
			+", kd_waktu_penyelenggaraan"
			+", jalan"
			+", kd_desa"
			+", kd_daerah"
			+", kd_klasifikasi_geografis"
			+", id_propinsi"
			+", id_kabupaten"
			+", id_kecamatan"
			+", kd_pos"
			+", kd_area"
			+", no_telp"
			+", no_fax"
			+", jarak_skl_sjns"
			+", kd_klasifikasi_sekolah"
			+", kategori"
			+", username)"
			+"  values ("
			+"'"+ kd_tahun_ajaran +"'"
			+", '"+ npsn +"'"
			+", '"+ nm_sekolah +"'"
			+", '"+ kd_bentuk_sekolah +"'"
			+", '"+ kd_jenis_sekolah +"'"
			+", '"+ kd_status_sekolah +"'"
			+", '"+ kd_waktu_penyelenggaraan +"'"
			+", '"+ jalan +"'"
			+", '"+ kd_desa +"'"
			+", '"+ kd_daerah +"'"
			+", '"+ kd_klasifikasi_geografis +"'"
			+", "+ id_propinsi
			+", "+ id_kabupaten
			+", "+ id_kecamatan
			+", '"+ kd_pos + "'"
			+", '"+ kd_area + "'"
			+", '"+ no_telp + "'"
			+", '"+ no_fax + "'"
			+", "+ jarak_skl_sjns
			+", "+ kd_klasifikasi_sekolah
			+", '"+ kategori + "'"
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_sekolah_identitas"
			+" set		npsn						= '"+ npsn +"'"
			+" ,		nm_sekolah					= '"+ nm_sekolah +"'"
			+" ,		kd_bentuk_sekolah			= '"+ kd_bentuk_sekolah +"'"
			+" ,		kd_jenis_sekolah			= '"+ kd_jenis_sekolah +"'"
			+" ,		kd_status_sekolah			= '"+ kd_status_sekolah +"'"
			+" ,		kd_waktu_penyelenggaraan	= '"+ kd_waktu_penyelenggaraan +"'"
			+" ,		jalan						= '"+ jalan +"'"
			+" ,		kd_desa						= '"+ kd_desa +"'"
			+" ,		kd_daerah					= '"+ kd_daerah +"'"
			+" ,		kd_klasifikasi_geografis	= '"+ kd_klasifikasi_geografis +"'"
			+" ,		id_propinsi					= "+ id_propinsi
			+" ,		id_kabupaten				= "+ id_kabupaten
			+" ,		id_kecamatan				= "+ id_kecamatan
			+" ,		kd_pos						= '"+ kd_pos + "'"
			+" ,		kd_area						= '"+ kd_area + "'"
			+" ,		no_telp						= '"+ no_telp + "'"
			+" ,		no_fax						= '"+ no_fax + "'"
			+" ,		jarak_skl_sjns				= "+ jarak_skl_sjns
			+" ,		kd_klasifikasi_sekolah		= "+ kd_klasifikasi_sekolah
			+" ,		kategori					= '"+ kategori + "'"
			+" ,		username					= '"+ username +"'"
			+" where	kd_tahun_ajaran				= '"+ kd_tahun_ajaran +"'";
		break;
	case 4:
		q	= " delete	from t_sekolah_identitas"
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
