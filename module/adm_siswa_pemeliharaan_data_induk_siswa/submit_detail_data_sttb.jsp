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

	int dml 					= Integer.parseInt(request.getParameter("dml_type"));
	String id_siswa					= request.getParameter("id_siswa");
	String kd_matpel_before		= request.getParameter("kd_matpel_before");
	String kd_matpel_before_old	= request.getParameter("kd_matpel_before_old");
	String nilai				= request.getParameter("nilai");
	String username				= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	="  insert into t_siswa_sttb_before"
			+"( id_siswa"
			+", kd_matpel_before"
			+", nilai"
			+", username)"
			+"  values("
			+"  '"+ id_siswa + "'"
			+", '"+ kd_matpel_before + "'"
			+",  "+ nilai
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_siswa_sttb_before"
			+" set		kd_matpel_before	= '"+ kd_matpel_before + "'"
			+" ,		nilai				=  "+ nilai
			+" ,		username			= '"+ username +"'"
			+" where	id_siswa					= '"+ id_siswa + "'"
			+" and		kd_matpel_before	= '"+ kd_matpel_before_old + "'";
		break;
	case 4:
		q 	= " delete	from t_siswa_sttb_before"
			+" where	id_siswa					= '"+ id_siswa + "'"
			+" and		kd_matpel_before	= '"+ kd_matpel_before + "'";
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
