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

	int dml 							= Integer.parseInt(request.getParameter("dml_type"));
	String nip							= request.getParameter("nip");
	String no_urut						= request.getParameter("no_urut");
	String id_penataran					= request.getParameter("id_penataran");
	String kd_penyelenggara_penataran	= request.getParameter("kd_penyelenggara_penataran");
	String kd_jenis_penataran			= request.getParameter("kd_jenis_penataran");
	String kd_jenis_peserta_penataran	= request.getParameter("kd_jenis_peserta_penataran");
	String kd_mata_pelajaran_diajarkan	= request.getParameter("kd_mata_pelajaran_diajarkan");
	String tanggal_awal					= request.getParameter("tanggal_awal");
	String tanggal_akhir				= request.getParameter("tanggal_akhir");
	String jam							= request.getParameter("jam");
	String username						= (String) session.getAttribute("user.id");
	String q;

	if (tanggal_awal.equals("")){
		tanggal_awal = "null";
	} else {
		tanggal_awal = "cast('" + tanggal_awal + "' as date)";
	}

	if (tanggal_akhir.equals("")){
		tanggal_akhir = "null";
	} else {
		tanggal_akhir = "cast('" + tanggal_akhir + "' as date)";
	}

	switch (dml) {
	case 2:
		q	="  insert into t_pegawai_penataran"
			+"( nip"
			+", no_urut"
			+", id_penataran"
			+", kd_penyelenggara_penataran"
			+", kd_jenis_penataran"
			+", kd_jenis_peserta_penataran"
			+", kd_mata_pelajaran_diajarkan"
			+", tanggal_awal"
			+", tanggal_akhir"
			+", jam"
			+", username)"
			+"  values("
			+"   "+ nip
			+",  "+ no_urut
			+",  "+ id_penataran
			+", '"+ kd_penyelenggara_penataran + "'"
			+", '"+ kd_jenis_penataran + "'"
			+", '"+ kd_jenis_peserta_penataran + "'"
			+", '"+ kd_mata_pelajaran_diajarkan + "'"
			+",  "+ tanggal_awal
			+",  "+ tanggal_akhir
			+",  "+ jam
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_pegawai_penataran"
			+" set		id_penataran				=  "+ id_penataran
			+" ,		kd_penyelenggara_penataran	= '"+ kd_penyelenggara_penataran + "'"
			+" ,		kd_jenis_penataran			= '"+ kd_jenis_penataran + "'"
			+" ,		kd_jenis_peserta_penataran	= '"+ kd_jenis_peserta_penataran + "'"
			+" ,		kd_mata_pelajaran_diajarkan	= '"+ kd_mata_pelajaran_diajarkan + "'"
			+" ,		tanggal_awal				=  "+ tanggal_awal
			+" ,		tanggal_akhir				=  "+ tanggal_akhir
			+" ,		jam							=  "+ jam
			+" ,		username					= '"+ username +"'"
			+" where	nip		= "+ nip
			+" and		no_urut	= "+ no_urut;
		break;
	case 4:
		q 	= " delete	from t_pegawai_penataran"
			+ " where	nip		= "+ nip
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
