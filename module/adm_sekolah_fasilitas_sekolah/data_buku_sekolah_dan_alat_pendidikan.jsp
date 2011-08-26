<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	
	String 		kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");

	String q=" select	a.kd_tahun_ajaran"
			+" ,		a.kd_mata_pelajaran_diajarkan"
			+" ,		a.jml_jdl_guru"
			+" ,		a.jml_eks_guru"
			+" ,		a.jml_jdl_siswa"
			+" ,		a.jml_eks_siswa"
			+" ,		a.jml_jdl_pegang"
			+" ,		a.jml_eks_pegang"
			+" ,		a.prosen_peraga"
			+" ,		a.paktek"
			+" ,		a.mulmed"
			+" ,		b.nm_mata_pelajaran_diajarkan"
			+" from		t_sekolah_bualpen			as a"
			+" ,		r_mata_pelajaran_diajarkan	as b"
			+" where	a.kd_mata_pelajaran_diajarkan	= b.kd_mata_pelajaran_diajarkan"
			+" and		a.kd_tahun_ajaran				= '" + kd_tahun_ajaran + "'"
			+" order by	a.kd_mata_pelajaran_diajarkan";
	
	ResultSet	rs	= db_stmt.executeQuery(q);
	int		i	= 0;
	String		data	= "[";

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="['"+ rs.getString("kd_tahun_ajaran") + "'"
				+ ",'"+ rs.getString("kd_mata_pelajaran_diajarkan") +"'"
				+ ","+ rs.getString("jml_jdl_guru")
				+ ","+ rs.getString("jml_eks_guru")
				+ ","+ rs.getString("jml_jdl_siswa")
				+ ","+ rs.getString("jml_eks_siswa")
				+ ","+ rs.getString("jml_jdl_pegang")
				+ ","+ rs.getString("jml_eks_pegang")
				+ ","+ rs.getString("prosen_peraga")
				+ ","+ rs.getString("paktek")
				+ ","+ rs.getString("mulmed")
				+ ",\""+ rs.getString("nm_mata_pelajaran_diajarkan") +"\""
				+ "]";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
