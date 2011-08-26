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

	String kd_tahun_ajaran	= (String) session.getAttribute("kd.tahun_pelajaran");
	
	String q=" select	a.kd_tahun_ajaran"
			+" ,		a.nip"
			+" ,		b.nomor_induk"
			+" ,		b.nip_baru"
			+" ,		b.nm_pegawai"
			+" from		t_pegawai_aktif	as a"
			+" ,		t_pegawai		as b"
			+" where	a.nip					= b.nip"
			+" and		a.kd_jenis_ketenagaan	<> '2'"
			+" and		a.kd_tahun_ajaran		= '" + kd_tahun_ajaran + "'"
			+" order by	a.kd_tahun_ajaran, a.nip";
	
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
				+ ","+ rs.getString("nip")
				+ ",'"+ rs.getString("nomor_induk") + "'"
				+ ",'"+ rs.getString("nip_baru") + "'"
				+ ",'"+ rs.getString("nm_pegawai") +"']";
	}	
	data += "]";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
