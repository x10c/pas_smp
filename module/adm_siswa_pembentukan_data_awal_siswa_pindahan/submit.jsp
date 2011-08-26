<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.DateFormat" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int dml 							= Integer.parseInt(request.getParameter("dml_type"));
	String nis							= request.getParameter("nis");
	String no_induk						= request.getParameter("no_induk");
	String nisn							= request.getParameter("nisn");
	String nm_siswa						= request.getParameter("nm_siswa");
	String nm_panggilan					= request.getParameter("nm_panggilan");
	String kota_lahir					= request.getParameter("kota_lahir");
	String tanggal_lahir				= request.getParameter("tanggal_lahir");
	String kd_jenis_kelamin				= request.getParameter("kd_jenis_kelamin");
	String kd_agama						= request.getParameter("kd_agama");
	String hubungi						= request.getParameter("hubungi");
	String tanggung_biaya				= request.getParameter("tanggung_biaya");
	String kd_kesejahteraan_keluarga	= request.getParameter("kd_kesejahteraan_keluarga");
	String alamat						= request.getParameter("alamat");
	String rt							= request.getParameter("rt");
	String rw							= request.getParameter("rw");
	String kd_pos						= request.getParameter("kd_pos");
	String no_telp						= request.getParameter("no_telp");
	String no_hp						= request.getParameter("no_hp");
	String kd_gol_darah					= request.getParameter("kd_gol_darah");
	String kelainan_jasmani				= request.getParameter("kelainan_jasmani");
	String asal_smp						= request.getParameter("asal_smp");
	String pindah_alasan				= request.getParameter("pindah_alasan");
	String kd_tingkat_kelas				= request.getParameter("kd_tingkat_kelas");
	String diterima_tanggal				= request.getParameter("diterima_tanggal");
	String dir_foto						= request.getParameter("dir_foto");
	String username						= (String) session.getAttribute("user.id");
	String q;
	
	DateFormat df 						= new SimpleDateFormat ("yyMMddhhmmss");
	String formattedDate 				= df.format(new Date());

	switch (dml) {
	case 2:
		nis	= formattedDate;
		
		q	="  insert into t_siswa"
			+"( nis"
			+", no_induk"
			+", nisn"
			+", nm_siswa"
			+", nm_panggilan"
			+", kota_lahir"
			+", tanggal_lahir"
			+", kd_jenis_kelamin"
			+", kd_agama"
			+", hubungi"
			+", tanggung_biaya"
			+", kd_kesejahteraan_keluarga"
			+", alamat"
			+", rt"
			+", rw"
			+", kd_pos"
			+", no_telp"
			+", no_hp"
			+", kd_gol_darah"
			+", kelainan_jasmani"
			+", asal_smp"
			+", pindah_alasan"
			+", kd_tingkat_kelas"
			+", diterima_tanggal"
			+", dir_foto"
			+", status_entri"
			+", status_siswa"
			+", username)"
			+"  values("
			+"  '"+ nis + "'"
			+", '"+ no_induk + "'"
			+", '"+ nisn + "'"
			+", '"+ nm_siswa + "'"
			+", '"+ nm_panggilan + "'"
			+", '"+ kota_lahir + "'"
			+", cast('"+ tanggal_lahir +"' as date)"
			+", '"+ kd_jenis_kelamin + "'"
			+", '"+ kd_agama + "'"
			+", '"+ hubungi + "'"
			+",  "+ tanggung_biaya
			+", '"+ kd_kesejahteraan_keluarga + "'"
			+", '"+ alamat + "'"
			+", '"+ rt + "'"
			+", '"+ rw + "'"
			+", '"+ kd_pos + "'"
			+", '"+ no_telp + "'"
			+", '"+ no_hp +"'"
			+", '"+ kd_gol_darah + "'"
			+", '"+ kelainan_jasmani +"'"
			+",  "+ asal_smp
			+", '"+ pindah_alasan +"'"
			+", '"+ kd_tingkat_kelas +"'"
			+", cast('"+ diterima_tanggal +"' as date)"
			+", '"+ dir_foto +"'"
			+", '0'"
			+", '0'"
			+", '" + username +"')";
		break;
	case 3:
		q	=" update	t_siswa"
			+" set		no_induk					= '"+ no_induk +"'"
			+" ,		nisn						= '"+ nisn + "'"
			+" ,		nm_siswa					= '"+ nm_siswa + "'"
			+" ,		nm_panggilan				= '"+ nm_panggilan + "'"
			+" ,		kota_lahir					= '"+ kota_lahir + "'"
			+" ,		tanggal_lahir				= cast('"+ tanggal_lahir +"' as date)"
			+" ,		kd_jenis_kelamin			= '"+ kd_jenis_kelamin +"'"
			+" ,		kd_agama					= '"+ kd_agama +"'"
			+" ,		hubungi						= '"+ hubungi + "'"
			+" ,		tanggung_biaya				=  "+ tanggung_biaya
			+" ,		kd_kesejahteraan_keluarga	= '"+ kd_kesejahteraan_keluarga + "'"
			+" ,		alamat						= '"+ alamat + "'"
			+" ,		rt							= '"+ rt + "'"
			+" ,		rw							= '"+ rw + "'"
			+" ,		kd_pos						= '"+ kd_pos + "'"
			+" ,		no_telp						= '"+ no_telp +"'"
			+" ,		no_hp						= '"+ no_hp +"'"
			+" ,		kd_gol_darah				= '"+ kd_gol_darah + "'"
			+" ,		kelainan_jasmani			= '"+ kelainan_jasmani +"'"
			+" ,		asal_smp					=  "+ asal_smp
			+" ,		pindah_alasan				= '"+ pindah_alasan +"'"
			+" ,		kd_tingkat_kelas			= '"+ kd_tingkat_kelas +"'"
			+" ,		diterima_tanggal			= cast('"+ diterima_tanggal +"' as date)"
			+" ,		dir_foto					= '"+ dir_foto +"'"
			+" ,		username					= '"+ username +"'"
			+" where	nis	= '" + nis + "'";
		break;
	case 4:
		q 	= " delete	from t_siswa"
			+ " where	nis	= '" + nis + "'";
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
