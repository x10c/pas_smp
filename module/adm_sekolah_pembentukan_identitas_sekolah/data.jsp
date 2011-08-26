<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String 		kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");
	
	ResultSet	rs;
	String		q;
	String		data;

	q=" select	kd_tahun_ajaran"
	+" ,		npsn"
	+" ,		nm_sekolah"
	+" ,		kd_bentuk_sekolah"
	+" ,		kd_jenis_sekolah"
	+" ,		kd_status_sekolah"
	+" ,		kd_waktu_penyelenggaraan"
	+" ,		jalan"
	+" ,		kd_desa"
	+" ,		kd_daerah"
	+" ,		ifnull(kd_klasifikasi_geografis, '') as kd_klasifikasi_geografis"
	+" ,		id_propinsi"
	+" ,		id_kabupaten"
	+" ,		id_kecamatan"
	+" ,		kd_pos"
	+" ,		kd_area"
	+" ,		no_telp"
	+" ,		no_fax"
	+" ,		ifnull(jarak_skl_sjns, 0) as jarak_skl_sjns"
	+" ,		ifnull(kd_klasifikasi_sekolah, '') as kd_klasifikasi_sekolah"
	+" ,		ifnull(kategori, '') as kategori"
	+" ,		inklusi"
	+" from		t_sekolah_identitas "
	+" where	kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Sekolah tidak ditemukan!'}");
		return;
	}

	data	="{ kd_tahun_ajaran	: '"+ rs.getString("kd_tahun_ajaran") + "'"
			+", npsn : '"+ rs.getString("npsn") + "'"
			+", nm_sekolah : '"+ rs.getString("nm_sekolah") + "'"
			+", kd_bentuk_sekolah : '"+ rs.getString("kd_bentuk_sekolah") + "'"
			+", kd_jenis_sekolah : '"+ rs.getString("kd_jenis_sekolah") + "'"
			+", kd_status_sekolah : '"+ rs.getString("kd_status_sekolah") + "'"
			+", kd_waktu_penyelenggaraan : '"+ rs.getString("kd_waktu_penyelenggaraan") + "'"
			+", jalan : '"+ rs.getString("jalan") + "'"
			+", kd_desa : '"+ rs.getString("kd_desa") + "'"
			+", kd_daerah : '"+ rs.getString("kd_daerah") + "'"
			+", kd_klasifikasi_geografis : '"+ rs.getString("kd_klasifikasi_geografis") + "'"
			+", id_propinsi : "+ rs.getString("id_propinsi")
			+", id_kabupaten : "+ rs.getString("id_kabupaten")
			+", id_kecamatan : "+ rs.getString("id_kecamatan")
			+", kd_pos : '"+ rs.getString("kd_pos") + "'"
			+", kd_area : '"+ rs.getString("kd_area") + "'"
			+", no_telp : '"+ rs.getString("no_telp") + "'"
			+", no_fax : '"+ rs.getString("no_fax") + "'"
			+", jarak_skl_sjns : "+ rs.getString("jarak_skl_sjns")
			+", kd_klasifikasi_sekolah : '"+ rs.getString("kd_klasifikasi_sekolah") + "'"
			+", kategori : '"+ rs.getString("kategori") + "'"
			+", inklusi : '"+ rs.getString("inklusi") + "'";

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
