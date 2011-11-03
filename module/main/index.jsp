<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page contentType="text/html" %>
<%
// check user session, if not exist redirect user to module login
String user		= (String) session.getAttribute("user.id");
String cpath	= (String) request.getContextPath();
String db_url	= (String) session.getAttribute("db.url");

if (null == user || null == db_url) {
	String url = cpath +"/index.jsp";
	response.sendRedirect(url);
	return;
}
%>
<html>
<head>
<title>PAS-SMP</title>
<link rel='shortcut icon' href='<%=cpath%>/images/icon.png'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/css/main.css'/>
<%--
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/resources/css/ext-all.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/resources/css/xtheme-gray.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/ux/css/RowEditor.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/ux/css/Spinner.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/ux/css/GridSummary.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/ux/css/GroupSummary.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/ux/css/ColumnHeaderGroup.css'/>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/extjs/ux/css/LockingGridView.css'/>
<link rel="stylesheet" type="text/css" href="<%=cpath%>/extjs/ux/gridfilters/css/GridFilters.css" />
<link rel="stylesheet" type="text/css" href="<%=cpath%>/extjs/ux/gridfilters/css/RangeMenu.css" />
<link rel='stylesheet' type='text/css' href='<%=cpath%>/css/all.css'/>
--%>
<link rel='stylesheet' type='text/css' href='<%=cpath%>/css/all.css'/>

<%--
<script type='text/javascript' src='<%=cpath%>/extjs/adapter/ext/ext-base.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ext-all.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/RowEditor.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/Spinner.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/SpinnerField.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/GridSummary.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/GroupSummary.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/ColumnHeaderGroup.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/LockingGridView.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/PagingStore.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/data_drop_plugin/Override.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/data_drop_plugin/Ext.ux.DataDrop.js'></script>
<script type='text/javascript' src='<%=cpath%>/extjs/ux/ext_ux_exporter/Exporter-all.js'></script>
<script type="text/javascript" src="<%=cpath%>/extjs/ux/gridfilters/menu/RangeMenu.js"></script>
<script type="text/javascript" src="<%=cpath%>/extjs/ux/gridfilters/menu/ListMenu.js"></script>
<script type="text/javascript" src="<%=cpath%>/extjs/ux/gridfilters/GridFilters.js"></script>
<script type="text/javascript" src="<%=cpath%>/extjs/ux/gridfilters/filter/Filter.js"></script>
<script type="text/javascript" src="<%=cpath%>/extjs/ux/gridfilters/filter/StringFilter.js"></script>
<script type="text/javascript" src="<%=cpath%>/extjs/ux/gridfilters/filter/DateFilter.js"></script>
<script type="text/javascript" src="<%=cpath%>/extjs/ux/gridfilters/filter/ListFilter.js"></script>
<script type="text/javascript" src="<%=cpath%>/extjs/ux/gridfilters/filter/NumericFilter.js"></script>
<script type="text/javascript" src="<%=cpath%>/extjs/ux/gridfilters/filter/BooleanFilter.js"></script>
--%>
<script type='text/javascript' src='<%=cpath%>/extjs/extjs-ux-all.js'></script>

<%-- Highcharts --%>
<script type='text/javascript' src='<%=cpath%>/extjs/adapter/highcharts/extjs-highcharts-adapter.js'></script>
<script type='text/javascript' src='<%=cpath%>/highcharts/highcharts.js'></script>
<script type='text/javascript' src='<%=cpath%>/highcharts/modules/exporting.js'></script>
<!--[if IE]><script type="text/javascript" src="<%=cpath%>/highcharts/excanvas.compiled.js"></script><![endif]-->
<script type='text/javascript' src='<%=cpath%>/extjs/ux/HighChart.js'></script>

<script>
	var _g_root = '<%= cpath %>'
	var _g_username = "<%= session.getAttribute("user.id") %>"

	Ext.QuickTips.init();
</script>

<script type='text/javascript' src='<%=cpath%>/extjs/ux/Spotlight.js'></script>

<%-- PAS js --%>
<script type='text/javascript' src='<%=cpath%>/js/SHA256.js'></script>
<script type='text/javascript' src='<%=cpath%>/js/all.js'></script>
<script type='text/javascript' src='<%=cpath%>/js/NumericField.js'></script>
<script type='text/javascript' src='<%=cpath%>/js/cbColumn.js'></script>

<%-- all module --%>
<script type='text/javascript' src='<%=cpath%>/module/app_home/layout.js'></script>
<script type='text/javascript' src='<%=cpath%>/module/main/layout.js'></script>
</head>

<body>
<div id='loading-mask'></div>
<div id='loading'>
    <div class="loading-indicator">
        <img src='<%=cpath%>/images/logo.png'
		style='margin-right:8px;' align='absmiddle' />
	<br/>
        Loading&hellip;
    </div>
</div>

<div id='header'>
	<img class='header_logo' src='<%=cpath%>/images/logo.png'/>
	<span class='title'>Paket Aplikasi Sekolah - Sekolah Menengah Pertama</span>
	<span class='subtitle'>Tahun Pelajaran : <%= session.getAttribute("nm.tahun_pelajaran") + "&nbsp;&nbsp" + session.getAttribute("nm.periode_belajar")%> </span>
</div>

<div class='user'>
<span><%= session.getAttribute("user.id")%></span>
&nbsp;&nbsp; | &nbsp;&nbsp;
<a class="logout" href="#" onclick='do_logout()'>Logout</a>
</div>

<div id='msg'></div>
<div id='content'></div>

<div id='footer'>
&copy; 2011 Kementerian Pendidikan & Kebudayaan - Dit.PSMP. Aplikasi ini milik Negara, tidak untuk diperdagangkan.
</div>

</body>
</html>
