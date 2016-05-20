<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.util.*" %>
      <%@ page import="java.util.Date" %>
           <%@ include file="Session.jsp" %>
       <%@ page errorPage="Error.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%!HashMap<String, Date> map;%>
<%
Connection con;
Statement st;
ResultSet rs;
RequestDispatcher rd;

String name=request.getParameter("uname");
String pass=request.getParameter("pass");
pageContext.setAttribute("uname",name,PageContext.SESSION_SCOPE);

try {
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
	System.out.println("connection");
	st=con.createStatement();
	rs=st.executeQuery("select * from login where uname='"+name+"'and pass='"+pass+"'");
	System.out.println("connection");
	if(map ==null)
	{
	 map=new HashMap<String, Date>();
	}
	Date d=new Date(session.getCreationTime());
	
	if(rs.next())
	{
		pageContext.setAttribute("uname",PageContext.SESSION_SCOPE); 

		String type=rs.getString(3);
		if(type.equals("admin"))
			{
				map.put(name, d);
				session.setAttribute("map", map);
				rd=request.getRequestDispatcher("AdminHome.jsp");
				rd.forward(request, response);
			}
			else if(type.equals("user"))
			{
				map.put(name, d);
				session.setAttribute("map", map);
				rd=request.getRequestDispatcher("UserHome.jsp");
				rd.forward(request, response);
			}
			else
			{
				rd=request.getRequestDispatcher("Relogin.jsp");
				rd.forward(request, response);
			}
	
	}
}
catch(Exception e)
{
	rd=request.getRequestDispatcher("Error.jsp");
	rd.forward(request, response);
	}
%>

 </body>
</html>