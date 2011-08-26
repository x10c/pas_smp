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
	String kd_tahun_ajaran	= (String) session.getAttribute("kd.tahun_pelajaran");
	String kd_ketunaan		= request.getParameter("kd_ketunaan");
	String kd_ketunaan_old	= request.getParameter("kd_ketunaan_old");
	String username			= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into t_sekolah_tuna (kd_tahun_ajaran, kd_ketunaan, username)"
			+" values ('"+ kd_tahun_ajaran +"', '"+ kd_ketunaan +"', '"+ username +"')";
		break;
	case 3:
		q	=" update	t_sekolah_tuna"
			+" set		kd_ketunaan		= '"+ kd_ketunaan +"'"
			+" ,		username		= '"+ username +"'"
			+" where	kd_tahun_ajaran	= '"+ kd_tahun_ajaran + "'"
			+" and		kd_ketunaan		= '"+ kd_ketunaan_old + "'";
		break;
	case 4:
		q 	= " delete	from t_sekolah_tuna"
			+ " where	kd_tahun_ajaran	= '"+ kd_tahun_ajaran + "'"
			+ " and		kd_ketunaan		= '"+ kd_ketunaan + "'";
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
