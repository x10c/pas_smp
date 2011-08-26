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

	String 		nis		= request.getParameter("nis");
	
	ResultSet	rs;
	String		q;
	String		data;

	q=" select	*"
	 +" from	t_siswa_info "
	 +" where	nis	= '" + nis + "'";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Info Siswa tidak ditemukan!'}");
		return;
	}

	data	="{ nis	: '"+ rs.getString("nis") + "'"
			+", kewarganegaraan : '"+ rs.getString("kewarganegaraan") + "'"
			+", anak_ke : "+ rs.getString("anak_ke")
			+", jumlah_kandung : "+ rs.getString("jumlah_kandung")
			+", jumlah_tiri : "+ rs.getString("jumlah_tiri")
			+", jumlah_angkat : "+ rs.getString("jumlah_angkat")
			+", status_yatim_piatu : '"+ rs.getString("status_yatim_piatu") + "'"
			+", bahasa : '"+ rs.getString("bahasa") + "'"
			+", tinggal_di : '"+ rs.getString("tinggal_di") + "'"
			+", jarak_sek : "+ rs.getString("jarak_sek")
			+", kd_ketunaan : '"+ rs.getString("kd_ketunaan") + "'"
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
