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

	int dml 				= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran	= request.getParameter("kd_tahun_ajaran");
	String kd_tingkat_kelas	= request.getParameter("kd_tingkat_kelas");
	String kd_kurikulum		= request.getParameter("kd_kurikulum");
	String username			= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 3:
		q	=" update	t_sekolah_jurusan"
			+" set		kd_kurikulum	= '"+ kd_kurikulum +"'"
			+" ,		username		= '"+ username +"'"
			+" where	kd_tahun_ajaran		= '"+ kd_tahun_ajaran + "'"
			+" and		kd_tingkat_kelas	= '"+ kd_tingkat_kelas + "'";
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
