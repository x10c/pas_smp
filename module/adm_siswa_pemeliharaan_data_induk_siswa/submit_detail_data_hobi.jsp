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

	int dml 			= Integer.parseInt(request.getParameter("dml_type"));
	String id_siswa		= request.getParameter("id_siswa");
	String id_hobi		= request.getParameter("id_hobi");
	String id_hobi_old	= request.getParameter("id_hobi_old");
	String keterangan	= request.getParameter("keterangan");
	String username		= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	="  insert into t_siswa_hobi"
			+"( id_siswa"
			+", id_hobi"
			+", keterangan"
			+", username)"
			+"  values("
			+"   "+ id_siswa
			+",  "+ id_hobi
			+", '"+ keterangan + "'"
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_siswa_hobi"
			+" set		id_hobi		=  "+ id_hobi
			+" ,		keterangan	= '"+ keterangan + "'"
			+" ,		username	= '"+ username +"'"
			+" where	id_siswa	=  "+ id_siswa
			+" and		id_hobi		=  "+ id_hobi_old;
		break;
	case 4:
		q 	= " delete	from t_siswa_hobi"
			+" where	id_siswa	=  "+ id_siswa
			+" and		id_hobi		=  "+ id_hobi;
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
