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
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int dml 						= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran			= (String) session.getAttribute("kd.tahun_pelajaran");
	String no_urut					= request.getParameter("no_urut");
	String nm_narasumber			= request.getParameter("nm_narasumber");
	String tanggal_lahir			= request.getParameter("tanggal_lahir");
	String kd_tingkat_ijazah		= request.getParameter("kd_tingkat_ijazah");
	String kd_program_studi			= request.getParameter("kd_program_studi");
	String id_gol_pekerjaan_ortu	= request.getParameter("id_gol_pekerjaan_ortu");
	String bidang_keahlian			= request.getParameter("bidang_keahlian");
	String sedia_waktu				= request.getParameter("sedia_waktu");
	String keterangan				= request.getParameter("keterangan");
	String username					= (String) session.getAttribute("user.id");
	String q;

	switch (dml) {
	case 2:
		q	="  insert into t_sekolah_pkh_narasumber"
			+"( kd_tahun_ajaran"
			+", no_urut"
			+", nm_narasumber"
			+", tanggal_lahir"
			+", kd_tingkat_ijazah"
			+", kd_program_studi"
			+", id_gol_pekerjaan_ortu"
			+", bidang_keahlian"
			+", sedia_waktu"
			+", keterangan"
			+", username)"
			+"  values("
			+"  '"+ kd_tahun_ajaran + "'"
			+",  "+ no_urut
			+", '"+ nm_narasumber + "'"
			+", cast('"+ tanggal_lahir +"' as date)"
			+", '"+ kd_tingkat_ijazah + "'"
			+", '"+ kd_program_studi + "'"
			+",  "+ id_gol_pekerjaan_ortu
			+", '"+ bidang_keahlian + "'"
			+",  "+ sedia_waktu
			+", '"+ keterangan +"'"
			+", '" + username +"')";
		break;
	case 3:
		q	=" update	t_sekolah_pkh_narasumber"
			+" set		nm_narasumber			= '"+ nm_narasumber +"'"
			+" ,		tanggal_lahir			= cast('"+ tanggal_lahir +"' as date)"
			+" ,		kd_tingkat_ijazah		= '"+ kd_tingkat_ijazah +"'"
			+" ,		kd_program_studi		= '"+ kd_program_studi +"'"
			+" ,		id_gol_pekerjaan_ortu	= "+ id_gol_pekerjaan_ortu
			+" ,		bidang_keahlian			= '"+ bidang_keahlian + "'"
			+" ,		sedia_waktu				= "+ sedia_waktu
			+" ,		keterangan				= '"+ keterangan +"'"
			+" ,		username				= '"+ username +"'"
			+" where	kd_tahun_ajaran	= '"+ kd_tahun_ajaran + "'"
			+" and		no_urut			= "+ no_urut;
		break;
	case 4:
		q 	= " delete	from t_sekolah_pkh_narasumber"
			+ " where	kd_tahun_ajaran	= '"+ kd_tahun_ajaran + "'"
			+ " and		no_urut			= "+ no_urut;
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
	
	String		err_msg = props.getProperty("" + e.getErrorCode() + "");
	
	if (err_msg == null){
		out.print("{success:false,info:'" + e.getErrorCode() + " = Kesalahan operasi, silahkan hubungi direktorat.'}");
	} else {
		out.print("{success:false,info:'" + e.getErrorCode() + " = " + err_msg + "'}");
	}
}
%>
