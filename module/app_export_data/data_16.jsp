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

File		outputFile	= new File("C:\\16 - " + kd_tahun_ajaran + "_" + npsn + "_A_SEKOLAH_PEGAWAI_11.XML");
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
		+" 		SELECT 		IFNULL(v_pegawai_status.ADMIN_TTP_1_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS TGOL_01_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.ADMIN_TTP_1_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS TGOL_01_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.ADMIN_TTP_2_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS TGOL_02_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.ADMIN_TTP_2_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS TGOL_02_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.ADMIN_TTP_3_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS TGOL_03_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.ADMIN_TTP_3_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS TGOL_03_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.ADMIN_TTP_4_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS TGOL_04_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.ADMIN_TTP_4_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS TGOL_04_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.ADMIN_TTP_Y_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS TGOL_05_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.ADMIN_TTP_Y_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS TGOL_05_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.ADMIN_TAKTTP_PNS_L,0) + IFNULL(v_pegawai_status.ADMIN_TAKTTP_BPNS_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS TGOL_06_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_status.ADMIN_TAKTTP_PNS_P,0) + IFNULL(v_pegawai_status.ADMIN_TAKTTP_BPNS_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_status 	ON v_pegawai_status.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS TGOL_06_P"
		+" ,		0 AS TGOL_07_L"
		+" ,		0 AS TGOL_07_P"
		+" ,		0 AS TGOL_08_L"
		+" ,		0 AS TGOL_08_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_jml_tenaga_adm.KEP_TU_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_jml_tenaga_adm 	ON v_pegawai_jml_tenaga_adm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ADM_01_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_jml_tenaga_adm.KEP_TU_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_jml_tenaga_adm 	ON v_pegawai_jml_tenaga_adm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ADM_01_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_jml_tenaga_adm.BENDAHARA_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_jml_tenaga_adm 	ON v_pegawai_jml_tenaga_adm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ADM_02_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_jml_tenaga_adm.BENDAHARA_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_jml_tenaga_adm 	ON v_pegawai_jml_tenaga_adm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ADM_02_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_jml_tenaga_adm.PETUGAS_INS_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_jml_tenaga_adm 	ON v_pegawai_jml_tenaga_adm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ADM_03_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_jml_tenaga_adm.PETUGAS_INS_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_jml_tenaga_adm 	ON v_pegawai_jml_tenaga_adm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ADM_03_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_jml_tenaga_adm.LABORAN_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_jml_tenaga_adm 	ON v_pegawai_jml_tenaga_adm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ADM_04_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_jml_tenaga_adm.LABORAN_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_jml_tenaga_adm 	ON v_pegawai_jml_tenaga_adm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ADM_04_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_jml_tenaga_adm.PERPUS_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_jml_tenaga_adm 	ON v_pegawai_jml_tenaga_adm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ADM_05_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_jml_tenaga_adm.PERPUS_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_jml_tenaga_adm 	ON v_pegawai_jml_tenaga_adm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ADM_05_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_jml_tenaga_adm.JURU_BENGKEL_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_jml_tenaga_adm 	ON v_pegawai_jml_tenaga_adm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ADM_06_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_jml_tenaga_adm.JURU_BENGKEL_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_jml_tenaga_adm 	ON v_pegawai_jml_tenaga_adm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ADM_06_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_jml_tenaga_adm.JURU_KETIK_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_jml_tenaga_adm 	ON v_pegawai_jml_tenaga_adm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ADM_07_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_jml_tenaga_adm.JURU_KETIK_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_jml_tenaga_adm 	ON v_pegawai_jml_tenaga_adm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ADM_07_P"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_jml_tenaga_adm.PENJAGA_SEK_L,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_jml_tenaga_adm 	ON v_pegawai_jml_tenaga_adm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ADM_08_L"
		+" ,		("
		+" 		SELECT 		IFNULL(v_pegawai_jml_tenaga_adm.PENJAGA_SEK_P,0)"
		+" 		FROM 		r_tahun_ajaran"
		+" 		LEFT JOIN 	v_pegawai_jml_tenaga_adm 	ON v_pegawai_jml_tenaga_adm.KD_TAHUN_AJARAN = r_tahun_ajaran.KD_TAHUN_AJARAN"
		+" 		WHERE 		r_tahun_ajaran.KD_TAHUN_AJARAN 	= '" + kd_tahun_ajaran + "'"
		+" 		) AS ADM_08_P"
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
		outFile.write("<TGOL_01_L>" + rs.getString("TGOL_01_L") + "</TGOL_01_L>" + cLf);
		outFile.write("<TGOL_01_P>" + rs.getString("TGOL_01_P") + "</TGOL_01_P>" + cLf);
		outFile.write("<TGOL_02_L>" + rs.getString("TGOL_02_L") + "</TGOL_02_L>" + cLf);
		outFile.write("<TGOL_02_P>" + rs.getString("TGOL_02_P") + "</TGOL_02_P>" + cLf);
		outFile.write("<TGOL_03_L>" + rs.getString("TGOL_03_L") + "</TGOL_03_L>" + cLf);
		outFile.write("<TGOL_03_P>" + rs.getString("TGOL_03_P") + "</TGOL_03_P>" + cLf);
		outFile.write("<TGOL_04_L>" + rs.getString("TGOL_04_L") + "</TGOL_04_L>" + cLf);
		outFile.write("<TGOL_04_P>" + rs.getString("TGOL_04_P") + "</TGOL_04_P>" + cLf);
		outFile.write("<TGOL_05_L>" + rs.getString("TGOL_05_L") + "</TGOL_05_L>" + cLf);
		outFile.write("<TGOL_05_P>" + rs.getString("TGOL_05_P") + "</TGOL_05_P>" + cLf);
		outFile.write("<TGOL_06_L>" + rs.getString("TGOL_06_L") + "</TGOL_06_L>" + cLf);
		outFile.write("<TGOL_06_P>" + rs.getString("TGOL_06_P") + "</TGOL_06_P>" + cLf);
		outFile.write("<TGOL_07_L>" + rs.getString("TGOL_07_L") + "</TGOL_07_L>" + cLf);
		outFile.write("<TGOL_07_P>" + rs.getString("TGOL_07_P") + "</TGOL_07_P>" + cLf);
		outFile.write("<TGOL_08_L>" + rs.getString("TGOL_08_L") + "</TGOL_08_L>" + cLf);
		outFile.write("<TGOL_08_P>" + rs.getString("TGOL_08_P") + "</TGOL_08_P>" + cLf);
		outFile.write("<ADM_01_L>" + rs.getString("ADM_01_L") + "</ADM_01_L>" + cLf);
		outFile.write("<ADM_01_P>" + rs.getString("ADM_01_P") + "</ADM_01_P>" + cLf);
		outFile.write("<ADM_02_L>" + rs.getString("ADM_02_L") + "</ADM_02_L>" + cLf);
		outFile.write("<ADM_02_P>" + rs.getString("ADM_02_P") + "</ADM_02_P>" + cLf);
		outFile.write("<ADM_03_L>" + rs.getString("ADM_03_L") + "</ADM_03_L>" + cLf);
		outFile.write("<ADM_03_P>" + rs.getString("ADM_03_P") + "</ADM_03_P>" + cLf);
		outFile.write("<ADM_04_L>" + rs.getString("ADM_04_L") + "</ADM_04_L>" + cLf);
		outFile.write("<ADM_04_P>" + rs.getString("ADM_04_P") + "</ADM_04_P>" + cLf);
		outFile.write("<ADM_05_L>" + rs.getString("ADM_05_L") + "</ADM_05_L>" + cLf);
		outFile.write("<ADM_05_P>" + rs.getString("ADM_05_P") + "</ADM_05_P>" + cLf);
		outFile.write("<ADM_06_L>" + rs.getString("ADM_06_L") + "</ADM_06_L>" + cLf);
		outFile.write("<ADM_06_P>" + rs.getString("ADM_06_P") + "</ADM_06_P>" + cLf);
		outFile.write("<ADM_07_L>" + rs.getString("ADM_07_L") + "</ADM_07_L>" + cLf);
		outFile.write("<ADM_07_P>" + rs.getString("ADM_07_P") + "</ADM_07_P>" + cLf);
		outFile.write("<ADM_08_L>" + rs.getString("ADM_08_L") + "</ADM_08_L>" + cLf);
		outFile.write("<ADM_08_P>" + rs.getString("ADM_08_P") + "</ADM_08_P>" + cLf);
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
