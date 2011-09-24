<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import = "java.sql.*" %>
<%@ page import	= "java.util.Properties" %>
<%@ page import	= "java.io.FileInputStream" %>
<%@ page import	= "java.io.File" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int dml 						= Integer.parseInt(request.getParameter("dml_type"));
	String id_pegawai				= request.getParameter("id_pegawai");
	String kd_jenis_penghargaan		= request.getParameter("kd_jenis_penghargaan");
	String kd_jenis_penghargaan_old	= request.getParameter("kd_jenis_penghargaan_old");
	String tanggal_penghargaan		= request.getParameter("tanggal_penghargaan");
	String keterangan				= request.getParameter("keterangan");
	String username					= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	="  insert into t_pegawai_penghargaan"
			+"( id_pegawai"
			+", kd_jenis_penghargaan"
			+", tanggal_penghargaan"
			+", keterangan"
			+", username)"
			+"  values("
			+"   "+ id_pegawai
			+", '"+ kd_jenis_penghargaan + "'"
			+", cast('"+ tanggal_penghargaan +"' as date)"
			+", '"+ keterangan + "'"
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_pegawai_penghargaan"
			+" set		kd_jenis_penghargaan	= '"+ kd_jenis_penghargaan + "'"
			+" ,		tanggal_penghargaan		= cast('"+ tanggal_penghargaan +"' as date)"
			+" ,		keterangan				= '"+ keterangan +"'"
			+" ,		username				= '"+ username +"'"
			+" where	id_pegawai				=  "+ id_pegawai
			+" and		kd_jenis_penghargaan	= '"+ kd_jenis_penghargaan_old + "'";
		break;
	case 4:
		q 	= " delete	from t_pegawai_penghargaan"
			+" where	id_pegawai				=  "+ id_pegawai
			+" and		kd_jenis_penghargaan	= '"+ kd_jenis_penghargaan_old + "'";
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

	String		err_msg	= props.getProperty("" + e.getErrorCode() + "");
	
	if (err_msg == null){
		out.print("{success:false,info:'" + e.getErrorCode() + " = Kesalahan operasi, silahkan hubungi direktorat.'}");
	} else {
		out.print("{success:false,info:'" + e.getErrorCode() + " = " + err_msg + "'}");
	}
}
%>
