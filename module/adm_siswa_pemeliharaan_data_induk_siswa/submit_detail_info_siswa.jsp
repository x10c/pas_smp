<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import = "java.sql.*" %>
<%
String q = "";
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int dml 					= Integer.parseInt(request.getParameter("dml_type"));
	String nis					= request.getParameter("nis");
	String kewarganegaraan		= request.getParameter("kewarganegaraan");
	String anak_ke				= request.getParameter("anak_ke");
	String jumlah_kandung		= request.getParameter("jumlah_kandung");
	String jumlah_tiri			= request.getParameter("jumlah_tiri");
	String jumlah_angkat		= request.getParameter("jumlah_angkat");
	String status_yatim_piatu	= request.getParameter("status_yatim_piatu");
	String bahasa				= request.getParameter("bahasa");
	String tinggal_di			= request.getParameter("tinggal_di");
	String jarak_sek			= request.getParameter("jarak_sek");
	String kd_ketunaan			= request.getParameter("kd_ketunaan");
	String berat_badan			= request.getParameter("berat_badan");
	String tinggi_badan			= request.getParameter("tinggi_badan");
	String no_stl_sd			= request.getParameter("no_stl_sd");
	String tanggal_stl_sd		= request.getParameter("tanggal_stl_sd");
	String lama_belajar_sd		= request.getParameter("lama_belajar_sd");
	String username				= (String) session.getAttribute("user.id");

	if (anak_ke.equals("")){
		anak_ke = null;
	}

	if (jumlah_kandung.equals("")){
		jumlah_kandung = null;
	}

	if (jumlah_tiri.equals("")){
		jumlah_tiri = null;
	}

	if (jumlah_angkat.equals("")){
		jumlah_angkat = null;
	}

	if (jarak_sek.equals("")){
		jarak_sek = null;
	}

	if (berat_badan.equals("")){
		berat_badan = null;
	}

	if (tinggi_badan.equals("")){
		tinggi_badan = null;
	}

	if (tanggal_stl_sd.equals("")){
		tanggal_stl_sd = "null";
	} else {
		tanggal_stl_sd = "cast('" + tanggal_stl_sd + "' as date)";
	}

	if (lama_belajar_sd.equals("")){
		lama_belajar_sd = null;
	}

	switch (dml) {
	case 2:
		q	="  insert into t_siswa_info"
			+"  values ("
			+"  '"+ nis +"'"
			+", '"+ kewarganegaraan +"'"
			+",  "+ anak_ke
			+",  "+ jumlah_kandung
			+",  "+ jumlah_tiri
			+",  "+ jumlah_angkat
			+", '"+ status_yatim_piatu +"'"
			+", '"+ bahasa +"'"
			+", '"+ tinggal_di +"'"
			+",  "+ jarak_sek
			+", '"+ kd_ketunaan +"'"
			+",  "+ berat_badan
			+",  "+ tinggi_badan
			+", '"+ no_stl_sd +"'"
			+",  "+ tanggal_stl_sd
			+",  "+ lama_belajar_sd +")";
		break;
	case 3:
		q	=" update	t_siswa_info"
			+" set		kewarganegaraan		= '"+ kewarganegaraan +"'"
			+" ,		anak_ke				= "+ anak_ke
			+" ,		jumlah_kandung		= "+ jumlah_kandung
			+" ,		jumlah_tiri			= "+ jumlah_tiri
			+" ,		jumlah_angkat		= "+ jumlah_angkat
			+" ,		status_yatim_piatu	= '"+ status_yatim_piatu +"'"
			+" ,		bahasa				= '"+ bahasa +"'"
			+" ,		tinggal_di			= '"+ tinggal_di +"'"
			+" ,		jarak_sek			= "+ jarak_sek
			+" ,		kd_ketunaan			= '"+ kd_ketunaan +"'"
			+" ,		berat_badan			= "+ berat_badan
			+" ,		tinggi_badan		= "+ tinggi_badan
			+" ,		no_stl_sd			= '"+ no_stl_sd +"'"
			+" ,		tanggal_stl_sd		= "+ tanggal_stl_sd
			+" ,		lama_belajar_sd		= "+ lama_belajar_sd
			+" where	nis					= '"+ nis +"'";
		break;
	case 4:
		q	= " delete	from t_siswa_info"
			+ " where	nis = '"+ nis + "'";
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
