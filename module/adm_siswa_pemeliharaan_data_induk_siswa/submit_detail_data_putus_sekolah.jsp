<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import = "java.sql.*" %>
<%
String q = "";
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int dml 				= Integer.parseInt(request.getParameter("dml_type"));
	String id_siswa				= request.getParameter("id_siswa");
	String tanggal_keluar	= request.getParameter("tanggal_keluar");
	String alasan_keluar	= request.getParameter("alasan_keluar");
	String username			= (String) session.getAttribute("user.id");

	switch (dml) {
	case 2:
		q	="  insert into t_siswa_putus"
			+"( id_siswa"
			+", tanggal_keluar"
			+", alasan_keluar"
			+", username)"
			+"  values ("
			+"  '"+ id_siswa +"'"
			+", cast('"+ tanggal_keluar +"' as date)"
			+", '"+ alasan_keluar + "'"
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_siswa_putus"
			+" set		tanggal_keluar	= cast('"+ tanggal_keluar +"' as date)"
			+" ,		alasan_keluar	= '"+ alasan_keluar + "'"
			+" ,		username		= '"+ username +"'"
			+" where	id_siswa				= '"+ id_siswa +"'";
		break;
	case 4:
		q	= " delete	from t_siswa_putus"
			+ " where	id_siswa 			= '"+ id_siswa + "'";
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
