<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import = "java.sql.*" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	int dml 					= Integer.parseInt(request.getParameter("dml_type"));
	String id_pegawai					= request.getParameter("id_pegawai");
	String no_urut				= request.getParameter("no_urut");
	String nm_keluarga			= request.getParameter("nm_keluarga");
	String kd_hub_keluarga		= request.getParameter("kd_hub_keluarga");
	String kd_jenis_kelamin		= request.getParameter("kd_jenis_kelamin");
	String prop_lahir			= request.getParameter("prop_lahir");
	String kota_lahir			= request.getParameter("kota_lahir");
	String tanggal_lahir		= request.getParameter("tanggal_lahir");
	String kd_agama				= request.getParameter("kd_agama");
	String kd_gol_darah			= request.getParameter("kd_gol_darah");
	String kd_status_nikah		= request.getParameter("kd_status_nikah");
	String tanggal_menikah		= request.getParameter("tanggal_menikah");
	String tahun_meninggal		= request.getParameter("tahun_meninggal");
	String alamat				= request.getParameter("alamat");
	String username				= (String) session.getAttribute("user.id");
	String q;

	if (tanggal_menikah.equals("")){
		tanggal_menikah = "null";
	} else {
		tanggal_menikah = "cast('" + tanggal_menikah + "' as date)";
	}

	if (tahun_meninggal.equals("")){
		tahun_meninggal = null;
	}

	switch (dml) {
	case 2:
		q	="  insert into t_pegawai_keluarga"
			+"( id_pegawai"
			+", no_urut"
			+", nm_keluarga"
			+", kd_hub_keluarga"
			+", kd_jenis_kelamin"
			+", prop_lahir"
			+", kota_lahir"
			+", tanggal_lahir"
			+", kd_agama"
			+", kd_gol_darah"
			+", kd_status_nikah"
			+", tanggal_menikah"
			+", tahun_meninggal"
			+", alamat"
			+", username)"
			+"  values("
			+"   "+ id_pegawai
			+",  "+ no_urut
			+", '"+ nm_keluarga + "'"
			+", '"+ kd_hub_keluarga + "'"
			+", '"+ kd_jenis_kelamin + "'"
			+", '"+ prop_lahir + "'"
			+", '"+ kota_lahir + "'"
			+", cast('"+ tanggal_lahir +"' as date)"
			+", '"+ kd_agama + "'"
			+", '"+ kd_gol_darah + "'"
			+", '"+ kd_status_nikah + "'"
			+",  "+ tanggal_menikah
			+",  "+ tahun_meninggal
			+", '"+ alamat + "'"
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_pegawai_keluarga"
			+" set		nm_keluarga			= '"+ nm_keluarga +"'"
			+" ,		kd_hub_keluarga		= '"+ kd_hub_keluarga + "'"
			+" ,		kd_jenis_kelamin	= '"+ kd_jenis_kelamin + "'"
			+" ,		prop_lahir			= '"+ prop_lahir + "'"
			+" ,		kota_lahir			= '"+ kota_lahir + "'"
			+" ,		tanggal_lahir		= cast('"+ tanggal_lahir +"' as date)"
			+" ,		kd_agama			= '"+ kd_agama +"'"
			+" ,		kd_gol_darah		= '"+ kd_gol_darah +"'"
			+" ,		kd_status_nikah		= '"+ kd_status_nikah +"'"
			+" ,		tanggal_menikah		= "+ tanggal_menikah
			+" ,		tahun_meninggal		= "+ tahun_meninggal
			+" ,		alamat				= '"+ alamat + "'"
			+" ,		username			= '"+ username +"'"
			+" where	id_pegawai		= "+ id_pegawai
			+" and		no_urut	= "+ no_urut;
		break;
	case 4:
		q 	= " delete	from t_pegawai_keluarga"
			+ " where	id_pegawai		= "+ id_pegawai
			+ " and		no_urut	= "+ no_urut;
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
