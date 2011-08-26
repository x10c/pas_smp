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
	String no_urut			= request.getParameter("no_urut");
	String no_urut_old		= request.getParameter("no_urut_old");
	String nm_rek			= request.getParameter("nm_rek");
	String no_rek_sekolah	= request.getParameter("no_rek_sekolah");
	String nm_bank			= request.getParameter("nm_bank");
	String cabang_bank		= request.getParameter("cabang_bank");
	String username			= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into t_sekolah_rekening (kd_tahun_ajaran, no_urut, nm_rek, no_rek_sekolah, nm_bank, cabang_bank, username)"
			+" values ('"+ kd_tahun_ajaran +"', "+ no_urut +", '"+ nm_rek +"', '"+ no_rek_sekolah +"', '"+ nm_bank +"', '"+ cabang_bank +"', '" + username +"')";
		break;
	case 3:
		q	=" update	t_sekolah_rekening"
			+" set		no_urut			=  "+ no_urut
			+" ,		nm_rek			= '"+ nm_rek +"'"
			+" ,		no_rek_sekolah	= '"+ no_rek_sekolah + "'"
			+" ,		nm_bank			= '"+ nm_bank + "'"
			+" ,		cabang_bank		= '"+ cabang_bank +"'"
			+" ,		username		= '"+ username +"'"
			+" where	kd_tahun_ajaran	= '"+ kd_tahun_ajaran + "'"
			+" and		no_urut			=  "+ no_urut_old;
		break;
	case 4:
		q 	= " delete	from t_sekolah_rekening"
			+ " where	kd_tahun_ajaran	= '"+ kd_tahun_ajaran + "'"
			+ " and		no_urut			=  "+ no_urut;
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
