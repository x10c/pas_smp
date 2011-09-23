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

	int dml 					= Integer.parseInt(request.getParameter("dml_type"));
	String id_pegawai			= request.getParameter("id_pegawai");
	String no_urut				= request.getParameter("no_urut");
	String kd_tingkat_ijazah	= request.getParameter("kd_tingkat_ijazah");
	String nm_instansi_penddkn	= request.getParameter("nm_instansi_penddkn");
	String kd_program_studi		= request.getParameter("kd_program_studi");
	String kd_akreditasi		= request.getParameter("kd_akreditasi");
	String tahun_mulai			= request.getParameter("tahun_mulai");
	String kd_status_lulus		= request.getParameter("kd_status_lulus");
	String tahun_selesai		= request.getParameter("tahun_selesai");
	String no_ijazah			= request.getParameter("no_ijazah");
	String tanggal_ijazah		= request.getParameter("tanggal_ijazah");
	String username				= (String) session.getAttribute("user.id");
	String q;

	if (tahun_selesai.equals("")){
		tahun_selesai = null;
	}

	if (tanggal_ijazah.equals("")){
		tanggal_ijazah = "null";
	} else {
		tanggal_ijazah = "cast('" + tanggal_ijazah + "' as date)";
	}

	switch (dml) {
	case 2:
		q	="  insert into t_pegawai_didik_formal"
			+"( id_pegawai"
			+", no_urut"
			+", kd_tingkat_ijazah"
			+", nm_instansi_penddkn"
			+", kd_program_studi"
			+", kd_akreditasi"
			+", tahun_mulai"
			+", kd_status_lulus"
			+", tahun_selesai"
			+", no_ijazah"
			+", tanggal_ijazah"
			+", username)"
			+"  values("
			+"   "+ id_pegawai
			+",  "+ no_urut
			+", '"+ kd_tingkat_ijazah + "'"
			+", '"+ nm_instansi_penddkn + "'"
			+", '"+ kd_program_studi + "'"
			+", '"+ kd_akreditasi + "'"
			+",  "+ tahun_mulai
			+", '"+ kd_status_lulus + "'"
			+",  "+ tahun_selesai
			+", '"+ no_ijazah + "'"
			+",  "+ tanggal_ijazah
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_pegawai_didik_formal"
			+" set		kd_tingkat_ijazah	= '"+ kd_tingkat_ijazah +"'"
			+" ,		nm_instansi_penddkn	= '"+ nm_instansi_penddkn + "'"
			+" ,		kd_program_studi	= '"+ kd_program_studi + "'"
			+" ,		kd_akreditasi		= '"+ kd_akreditasi + "'"
			+" ,		tahun_mulai			=  "+ tahun_mulai
			+" ,		kd_status_lulus		= '"+ kd_status_lulus + "'"
			+" ,		tahun_selesai		=  "+ tahun_selesai
			+" ,		no_ijazah			= '"+ no_ijazah + "'"
			+" ,		tanggal_ijazah		=  "+ tanggal_ijazah
			+" ,		username			= '"+ username +"'"
			+" where	id_pegawai			= "+ id_pegawai
			+" and		no_urut				= "+ no_urut;
		break;
	case 4:
		q 	= " delete	from t_pegawai_didik_formal"
			+ " where	id_pegawai	= "+ id_pegawai
			+ " and		no_urut		= "+ no_urut;
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
