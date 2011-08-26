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

	int 	dml 				= Integer.parseInt(request.getParameter("dml_type"));
	String	nis					= request.getParameter("nis");
	String 	kd_tahun_ajaran		= request.getParameter("kd_tahun_ajaran");
	String 	kd_tingkat_kelas	= request.getParameter("kd_tingkat_kelas");
	String 	kd_rombel			= request.getParameter("kd_rombel");
	String 	kd_periode_belajar	= request.getParameter("kd_periode_belajar");
	String 	id_ahlak			= request.getParameter("id_ahlak");
	String 	id_pribadi			= request.getParameter("id_pribadi");
	String 	sakit				= request.getParameter("sakit");
	String 	ijin				= request.getParameter("ijin");
	String 	absen				= request.getParameter("absen");
	String 	catatan				= request.getParameter("catatan");
	String username				= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 3:
		q	=" update	t_nilai_rapor"
			+" set		id_ahlak			= "+ id_ahlak
			+" ,		id_pribadi			= "+ id_pribadi
			+" ,		sakit				= "+ sakit
			+" ,		ijin				= "+ ijin
			+" ,		absen				= "+ absen
			+" ,		catatan				= '"+ catatan +"'"
			+" ,		username			= '"+ username +"'"
			+" where	nis					= '"+ nis + "'"
			+" and		kd_tahun_ajaran		= '"+ kd_tahun_ajaran + "'"
			+" and		kd_tingkat_kelas	= '"+ kd_tingkat_kelas + "'"
			+" and		kd_rombel			= '"+ kd_rombel + "'"
			+" and		kd_periode_belajar	= '"+ kd_periode_belajar + "'";
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
