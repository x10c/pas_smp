<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
--%>

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
String	kd_tahun_ajaran		= (String) session.getAttribute("kd.tahun_pelajaran");
String	npsn				= request.getParameter("npsn");
String	id_propinsi			= request.getParameter("id_propinsi");
String	id_kabupaten		= request.getParameter("id_kabupaten");
String	id_kecamatan		= request.getParameter("id_kecamatan");

String 	q	= "";
int		iLf	= 10;
char	cLf	= (char)iLf;

File		outputFile	= new File("C:\\18 - " + kd_tahun_ajaran + "_" + npsn + "_A_SEKOLAH_KEUANGAN.XML");
outputFile.createNewFile();
FileWriter	outFile		= new FileWriter(outputFile);

outFile.write("<?xml version='1.0' encoding='UTF-8'?>" + cLf);
try{
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt = db_con.createStatement();
	
	q	=" SELECT	KD_TAHUN_AJARAN"
		+" ,		ID_PROPINSI"
		+" ,		ID_KABUPATEN"
		+" ,		ID_KECAMATAN"
		+" ,		NPSN"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.SALDO_AWAL),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_01"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.TRM_GAJI_KSR_GURU),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_02"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.TRM_GAJI_KSR_PGW),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_03"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.TRM_GAJI_KSR_GURUBANTU),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_04"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.TRM_BOS_REGULER),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_05"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.TRM_BOS_BUKU),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_06"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.TRM_BOMM),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_07"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.TRM_BKM),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_08"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.TRM_BOP),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_09"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.TRM_GJ_PGW),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_10"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.TRM_OPR_HARA),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_11"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.TRM_ADM),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_12"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.TRM_SWASTA_NON),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_13"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.TRM_PANGKAL_BANGKU),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_14"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.TRM_KOMITE),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_15"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.TRM_EKS_KUL),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_16"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.TRM_LAIN),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_17"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.TRM_PROD),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_18"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.TRM_SUMBER_LAIN),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_01_19"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_GURU),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_01"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_DPK),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_02"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_GURU_HON),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_03"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_BANTU),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_04"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_GURU_KESRA),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_05"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_PGW),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_06"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_PGW_HON),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_07"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_PGW_KESRA),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_08"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_PBM),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_09"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_GEDUNG),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_10"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_ALAT),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_11"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_PERABOT),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_12"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_REHAB),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_13"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_BUKU),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_14"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_ADA_LAIN),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_15"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_EKS_KUL),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_16"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_DAYA_JASA),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_17"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_TU_ADM),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_18"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.BYR_LAIN),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_19"
		+" ,		("
		+" 		SELECT		IFNULL(SUM(k_sekolah_keuangan.SALDO_AKHIR),0)"
		+" 		FROM 		k_sekolah_keuangan"
		+" 		WHERE		k_sekolah_keuangan.KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'"
		+" 		) AS KEU_02_20"
		+" FROM	t_sekolah_identitas"
		+" WHERE	KD_TAHUN_AJARAN	= '" + kd_tahun_ajaran + "'";
	
	ResultSet	rs	= db_stmt.executeQuery(q);

	outFile.write("<DATA>" + cLf);
	
	while (rs.next()){
		outFile.write("<DATA_ROW>" + cLf);
		outFile.write("<KD_TAHUN_AJARAN>" + rs.getString("KD_TAHUN_AJARAN") + "</KD_TAHUN_AJARAN>" + cLf);
		outFile.write("<ID_PROPINSI>" + rs.getString("ID_PROPINSI") + "</ID_PROPINSI>" + cLf);
		outFile.write("<ID_KABUPATEN>" + rs.getString("ID_KABUPATEN") + "</ID_KABUPATEN>" + cLf);
		outFile.write("<ID_KECAMATAN>" + rs.getString("ID_KECAMATAN") + "</ID_KECAMATAN>" + cLf);
		outFile.write("<NPSN>" + rs.getString("NPSN") + "</NPSN>" + cLf);
		outFile.write("<KEU_01_01>" + rs.getString("KEU_01_01") + "</KEU_01_01>" + cLf);
		outFile.write("<KEU_01_02>" + rs.getString("KEU_01_02") + "</KEU_01_02>" + cLf);
		outFile.write("<KEU_01_03>" + rs.getString("KEU_01_03") + "</KEU_01_03>" + cLf);
		outFile.write("<KEU_01_04>" + rs.getString("KEU_01_04") + "</KEU_01_04>" + cLf);
		outFile.write("<KEU_01_05>" + rs.getString("KEU_01_05") + "</KEU_01_05>" + cLf);
		outFile.write("<KEU_01_06>" + rs.getString("KEU_01_06") + "</KEU_01_06>" + cLf);
		outFile.write("<KEU_01_07>" + rs.getString("KEU_01_07") + "</KEU_01_07>" + cLf);
		outFile.write("<KEU_01_08>" + rs.getString("KEU_01_08") + "</KEU_01_08>" + cLf);
		outFile.write("<KEU_01_09>" + rs.getString("KEU_01_09") + "</KEU_01_09>" + cLf);
		outFile.write("<KEU_01_10>" + rs.getString("KEU_01_10") + "</KEU_01_10>" + cLf);
		outFile.write("<KEU_01_11>" + rs.getString("KEU_01_11") + "</KEU_01_11>" + cLf);
		outFile.write("<KEU_01_12>" + rs.getString("KEU_01_12") + "</KEU_01_12>" + cLf);
		outFile.write("<KEU_01_13>" + rs.getString("KEU_01_13") + "</KEU_01_13>" + cLf);
		outFile.write("<KEU_01_14>" + rs.getString("KEU_01_14") + "</KEU_01_14>" + cLf);
		outFile.write("<KEU_01_15>" + rs.getString("KEU_01_15") + "</KEU_01_15>" + cLf);
		outFile.write("<KEU_01_16>" + rs.getString("KEU_01_16") + "</KEU_01_16>" + cLf);
		outFile.write("<KEU_01_17>" + rs.getString("KEU_01_17") + "</KEU_01_17>" + cLf);
		outFile.write("<KEU_01_18>" + rs.getString("KEU_01_18") + "</KEU_01_18>" + cLf);
		outFile.write("<KEU_01_19>" + rs.getString("KEU_01_19") + "</KEU_01_19>" + cLf);
		outFile.write("<KEU_02_01>" + rs.getString("KEU_02_01") + "</KEU_02_01>" + cLf);
		outFile.write("<KEU_02_02>" + rs.getString("KEU_02_02") + "</KEU_02_02>" + cLf);
		outFile.write("<KEU_02_03>" + rs.getString("KEU_02_03") + "</KEU_02_03>" + cLf);
		outFile.write("<KEU_02_04>" + rs.getString("KEU_02_04") + "</KEU_02_04>" + cLf);
		outFile.write("<KEU_02_05>" + rs.getString("KEU_02_05") + "</KEU_02_05>" + cLf);
		outFile.write("<KEU_02_06>" + rs.getString("KEU_02_06") + "</KEU_02_06>" + cLf);
		outFile.write("<KEU_02_07>" + rs.getString("KEU_02_07") + "</KEU_02_07>" + cLf);
		outFile.write("<KEU_02_08>" + rs.getString("KEU_02_08") + "</KEU_02_08>" + cLf);
		outFile.write("<KEU_02_09>" + rs.getString("KEU_02_09") + "</KEU_02_09>" + cLf);
		outFile.write("<KEU_02_10>" + rs.getString("KEU_02_10") + "</KEU_02_10>" + cLf);
		outFile.write("<KEU_02_11>" + rs.getString("KEU_02_11") + "</KEU_02_11>" + cLf);
		outFile.write("<KEU_02_12>" + rs.getString("KEU_02_12") + "</KEU_02_12>" + cLf);
		outFile.write("<KEU_02_13>" + rs.getString("KEU_02_13") + "</KEU_02_13>" + cLf);
		outFile.write("<KEU_02_14>" + rs.getString("KEU_02_14") + "</KEU_02_14>" + cLf);
		outFile.write("<KEU_02_15>" + rs.getString("KEU_02_15") + "</KEU_02_15>" + cLf);
		outFile.write("<KEU_02_16>" + rs.getString("KEU_02_16") + "</KEU_02_16>" + cLf);
		outFile.write("<KEU_02_17>" + rs.getString("KEU_02_17") + "</KEU_02_17>" + cLf);
		outFile.write("<KEU_02_18>" + rs.getString("KEU_02_18") + "</KEU_02_18>" + cLf);
		outFile.write("<KEU_02_19>" + rs.getString("KEU_02_19") + "</KEU_02_19>" + cLf);
		outFile.write("<KEU_02_20>" + rs.getString("KEU_02_20") + "</KEU_02_20>" + cLf);
		outFile.write("</DATA_ROW>" + cLf);
	}	
	
	outFile.write("</DATA>" + cLf);
	
	rs.close();
	outFile.close();
}catch (Exception e){
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
	outFile.close();
}
%>
