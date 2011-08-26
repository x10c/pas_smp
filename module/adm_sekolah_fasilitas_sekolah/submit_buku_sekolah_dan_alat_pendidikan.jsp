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
	String kd_tahun_ajaran				= (String) session.getAttribute("kd.tahun_pelajaran");
	String kd_mata_pelajaran_diajarkan	= request.getParameter("kd_mata_pelajaran_diajarkan");
	String jml_jdl_guru					= request.getParameter("jml_jdl_guru");
	String jml_eks_guru					= request.getParameter("jml_eks_guru");
	String jml_jdl_siswa				= request.getParameter("jml_jdl_siswa");
	String jml_eks_siswa				= request.getParameter("jml_eks_siswa");
	String jml_jdl_pegang				= request.getParameter("jml_jdl_pegang");
	String jml_eks_pegang				= request.getParameter("jml_eks_pegang");
	String prosen_peraga				= request.getParameter("prosen_peraga");
	String paktek						= request.getParameter("paktek");
	String mulmed						= request.getParameter("mulmed");
	String username						= (String) session.getAttribute("user.id");
	String q;

	if(jml_jdl_guru.equals("")){
		jml_jdl_guru = "0";
	}

	if(jml_eks_guru.equals("")){
		jml_eks_guru = "0";
	}

	if(jml_jdl_siswa.equals("")){
		jml_jdl_siswa = "0";
	}

	if(jml_eks_siswa.equals("")){
		jml_eks_siswa = "0";
	}

	if(jml_jdl_pegang.equals("")){
		jml_jdl_pegang = "0";
	}

	if(jml_eks_pegang.equals("")){
		jml_eks_pegang = "0";
	}

	if(prosen_peraga.equals("")){
		prosen_peraga = "0";
	}

	if(paktek.equals("")){
		paktek = "0";
	}

	if(mulmed.equals("")){
		mulmed = "0";
	}
	
	switch (dml) {
	case 3:
		q	=" update	t_sekolah_bualpen"
			+" set		jml_jdl_guru	= "+ jml_jdl_guru
			+" ,		jml_eks_guru	= "+ jml_eks_guru
			+" ,		jml_jdl_siswa	= "+ jml_jdl_siswa
			+" ,		jml_eks_siswa	= "+ jml_eks_siswa
			+" ,		jml_jdl_pegang	= "+ jml_jdl_pegang
			+" ,		jml_eks_pegang	= "+ jml_eks_pegang
			+" ,		prosen_peraga	= "+ prosen_peraga
			+" ,		paktek			= "+ paktek
			+" ,		mulmed			= "+ mulmed
			+" ,		username		= '"+ username +"'"
			+" where	kd_tahun_ajaran				= '"+ kd_tahun_ajaran + "'"
			+" and		kd_mata_pelajaran_diajarkan	= '"+ kd_mata_pelajaran_diajarkan + "'";
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
