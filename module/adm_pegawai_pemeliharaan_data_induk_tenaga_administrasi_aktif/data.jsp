<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
String q = "";
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();

	String 		kd_tahun_ajaran	= (String) session.getAttribute("kd.tahun_pelajaran");
	String		data			= "{rows:[";
	ResultSet	rs				= null;
	int			i				= 0;

	q	=" select	a.kd_tahun_ajaran"
		+" ,		a.nip"
		+" ,		a.nip_baru"
		+" ,		b.nm_pegawai"
		+" ,		c.nm_jenis_ketenagaan"
		+" ,		a.status_aktif"
		+" from		t_pegawai_aktif		as a"
		+" ,		t_pegawai			as b"
		+" ,		r_jenis_ketenagaan	as c"
		+" where	a.nip					= b.nip"
		+" and		a.kd_jenis_ketenagaan	= c.kd_jenis_ketenagaan"
		+" and		a.kd_jenis_ketenagaan	in ('2')"
		+" and		a.kd_tahun_ajaran		= '" + kd_tahun_ajaran + "'"
		+" order by	a.kd_jenis_ketenagaan, b.nm_pegawai";
	
	rs	= db_stmt.executeQuery(q);

	while (rs.next()){
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data 	+="{ kd_tahun_ajaran : '"+ rs.getString("kd_tahun_ajaran") + "'"
				+ ", nip : "+ rs.getString("nip")
				+ ", nip_baru : '"+ rs.getString("nip_baru") + "'"
				+ ", nm_pegawai :\""+ rs.getString("nm_pegawai") +"\""
				+ ", nm_jenis_ketenagaan : '"+ rs.getString("nm_jenis_ketenagaan") + "'"
				+ ", status_aktif : '"+ rs.getString("status_aktif") +"'"
				+ "}";
	}	
	data += "]}";
	
	out.print(data);
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
