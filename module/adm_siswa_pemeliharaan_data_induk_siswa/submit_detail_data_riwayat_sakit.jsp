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

	int dml 			= Integer.parseInt(request.getParameter("dml_type"));
	String id_siswa		= request.getParameter("id_siswa");
	String no_urut		= request.getParameter("no_urut");
	String no_urut_old	= request.getParameter("no_urut_old");
	String id_penyakit	= request.getParameter("id_penyakit");
	String lama_sakit	= request.getParameter("lama_sakit");
	String keterangan	= request.getParameter("keterangan");
	String username		= (String) session.getAttribute("user.id");

	switch (dml) {
	case 2:
		q	="  insert into t_siswa_rwyt_sakit"
			+"( id_siswa"
			+", no_urut"
			+", id_penyakit"
			+", lama_sakit"
			+", keterangan"
			+", username)"
			+"  values("
			+"   "+ id_siswa
			+",  "+ no_urut
			+",  "+ id_penyakit
			+",  "+ lama_sakit
			+", '"+ keterangan + "'"
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_siswa_rwyt_sakit"
			+" set		no_urut		=  "+ no_urut
			+" ,		id_penyakit	=  "+ id_penyakit
			+" ,		lama_sakit	=  "+ lama_sakit
			+" ,		keterangan	= '"+ keterangan + "'"
			+" ,		username	= '"+ username +"'"
			+" where	id_siswa	=  "+ id_siswa
			+" and		no_urut		=  "+ no_urut_old;
		break;
	case 4:
		q 	= " delete	from t_siswa_rwyt_sakit"
			+" where	id_siswa	=  "+ id_siswa
			+" and		no_urut		=  "+ no_urut;
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (SQLException e){
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
