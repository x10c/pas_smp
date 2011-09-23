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

	int dml 				= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran	= (String) session.getAttribute("kd.tahun_pelajaran");
	String lanjut_jauh		= request.getParameter("lanjut_jauh");
	String biaya			= request.getParameter("biaya");
	String transportasi		= request.getParameter("transportasi");
	String geografi			= request.getParameter("geografi");
	String terpencil		= request.getParameter("terpencil");
	String kurang_penting	= request.getParameter("kurang_penting");
	String kerja			= request.getParameter("kerja");
	String menikah			= request.getParameter("menikah");
	String lain_lain		= request.getParameter("lain_lain");
	String keterangan		= request.getParameter("keterangan");
	String username			= (String) session.getAttribute("user.id");

	switch (dml) {
	case 2:
		q	=" insert into t_sekolah_do"
			+" (kd_tahun_ajaran"
			+", lanjut_jauh"
			+", biaya"
			+", transportasi"
			+", geografi"
			+", terpencil"
			+", kurang_penting"
			+", kerja"
			+", menikah"
			+", lain_lain"
			+", keterangan"
			+", username)"
			+"  values ("
			+" '"+ kd_tahun_ajaran +"'"
			+", "+ lanjut_jauh
			+", "+ biaya
			+", "+ transportasi
			+", "+ geografi
			+", "+ terpencil
			+", "+ kurang_penting
			+", "+ kerja
			+", "+ menikah
			+", "+ lain_lain
			+", '"+ keterangan + "'"
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_sekolah_do"
			+" set		lanjut_jauh		= "+ lanjut_jauh
			+" ,		biaya			= "+ biaya
			+" ,		transportasi	= "+ transportasi
			+" ,		geografi		= "+ geografi
			+" ,		terpencil		= "+ terpencil
			+" ,		kurang_penting	= "+ kurang_penting
			+" ,		kerja			= "+ kerja
			+" ,		menikah			= "+ menikah
			+" ,		lain_lain		= "+ lain_lain
			+" ,		keterangan		= '"+ keterangan + "'"
			+" ,		username		= '"+ username +"'"
			+" where	kd_tahun_ajaran	= '"+ kd_tahun_ajaran +"'";
		break;
	case 4:
		q	= " delete	from t_sekolah_do"
			+ " where	kd_tahun_ajaran = '"+ kd_tahun_ajaran + "'";
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
