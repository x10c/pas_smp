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

	int dml 						= Integer.parseInt(request.getParameter("dml_type"));
	String nip						= request.getParameter("nip");
	String no_urut					= request.getParameter("no_urut");
	String no_urut_old				= request.getParameter("no_urut_old");
	String no_sk					= request.getParameter("no_sk");
	String tanggal_sk				= request.getParameter("tanggal_sk");
	String tmt_sk					= request.getParameter("tmt_sk");
	String kd_jenis_pegawai			= request.getParameter("kd_jenis_pegawai");
	String kd_tenaga_administrasi	= request.getParameter("kd_tenaga_administrasi");
	String tahun_berhenti			= request.getParameter("tahun_berhenti");
	String keterangan				= request.getParameter("keterangan");
	String username					= (String) session.getAttribute("user.id");
	String q;

	if (tahun_berhenti.equals("")){
		tahun_berhenti = null;
	}

	switch (dml) {
	case 2:
		q	="  insert into t_pegawai_rwyt_jabatan"
			+"( nip"
			+", no_urut"
			+", no_sk"
			+", tanggal_sk"
			+", tmt_sk"
			+", kd_jenis_pegawai"
			+", kd_tenaga_administrasi"
			+", tahun_berhenti"
			+", keterangan"
			+", username)"
			+"  values("
			+"   "+ nip
			+",  "+ no_urut
			+", '"+ no_sk + "'"
			+", cast('"+ tanggal_sk +"' as date)"
			+", cast('"+ tmt_sk +"' as date)"
			+", '"+ kd_jenis_pegawai + "'"
			+", '"+ kd_tenaga_administrasi + "'"
			+",  "+ tahun_berhenti
			+", '"+ keterangan + "'"
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	t_pegawai_rwyt_jabatan"
			+" set		no_urut					= "+ no_urut
			+" ,		no_sk					= '"+ no_sk + "'"
			+" ,		tanggal_sk				= cast('"+ tanggal_sk +"' as date)"
			+" ,		tmt_sk					= cast('"+ tmt_sk +"' as date)"
			+" ,		kd_jenis_pegawai		= '"+ kd_jenis_pegawai +"'"
			+" ,		kd_tenaga_administrasi	= '"+ kd_tenaga_administrasi +"'"
			+" ,		tahun_berhenti			=  "+ tahun_berhenti
			+" ,		keterangan				= '"+ keterangan +"'"
			+" ,		username				= '"+ username +"'"
			+" where	nip		= "+ nip
			+" and		no_urut	= "+ no_urut_old;
		break;
	case 4:
		q 	= " delete	from t_pegawai_rwyt_jabatan"
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
