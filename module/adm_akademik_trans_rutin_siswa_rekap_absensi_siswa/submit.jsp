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
	String kd_periode_belajar	= (String) session.getAttribute("kd.periode_belajar");
	String tanggal_rapor		= request.getParameter("tanggal_rapor");
	String username				= (String) session.getAttribute("user.id");
	String q					= "";
	String q2					= "";

	switch (dml) {
	case 5:
		q	=" update	t_pegawai_rombel"
			+" set		status_naik_kelas	= '" + kd_periode_belajar + "'"
			+" ,		username			= 'ditpsmp'";
		if (kd_periode_belajar.equals("1")){
			q	+=",	tanggal_semester_1	= cast('"+ tanggal_rapor +"' as date)"
		} else {
			q	+=",	tanggal_semester_2	= cast('"+ tanggal_rapor +"' as date)"
		}
			+" where	kd_tahun_ajaran		= '" + kd_tahun_ajaran + "'";

		q2	=" update	t_nilai_rapor"
			+" set		tanggal_diberikan	= cast('"+ tanggal_rapor +"' as date)"
			+" where	kd_tahun_ajaran		= '"+ kd_tahun_ajaran + "'"
			+" and		kd_periode_belajar	= '"+ kd_periode_belajar + "'";
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate(q);
	
	if (q2 != ""){
		db_stmt.executeUpdate(q2);
	}

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'", "\\'") +"'}");
}
%>
