<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>

<%@ page import="java.io.IOException" %>
<%@ page import="java.io.StringReader" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.ServletOutputStream" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="org.apache.batik.transcoder.Transcoder" %>
<%@ page import="org.apache.batik.transcoder.TranscoderException" %>
<%@ page import="org.apache.batik.transcoder.TranscoderInput" %>
<%@ page import="org.apache.batik.transcoder.TranscoderOutput" %>
<%@ page import="org.apache.batik.transcoder.image.JPEGTranscoder" %>
<%@ page import="org.apache.batik.transcoder.image.PNGTranscoder" %>
<%@ page import="org.apache.fop.svg.PDFTranscoder" %>

<% try {
String			type	= request.getParameter("type");
String			svg	= request.getParameter("svg");
String			file	= request.getParameter("filename");
String			ext	= "";
Transcoder		t	= null;

ServletOutputStream	httpout	= response.getOutputStream();

if (null == svg) {
	response.setContentType("text/html");
	out.println("Usage:\n\tParameter [svg]: The DOM Element to be converted.\n\tParameter [type]: The destination MIME type for the elment to be transcoded.");
	return;
}
if (null == file) {
	file = "chart";
}
if (null == type) {
	type = "image/png";
}

if (type.equals("image/png")) {
	ext	= "png";
	t	= new PNGTranscoder();
} else if (type.equals("image/jpeg")) {
	ext	= "jpg";
	t	= new JPEGTranscoder();
} else if (type.equals("application/pdf")) {
	ext	= "pdf";
	t	= new PDFTranscoder();
} else if (type.equals("image/svg+xml")) {
	ext	= "svg";
} else {
	/* default to PNG */
	type	= "image/png";
	ext	= "png";
	t	= new PNGTranscoder();
}

response.setHeader("Content-Disposition", "attachment; filename="+ file +"."+ ext);
response.setContentType(type);

if (null != t) {
	TranscoderInput input	= new TranscoderInput(new StringReader(svg));
	TranscoderOutput output	= new TranscoderOutput(httpout);

	t.transcode(input, output);
} else {
	httpout.print(svg);
}

httpout.flush();
httpout.close();

} catch (Exception e) {
	out.print("{success:false, info:\""+ e +"\"}");
}
%>
