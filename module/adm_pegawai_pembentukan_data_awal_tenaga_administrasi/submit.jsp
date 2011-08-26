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
	String nip					= request.getParameter("nip");
	String nip_baru				= request.getParameter("nip_baru");
	String nomor_induk			= request.getParameter("nomor_induk");
	String nuptk				= request.getParameter("nuptk");
	String nm_pegawai			= request.getParameter("nm_pegawai");
	String inisial				= request.getParameter("inisial");
	String kota_lahir			= request.getParameter("kota_lahir");
	String tanggal_lahir		= request.getParameter("tanggal_lahir");
	String kd_jenis_kelamin		= request.getParameter("kd_jenis_kelamin");
	String kd_agama				= request.getParameter("kd_agama");
	String alamat				= request.getParameter("alamat");
	String kd_pos				= request.getParameter("kd_pos");
	String kd_gol_darah			= request.getParameter("kd_gol_darah");
	String no_telp				= request.getParameter("no_telp");
	String no_hp				= request.getParameter("no_hp");
	String kd_status_nikah		= request.getParameter("kd_status_nikah");
	String kd_jenis_ketenagaan	= request.getParameter("kd_jenis_ketenagaan");
	String operasi_komputer		= request.getParameter("operasi_komputer");
	String kursus_komputer		= request.getParameter("kursus_komputer");
	String sertifikasi			= request.getParameter("sertifikasi");
	String dir_foto				= request.getParameter("dir_foto");
	String username				= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	="  insert into t_pegawai"
			+"( nip_baru"
			+", nomor_induk"
			+", nuptk"
			+", nm_pegawai"
			+", inisial"
			+", kota_lahir"
			+", tanggal_lahir"
			+", kd_jenis_kelamin"
			+", kd_agama"
			+", alamat"
			+", kd_pos"
			+", kd_gol_darah"
			+", no_telp"
			+", no_hp"
			+", kd_status_nikah"
			+", kd_jenis_ketenagaan"
			+", operasi_komputer"
			+", kursus_komputer"
			+", sertifikasi"
			+", dir_foto"
			+", username)"
			+"  values("
			+"  '"+ nip_baru + "'"
			+", '"+ nomor_induk + "'"
			+", '"+ nuptk + "'"
			+", '"+ nm_pegawai + "'"
			+", '"+ inisial + "'"
			+", '"+ kota_lahir + "'"
			+", cast('"+ tanggal_lahir +"' as date)"
			+", '"+ kd_jenis_kelamin + "'"
			+", '"+ kd_agama + "'"
			+", '"+ alamat + "'"
			+", '"+ kd_pos + "'"
			+", '"+ kd_gol_darah + "'"
			+", '"+ no_telp + "'"
			+", '"+ no_hp +"'"
			+", '"+ kd_status_nikah +"'"
			+", '"+ kd_jenis_ketenagaan +"'"
			+", '"+ operasi_komputer +"'"
			+", '"+ kursus_komputer +"'"
			+", '"+ sertifikasi +"'"
			+", '"+ dir_foto +"'"
			+", '" + username +"')";
		break;
	case 3:
		q	=" update	t_pegawai"
			+" set		nip_baru			= '"+ nip_baru +"'"
			+" ,		nuptk				= '"+ nuptk + "'"
			+" ,		nm_pegawai			= '"+ nm_pegawai + "'"
			+" ,		inisial				= '"+ inisial + "'"
			+" ,		kota_lahir			= '"+ kota_lahir + "'"
			+" ,		tanggal_lahir		= cast('"+ tanggal_lahir +"' as date)"
			+" ,		kd_jenis_kelamin	= '"+ kd_jenis_kelamin +"'"
			+" ,		kd_agama			= '"+ kd_agama +"'"
			+" ,		alamat				= '"+ alamat + "'"
			+" ,		kd_pos				= '"+ kd_pos + "'"
			+" ,		kd_gol_darah		= '"+ kd_gol_darah + "'"
			+" ,		no_telp				= '"+ no_telp +"'"
			+" ,		no_hp				= '"+ no_hp +"'"
			+" ,		kd_status_nikah		= '"+ kd_status_nikah +"'"
			+" ,		kd_jenis_ketenagaan	= '"+ kd_jenis_ketenagaan +"'"
			+" ,		operasi_komputer	= '"+ operasi_komputer +"'"
			+" ,		kursus_komputer		= '"+ kursus_komputer +"'"
			+" ,		sertifikasi			= '"+ sertifikasi +"'"
			+" ,		username			= '"+ username +"'"
			+" where	nip	= "+ nip;
		break;
	case 4:
		q 	= " delete	from t_pegawai"
			+ " where	nip	= "+ nip;
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
