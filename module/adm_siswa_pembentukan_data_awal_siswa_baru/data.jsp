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
	
	String 		nis		= request.getParameter("nis");

	ResultSet	rs;
	String		q;
	String		data;

	q=" select	*"
	 +" from	t_siswa"
	 +" where	nis	= '" + nis + "'";
	
	rs	= db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Siswa tidak ditemukan!'}");
		return;
	}
	
	data 	="{ nis : '"+ rs.getString("nis") + "'"
			+ ", no_calsis : '"+ rs.getString("no_calsis") + "'"
			+ ", nm_siswa : '"+ rs.getString("nm_siswa") + "'"
			+ ", nm_panggilan : '"+ rs.getString("nm_panggilan") + "'"
			+ ", kd_jenis_kelamin : '"+ rs.getString("kd_jenis_kelamin") + "'"
			+ ", kota_lahir : '"+ rs.getString("kota_lahir") + "'"
			+ ", tanggal_lahir : '"+ rs.getString("tanggal_lahir") + "'"
			+ ", alamat : '"+ rs.getString("alamat") + "'"
			+ ", rt : '"+ rs.getString("rt") + "'"
			+ ", rw : '"+ rs.getString("rw") + "'"
			+ ", kd_pos : '"+ rs.getString("kd_pos") + "'"
			+ ", kd_gol_darah : '"+ rs.getString("kd_gol_darah") + "'"
			+ ", kd_agama : '"+ rs.getString("kd_agama") + "'"
			+ ", no_telp : '"+ rs.getString("no_telp") + "'"
			+ ", no_hp : '"+ rs.getString("no_hp") + "'"
			+ ", status_siswa : '"+ rs.getString("status_siswa") + "'"
			+ ", kewarganegaraan : '"+ rs.getString("kewarganegaraan") + "'"
			+ ", anak_ke : "+ rs.getString("anak_ke")
			+ ", jumlah_kandung : "+ rs.getString("jumlah_kandung")
			+ ", jumlah_tiri : "+ rs.getString("jumlah_tiri")
			+ ", jumlah_angkat : "+ rs.getString("jumlah_angkat")
			+ ", status_yatim_piatu : '"+ rs.getString("status_yatim_piatu") + "'"
			+ ", bahasa : '"+ rs.getString("bahasa") + "'"
			+ ", tinggal_di : '"+ rs.getString("tinggal_di") + "'"
			+ ", jarak_sek : "+ rs.getString("jarak_sek")
			+ ", kelainan_jasmani : '"+ rs.getString("kelainan_jasmani") + "'"
			+ ", berat_badan : "+ rs.getString("berat_badan")
			+ ", tinggi_badan : "+ rs.getString("tinggi_badan")
			+ ", asal_sd : "+ rs.getString("asal_sd")
			+ ", no_stl_sd : '"+ rs.getString("no_stl_sd") + "'"
			+ ", tanggal_stl_sd : '"+ rs.getString("tanggal_stl_sd") + "'"
			+ ", lama_belajar_sd : "+ rs.getString("lama_belajar_sd")
			+ ", asal_smp : "+ rs.getString("asal_smp")
			+ ", kd_tingkat_kelas : '"+ rs.getString("kd_tingkat_kelas") + "'"
			+ ", diterima_tanggal : '"+ rs.getString("diterima_tanggal") + "'"
			+ ", pindah_alasan : '"+ rs.getString("pindah_alasan") + "'"
			+ ", hubungi : '"+ rs.getString("hubungi") + "'"
			+ ", tanggung_biaya : "+ rs.getString("tanggung_biaya")
			+ ", temp_akses_net : '"+ rs.getString("temp_akses_net") + "'"
			+ ", frek_akses_net : '"+ rs.getString("frek_akses_net") + "'"
			+ ", frek_rekre_kel : '"+ rs.getString("frek_rekre_kel") + "'"
			+ ", nilai : "+ rs.getString("nilai")
			+ ", no_induk : '"+ rs.getString("no_induk") + "'"
			+ ", dir_foto : '"+ rs.getString("dir_foto") + "'"
			+ ", status_entri : '"+ rs.getString("status_entri") + "'"
			+ ", username : '"+ rs.getString("username") + "'"
			+ ", tanggal_akses : '"+ rs.getString("tanggal_akses") + "'"
			+ ", kd_kesejahteraan_keluarga : '"+ rs.getString("kd_kesejahteraan_keluarga") + "'"
			+ ", nisn : '"+ rs.getString("nisn") +"'}";
	
	rs.close();
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
