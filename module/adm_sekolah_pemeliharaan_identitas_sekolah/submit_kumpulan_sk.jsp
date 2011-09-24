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

	int dml 							= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran				= (String) session.getAttribute("kd.tahun_pelajaran");
	String no_sk_pendirian				= request.getParameter("no_sk_pendirian");
	String tanggal_sk_pendirian			= request.getParameter("tanggal_sk_pendirian");
	String kd_keterangan_sk				= request.getParameter("kd_keterangan_sk");
	String no_sk_akhir_status			= request.getParameter("no_sk_akhir_status");
	String tanggal_sk_akhir_status		= request.getParameter("tanggal_sk_akhir_status");
	String no_sk_akreditasi				= request.getParameter("no_sk_akreditasi");
	String tanggal_sk_akreditasi		= request.getParameter("tanggal_sk_akreditasi");
	String no_sk_akreditasi_akhir		= request.getParameter("no_sk_akreditasi_akhir");
	String tanggal_sk_akreditasi_akhir	= request.getParameter("tanggal_sk_akreditasi_akhir");
	String kd_akreditasi				= request.getParameter("kd_akreditasi");
	String username						= (String) session.getAttribute("user.id");

	if (tanggal_sk_pendirian.equals("")){
		tanggal_sk_pendirian = "null";
	} else {
		tanggal_sk_pendirian = "cast('" + tanggal_sk_pendirian + "' as date)";
	}

	if (tanggal_sk_akhir_status.equals("")){
		tanggal_sk_akhir_status = "null";
	} else {
		tanggal_sk_akhir_status = "cast('" + tanggal_sk_akhir_status + "' as date)";
	}

	if (tanggal_sk_akreditasi.equals("")){
		tanggal_sk_akreditasi = "null";
	} else {
		tanggal_sk_akreditasi = "cast('" + tanggal_sk_akreditasi + "' as date)";
	}

	if (tanggal_sk_akreditasi_akhir.equals("")){
		tanggal_sk_akreditasi_akhir = "null";
	} else {
		tanggal_sk_akreditasi_akhir = "cast('" + tanggal_sk_akreditasi_akhir + "' as date)";
	}

	switch (dml) {
	case 2:
		q	=" insert into t_sekolah_sk"
			+" (kd_tahun_ajaran"
			+", no_sk_pendirian"
			+", tanggal_sk_pendirian"
			+", kd_keterangan_sk"
			+", no_sk_akhir_status"
			+", tanggal_sk_akhir_status"
			+", no_sk_akreditasi"
			+", tanggal_sk_akreditasi"
			+", no_sk_akreditasi_akhir"
			+", tanggal_sk_akreditasi_akhir"
			+", kd_akreditasi"
			+", username)"
			+"  values ("
			+"  '"+ kd_tahun_ajaran +"'"
			+", '"+ no_sk_pendirian +"'"
			+",  "+ tanggal_sk_pendirian
			+", '"+ kd_keterangan_sk +"'"
			+", '"+ no_sk_akhir_status +"'"
			+",  "+ tanggal_sk_akhir_status
			+", '"+ no_sk_akreditasi +"'"
			+",  "+ tanggal_sk_akreditasi
			+", '"+ no_sk_akreditasi_akhir +"'"
			+",  "+ tanggal_sk_akreditasi_akhir
			+", '"+ kd_akreditasi +"'"
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_sekolah_sk"
			+" set		no_sk_pendirian				= '"+ no_sk_pendirian +"'"
			+" ,		tanggal_sk_pendirian		= "+ tanggal_sk_pendirian
			+" ,		kd_keterangan_sk			= '"+ kd_keterangan_sk +"'"
			+" ,		no_sk_akhir_status			= '"+ no_sk_akhir_status +"'"
			+" ,		tanggal_sk_akhir_status		= "+ tanggal_sk_akhir_status
			+" ,		no_sk_akreditasi			= '"+ no_sk_akreditasi +"'"
			+" ,		tanggal_sk_akreditasi		= "+ tanggal_sk_akreditasi
			+" ,		no_sk_akreditasi_akhir		= '"+ no_sk_akreditasi_akhir +"'"
			+" ,		tanggal_sk_akreditasi_akhir	= "+ tanggal_sk_akreditasi_akhir
			+" ,		kd_akreditasi				= '"+ kd_akreditasi +"'"
			+" ,		username					= '"+ username +"'"
			+" where	kd_tahun_ajaran				= '"+ kd_tahun_ajaran +"'";
		break;
	case 4:
		q	= " delete	from t_sekolah_sk"
			+ " where	kd_tahun_ajaran = '"+ kd_tahun_ajaran + "'";
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
