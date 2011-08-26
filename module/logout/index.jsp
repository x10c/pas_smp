<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%
Connection db_con = (Connection) session.getAttribute("db.con");

if (db_con != null && !db_con.isClosed()) {
	db_con.close();
}

session.removeAttribute("user.id");
session.removeAttribute("db.con");
session.removeAttribute("db.url");
session.removeAttribute("kd.tahun_pelajaran");
session.removeAttribute("nm.tahun_pelajaran");
session.removeAttribute("kd.periode_belajar");
session.removeAttribute("nm.periode_belajar");

out.print("{success:true,info:'"+ request.getContextPath() +"/'}");
%>
