<%-- 
    Document   : index
    Created on : 30/10/2019, 11:30:52 AM
    Author     : dansa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String Error="";
    request.getSession().setAttribute("SH", null);
    request.getSession().setAttribute("SV", null);
    request.getSession().setAttribute("X", null);
    request.getSession().setAttribute("Cost", null);
    request.getSession().setAttribute("Ind", null);
    if(request.getSession().getAttribute("Error")!=null){
        Error=request.getSession().getAttribute("Error").toString();
        request.getSession().setAttribute("Error", null);
    }
    int f=5;
    int c=7;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="cssElestilazoquetevienefiera.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div>
            <h1 style="text-align: center">Stepping Stone</h1>
            <%
                if(Error!=""){
                    out.println("<div style='text-align:center; font-size: 1rem; color:#CB3234'>"+Error+"</div>");
                }
            %>
            <div style="width: auto; margin: 0 auto; justify-content: center">
                
                <form class="datos" name="frmEsp" id="frmEsp" method="post" action="datos.do">
                    <table style="width: auto; margin: 0 auto">
                        <tr>
                            <td colspan="2" style="height: 30px">
                                <p>Define las dimensiones de la tabla</p>
                            </td>
                        </tr>
                        <tr>
                            <td style="min-width: 200px; width: 55%;">
                                Filas:
                            </td>
                            <td style="text-align: left;">
                                <input type="text" id="Filas" name="Filas">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Columnas:
                            </td>
                            <td style="text-align: left;">
                                <input type="text" id="Columnas" name="Columnas">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: center; padding-top: 10px;">
                                <button type="submit" name="FILCOL" id='FILCOL'>Aceptar</button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </body>
</html>
