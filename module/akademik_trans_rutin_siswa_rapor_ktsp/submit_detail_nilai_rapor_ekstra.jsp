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

	int 	dml 					= Integer.parseInt(request.getParameter("dml_type"));
	String	id_siswa				= request.getParameter("id_siswa");
	String	id_siswa_old			= request.getParameter("id_siswa_old");
	String 	kd_tahun_ajaran			= request.getParameter("kd_tahun_ajaran");
	String 	kd_tingkat_kelas		= request.getParameter("kd_tingkat_kelas");
	String 	kd_rombel				= request.getParameter("kd_rombel");
	String 	kd_periode_belajar		= request.getParameter("kd_periode_belajar");
	String 	id_ekstrakurikuler		= request.getParameter("id_ekstrakurikuler");
	String 	id_ekstrakurikuler_old	= request.getParameter("id_ekstrakurikuler_old");
	String 	nilai					= request.getParameter("nilai");
	String 	keterangan				= request.getParameter("keterangan");
	String 	username				= (String) session.getAttribute("user.id");
	String 	q;

	switch (dml) {
	case 2:
		q	="  insert into t_nilai_rapor_ekstra"
			+"( id_siswa"
			+", kd_tahun_ajaran"
			+", kd_tingkat_kelas"
			+", kd_rombel"
			+", kd_periode_belajar"
			+", id_ekstrakurikuler"
			+", nilai"
			+", keterangan"
			+", username)"
			+"  values("
			+"  '"+ nis + "'"
			+", '"+ kd_tahun_ajaran + "'"
			+", '"+ kd_tingkat_kelas + "'"
			+", '"+ kd_rombel + "'"
			+", '"+ kd_periode_belajar + "'"
			+",  "+ id_ekstrakurikuler
			+",  "+ nilai
			+", '"+ keterangan + "'"
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_nilai_rapor_ekstra"
			+" set		nis					= '"+ nis + "'"
			+" ,		id_ekstrakurikuler	=  "+ id_ekstrakurikuler
			+" ,		nilai				=  "+ nilai
			+" ,		keterangan			= '"+ keterangan +"'"
			+" ,		username			= '"+ username +"'"
			+" where	nis					= '"+ nis_old + "'"
			+" and		kd_tahun_ajaran		= '"+ kd_tahun_ajaran + "'"
			+" and		kd_tingkat_kelas	= '"+ kd_tingkat_kelas + "'"
			+" and		kd_rombel			= '"+ kd_rombel + "'"
			+" and		kd_periode_belajar	= '"+ kd_periode_belajar + "'"
			+" and		id_ekstrakurikuler	=  "+ id_ekstrakurikuler_old;
		break;
	case 4:
		q	= " delete	from t_nilai_rapor_ekstra"
			+ " where	nis					= '"+ nis + "'"
			+ " and		kd_tahun_ajaran		= '"+ kd_tahun_ajaran + "'"
			+ " and		kd_tingkat_kelas	= '"+ kd_tingkat_kelas + "'"
			+ " and		kd_rombel			= '"+ kd_rombel + "'"
			+ " and		kd_periode_belajar	= '"+ kd_periode_belajar + "'"
			+ " and		id_ekstrakurikuler	=  "+ id_ekstrakurikuler;
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
