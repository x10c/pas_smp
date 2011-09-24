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

	int dml 					= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");
	String id_ruang_kelas		= request.getParameter("id_ruang_kelas");
	String nm_ruang_kelas		= request.getParameter("nm_ruang_kelas");
	String kd_ruang				= request.getParameter("kd_ruang");
	String kd_kepemilikan		= request.getParameter("kd_kepemilikan");
	String kd_kondisi_ruangan	= request.getParameter("kd_kondisi_ruangan");
	String kapasitas			= request.getParameter("kapasitas");
	String panjang				= request.getParameter("panjang");
	String lebar				= request.getParameter("lebar");
	String luas					= request.getParameter("luas");
	String keterangan			= request.getParameter("keterangan");
	String username				= (String) session.getAttribute("user.id");
	String q;

	if(panjang.equals("")){
		panjang = "0";
	}

	if(lebar.equals("")){
		lebar = "0";
	}

	if(luas.equals("")){
		luas = "0";
	}
	
	switch (dml) {
	case 2:
		q	=" insert into t_sekolah_ruang"
			+" (kd_tahun_ajaran"
			+", nm_ruang_kelas"
			+", kd_ruang"
			+", kd_kepemilikan"
			+", kd_kondisi_ruangan"
			+", kapasitas"
			+", panjang"
			+", lebar"
			+", luas"
			+", keterangan"
			+", username)"
			+"  values ("
			+"  '"+ kd_tahun_ajaran +"'"
			+", '"+ nm_ruang_kelas +"'"
			+", '"+ kd_ruang +"'"
			+", '"+ kd_kepemilikan +"'"
			+", '"+ kd_kondisi_ruangan +"'"
			+",  "+ kapasitas
			+",  "+ panjang
			+",  "+ lebar
			+",  "+ luas
			+", '"+ keterangan + "'"
			+", '" + username +"')";
		break;
	case 3:
		q	=" update	t_sekolah_ruang"
			+" set		nm_ruang_kelas		= '"+ nm_ruang_kelas +"'"
			+" ,		kd_ruang			= '"+ kd_ruang +"'"
			+" ,		kd_kepemilikan		= '"+ kd_kepemilikan + "'"
			+" ,		kd_kondisi_ruangan	= '"+ kd_kondisi_ruangan + "'"
			+" ,		kapasitas			=  "+ kapasitas
			+" ,		panjang				=  "+ panjang
			+" ,		lebar				=  "+ lebar
			+" ,		luas				=  "+ luas
			+" ,		keterangan			= '"+ keterangan +"'"
			+" ,		username			= '"+ username +"'"
			+" where	id_ruang_kelas		= "+ id_ruang_kelas;
		break;
	case 4:
		q 	= " delete	from t_sekolah_ruang"
			+ " where	id_ruang_kelas		= "+ id_ruang_kelas;
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
