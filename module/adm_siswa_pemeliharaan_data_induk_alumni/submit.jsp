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
	String nis				= request.getParameter("nis");
	String lanjut_di		= request.getParameter("lanjut_di");
	String tanggal_bekerja	= request.getParameter("tanggal_bekerja");
	String nm_perusahaan	= request.getParameter("nm_perusahaan");
	String username			= (String) session.getAttribute("user.id");
	String q;

	if (tanggal_bekerja.equals("")){
		tanggal_bekerja = "null";
	} else {
		tanggal_bekerja = "cast('" + tanggal_bekerja + "' as date)";
	}

	switch (dml) {
	case 3:
		q	=" update	t_siswa_alumni"
			+" set		lanjut_di		= '"+ lanjut_di +"'"
			+" ,		tanggal_bekerja	=  "+ tanggal_bekerja
			+" ,		nm_perusahaan	= '"+ nm_perusahaan +"'"
			+" ,		username		= '"+ username +"'"
			+" where	nis				= '"+ nis + "'";
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
