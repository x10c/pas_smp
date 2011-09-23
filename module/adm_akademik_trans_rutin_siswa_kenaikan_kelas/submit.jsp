<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import = "java.sql.*" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int dml 					= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran		= request.getParameter("kd_tahun_ajaran");
	String kd_tingkat_kelas		= request.getParameter("kd_tingkat_kelas");
	String kd_rombel			= request.getParameter("kd_rombel");
	String username				= (String) session.getAttribute("user.id");
	String q					= "";
	String q2					= "";
	String q3					= "";

	switch (dml) {
	case 5:
		switch (kd_tingkat_kelas){
		case "01":
			q	=" insert into t_siswa_tingkat_thn(id_siswa, kd_tahun_ajaran, kd_tingkat_kelas, kd_status_siswa, username)"
				+" select	id_siswa, kd_tahun_ajaran + 1, '02', '0', 'ditpsmp'"
				+" from		t_siswa_tingkat"
				+" where	kd_tahun_ajaran		= '" + kd_tahun_ajaran + "'"
				+" and		kd_tingkat_kelas	= '01'"
				+" and		kd_rombel			= '" + kd_rombel + "'"
				+" and		kd_lulus			= '1'";
			
			break;
		case "02":
			q	=" insert into t_siswa_tingkat_thn(id_siswa, kd_tahun_ajaran, kd_tingkat_kelas, kd_status_siswa, username)"
				+" select	id_siswa, kd_tahun_ajaran + 1, '03', '0', 'ditpsmp'"
				+" from		t_siswa_tingkat"
				+" where	kd_tahun_ajaran		= '" + kd_tahun_ajaran + "'"
				+" and		kd_tingkat_kelas	= '02'"
				+" and		kd_rombel			= '" + kd_rombel + "'"
				+" and		kd_lulus			= '1'";

			break;
		case "03"
			q	=" insert into t_siswa_alumni(id_siswa, tahun_lulus, no_stl_lulus, username)"
				+" select	a.id_siswa, right(b.nm_tahun_ajaran,4), a.no_ijazah, 'ditpsmp'"
				+" from		t_siswa_tingkat	as a"
				+" ,		r_tahun_ajaran	as b"
				+" where	a.kd_tahun_ajaran	= b.kd_tahun_ajaran"
				+" and		a.kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'"
				+" and		a.kd_tingkat_kelas	= '03'"
				+" and		a.kd_rombel			= '" + kd_rombel + "'"
				+" and		a.kd_lulus			= '1'"
				+" and		a.id_siswa			not in (select id_siswa from t_siswa_alumni)";

			break;
		default:
			return;
		}
		
		q2	=" insert into t_siswa_tingkat_thn(id_siswa, kd_tahun_ajaran, kd_tingkat_kelas, kd_status_siswa, username)"
			+" select	a.id_siswa, a.kd_tahun_ajaran + 1, a.kd_tingkat_kelas, '1', 'ditpsmp'"
			+" from		t_siswa_tingkat	as a"
			+" ,		t_siswa			as b"
			+" where	a.id_siswa		= b.id_siswa"
			+" and		b.status_siswa		not in ('1','4','6')"
			+" and		a.kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'"
			+" and		a.kd_tingkat_kelas	= '" + kd_tingkat_kelas + "'"
			+" and		a.kd_rombel			= '" + kd_rombel + "'"
			+" and		a.kd_lulus			= '0'";
		
		q3	=" update	t_pegawai_rombel"
			+" set		status_naik_kelas	= '3'"
			+" where	kd_tahun_ajaran		= '" + kd_tahun_ajaran + "'"
			+" and		kd_tingkat_kelas	= '" + kd_tingkat_kelas + "'"
			+" and		kd_rombel			= '" + kd_rombel + "'";
		
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate(q);
	
	if (q2 != ""){
		db_stmt.executeUpdate(q2);
	}

	if (q3 != ""){
		db_stmt.executeUpdate(q3);
	}

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'", "\\'") +"'}");
}
%>
