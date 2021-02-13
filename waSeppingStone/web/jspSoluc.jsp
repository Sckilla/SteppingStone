<%-- 
    Document   : jspSoluc
    Created on : 17/11/2019, 09:18:51 PM
    Author     : dansa
--%>

<%@page import="modelo.clsOperador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(request.getSession().getAttribute("O")==null){
        request.getSession().setAttribute("Error", "Ocurrió un error al verificar la sesión");//
        this.getServletConfig().getServletContext().getRequestDispatcher("index.jsp").forward(request, response);
    }
    //String Error=request.getSession().getAttribute("Error").toString();
    clsOperador O=(clsOperador)request.getSession().getAttribute("O");
    int[][] X=O.getX();
    int[][] Cost=O.getCost();
    String[][] Ind=O.getInd();   
    int[] SH=O.getSH();
    int[] SV=O.getSV();
    int f=O.getF();
    int c=O.getC();
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
            <div style="width: auto; margin: 0 auto">
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
            </div>
            <br/>
            
            
            <div style="width: auto; margin: 0 auto">
                <table style="width: auto; margin: 0 auto; text-align: center;">
                <%
                    O.primSol();
                    X=O.getX();
                    Ind=O.getInd();
                    for(int i=0; i<f; i++){
                %>
                <tr>
                    <%
                        for(int j=0;j<c;j++){
                            %>
                            <td>
                                <table class="<%out.println(Ind[i][j]);%>" style="padding: 5px;">
                                    <tr>
                                        <td style="width: 25px;">
                                            <%out.println("<input type='text' class='"+Ind[i][j]+"' style='width: 100%' id='Ind"+i+j+"' name='Ind"+i+j+"' value='*' readonly disabled>");%>
                                        </td>
                                        <td style="width: 25px;">
                                            <%out.println("<input type='text' class='"+Ind[i][j]+"' style='width: 100%;' id='Cost"+i+j+"' name='Cost"+i+j+"'  value='"+Cost[i][j]+"' readonly disabled>");%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <%out.println("<input type='text' class='"+Ind[i][j]+"' style='width: 100%' id='X"+i+j+"' name='X"+i+j+"' value='"+X[i][j]+"' readonly disabled>");%>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <%
                            if(j==c-1){
                                %>
                                <td class="tot" style="padding: 0 5px 0 5px; width: 50px">
                                    <%out.println("<input type='text' style='height: 100%;' id='SH"+i+"' name='SH"+i+"' value='"+SH[i]+"' readonly disabled>");%>
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
                            out.println("<input type='text' style='height: 100%;' id='SV"+k+"' name='SV"+k+"' value='"+SV[k]+"' readonly disabled>");
                        %></td><%
                    }
                %>
                </tr>
                </table>
            </div>
            <br/>
            
            
            <%while(O.getOpt()==false){
               O.shipping();
               X=O.getX();
            %>
            <div style="width: auto; margin: 0 auto;">
                <table style="width: auto; margin: 0 auto; text-align: center;">
                <%
                    for(int i=0; i<f; i++){
                %>
                <tr>
                    <%
                        for(int j=0;j<c;j++){
                            %>
                            <td>
                                <table class="<%out.println(Ind[i][j]);%>" style="padding: 5px;">
                                    <tr>
                                        <td style="width: 25px;">
                                            <%out.println("<input type='text' class='"+Ind[i][j]+"' style='width: 100%' id='Ind"+i+j+"' name='Ind"+i+j+"' value='*' readonly disabled>");%>
                                        </td>
                                        <td style="width: 25px;">
                                            <%out.println("<input type='text' class='"+Ind[i][j]+"' style='width: 100%;' id='Cost"+i+j+"' name='Cost"+i+j+"'  value='"+Cost[i][j]+"' readonly disabled>");%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <%out.println("<input type='text' class='"+Ind[i][j]+"' style='width: 100%' id='X"+i+j+"' name='X"+i+j+"' value='"+X[i][j]+"' readonly disabled>");%>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <%
                            if(j==c-1){
                                %>
                                <td class="tot" style="padding: 0 5px 0 5px; width: 50px">
                                    <%out.println("<input type='text' style='height: 100%;' id='SH"+i+"' name='SH"+i+"' value='"+SH[i]+"' readonly disabled>");%>
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
                            out.println("<input type='text' style='height: 100%;' id='SV"+k+"' name='SV"+k+"' value='"+SV[k]+"' readonly disabled>");
                        %></td><%
                    }
                %>
                </tr>
                </table>
            
            </div>
            <div class="cf">
            <%
                int len=O.getCoefl();
                for(int i=0; i<len; i++){
                    out.println("<div>X"+O.getCoefx(i)+O.getCoefy(i)+" = "+O.getCoefv(i)+"</div>");
                }
            %>
            </div>
            <div style="display: flex; text-align: center; width: 70%">...</div>
            <%}%>
        </div>
    </body>
</html>
