<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String kd_tahun_ajaran	= request.getParameter("kd_tahun_ajaran");
	String kd_tingkat_kelas	= request.getParameter("kd_tingkat_kelas");
	String kd_rombel		= request.getParameter("kd_rombel");
	
	String q=" select	kd_tahun_ajaran"
			+" ,		kd_tingkat_kelas"
			+" ,		kd_rombel"
			+" ,		id_siswa"
			+" ,		id_siswa as id_siswa_old"
			+" ,		id_jenis_lomba"
			+" ,		id_jenis_lomba as id_jenis_lomba_old"
			+" ,		kd_tingkat_prestasi"
			+" ,		kd_tingkat_prestasi as kd_tingkat_prestasi_old"
			+" ,		tanggal_prestasi"
			+" ,		tanggal_prestasi as tanggal_prestasi_old"
			+" ,		juara_ke"
			+" ,		keterangan"
			+" from		t_siswa_prestasi"
			+" where	kd_tahun_ajaran		= '" + kd_tahun_ajaran + "'"
			+" and		kd_tingkat_kelas	= '" + kd_tingkat_kelas + "'"
			+" and		kd_rombel			= '" + kd_rombel + "'"
			+" order by	kd_tahun_ajaran, kd_tingkat_kelas, kd_rombel, id_siswa";
	
	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="['"+ rs.getString("kd_tahun_ajaran") + "'"
				+ ",'"+ rs.getString("kd_tingkat_kelas") +"'"
				+ ",'"+ rs.getString("kd_rombel") +"'"
				+ ","+ rs.getString("id_siswa")
				+ ","+ rs.getString("id_siswa_old")
				+ ","+ rs.getString("id_jenis_lomba")
				+ ","+ rs.getString("id_jenis_lomba_old")
				+ ",'"+ rs.getString("kd_tingkat_prestasi") + "'"
				+ ",'"+ rs.getString("kd_tingkat_prestasi_old") + "'"
				+ ",'"+ rs.getString("tanggal_prestasi") + "'"
				+ ",'"+ rs.getString("tanggal_prestasi_old") + "'"
				+ ","+ rs.getString("juara_ke")
				+ ",\""+ rs.getString("keterangan") +"\""
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
