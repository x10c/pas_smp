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

	int 	dml 						= Integer.parseInt(request.getParameter("dml_type"));
	String	nis							= request.getParameter("nis");
	String 	kd_tahun_ajaran				= request.getParameter("kd_tahun_ajaran");
	String 	kd_tingkat_kelas			= request.getParameter("kd_tingkat_kelas");
	String 	kd_rombel					= request.getParameter("kd_rombel");
	String 	kd_periode_belajar			= request.getParameter("kd_periode_belajar");
	String 	kd_kurikulum				= request.getParameter("kd_kurikulum");
	String 	kd_mata_pelajaran_diajarkan	= request.getParameter("kd_mata_pelajaran_diajarkan");
	String 	nilai						= request.getParameter("nilai");
	String 	keterangan					= request.getParameter("keterangan");
	String 	username					= (String) session.getAttribute("user.id");
	String 	q;

	switch (dml) {
	case 3:
		q	=" update	t_nilai_rapor_nilai"
			+" set		nilai		= "+ nilai
			+" ,		keterangan	= '"+ keterangan +"'"
			+" ,		username	= '"+ username +"'"
			+" where	nis							= '"+ nis + "'"
			+" and		kd_tahun_ajaran				= '"+ kd_tahun_ajaran + "'"
			+" and		kd_tingkat_kelas			= '"+ kd_tingkat_kelas + "'"
			+" and		kd_rombel					= '"+ kd_rombel + "'"
			+" and		kd_periode_belajar			= '"+ kd_periode_belajar + "'"
			+" and		kd_kurikulum				= '"+ kd_kurikulum + "'"
			+" and		kd_mata_pelajaran_diajarkan	= '"+ kd_mata_pelajaran_diajarkan + "'";
		break;
	case 4:
		q	= " delete	from t_nilai_rapor_nilai"
			+ " where	nis							= '"+ nis + "'"
			+ " and		kd_tahun_ajaran				= '"+ kd_tahun_ajaran + "'"
			+ " and		kd_tingkat_kelas			= '"+ kd_tingkat_kelas + "'"
			+ " and		kd_rombel					= '"+ kd_rombel + "'"
			+ " and		kd_periode_belajar			= '"+ kd_periode_belajar + "'"
			+ " and		kd_kurikulum				= '"+ kd_kurikulum + "'"
			+ " and		kd_mata_pelajaran_diajarkan	= '"+ kd_mata_pelajaran_diajarkan + "'";
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'", "\\'") +"'}");
}
%>
