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
String q = "";
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int dml 				= Integer.parseInt(request.getParameter("dml_type"));
	String id_siswa			= request.getParameter("id_siswa");
	String asal_smp			= request.getParameter("asal_smp");
	String pindah_alasan	= request.getParameter("pindah_alasan");
	String username			= (String) session.getAttribute("user.id");

	switch (dml) {
	case 2:
		q	="  insert into t_siswa_pindah"
			+"( id_siswa"
			+", asal_smp"
			+", pindah_alasan"
			+", username)"
			+"  values ("
			+"   "+ id_siswa
			+",  "+ asal_smp
			+", '"+ pindah_alasan + "'"
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_siswa_pindah"
			+" set		asal_smp		= "+ asal_smp
			+" ,		pindah_alasan	= '"+ pindah_alasan + "'"
			+" ,		username		= '"+ username +"'"
			+" where	id_siswa		=  "+ id_siswa;
		break;
	case 4:
		q	= " delete	from t_siswa_pindah"
			+ " where	id_siswa = "+ id_siswa;
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
