<%-- 
    Document   : showSkills
    Created on : 18-Jun-2016, 22:28:56
    Author     : ccchia.2014
--%>

<%@page import="model.Skill"%>
<%@page import="model.SkillDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Show Skills</title>
    </head>
    <body>
        <%
            String userId = request.getParameter("userId");
            SkillDAO skillDAO = new SkillDAO();
            final ArrayList<String> skillTypes = skillDAO.getSkillTypes();
            for(String type: skillTypes){
                System.out.println("showSkills: " + type);
                ArrayList<Skill> skills = skillDAO.getSkillByType(type);
        %>
        <div>
            <h2><%=type%></h2>
            <p>
                <table>
                    <tr>
                        <td>Level</td>
                        <td>Description</td>
                    </tr>
            <%
                    for(Skill s: skills){
            %>
                    <tr>
                        <td><%= s.getLevel() %></td>
                        <td><%= s.getDescription() %></td>
                    </tr>
            <%
                    }
            %>
                </table>
            </p>
        </div>
        <%
            }
        %>
        <div>
            <form action="overview.jsp" type="post">
                <button type="submit">Back to overview</button>
            </form>
        </div>
    </body>
</html>
