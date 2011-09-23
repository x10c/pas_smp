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
	String kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");
	String username				= (String) session.getAttribute("user.id");
	String q					= "";
	String q2					= "";
	String q3					= "";

	int	i_tahun_ajaran		= Integer.parseInt(kd_tahun_ajaran) + 1;
	String s_tahun_ajaran	= i_tahun_ajaran + "";

	switch (dml) {
	case 5:
		q	=" delete	from t_siswa_tingkat_thn"
			+" where	kd_tahun_ajaran = '" + s_tahun_ajaran + "'";

		q2	=" delete	from t_siswa_alumni"
			+" where	id_siswa in (select id_siswa from t_siswa_tingkat where kd_tahun_ajaran = '" + kd_tahun_ajaran + "' and kd_tingkat_kelas = '03' and kd_lulus = '1')";

		q3	=" update	t_pegawai_rombel"
			+" set		status_naik_kelas	= '2'"
			+" where	kd_tahun_ajaran		= '" + kd_tahun_ajaran + "'"

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
		db_stmt.executeUpdate(q2);
	}

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'", "\\'") +"'}");
}
%>
