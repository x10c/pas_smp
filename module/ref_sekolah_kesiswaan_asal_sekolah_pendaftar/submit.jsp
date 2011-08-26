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
	String asal_sd				= request.getParameter("asal_sd");
	String id_propinsi			= request.getParameter("id_propinsi");
	String id_kabupaten			= request.getParameter("id_kabupaten");
	String nm_sekolah			= request.getParameter("nm_sekolah");
	String kd_jenis_sekolah		= request.getParameter("kd_jenis_sekolah");
	String kd_status_sekolah	= request.getParameter("kd_status_sekolah");
	String alamat_sekolah		= request.getParameter("alamat_sekolah");
	String no_telp				= request.getParameter("no_telp");
	String username				= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into r_asal_sekolah (id_propinsi, id_kabupaten, nm_sekolah, kd_jenis_sekolah, kd_status_sekolah, alamat_sekolah, no_telp, username)"
			+" values ("+ id_propinsi +", "+ id_kabupaten +", '" + nm_sekolah +"', '" + kd_jenis_sekolah +"', '"+ kd_status_sekolah +"', '"+ alamat_sekolah +"', '"+ no_telp +"', '"+ username +"')";
		break;
	case 3:
		q	=" update	r_asal_sekolah"
			+" set		id_propinsi			= "+ id_propinsi
			+" ,		id_kabupaten		= "+ id_kabupaten
			+" ,		nm_sekolah			= '"+ nm_sekolah +"'"
			+" ,		kd_jenis_sekolah	= '"+ kd_jenis_sekolah +"'"
			+" ,		kd_status_sekolah	= '"+ kd_status_sekolah +"'"
			+" ,		alamat_sekolah		= '"+ alamat_sekolah +"'"
			+" ,		no_telp				= '"+ no_telp +"'"
			+" ,		username			= '"+ username +"'"
			+" where	asal_sd				= "+ asal_sd;
		break;
	case 4:
		q = " delete from r_asal_sekolah where asal_sd = "+ asal_sd;
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
