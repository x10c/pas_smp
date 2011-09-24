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

	Statement	db_stmt 	= db_con.createStatement();

	String 		id_siswa	= request.getParameter("id_siswa");
	
	ResultSet	rs;
	String		q;
	String		data;

	q=" select	*"
	 +" from	t_siswa_info "
	 +" where	id_siswa	= " + id_siswa;

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Info Siswa tidak ditemukan!'}");
		return;
	}

	data	="{ id_siswa : "+ rs.getString("id_siswa")
			+", nis : '"+ rs.getString("nis") + "'"
			+", hubungi : '"+ rs.getString("hubungi") + "'"
			+", tanggung_biaya : "+ rs.getString("tanggung_biaya")
			+", status_yatim_piatu : '"+ rs.getString("status_yatim_piatu") + "'"
			+", kd_kesejahteraan_keluarga : '"+ rs.getString("kd_kesejahteraan_keluarga") + "'"
			+", anak_ke : "+ rs.getString("anak_ke")
			+", jumlah_kandung : "+ rs.getString("jumlah_kandung")
			+", jumlah_tiri : "+ rs.getString("jumlah_tiri")
			+", jumlah_angkat : "+ rs.getString("jumlah_angkat")
			+", kewarganegaraan : '"+ rs.getString("kewarganegaraan") + "'"			
			+", bahasa : '"+ rs.getString("bahasa") + "'"
			+", tinggal_di : '"+ rs.getString("tinggal_di") + "'"
			+", jarak_sek : "+ rs.getString("jarak_sek")
			+", kd_ketunaan : '"+ rs.getString("kd_ketunaan") + "'"
			+", kelainan_jasmani : '"+ rs.getString("kd_ketunaan") + "'"
			+", berat_badan : "+ rs.getString("berat_badan")
			+", tinggi_badan : "+ rs.getString("tinggi_badan")
			+", no_stl_sd : '"+ rs.getString("no_stl_sd") + "'"
			+", tanggal_stl_sd : '"+ rs.getString("tanggal_stl_sd") + "'"
			+", lama_belajar_sd : "+ rs.getString("lama_belajar_sd");

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
