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

	int dml 						= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran			= (String) session.getAttribute("kd.tahun_pelajaran");
	String kd_tingkat_prestasi		= request.getParameter("kd_tingkat_prestasi");
	String kd_tingkat_prestasi_old	= request.getParameter("kd_tingkat_prestasi_old");
	String peringkat_sejenis		= request.getParameter("peringkat_sejenis");
	String peringkat_gabungan		= request.getParameter("peringkat_gabungan");
	String username					= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into t_sekolah_peringkat_uan (kd_tahun_ajaran, kd_tingkat_prestasi, peringkat_sejenis, peringkat_gabungan, username)"
			+" values ('"+ kd_tahun_ajaran +"', '"+ kd_tingkat_prestasi +"', "+ peringkat_sejenis +", "+ peringkat_gabungan +", '" + username +"')";
		break;
	case 3:
		q	=" update	t_sekolah_peringkat_uan"
			+" set		kd_tingkat_prestasi	= '"+ kd_tingkat_prestasi + "'"
			+" ,		peringkat_sejenis	=  "+ peringkat_sejenis
			+" ,		peringkat_gabungan	=  "+ peringkat_gabungan
			+" ,		username			= '"+ username +"'"
			+" where	kd_tahun_ajaran		= '"+ kd_tahun_ajaran + "'"
			+" and		kd_tingkat_prestasi	= '"+ kd_tingkat_prestasi_old + "'";
		break;
	case 4:
		q 	= " delete	from t_sekolah_peringkat_uan"
			+ " where	kd_tahun_ajaran		= '"+ kd_tahun_ajaran + "'"
			+ " and		kd_tingkat_prestasi	= '"+ kd_tingkat_prestasi + "'";
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
