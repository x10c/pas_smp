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
	String kd_rombel		= request.getParameter("kd_rombel");
	String kd_rombel_old	= request.getParameter("kd_rombel_old");
	String id_ruang_kelas	= request.getParameter("id_ruang_kelas");
	String nip				= request.getParameter("nip");
	String nip_bk			= request.getParameter("nip_bk");
	String keterangan		= request.getParameter("keterangan");
	String username			= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into t_pegawai_rombel (kd_tahun_ajaran, kd_tingkat_kelas, kd_rombel, id_ruang_kelas, nip, nip_bk, keterangan, username)"
			+" values ('"+ kd_tahun_ajaran +"', '"+ kd_tingkat_kelas +"', '"+ kd_rombel +"', "+ id_ruang_kelas +", "+ nip +", "+ nip_bk +", '"+ keterangan +"', '" + username +"')";
		break;
	case 3:
		q	=" update	t_pegawai_rombel"
			+" set		kd_rombel		= '"+ kd_rombel +"'"
			+" ,		id_ruang_kelas	= "+ id_ruang_kelas
			+" ,		nip				= "+ nip
			+" ,		nip_bk			= "+ nip_bk
			+" ,		keterangan		= '"+ keterangan + "'"
			+" ,		username		= '"+ username +"'"
			+" where	kd_tahun_ajaran		= '"+ kd_tahun_ajaran +"'"
			+" and		kd_tingkat_kelas	= '"+ kd_tingkat_kelas +"'"
			+" and		kd_rombel			= '"+ kd_rombel_old +"'";
		break;
	case 4:
		q	= " delete	from t_pegawai_rombel"
			+ " where	kd_tahun_ajaran 	= '"+ kd_tahun_ajaran + "'"
			+ " and		kd_tingkat_kelas 	= '"+ kd_tingkat_kelas + "'"
			+ " and 	kd_rombel 			= '"+ kd_rombel + "'";
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
