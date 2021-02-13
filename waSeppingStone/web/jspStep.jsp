<%-- 
    Document   : jspStep
    Created on : 30/10/2019, 10:04:19 PM
    Author     : dansa
--%>

<%@page import="modelo.clsOperador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int f=Integer.parseInt(request.getSession().getAttribute("f").toString());
    int c=Integer.parseInt(request.getSession().getAttribute("c").toString());
    clsOperador O=new clsOperador(f,c);
    String Error="No se encontraron errores, da click para continuar...";
    if(request.getSession().getAttribute("Error")!=null){
        Error=request.getSession().getAttribute("Error").toString();
        request.getSession().setAttribute("Error", null);
    }
    if(request.getSession().getAttribute("X")!=null || request.getSession().getAttribute("Cost")!=null || request.getSession().getAttribute("Ind")!=null && request.getSession().getAttribute("SH")!=null && request.getSession().getAttribute("SV")!=null){
        O.setX();
        O.setCost((String[][])request.getSession().getAttribute("Cost"));
        O.setInd();
        O.setSV((String[])request.getSession().getAttribute("SV"));
        O.setSH((String[])request.getSession().getAttribute("SH"));
    }else{
        request.getSession().setAttribute("Error", "Ocurrió un error al verificar la sesión");//
        this.getServletConfig().getServletContext().getRequestDispatcher("index.jsp").forward(request, response);
    }
    O.cuadrar();
    String[][] X;
    int[][] Cost=O.getCost();
    String[][] Ind=O.getInd();   
    int[] SH=O.getSH();
    int[] SV=O.getSV();
    f=O.getF();
    c=O.getC();
    request.getSession().setAttribute("O", O);
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
            <h2 style="text-align: center">Stepping Stone</h2>
            <%
                if(Error!=""){
                    out.println("<div style='text-align:center; font-size: 1rem; color:#2f4'>"+Error+"</div>");
                }
            %>
            <div style="width: auto; margin: 0 auto">
                <form name="frmEsp" id="frmEsp" method="post" action="jspSoluc.jsp">
                    <table style="width: auto; margin: 0 auto; text-align: center;">
                    <%
                        for(int i=0; i<f; i++){
                    %>
                    <tr>
                        <%
                            for(int j=0;j<c;j++){
                                %>
                                <td>
                                    <table class="default" style="padding: 5px;">
                                        <tr>
                                            <td style="width: 25px;">
                                                <%out.println("<input type='text' style='width: 100%' id='Ind"+i+j+"' name='Ind"+i+j+"' value='*' readonly disabled>");%>
                                            </td>
                                            <td style="width: 25px;">
                                                <%out.println("<input type='text' style='width: 100%;' id='Cost"+i+j+"' name='Cost"+i+j+"'  value='"+Cost[i][j]+"'>");%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <%out.println("<input type='text' style='width: 100%' id='X"+i+j+"' name='X"+i+j+"' value='X"+i+j+"' readonly disabled>");%>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <%
                                if(j==c-1){
                                    %>
                                    <td class="tot" style="padding: 0 5px 0 5px; width: 50px">
                                        <%out.println("<input type='text' style='height: 100%;' id='SH"+i+"' name='SH"+i+"' value='"+SH[i]+"'>");%>
                                    </td>
                                    <%
                                }
                            }
                        %>
                    </tr>
                    <tr>
                    <%
                        }
                        for(int k=0; k<c; k++){
                    %>
                            <td class="tot" style="padding: 5px; width: 50px"><%
                                out.println("<input type='text' style='height: 100%;' id='SV"+k+"' name='SV"+k+"' value='"+SV[k]+"'>");
                            %></td><%
                        }
                    %>
                    </tr>
                    </table>
                    <div style="width: 10%; margin: 0 auto; padding: 1%">
                        <button type="submit" name="FILCOL" id='FILCOL' style="width: 150px; margin: 0 auto">Continuar</button>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
