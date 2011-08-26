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
	String kd_tahun_ajaran	= (String) session.getAttribute("kd.tahun_pelajaran");
	String rata_un			= request.getParameter("rata_un");
	String renc_term		= request.getParameter("renc_term");
	String jml_daft_l		= request.getParameter("jml_daft_l");
	String jml_daft_p		= request.getParameter("jml_daft_p");
	String username			= (String) session.getAttribute("user.id");

	switch (dml) {
	case 2:
		q	=" insert into k_sekolah_passing_grade"
			+" (kd_tahun_ajaran"
			+", rata_un"
			+", renc_term"
			+", jml_daft_l"
			+", jml_daft_p"
			+", username)"
			+"  values ("
			+" '"+ kd_tahun_ajaran +"'"
			+", "+ rata_un
			+", "+ renc_term
			+", "+ jml_daft_l
			+", "+ jml_daft_p
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	k_sekolah_passing_grade"
			+" set		rata_un			= "+ rata_un
			+" ,		renc_term		= "+ renc_term
			+" ,		jml_daft_l		= "+ jml_daft_l
			+" ,		jml_daft_p		= "+ jml_daft_p
			+" ,		username		= '"+ username +"'"
			+" where	kd_tahun_ajaran	= '"+ kd_tahun_ajaran +"'";
		break;
	case 4:
		q	= " delete	from k_sekolah_passing_grade"
			+ " where	kd_tahun_ajaran = '"+ kd_tahun_ajaran + "'";
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
