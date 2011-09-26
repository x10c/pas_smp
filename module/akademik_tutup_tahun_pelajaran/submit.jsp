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

	Statement	db_stmt		= db_con.createStatement();
	Statement	db_stmt2	= db_con.createStatement();
	ResultSet	rs			= null;
	
	int dml 					= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");
	String username				= (String) session.getAttribute("user.id");
	String q					= "";
	String q2					= "";
	int kd_tahun_tambah			= 0;
	String kd_tahun_pelajaran	= "";
	int jumlah					= 0;
	
	kd_tahun_tambah = Integer.parseInt(kd_tahun_ajaran) + 1;
	kd_tahun_pelajaran = kd_tahun_tambah + "";
	
	switch (dml) {
	case 5:
		q	=" select	count(*) as jumlah"
			+" from		t_sekolah_identitas"
			+" where	kd_tahun_ajaran = '" + kd_tahun_pelajaran + "'";
		
		q2	=" insert	into t_sekolah_identitas"
			+" select	'" + kd_tahun_pelajaran + "'"
			+" ,		npsn"
			+" ,		kd_status_sekolah"
			+" ,		kd_bentuk_sekolah"
			+" ,		kd_jenis_sekolah"
			+" ,		nm_sekolah"
			+" ,		jalan"
			+" ,		kd_pos"
			+" ,		kd_daerah"
			+" ,		id_propinsi"
			+" ,		id_kabupaten"
			+" ,		id_kecamatan"
			+" ,		kd_desa"
			+" ,		kd_area"
			+" ,		no_telp"
			+" ,		no_fax"
			+" ,		jarak_skl_sjns"
			+" ,		kd_waktu_penyelenggaraan"
			+" ,		kd_type_sekolah"
			+" ,		kd_klasifikasi_sekolah"
			+" ,		kategori"
			+" ,		kd_klasifikasi_geografis"
			+" ,		'" + username + "'"
			+" ,		now()"
			+" from		t_sekolah_identitas"
			+" where	kd_tahun_ajaran =	("
			+"								select	max(kd_tahun_ajaran)"
			+"								from	t_sekolah_identitas"
			+"								where	kd_tahun_ajaran < '" + kd_tahun_pelajaran + "'"
			+"								)";

		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	rs	= db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Identitas Sekolah tidak ditemukan!'}");
		return;
	}

	jumlah	= Integer.parseInt(rs.getString("jumlah"));
	
	if (jumlah == 0){
		db_stmt2.executeUpdate(q2);
	}
	
	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (SQLException e){
	Properties	props	= new Properties();
	
	props.load(new FileInputStream(application.getRealPath("WEB-INF"+File.separator+"error.properties")));
	
	String		err_msg = props.getProperty("" + e.getErrorCode() + "");
	
	if (err_msg == null){
		out.print("{success:false,info:'" + e.getErrorCode() + " = " + e.toString() + "'}");
	} else {
		out.print("{success:false,info:'" + e.getErrorCode() + " = " + e.toString() + "'}");
	}
}
%>
