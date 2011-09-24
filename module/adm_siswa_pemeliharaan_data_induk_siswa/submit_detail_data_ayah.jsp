<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.Properties" %>
<%@ page import = "java.io.FileInputStream" %>
<%@ page import = "java.io.File" %>
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
	String id_siswa					= request.getParameter("id_siswa");
	String nm_ortu					= request.getParameter("nm_ortu");
	String kota_lahir				= request.getParameter("kota_lahir");
	String tanggal_lahir			= request.getParameter("tanggal_lahir");
	String kd_agama					= request.getParameter("kd_agama");
	String kewarganegaraan			= request.getParameter("kewarganegaraan");
	String kd_tingkat_ijazah		= request.getParameter("kd_tingkat_ijazah");
	String id_gol_pekerjaan_ortu	= request.getParameter("id_gol_pekerjaan_ortu");
	String gaji						= request.getParameter("gaji");
	String alamat					= request.getParameter("alamat");
	String rt						= request.getParameter("rt");
	String rw						= request.getParameter("rw");
	String kd_pos					= request.getParameter("kd_pos");
	String no_telp					= request.getParameter("no_telp");
	String no_hp					= request.getParameter("no_hp");
	String status_hub				= request.getParameter("status_hub");
	String kd_status_nikah			= request.getParameter("kd_status_nikah");
	String status_hidup				= request.getParameter("status_hidup");
	String tahun_meninggal			= request.getParameter("tahun_meninggal");
	String username					= (String) session.getAttribute("user.id");

	if (tahun_meninggal.equals("")){
		tahun_meninggal = null;
	}

	switch (dml) {
	case 2:
		q	="  insert into t_siswa_ortu"
			+"( id_siswa"
			+", kd_jenis_ortu"
			+", nm_ortu"
			+", kota_lahir"
			+", tanggal_lahir"
			+", kd_agama"
			+", kewarganegaraan"
			+", kd_tingkat_ijazah"
			+", id_gol_pekerjaan_ortu"
			+", gaji"
			+", alamat"
			+", rt"
			+", rw"
			+", kd_pos"
			+", no_telp"
			+", no_hp"
			+", status_hub"
			+", kd_status_nikah"
			+", status_hidup"
			+", tahun_meninggal"
			+", kd_jenis_kelamin"
			+", username)"
			+"  values ("
			+"   "+ id_siswa
			+", '1'"
			+", '"+ nm_ortu + "'"
			+", '"+ kota_lahir + "'"
			+", cast('"+ tanggal_lahir +"' as date)"
			+", '"+ kd_agama + "'"
			+", '"+ kewarganegaraan + "'"
			+", '"+ kd_tingkat_ijazah +"'"
			+",  "+ id_gol_pekerjaan_ortu
			+",  "+ gaji
			+", '"+ alamat + "'"
			+", '"+ rt +"'"
			+", '"+ rw +"'"
			+", '"+ kd_pos +"'"
			+", '"+ no_telp +"'"
			+", '"+ no_hp +"'"
			+", '"+ status_hub +"'"
			+", '"+ kd_status_nikah +"'"
			+", '"+ status_hidup +"'"
			+",  "+ tahun_meninggal
			+", '1'"
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_siswa_ortu"
			+" set		nm_ortu					= '"+ nm_ortu +"'"
			+" ,		kota_lahir				= '"+ kota_lahir + "'"
			+" ,		tanggal_lahir			= cast('"+ tanggal_lahir +"' as date)"
			+" ,		kd_agama				= '"+ kd_agama + "'"
			+" ,		kewarganegaraan			= '"+ kewarganegaraan + "'"
			+" ,		kd_tingkat_ijazah		= '"+ kd_tingkat_ijazah + "'"
			+" ,		id_gol_pekerjaan_ortu	= "+ id_gol_pekerjaan_ortu
			+" ,		gaji					= "+ gaji
			+" ,		alamat					= '"+ alamat +"'"
			+" ,		rt						= '"+ rt +"'"
			+" ,		rw						= '"+ rw +"'"
			+" ,		kd_pos					= '"+ kd_pos +"'"
			+" ,		no_telp					= '"+ no_telp +"'"
			+" ,		no_hp					= '"+ no_hp +"'"
			+" ,		status_hub				= '"+ status_hub +"'"
			+" ,		kd_status_nikah			= '"+ kd_status_nikah +"'"
			+" ,		status_hidup			= '"+ status_hidup +"'"
			+" ,		tahun_meninggal			= "+ tahun_meninggal
			+" ,		username				= '"+ username +"'"
			+" where	id_siswa				=  "+ id_siswa
			+" and		kd_jenis_ortu 			= '1'";
		break;
	case 4:
		q	= " delete	from t_siswa_ortu"
			+ " where	id_siswa 		=  "+ id_siswa
			+ " and		kd_jenis_ortu 	= '1'";
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (SQLException e){
	Properties	props	= new Properties();
	
	props.load(new FileInputStream(application.getRealPath("WEB-INF"+File.separator+"error.properties")));
	
	String		err_msg = props.getProperty("" + e.getErrorCode() + "");
	
	if (err_msg == null){
		out.print("{success:false,info:'" + e.getErrorCode() + " = Kesalahan operasi, silahkan hubungi direktorat.'}");
	} else {
		out.print("{success:false,info:'" + e.getErrorCode() + " = " + err_msg + "'}");
	}
}
%>
