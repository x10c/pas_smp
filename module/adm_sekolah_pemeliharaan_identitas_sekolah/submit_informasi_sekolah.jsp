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

	int dml 						= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran			= (String) session.getAttribute("kd.tahun_pelajaran");
	String email					= request.getParameter("email");
	String website					= request.getParameter("website");
	String tahun_operasi			= request.getParameter("tahun_operasi");
	String tahun_dibuka				= request.getParameter("tahun_dibuka");
	String tahun_akhir_renov		= request.getParameter("tahun_akhir_renov");
	String keliling_tanah			= request.getParameter("keliling_tanah");
	String dipagar_permanen			= request.getParameter("dipagar_permanen");
	String luas_siap_bangun			= request.getParameter("luas_siap_bangun");
	String luas_atas_siap_bangun	= request.getParameter("luas_atas_siap_bangun");
	String bujur					= request.getParameter("bujur");
	String lintang					= request.getParameter("lintang");
	String username					= (String) session.getAttribute("user.id");

	if (tahun_operasi.equals("")){
		tahun_operasi = null;
	}

	if (tahun_dibuka.equals("")){
		tahun_dibuka = null;
	}

	if (tahun_akhir_renov.equals("")){
		tahun_akhir_renov = null;
	}

	if (keliling_tanah.equals("")){
		keliling_tanah = null;
	}

	if (dipagar_permanen.equals("")){
		dipagar_permanen = null;
	}

	if (luas_siap_bangun.equals("")){
		luas_siap_bangun = null;
	}

	if (luas_atas_siap_bangun.equals("")){
		luas_atas_siap_bangun = null;
	}

	if (bujur.equals("")){
		bujur = null;
	}

	if (lintang.equals("")){
		lintang = null;
	}
	
	switch (dml) {
	case 2:
		q	=" insert into t_sekolah_info"
			+" (kd_tahun_ajaran"
			+", email"
			+", website"
			+", tahun_operasi"
			+", tahun_dibuka"
			+", tahun_akhir_renov"
			+", keliling_tanah"
			+", dipagar_permanen"
			+", luas_siap_bangun"
			+", luas_atas_siap_bangun"
			+", bujur"
			+", lintang"
			+", username)"
			+"  values ("
			+"'"+ kd_tahun_ajaran +"'"
			+", '"+ email +"'"
			+", '"+ website +"'"
			+", "+ tahun_operasi
			+", "+ tahun_dibuka
			+", "+ tahun_akhir_renov
			+", "+ keliling_tanah
			+", "+ dipagar_permanen
			+", "+ luas_siap_bangun
			+", "+ luas_atas_siap_bangun
			+", "+ bujur
			+", "+ lintang
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_sekolah_info"
			+" set		email					= '"+ email +"'"
			+" ,		website					= '"+ website +"'"
			+" ,		tahun_operasi			= "+ tahun_operasi
			+" ,		tahun_dibuka			= "+ tahun_dibuka
			+" ,		tahun_akhir_renov		= "+ tahun_akhir_renov
			+" ,		keliling_tanah			= "+ keliling_tanah
			+" ,		dipagar_permanen		= "+ dipagar_permanen
			+" ,		luas_siap_bangun		= "+ luas_siap_bangun
			+" ,		luas_atas_siap_bangun	= "+ luas_atas_siap_bangun
			+" ,		bujur					= "+ bujur
			+" ,		lintang					= "+ lintang
			+" ,		username				= '"+ username +"'"
			+" where	kd_tahun_ajaran			= '"+ kd_tahun_ajaran +"'";
		break;
	case 4:
		q	= " delete	from t_sekolah_info"
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
