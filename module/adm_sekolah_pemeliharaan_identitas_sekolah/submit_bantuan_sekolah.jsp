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
	String kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");
	String kd_bantuan			= request.getParameter("kd_bantuan");
	String kd_bantuan_old		= request.getParameter("kd_bantuan_old");
	String tahun_bantuan		= request.getParameter("tahun_bantuan");
	String sumber_bantuan		= request.getParameter("sumber_bantuan");
	String sumber_bantuan_old	= request.getParameter("sumber_bantuan_old");
	String jumlah_dana			= request.getParameter("jumlah_dana");
	String dana_pendamping		= request.getParameter("dana_pendamping");
	String peruntukan_dana		= request.getParameter("peruntukan_dana");
	String username				= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	=" insert into t_sekolah_bantuan (kd_tahun_ajaran, kd_bantuan, tahun_bantuan, sumber_bantuan, jumlah_dana, dana_pendamping, peruntukan_dana, username)"
			+" values ('"+ kd_tahun_ajaran +"', '"+ kd_bantuan +"', 1, '"+ sumber_bantuan +"', "+ jumlah_dana +", "+ dana_pendamping +", '"+ peruntukan_dana +"', '" + username +"')";
		break;
	case 3:
		q	=" update	t_sekolah_bantuan"
			+" set		kd_bantuan		= '"+ kd_bantuan +"'"
			+" ,		sumber_bantuan	= '"+ sumber_bantuan +"'"
			+" ,		jumlah_dana		=  "+ jumlah_dana
			+" ,		dana_pendamping	=  "+ dana_pendamping
			+" ,		peruntukan_dana	= '"+ peruntukan_dana +"'"
			+" ,		username		= '"+ username +"'"
			+" where	kd_tahun_ajaran	= '"+ kd_tahun_ajaran + "'"
			+" and		kd_bantuan		= '"+ kd_bantuan_old + "'"
			+" and		tahun_bantuan	=  "+ tahun_bantuan
			+" and		sumber_bantuan	= '"+ sumber_bantuan + "'";
		break;
	case 4:
		q 	= " delete	from t_sekolah_bantuan"
			+ " where	kd_tahun_ajaran	= '"+ kd_tahun_ajaran + "'"
			+ " and		kd_bantuan		= '"+ kd_bantuan_old + "'"
			+ " and		tahun_bantuan	=  "+ tahun_bantuan
			+ " and		sumber_bantuan	= '"+ sumber_bantuan + "'";
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
