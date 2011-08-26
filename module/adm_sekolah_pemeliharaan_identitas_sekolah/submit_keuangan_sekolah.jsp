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

	int dml 						= Integer.parseInt(request.getParameter("dml_type"));
	String kd_tahun_ajaran			= (String) session.getAttribute("kd.tahun_pelajaran");
	String saldo_awal				= request.getParameter("saldo_awal");
	String trm_gaji_ksr_guru		= request.getParameter("trm_gaji_ksr_guru");
	String trm_gaji_ksr_pgw			= request.getParameter("trm_gaji_ksr_pgw");
	String trm_gaji_ksr_gurubantu	= request.getParameter("trm_gaji_ksr_gurubantu");
	String trm_bos_reguler			= request.getParameter("trm_bos_reguler");
	String trm_bos_buku				= request.getParameter("trm_bos_buku");
	String trm_bomm					= request.getParameter("trm_bomm");
	String trm_bkm					= request.getParameter("trm_bkm");
	String trm_bop					= request.getParameter("trm_bop");
	String trm_gj_pgw				= request.getParameter("trm_gj_pgw");
	String trm_opr_hara				= request.getParameter("trm_opr_hara");
	String trm_adm					= request.getParameter("trm_adm");
	String trm_swasta_non			= request.getParameter("trm_swasta_non");
	String trm_pangkal_bangku		= request.getParameter("trm_pangkal_bangku");
	String trm_komite				= request.getParameter("trm_komite");
	String trm_eks_kul				= request.getParameter("trm_eks_kul");
	String trm_lain					= request.getParameter("trm_lain");
	String trm_prod					= request.getParameter("trm_prod");
	String trm_sumber_lain			= request.getParameter("trm_sumber_lain");
	String byr_guru					= request.getParameter("byr_guru");
	String byr_dpk					= request.getParameter("byr_dpk");
	String byr_guru_hon				= request.getParameter("byr_guru_hon");
	String byr_bantu				= request.getParameter("byr_bantu");
	String byr_guru_kesra			= request.getParameter("byr_guru_kesra");
	String byr_pgw					= request.getParameter("byr_pgw");
	String byr_pgw_hon				= request.getParameter("byr_pgw_hon");
	String byr_pgw_kesra			= request.getParameter("byr_pgw_kesra");
	String byr_pbm					= request.getParameter("byr_pbm");
	String byr_gedung				= request.getParameter("byr_gedung");
	String byr_alat					= request.getParameter("byr_alat");
	String byr_perabot				= request.getParameter("byr_perabot");
	String byr_rehab				= request.getParameter("byr_rehab");
	String byr_buku					= request.getParameter("byr_buku");
	String byr_ada_lain				= request.getParameter("byr_ada_lain");
	String byr_eks_kul				= request.getParameter("byr_eks_kul");
	String byr_daya_jasa			= request.getParameter("byr_daya_jasa");
	String byr_tu_adm				= request.getParameter("byr_tu_adm");
	String byr_lain					= request.getParameter("byr_lain");
	String saldo_akhir				= request.getParameter("saldo_akhir");
	String username					= (String) session.getAttribute("user.id");

	switch (dml) {
	case 2:
		q	=" insert into k_sekolah_keuangan"
			+" (kd_tahun_ajaran"
			+", saldo_awal"
			+", trm_gaji_ksr_guru"
			+", trm_gaji_ksr_pgw"
			+", trm_gaji_ksr_gurubantu"
			+", trm_bos_reguler"
			+", trm_bos_buku"
			+", trm_bomm"
			+", trm_bkm"
			+", trm_bop"
			+", trm_gj_pgw"
			+", trm_opr_hara"
			+", trm_adm"
			+", trm_swasta_non"
			+", trm_pangkal_bangku"
			+", trm_komite"
			+", trm_eks_kul"
			+", trm_lain"
			+", trm_prod"
			+", trm_sumber_lain"
			+", byr_guru"
			+", byr_dpk"
			+", byr_guru_hon"
			+", byr_bantu"
			+", byr_guru_kesra"
			+", byr_pgw"
			+", byr_pgw_hon"
			+", byr_pgw_kesra"
			+", byr_pbm"
			+", byr_gedung"
			+", byr_alat"
			+", byr_perabot"
			+", byr_rehab"
			+", byr_buku"
			+", byr_ada_lain"
			+", byr_eks_kul"
			+", byr_daya_jasa"
			+", byr_tu_adm"
			+", byr_lain"
			+", saldo_akhir"
			+", username)"
			+"  values ("
			+" '"+ kd_tahun_ajaran +"'"
			+", "+ saldo_awal
			+", "+ trm_gaji_ksr_guru
			+", "+ trm_gaji_ksr_pgw
			+", "+ trm_gaji_ksr_gurubantu
			+", "+ trm_bos_reguler
			+", "+ trm_bos_buku
			+", "+ trm_bomm
			+", "+ trm_bkm
			+", "+ trm_bop
			+", "+ trm_gj_pgw
			+", "+ trm_opr_hara
			+", "+ trm_adm
			+", "+ trm_swasta_non
			+", "+ trm_pangkal_bangku
			+", "+ trm_komite
			+", "+ trm_eks_kul
			+", "+ trm_lain
			+", "+ trm_prod
			+", "+ trm_sumber_lain
			+", "+ byr_guru
			+", "+ byr_dpk
			+", "+ byr_guru_hon
			+", "+ byr_bantu
			+", "+ byr_guru_kesra
			+", "+ byr_pgw
			+", "+ byr_pgw_hon
			+", "+ byr_pgw_kesra
			+", "+ byr_pbm
			+", "+ byr_gedung
			+", "+ byr_alat
			+", "+ byr_perabot
			+", "+ byr_rehab
			+", "+ byr_buku
			+", "+ byr_ada_lain
			+", "+ byr_eks_kul
			+", "+ byr_daya_jasa
			+", "+ byr_tu_adm
			+", "+ byr_lain
			+", "+ saldo_akhir
			+", '"+ username +"')";
		break;
	case 3:
		q	=" update	k_sekolah_keuangan"
			+" set		saldo_awal				= "+ saldo_awal
			+" ,		trm_gaji_ksr_guru		= "+ trm_gaji_ksr_guru
			+" ,		trm_gaji_ksr_pgw		= "+ trm_gaji_ksr_pgw
			+" ,		trm_gaji_ksr_gurubantu	= "+ trm_gaji_ksr_gurubantu
			+" ,		trm_bos_reguler			= "+ trm_bos_reguler
			+" ,		trm_bos_buku			= "+ trm_bos_buku
			+" ,		trm_bomm				= "+ trm_bomm
			+" ,		trm_bkm					= "+ trm_bkm
			+" ,		trm_bop					= "+ trm_bop
			+" ,		trm_gj_pgw				= "+ trm_gj_pgw
			+" ,		trm_opr_hara			= "+ trm_opr_hara
			+" ,		trm_adm					= "+ trm_adm
			+" ,		trm_swasta_non			= "+ trm_swasta_non
			+" ,		trm_pangkal_bangku		= "+ trm_pangkal_bangku
			+" ,		trm_komite				= "+ trm_komite
			+" ,		trm_eks_kul				= "+ trm_eks_kul
			+" ,		trm_lain				= "+ trm_lain
			+" ,		trm_prod				= "+ trm_prod
			+" ,		trm_sumber_lain			= "+ trm_sumber_lain
			+" ,		byr_guru				= "+ byr_guru
			+" ,		byr_dpk					= "+ byr_dpk
			+" ,		byr_guru_hon			= "+ byr_guru_hon
			+" ,		byr_bantu				= "+ byr_bantu
			+" ,		byr_guru_kesra			= "+ byr_guru_kesra
			+" ,		byr_pgw					= "+ byr_pgw
			+" ,		byr_pgw_hon				= "+ byr_pgw_hon
			+" ,		byr_pgw_kesra			= "+ byr_pgw_kesra
			+" ,		byr_pbm					= "+ byr_pbm
			+" ,		byr_gedung				= "+ byr_gedung
			+" ,		byr_alat				= "+ byr_alat
			+" ,		byr_perabot				= "+ byr_perabot
			+" ,		byr_rehab				= "+ byr_rehab
			+" ,		byr_buku				= "+ byr_buku
			+" ,		byr_ada_lain			= "+ byr_ada_lain
			+" ,		byr_eks_kul				= "+ byr_eks_kul
			+" ,		byr_daya_jasa			= "+ byr_daya_jasa
			+" ,		byr_tu_adm				= "+ byr_tu_adm
			+" ,		byr_lain				= "+ byr_lain
			+" ,		saldo_akhir				= "+ saldo_akhir
			+" ,		username				= '"+ username +"'"
			+" where	kd_tahun_ajaran			= '"+ kd_tahun_ajaran +"'";
		break;
	case 4:
		q	= " delete	from k_sekolah_keuangan"
			+ " where	kd_tahun_ajaran = '"+ kd_tahun_ajaran + "'";
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
