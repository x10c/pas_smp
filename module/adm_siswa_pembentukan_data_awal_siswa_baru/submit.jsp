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
	String id_siswa							= request.getParameter("id_siswa");
	String nis						= request.getParameter("nis");
	String nm_siswa						= request.getParameter("nm_siswa");
	String nm_panggilan					= request.getParameter("nm_panggilan");
	String kota_lahir					= request.getParameter("kota_lahir");
	String tanggal_lahir				= request.getParameter("tanggal_lahir");
	String kd_jenis_kelamin				= request.getParameter("kd_jenis_kelamin");
	String kd_agama						= request.getParameter("kd_agama");
	String alamat						= request.getParameter("alamat");
	String rt							= request.getParameter("rt");
	String rw							= request.getParameter("rw");
	String kd_pos						= request.getParameter("kd_pos");
	String no_telp						= request.getParameter("no_telp");
	String no_hp						= request.getParameter("no_hp");
	String kd_gol_darah					= request.getParameter("kd_gol_darah");
	String diterima_tanggal				= request.getParameter("diterima_tanggal");
	String asal_sd						= request.getParameter("asal_sd");
	String nilai						= request.getParameter("nilai");
	String username						= (String) session.getAttribute("user.id");
	String q;
	
	DateFormat df 						= new SimpleDateFormat ("yyMMddhhmmss");
	String formattedDate 				= df.format(new Date());

	if (asal_sd.equals("")){
		asal_sd = null;
	}

	if (nilai.equals("")){
		nilai = "0";
	}

	switch (dml) {
	case 2:
		id_siswa	= formattedDate;
		
		q	="  insert into t_siswa"
			+"( id_siswa"
			+", nis"
			+", nm_siswa"
			+", nm_panggilan"
			+", kota_lahir"
			+", tanggal_lahir"
			+", kd_jenis_kelamin"
			+", kd_agama"
			+", alamat"
			+", rt"
			+", rw"
			+", kd_pos"
			+", no_telp"
			+", no_hp"
			+", kd_gol_darah"
			+", diterima_tanggal"
			+", asal_sd"
			+", nilai"
			+", status_entri"
			+", status_siswa"
			+", kd_tingkat_kelas"
			+", username)"
			+"  values("
			+"  '"+ id_siswa + "'"
			+", '"+ nis + "'"
			+", '"+ nm_siswa + "'"
			+", '"+ nm_panggilan + "'"
			+", '"+ kota_lahir + "'"
			+", cast('"+ tanggal_lahir +"' as date)"
			+", '"+ kd_jenis_kelamin + "'"
			+", '"+ kd_agama + "'"
			+", '"+ alamat + "'"
			+", '"+ rt + "'"
			+", '"+ rw + "'"
			+", '"+ kd_pos + "'"
			+", '"+ no_telp + "'"
			+", '"+ no_hp +"'"
			+", '"+ kd_gol_darah + "'"
			+", cast('"+ diterima_tanggal +"' as date)"
			+",  "+ asal_sd
			+",  "+ nilai
			+", '0'"
			+", '0'"
			+", '01'"
			+", '" + username +"')";
		break;
	case 3:
		q	=" update	t_siswa"
			+" set		nis					= '"+ nis +"'"
			+" ,		nm_siswa					= '"+ nm_siswa + "'"
			+" ,		nm_panggilan				= '"+ nm_panggilan + "'"
			+" ,		kota_lahir					= '"+ kota_lahir + "'"
			+" ,		tanggal_lahir				= cast('"+ tanggal_lahir +"' as date)"
			+" ,		kd_jenis_kelamin			= '"+ kd_jenis_kelamin +"'"
			+" ,		kd_agama					= '"+ kd_agama +"'"
			+" ,		alamat						= '"+ alamat + "'"
			+" ,		rt							= '"+ rt + "'"
			+" ,		rw							= '"+ rw + "'"
			+" ,		kd_pos						= '"+ kd_pos + "'"
			+" ,		no_telp						= '"+ no_telp +"'"
			+" ,		no_hp						= '"+ no_hp +"'"
			+" ,		kd_gol_darah				= '"+ kd_gol_darah + "'"
			+" ,		diterima_tanggal			= cast('"+ diterima_tanggal +"' as date)"
			+" ,		asal_sd						=  "+ asal_sd
			+" ,		nilai						=  "+ nilai
			+" ,		username					= '"+ username +"'"
			+" where	id_siswa	= '" + id_siswa + "'";
		break;
	case 4:
		q 	= " delete	from t_siswa"
			+ " where	id_siswa	= '" + id_siswa + "'";
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
