<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import = "java.sql.*" %>
<%@ page import	= "java.util.Properties" %>
<%@ page import	= "java.io.FileInputStream" %>
<%@ page import	= "java.io.File" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int dml 						= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran			= request.getParameter("kd_tahun_ajaran");
	String kd_tingkat_kelas			= request.getParameter("kd_tingkat_kelas");
	String kd_rombel				= request.getParameter("kd_rombel");
	String id_siswa					= request.getParameter("id_siswa");
	String id_siswa_old				= request.getParameter("id_siswa_old");
	String id_jenis_lomba			= request.getParameter("id_jenis_lomba");
	String id_jenis_lomba_old		= request.getParameter("id_jenis_lomba_old");
	String kd_tingkat_prestasi		= request.getParameter("kd_tingkat_prestasi");
	String kd_tingkat_prestasi_old	= request.getParameter("kd_tingkat_prestasi_old");
	String tanggal_prestasi			= request.getParameter("tanggal_prestasi");
	String tanggal_prestasi_old		= request.getParameter("tanggal_prestasi_old");
	String juara_ke					= request.getParameter("juara_ke");
	String keterangan				= request.getParameter("keterangan");
	String username					= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	="  insert into t_siswa_prestasi"
			+"( kd_tahun_ajaran"
			+", kd_tingkat_kelas"
			+", kd_rombel"
			+", id_siswa"
			+", id_jenis_lomba"
			+", kd_tingkat_prestasi"
			+", tanggal_prestasi"
			+", juara_ke"
			+", keterangan"
			+", username)"
			+"  values("
			+"  '"+ kd_tahun_ajaran + "'"
			+", '"+ kd_tingkat_kelas + "'"
			+", '"+ kd_rombel + "'"
			+",  "+ id_siswa
			+",  "+ id_jenis_lomba
			+", '"+ kd_tingkat_prestasi + "'"
			+", cast('"+ tanggal_prestasi +"' as date)"
			+",  "+ juara_ke
			+", '"+ keterangan + "'"
			+", '"+ username +"')";

		break;
	case 3:
		q	=" update	t_siswa_prestasi"
			+" set		id_siswa			=  "+ id_siswa
			+" ,		id_jenis_lomba		=  "+ id_jenis_lomba
			+" ,		kd_tingkat_prestasi	= '"+ kd_tingkat_prestasi + "'"
			+" ,		tanggal_prestasi	= cast('"+ tanggal_prestasi +"' as date)"
			+" ,		juara_ke			=  "+ juara_ke
			+" ,		keterangan			= '"+ keterangan + "'"
			+" ,		username			= '"+ username +"'"
			+" where	kd_tahun_ajaran		= '"+ kd_tahun_ajaran +"'"
			+" and		kd_tingkat_kelas	= '"+ kd_tingkat_kelas +"'"
			+" and		kd_rombel			= '"+ kd_rombel +"'"
			+" and		id_siswa			=  "+ id_siswa_old
			+" and		id_jenis_lomba		=  "+ id_jenis_lomba_old
			+" and		kd_tingkat_prestasi	= '"+ kd_tingkat_prestasi_old + "'"
			+" and		tanggal_prestasi	= cast('"+ tanggal_prestasi_old +"' as date)";
		break;
	case 4:
		q	= " delete	from t_siswa_prestasi"
			+ " where	kd_tahun_ajaran 	= '"+ kd_tahun_ajaran + "'"
			+ " and		kd_tingkat_kelas 	= '"+ kd_tingkat_kelas + "'"
			+ " and 	kd_rombel 			= '"+ kd_rombel + "'"
			+ " and		id_siswa			=  "+ id_siswa
			+ " and		id_jenis_lomba		=  "+ id_jenis_lomba
			+ " and		kd_tingkat_prestasi	= '"+ kd_tingkat_prestasi + "'"
			+ " and		tanggal_prestasi	= cast('"+ tanggal_prestasi +"' as date)";
		break;
	default:
		out.print("{success:false,info:'DML tipe tidak diketahui ("+dml+")!'}");
		return;
	}

	db_stmt.executeUpdate(q);

	out.print("{success:true,info:'Data telah tersimpan.'}");
} catch (Exception e){
	Properties	props	= new Properties();
	
	props.load(new FileInputStream(application.getRealPath("WEB-INF"+File.separator+"error.properties")));

	String		err_msg	= props.getProperty("" + e.getErrorCode() + "");
	
	if (err_msg == null){
		out.print("{success:false,info:'" + e.getErrorCode() + " = Kesalahan operasi, silahkan hubungi direktorat.'}");
	} else {
		out.print("{success:false,info:'" + e.getErrorCode() + " = " + err_msg + "'}");
	}
}
%>
