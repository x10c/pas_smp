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

	int dml 						= Integer.parseInt(request.getParameter("dml_type"));
	String nip						= request.getParameter("nip");
	String kd_jenis_penghargaan		= request.getParameter("kd_jenis_penghargaan");
	String kd_jenis_penghargaan_old	= request.getParameter("kd_jenis_penghargaan_old");
	String tanggal_penghargaan		= request.getParameter("tanggal_penghargaan");
	String keterangan				= request.getParameter("keterangan");
	String username					= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	="  insert into t_pegawai_penghargaan"
			+"( nip"
			+", kd_jenis_penghargaan"
			+", tanggal_penghargaan"
			+", keterangan"
			+", username)"
			+"  values("
			+"   "+ nip
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
			+" where	nip						=  "+ nip
			+" and		kd_jenis_penghargaan	= '"+ kd_jenis_penghargaan_old + "'";
		break;
	case 4:
		q 	= " delete	from t_pegawai_penghargaan"
			+" where	nip						=  "+ nip
			+" and		kd_jenis_penghargaan	= '"+ kd_jenis_penghargaan_old + "'";
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