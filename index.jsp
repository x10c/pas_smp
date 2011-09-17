<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.File" %>
<%
Properties	props	= new Properties();
props.load(new FileInputStream(application.getRealPath("WEB-INF"+File.separator+"web.properties")));
String		db_url	= props.getProperty("db")+"user="+props.getProperty("user")+"&password="+props.getProperty("pass");
Connection	db_con	= DriverManager.getConnection(db_url);
Statement	db_stmt	= db_con.createStatement();

session.setAttribute("db.url", (Object) db_url);
session.setAttribute("db.con", (Object) db_con);

// get user session, redirect to main page if user already logged in
Object		user	= session.getAttribute("user.id");
String		cpath	= request.getContextPath();

if (user != null) {
	response.sendRedirect(cpath +"/module/main/index.jsp");
	return;
}
%>

<html>
<head>
<title> PAS-SMP </title>
<link rel='shortcut icon' href='<%=cpath%>/images/icon.png'/>
<script>
	var _g_root = '<%= cpath %>';
</script>

<link rel='icon' href='<%=cpath%>/images/icon.png' />
<link rel='stylesheet' type='text/css' href='<%=cpath%>/css/index.css'/>
<%--
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/resources/css/ext-all.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/resources/css/xtheme-gray.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/css/style.css'/>
--%>
<%--
<script type='text/javascript' src='<%=cpath%>/extjs/adapter/ext/ext-base.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ext-all.js'></script>
<script type='text/javascript' src='<%=cpath%>/js/jquery-1.4.2.min.js'></script>
<script type='text/javascript' src='<%=cpath%>/js/jquery.cycle.all.min.js'></script>
<script type='text/javascript' src='<%=cpath%>/js/jquery_ease.js'></script>
<script type='text/javascript' src='<%=cpath%>/js/jquery.Scroller-1.0.min.js'></script>
--%>
<script type='text/javascript' src='<%=cpath%>/js/index-all.js'></script>

<%-- Highcharts --%>
<script type='text/javascript' src='<%=cpath%>/extjs/adapter/highcharts/extjs-highcharts-adapter.js'></script>
<script type='text/javascript' src='<%=cpath%>/highcharts/highcharts.js'></script>
<script type='text/javascript' src='<%=cpath%>/highcharts/modules/exporting.js'></script>
<!--[if IE]><script type="text/javascript" src="<%=cpath%>/highcharts/excanvas.compiled.js"></script><![endif]-->
<script type='text/javascript' src='<%=cpath%>/extjs/ux/HighChart.js'></script>

<script type='text/javascript' src='<%=cpath%>/extjs/ux/Spotlight.js'></script>

<script type='text/javascript' src='<%=cpath%>/js/SHA256.js'></script>
<script type='text/javascript' src='<%=cpath%>/js/all.js'></script>
<script type='text/javascript' src='<%=cpath%>/layout.js'></script>
</head>

<body>
<div id="back" class="clearfloat">
	<div id="header" class="clearfloat">
		<!--
		<h1> PAKET APLIKASI SEKOLAH </h1>
		-->
	</div>

	<div id="wrap" class="clearfloat">
		<div id="top">
			<div class="horizontal_scroller">
			</div>
		</div>
		<div id="main">
			<div class='image-display'>
				<img src="<%=cpath%>/images/image.png"/>
			</div>

		</div><!--end main-->

		<div id="sidebar" class="clearfloat">
			<div class="login-section">
				<h3>User Login</h3>
				<form name="login_form">
					<label>Nama User:</label>
					<input type="text" name="user" id="user_login" value="" size="23" />
					<label>Kata Kunci:</label>
					<input type="password" name="password" id="user_pass" size="23" onKeyDown="form_pass_on_keydown(event)" />
					<center>
					<input type="button" name="login" value="Login" class="bt_login" onClick="call_do_login()"/>
					</center>
				</form>
			</div>
		</div>
		<div id="footer" class="clearfloat">
			<div class="right">
			<p>&#169; 2011 Kementerian Pendidikan Nasional - Dit.PSMP. Aplikasi ini milik Negara, tidak untuk diperdagangkan.</p>
			</div>
		</div><!--end #footer-->
	</div><!--end wrap-->
</div><!--end back-->
</body>
</html>
