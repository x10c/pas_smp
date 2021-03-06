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
	String id_siswa						= request.getParameter("id_siswa");
	String hubungi						= request.getParameter("hubungi");
	String tanggung_biaya				= request.getParameter("tanggung_biaya");
	String status_yatim_piatu			= request.getParameter("status_yatim_piatu");
	String kd_kesejahteraan_keluarga	= request.getParameter("kd_kesejahteraan_keluarga");
	String anak_ke						= request.getParameter("anak_ke");
	String jumlah_kandung				= request.getParameter("jumlah_kandung");
	String jumlah_tiri					= request.getParameter("jumlah_tiri");
	String jumlah_angkat				= request.getParameter("jumlah_angkat");
	String kewarganegaraan				= request.getParameter("kewarganegaraan");
	String bahasa						= request.getParameter("bahasa");
	String tinggal_di					= request.getParameter("tinggal_di");
	String jarak_sek					= request.getParameter("jarak_sek");
	String kd_ketunaan					= request.getParameter("kd_ketunaan");
	String kelainan_jasmani				= request.getParameter("kelainan_jasmani");
	String berat_badan					= request.getParameter("berat_badan");
	String tinggi_badan					= request.getParameter("tinggi_badan");
	String no_stl_sd					= request.getParameter("no_stl_sd");
	String tanggal_stl_sd				= request.getParameter("tanggal_stl_sd");
	String lama_belajar_sd				= request.getParameter("lama_belajar_sd");
	String username						= (String) session.getAttribute("user.id");

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
			+" (id_siswa"
			+", hubungi"
			+", tanggung_biaya"
			+", status_yatim_piatu"
			+", kd_kesejahteraan_keluarga"
			+", anak_ke"
			+", jumlah_kandung"
			+", jumlah_tiri"
			+", jumlah_angkat"
			+", kewarganegaraan"
			+", bahasa"
			+", tinggal_di"
			+", jarak_sek"
			+", kd_ketunaan"
			+", kelainan_jasmani"
			+", berat_badan"
			+", tinggi_badan"
			+", no_stl_sd"
			+", tanggal_stl_sd"
			+", lama_belajar_sd"
			+", username)"
			+"  values ("
			+"   "+ id_siswa
			+", '"+ hubungi +"'"
			+",  "+ tanggung_biaya
			+", '"+ status_yatim_piatu +"'"
			+", '"+ kd_kesejahteraan_keluarga +"'"
			+",  "+ anak_ke
			+",  "+ jumlah_kandung
			+",  "+ jumlah_tiri
			+",  "+ jumlah_angkat
			+", '"+ kewarganegaraan +"'"
			+", '"+ bahasa +"'"
			+", '"+ tinggal_di +"'"
			+",  "+ jarak_sek
			+", '"+ kd_ketunaan +"'"
			+", '"+ kelainan_jasmani +"'"
			+",  "+ berat_badan
			+",  "+ tinggi_badan
			+", '"+ no_stl_sd +"'"
			+",  "+ tanggal_stl_sd
			+",  "+ lama_belajar_sd
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_siswa_info"
			+" set		hubungi						= '"+ hubungi +"'"
			+" ,		tanggung_biaya				= "+ tanggung_biaya
			+" ,		status_yatim_piatu			= '"+ status_yatim_piatu +"'"
			+" ,		kd_kesejahteraan_keluarga	= '"+ kd_kesejahteraan_keluarga +"'"
			+" ,		anak_ke						= "+ anak_ke
			+" ,		jumlah_kandung				= "+ jumlah_kandung
			+" ,		jumlah_tiri					= "+ jumlah_tiri
			+" ,		jumlah_angkat				= "+ jumlah_angkat
			+" ,		kewarganegaraan				= '"+ bahasa +"'"
			+" ,		bahasa						= '"+ bahasa +"'"
			+" ,		tinggal_di					= '"+ tinggal_di +"'"
			+" ,		jarak_sek					= "+ jarak_sek
			+" ,		kd_ketunaan					= '"+ kd_ketunaan +"'"
			+" ,		kelainan_jasmani			= '"+ kelainan_jasmani +"'"
			+" ,		berat_badan					= "+ berat_badan
			+" ,		tinggi_badan				= "+ tinggi_badan
			+" ,		no_stl_sd					= '"+ no_stl_sd +"'"
			+" ,		tanggal_stl_sd				= "+ tanggal_stl_sd
			+" ,		lama_belajar_sd				= "+ lama_belajar_sd
			+" ,		username					= '"+ username + "'"
			+" where	id_siswa					= "+ id_siswa;
		break;
	case 4:
		q	= " delete	from t_siswa_info"
			+ " where	id_siswa = "+ id_siswa;
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
