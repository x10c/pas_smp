<%--
 % Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 %
 % Author(s):
 % + x10c-Lab
 %   - agus sugianto (agus.delonge@gmail.com)
 %   - joko yuniaji
--%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.*" %>
<%
try {
	Connection con = (Connection) session.getAttribute("db.con");

	if (con == null || con.isClosed()) {
		String db_url = (String) session.getAttribute("db.url");

		if (db_url == null) {
			out.print("{success:false, info:'Session anda telah habis!'}");
			return;
		}

		Class.forName("com.mysql.jdbc.Driver");

		con = DriverManager.getConnection(db_url);

		session.setAttribute("db.con", (Object) con);
	}

	Statement	stmt1	= con.createStatement();
	Statement	stmt2	= con.createStatement();
	Statement	stmt3	= con.createStatement();
	Statement	stmt4	= con.createStatement();
	Statement	stmt5	= con.createStatement();
	List		list	= new ArrayList();
	List		list1	= new ArrayList();
	List		list2	= new ArrayList();
	List		list3	= new ArrayList();
	List		list4	= new ArrayList();
	List		list5	= new ArrayList();
	ResultSet	rs1		= null;
	ResultSet	rs2		= null;
	ResultSet	rs3		= null;
	ResultSet	rs4		= null;
	ResultSet	rs5		= null;
	
	
	
	String	user = (String) session.getAttribute("user.id");
	String	q;
	
	q	=" select distinct		a.menu_name, a.menu_folder, a.menu_id, a.menu_leaf, a.menu_kd, a.icon, a.menu_status "
		+" from			__menu		as a"
		+" left join	__hak_akses	as b on b.menu_id = a.menu_id and b.ha_level >= 1 and b.id_grup in (select id_grup from __auth as c where c.username = '" + user + "')"
		+" where		a.menu_parent = '%s' "
		+" order by		a.menu_id ";

		rs1 = stmt1.executeQuery(String.format(q, "00"));
		Map map = new HashMap();
		while (rs1.next()){
			map.put("text", rs1.getString("menu_name"));
			map.put("id", rs1.getString("menu_folder"));
			map.put("iconCls", rs1.getString("icon"));

			if (rs1.getString("menu_status").equals("0")){
				map.put("disabled", Boolean.TRUE);
			}

			rs2 = stmt2.executeQuery(String.format(q, rs1.getString("menu_kd")));
			Map map2 = new HashMap();
			while (rs2.next()) {
				if (rs2.getString("menu_leaf").equals("0")) {
					map2.put("text", rs2.getString("menu_name"));
					map2.put("id", rs2.getString("menu_folder"));
					map2.put("iconCls", rs2.getString("icon"));
					
					if (rs2.getString("menu_status").equals("0")){
						map2.put("disabled", Boolean.TRUE);
					}

					rs3 = stmt3.executeQuery(String.format(q, rs2.getString("menu_kd")));
					Map map3 = new HashMap();
					while (rs3.next()) {
						if (rs3.getString("menu_leaf").equals("0")) {
							map3.put("text", rs3.getString("menu_name"));
							map3.put("id", rs3.getString("menu_folder"));
							map3.put("iconCls", rs3.getString("icon"));
							
							if (rs3.getString("menu_status").equals("0")){
								map3.put("disabled", Boolean.TRUE);
							}

							rs4 = stmt4.executeQuery(String.format(q, rs3.getString("menu_kd")));
							Map map4 = new HashMap();
							while (rs4.next()) {
								if (rs4.getString("menu_leaf").equals("0")) {
									map4.put("text", rs4.getString("menu_name"));
									map4.put("id", rs4.getString("menu_folder"));
									map4.put("iconCls", rs4.getString("icon"));
									
									if (rs4.getString("menu_status").equals("0")){
										map4.put("disabled", Boolean.TRUE);
									}

									rs5 = stmt5.executeQuery(String.format(q, rs4.getString("menu_kd")));
									Map map5 = new HashMap();
									while (rs5.next()) {
										map5.put("text", rs5.getString("menu_name"));
										map5.put("id", rs5.getString("menu_folder"));
										map5.put("menu_id", rs5.getString("menu_id"));
										map5.put("iconCls", rs5.getString("icon"));
										map5.put("leaf", Boolean.TRUE);
										
										if (rs5.getString("menu_status").equals("0")){
											map5.put("disabled", Boolean.TRUE);
										}

										list5.add(map5);
										map5 = new HashMap();
									}
									
									rs5.close();
									
									map4.put("children", list5);
									list5 = new ArrayList();
								} else {
									map4.put("text", rs4.getString("menu_name"));
									map4.put("id", rs4.getString("menu_folder"));
									map4.put("menu_id", rs4.getString("menu_id"));
									map4.put("iconCls", rs4.getString("icon"));
									map4.put("leaf", Boolean.TRUE);
									
									if (rs4.getString("menu_status").equals("0")){
										map4.put("disabled", Boolean.TRUE);
									}

								}
								
								list4.add(map4);
								map4 = new HashMap();
							}
							
							rs4.close();
							
							map3.put("children", list4);
							list4 = new ArrayList();
						} else {
							map3.put("text", rs3.getString("menu_name"));
							map3.put("id", rs3.getString("menu_folder"));
							map3.put("menu_id", rs3.getString("menu_id"));
							map3.put("iconCls", rs3.getString("icon"));
							map3.put("leaf", Boolean.TRUE);
							
							if (rs3.getString("menu_status").equals("0")){
								map3.put("disabled", Boolean.TRUE);
							}
						}
						
						list3.add(map3);
						map3 = new HashMap();
					}
					
					rs3.close();
					
					map2.put("children", list3);
					list3 = new ArrayList();
				} else {
					map2.put("text", rs2.getString("menu_name"));
					map2.put("id", rs2.getString("menu_folder"));
					map2.put("menu_id", rs2.getString("menu_id"));
					map2.put("iconCls", rs2.getString("icon"));
					map2.put("leaf", Boolean.TRUE);	

					if (rs2.getString("menu_status").equals("0")){
						map2.put("disabled", Boolean.TRUE);
					}
				}
				
				list2.add(map2);
				map2 = new HashMap();
			}
			
			rs2.close();
			
			map.put("children", list2);
			list2 = new ArrayList();
			
			list.add(map);
			map = new HashMap();
		}
	
	JSONArray jsonArray = JSONArray.fromObject(list);
	
	rs1.close();	
	
	out.print(jsonArray);
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
