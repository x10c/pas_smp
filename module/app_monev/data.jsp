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

	q	="SELECT	( "
		+"			( "
		+"			IF(a.jumlah > 0, 1, 0) + IF(b.jumlah > 0, 1, 0) + IF(c.jumlah > 0, 1, 0) + "
		+"			IF(d.jumlah > 0, 1, 0) + IF(e.jumlah > 0, 1, 0) + IF(f.jumlah > 0, 1, 0) + "
		+"			IF(g.jumlah > 0, 1, 0) + IF(h.jumlah > 0, 1, 0) + IF(i.jumlah > 0, 1, 0) + "
		+"			IF(j.jumlah > 0, 1, 0) + IF(k.jumlah > 0, 1, 0) + IF(l.jumlah > 0, 1, 0) + "
		+"			IF(m.jumlah > 0, 1, 0) + IF(n.jumlah > 0, 1, 0) "
		+"			) / 14 * 100 "
		+"			) AS referensi "
		+",			( "
		+"			o.jumlah / 5 * 100 "
		+"			) AS properti_sekolah "
		+",			( "
		+"			p.jumlah / 11 * 100 "
		+"			) AS perlengkapan_sekolah "
		+",			( "
		+"			q.jumlah / 7 * 100 "
		+"			) AS perlengkapan_kbm "
		+",			( "
		+"			r.jumlah / 37 * 100 "
		+"			) AS ruangan "
		+",			( "
		+"			s.jumlah / (SELECT COUNT(*) FROM r_mata_pelajaran_diajarkan AS xx) * 100 "
		+"			) AS bualpen "
		+",			( "
		+"			( "
		+"			IF(t.jumlah > 0, 1, 0) + IF(u.jumlah > 0, 1, 0) + IF(v.jumlah > 0, 1, 0) + "
		+"			IF(w.jumlah > 0, 1, 0) + IF(x.jumlah > 0, 1, 0) + IF(y.jumlah > 0, 1, 0) "
		+"			) / 6 * 100 "
		+"			) AS pendukung_lism "
		+",			x.jumlah AS keuangan "
		+",			y.jumlah AS bantuan "
		+",			z.jumlah AS kepala_sekolah "
		+",			aa.jumlah AS guru "
		+",			bb.jumlah AS tenaga_administrasi "
		+",			cc.jumlah AS siswa "
		+",			dd.jumlah AS rombongan_belajar "
		+",			ee.jumlah AS penentuan_kelas "
		+"FROM 		( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	r_jenis_lomba "
		+"			) AS a "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	r_jenis_pkh "
		+"			) AS b "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	r_penataran "
		+"			) AS c "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	r_asal_sekolah "
		+"			) AS d "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	r_sekolah_setingkat "
		+"			) AS e "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	r_penyakit "
		+"			) AS f "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	r_hobi "
		+"			) AS g "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	r_gol_pekerjaan_ortu "
		+"			) AS h "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	r_mata_pelajaran_diajarkan "
		+"			WHERE	LEFT(KD_MATA_PELAJARAN_DIAJARKAN, 2) = '16' "
		+"			) AS i "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	t_kur_kurikulum "
		+"			WHERE	LEFT(KD_MATA_PELAJARAN_DIAJARKAN, 2) = '16' "
		+"			) AS j "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	r_ekstrakurikuler "
		+"			) AS k "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	t_sekolah_jurusan "
		+"			WHERE	KD_TAHUN_AJARAN = '" + kd_tahun_ajaran + "' "
		+"			) AS l "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	t_pegawai_mengajar "
		+"			WHERE	KD_TAHUN_AJARAN = '" + kd_tahun_ajaran + "' "
		+"			) AS m "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	t_kur_kkm_matpel "
		+"			WHERE	KD_TAHUN_AJARAN = '" + kd_tahun_ajaran + "' "
		+"			) AS n "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM	( "
		+"					SELECT	DISTINCT KD_PENGGUNAAN_TANAH "
		+"					FROM	t_sekolah_properti "
		+"					WHERE	KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "' "
		+"					) AS zz"
		+"			) as o "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	t_sekolah_perlengkapan "
		+"			WHERE	KD_TAHUN_AJARAN = '" + kd_tahun_ajaran + "' "
		+"			) AS p "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	t_sekolah_perlengkapan_kbm "
		+"			WHERE	KD_TAHUN_AJARAN = '" + kd_tahun_ajaran + "' "
		+"			) AS q "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM	( "
		+"					SELECT	DISTINCT KD_RUANG "
		+"					FROM	t_sekolah_ruang "
		+"					WHERE	KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "' "
		+"					) AS yy"
		+"			) as r "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	t_sekolah_bualpen "
		+"			WHERE	KD_TAHUN_AJARAN = '" + kd_tahun_ajaran + "' "
		+"			) AS s "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	t_sekolah_info "
		+"			WHERE	KD_TAHUN_AJARAN = '" + kd_tahun_ajaran + "' "
		+"			) AS t "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	t_sekolah_sk "
		+"			WHERE	KD_TAHUN_AJARAN = '" + kd_tahun_ajaran + "' "
		+"			) AS u "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	k_sekolah_lism "
		+"			WHERE	KD_TAHUN_AJARAN = '" + kd_tahun_ajaran + "' "
		+"			) AS v "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	k_sekolah_passing_grade "
		+"			WHERE	KD_TAHUN_AJARAN = '" + kd_tahun_ajaran + "' "
		+"			) AS w "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	k_sekolah_keuangan "
		+"			WHERE	KD_TAHUN_AJARAN = '" + kd_tahun_ajaran + "' "
		+"			) AS x "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	t_sekolah_bantuan "
		+"			WHERE	KD_TAHUN_AJARAN = '" + kd_tahun_ajaran + "' "
		+"			) AS y "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	v_pegawai_detil "
		+"			WHERE	KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "' "
		+"			AND		KD_JENIS_PEGAWAI	IN ('15','20','21','22','23','24') "
		+"			AND		STS_AKTIF			= '1' "
		+"			) AS z "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	v_pegawai_detil "
		+"			WHERE	KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "' "
		+"			AND		KD_JENIS_KETENAGAAN	IN ('6') "
		+"			AND		STS_AKTIF			= '1' "
		+"			) AS aa "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	v_pegawai_detil "
		+"			WHERE	KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "' "
		+"			AND		KD_JENIS_KETENAGAAN	IN ('2') "
		+"			AND		STS_AKTIF			= '1' "
		+"			) AS bb "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	t_siswa_tingkat "
		+"			WHERE	KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "' "
		+"			) AS cc "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	t_pegawai_rombel "
		+"			WHERE	KD_TAHUN_AJARAN		= '" + kd_tahun_ajaran + "' "
		+"			) AS dd "
		+",			( "
		+"			SELECT	COUNT(*) AS jumlah "
		+"			FROM 	( "
		+"					SELECT	DISTINCT KD_ROMBEL "
		+"					FROM	t_siswa_tingkat "
		+"					WHERE	KD_TAHUN_AJARAN = '" + kd_tahun_ajaran + "' "
		+"					) AS ww"
		+"			) AS ee ";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data PAS tidak ditemukan!'}");
		return;
	}

	data	="{ referensi	: "+ rs.getString("referensi")
			+", properti_sekolah : "+ rs.getString("properti_sekolah")
			+", perlengkapan_sekolah : "+ rs.getString("perlengkapan_sekolah")
			+", perlengkapan_kbm : "+ rs.getString("perlengkapan_kbm")
			+", ruangan : "+ rs.getString("ruangan")
			+", bualpen : "+ rs.getString("bualpen")
			+", pendukung_lism : "+ rs.getString("pendukung_lism")
			+", keuangan : "+ rs.getString("keuangan")
			+", bantuan : "+ rs.getString("bantuan")
			+", kepala_sekolah : "+ rs.getString("kepala_sekolah")
			+", guru : "+ rs.getString("guru")
			+", tenaga_administrasi : "+ rs.getString("tenaga_administrasi")
			+", siswa : "+ rs.getString("siswa")
			+", rombongan_belajar : "+ rs.getString("rombongan_belajar")
			+", penentuan_kelas : "+ rs.getString("penentuan_kelas");

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
