<%-- 
    Document   : showSkills
    Created on : 18-Jun-2016, 22:28:56
    Author     : ccchia.2014
--%>

<%@page import="java.util.HashMap"%>
<%@page import="model.UserDAO"%>
<%@page import="model.Skill"%>
<%@page import="model.SkillDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css">
        <title>Show Skills</title>
    </head>
    <body>
        <%
            String userId = request.getParameter("userId");
            SkillDAO skillDAO = new SkillDAO();
            UserDAO userDAO = new UserDAO();
            HashMap<String,Integer> skillLevels = userDAO.getSkillLevels(userId);
            if(null == skillLevels){
                session.setAttribute("displayMessage","Unknown ID! Please try again!");
                session.setAttribute("userId", null);
                response.sendRedirect("overview.jsp");
                return;
            }
            final ArrayList<String> skillTypes = skillDAO.getSkillTypes();
        %>
        <div class="main" style="overflow:scroll">
            <table>
                <%
                    for(String type: skillTypes){
                        ArrayList<Skill> skills = skillDAO.getSkillByType(type);
                        int userLevel = skillLevels.get(type);
                %>
                <tr>
                    <td class="centered" colspan="3"><u><%=type%></u></td>
                </tr>
                <%
                        for(Skill s: skills){
                            int skillLevel = s.getLevel();
                %>
                        <tr>
                            <td class="alignRight">Level <%= skillLevel %>: </td>
                            <td class="alignLeft" <% if(userLevel >= skillLevel) out.print("style=\"color:green;\""); else out.print("style=\"color:red;\"");%> ><%= s.getDescription() %></td>
                            <td class="centered">Cost: <% if(skillLevel == 1) out.print("25"); else if (skillLevel == 2) out.print("50"); else out.print(100); %> Points</td>
                        </tr>
                <%
                        }
                %>
                        <tr>
                            <td class="spacer" colspan="3"></td>
                        </tr>
                <%
                    }
                %>
            </table>
        </div>
        <div class="footer">
            <form action="overview.jsp" method="post">
                <button type="submit">Back</button>
            </form>
        </div>
    </body>
</html>
