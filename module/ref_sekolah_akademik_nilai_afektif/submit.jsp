<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.Properties" %>
<%@ page import = "java.io.FileInputStream" %>
<%@ page import = "java.io.File" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int dml 				= Integer.parseInt(request.getParameter("dml_type"));
	String id_nilai_afektif	= request.getParameter("id_nilai_afektif");
	String nm_nilai_afektif	= request.getParameter("nm_nilai_afektif");
	String keterangan		= request.getParameter("keterangan");
	String username			= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into r_nilai_afektif (nm_nilai_afektif, keterangan, username)"
			+" values ('"+ nm_nilai_afektif +"', '" + keterangan +"', '"+ username +"')";
		break;
	case 3:
		q	=" update	r_nilai_afektif"
			+" set		nm_nilai_afektif	= '"+ nm_nilai_afektif +"'"
			+" ,		keterangan			= '"+ keterangan +"'"
			+" ,		username			= '"+ username +"'"
			+" where	id_nilai_afektif	= "+ id_nilai_afektif;
		break;
	case 4:
		q = " delete from r_nilai_afektif where id_nilai_afektif = "+ id_nilai_afektif;
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e){
	Properties	props	= new Properties();
	
	props.load(new FileInputStream(application.getRealPath("WEB-INF"+File.separator+"error.properties")));
	
	String		err_msg = props.getProperty("" + e.getErrorCode() + "");
	
	if (err_msg == null){
		out.print("{success:false,info:'" + e.getErrorCode() + " = Kesalahan operasi, silahkan hubungi direktorat.'}");
	} else {
		out.print("{success:false,info:'" + e.getErrorCode() + " = " + err_msg + "'}");
	}
}
%>
