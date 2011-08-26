<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try {
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String 		kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");
	
	ResultSet	rs;
	String		q;
	String		data;

	q=" select	kd_tahun_ajaran"
	+" ,		saldo_awal"
	+" ,		trm_gaji_ksr_guru"
	+" ,		trm_gaji_ksr_pgw"
	+" ,		trm_gaji_ksr_gurubantu"
	+" ,		trm_bos_reguler"
	+" ,		trm_bos_buku"
	+" ,		trm_bomm"
	+" ,		trm_bkm"
	+" ,		trm_bop"
	+" ,		trm_gj_pgw"
	+" ,		trm_opr_hara"
	+" ,		trm_adm"
	+" ,		trm_swasta_non"
	+" ,		trm_pangkal_bangku"
	+" ,		trm_komite"
	+" ,		trm_eks_kul"
	+" ,		trm_lain"
	+" ,		trm_prod"
	+" ,		trm_sumber_lain"
	+" ,		byr_guru"
	+" ,		byr_dpk"
	+" ,		byr_guru_hon"
	+" ,		byr_bantu"
	+" ,		byr_guru_kesra"
	+" ,		byr_pgw"
	+" ,		byr_pgw_hon"
	+" ,		byr_pgw_kesra"
	+" ,		byr_pbm"
	+" ,		byr_gedung"
	+" ,		byr_alat"
	+" ,		byr_perabot"
	+" ,		byr_rehab"
	+" ,		byr_buku"
	+" ,		byr_ada_lain"
	+" ,		byr_eks_kul"
	+" ,		byr_daya_jasa"
	+" ,		byr_tu_adm"
	+" ,		byr_lain"
	+" ,		saldo_akhir"
	+" from		k_sekolah_keuangan"
	+" where	kd_tahun_ajaran	= '" + kd_tahun_ajaran + "'";

	rs = db_stmt.executeQuery(q);

	if (!rs.next()) {
		out.print("{ success: false"
		+", info:'Data Keuangan Sekolah tidak ditemukan!'}");
		return;
	}

	data	="{ kd_tahun_ajaran	: '"+ rs.getString("kd_tahun_ajaran") + "'"
			+", saldo_awal : "+ rs.getString("saldo_awal")
			+", trm_gaji_ksr_guru : "+ rs.getString("trm_gaji_ksr_guru")
			+", trm_gaji_ksr_pgw : "+ rs.getString("trm_gaji_ksr_pgw")
			+", trm_gaji_ksr_gurubantu : "+ rs.getString("trm_gaji_ksr_gurubantu")
			+", trm_bos_reguler : "+ rs.getString("trm_bos_reguler")
			+", trm_bos_buku : "+ rs.getString("trm_bos_buku")
			+", trm_bomm : "+ rs.getString("trm_bomm")
			+", trm_bkm : "+ rs.getString("trm_bkm")
			+", trm_bop : "+ rs.getString("trm_bop")
			+", trm_gj_pgw : "+ rs.getString("trm_gj_pgw")
			+", trm_opr_hara : "+ rs.getString("trm_opr_hara")
			+", trm_adm : "+ rs.getString("trm_adm")
			+", trm_swasta_non : "+ rs.getString("trm_swasta_non")
			+", trm_pangkal_bangku : "+ rs.getString("trm_pangkal_bangku")
			+", trm_komite : "+ rs.getString("trm_komite")
			+", trm_eks_kul : "+ rs.getString("trm_eks_kul")
			+", trm_lain : "+ rs.getString("trm_lain")
			+", trm_prod : "+ rs.getString("trm_prod")
			+", trm_sumber_lain : "+ rs.getString("trm_sumber_lain")
			+", byr_guru : "+ rs.getString("byr_guru")
			+", byr_dpk : "+ rs.getString("byr_dpk")
			+", byr_guru_hon : "+ rs.getString("byr_guru_hon")
			+", byr_bantu : "+ rs.getString("byr_bantu")
			+", byr_guru_kesra : "+ rs.getString("byr_guru_kesra")
			+", byr_pgw : "+ rs.getString("byr_pgw")
			+", byr_pgw_hon : "+ rs.getString("byr_pgw_hon")
			+", byr_pgw_kesra : "+ rs.getString("byr_pgw_kesra")
			+", byr_pbm : "+ rs.getString("byr_pbm")
			+", byr_gedung : "+ rs.getString("byr_gedung")
			+", byr_alat : "+ rs.getString("byr_alat")
			+", byr_perabot : "+ rs.getString("byr_perabot")
			+", byr_rehab : "+ rs.getString("byr_rehab")
			+", byr_buku : "+ rs.getString("byr_buku")
			+", byr_ada_lain : "+ rs.getString("byr_ada_lain")
			+", byr_eks_kul : "+ rs.getString("byr_eks_kul")
			+", byr_daya_jasa : "+ rs.getString("byr_daya_jasa")
			+", byr_tu_adm : "+ rs.getString("byr_tu_adm")
			+", byr_lain : "+ rs.getString("byr_lain")
			+", saldo_akhir : "+ rs.getString("saldo_akhir");

	data += "}";

	rs.close();

	out.print(data);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
