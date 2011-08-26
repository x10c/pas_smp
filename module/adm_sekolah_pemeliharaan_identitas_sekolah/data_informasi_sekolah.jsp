<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String 		kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");
	
	ResultSet	rs;
	String		q;
	String		data;

	q=" select	kd_tahun_ajaran"
	+" ,		ifnull(email, '') as email"
	+" ,		ifnull(website, '') as website"
	+" ,		tahun_operasi"
	+" ,		tahun_dibuka"
	+" ,		tahun_akhir_renov"
	+" ,		keliling_tanah"
	+" ,		dipagar_permanen"
	+" ,		luas_siap_bangun"
	+" ,		luas_atas_siap_bangun"
	+" ,		bujur"
	+" ,		lintang"
	+" from		t_sekolah_info "
	+" where	kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Informasi Sekolah tidak ditemukan!'}");
		return;
	}

	data	="{ kd_tahun_ajaran	: '"+ rs.getString("kd_tahun_ajaran") + "'"
			+", email : '"+ rs.getString("email") + "'"
			+", website : '"+ rs.getString("website") + "'"
			+", tahun_operasi : "+ rs.getString("tahun_operasi")
			+", tahun_dibuka : "+ rs.getString("tahun_dibuka")
			+", tahun_akhir_renov : "+ rs.getString("tahun_akhir_renov")
			+", keliling_tanah : "+ rs.getString("keliling_tanah")
			+", dipagar_permanen : "+ rs.getString("dipagar_permanen")
			+", luas_siap_bangun : "+ rs.getString("luas_siap_bangun")
			+", luas_atas_siap_bangun : "+ rs.getString("luas_atas_siap_bangun")
			+", bujur : "+ rs.getString("bujur")
			+", lintang : "+ rs.getString("lintang");

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
