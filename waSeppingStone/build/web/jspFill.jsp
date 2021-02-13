<%-- 
    Document   : jspFill
    Created on : 30/10/2019, 11:09:29 AM
    Author     : dansa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int f=Integer.parseInt(request.getSession().getAttribute("f").toString());
    int c=Integer.parseInt(request.getSession().getAttribute("c").toString());
    String Error="";
    String[][] Cost=new String[f][c];
    String[] SH= new String [f];
    String[] SV= new String [c];
    boolean full=false;
    
    if(request.getSession().getAttribute("Error")!=null){
        Error=request.getSession().getAttribute("Error").toString();
        request.getSession().setAttribute("Error", null);
    }
    if(request.getSession().getAttribute("Cost")!=null && request.getSession().getAttribute("SH")!=null && request.getSession().getAttribute("SV")!=null){
        Cost=(String[][])request.getSession().getAttribute("Cost");
        SH=(String[])request.getSession().getAttribute("SH");
        SV=(String[])request.getSession().getAttribute("SV");
        full=true;
    }
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
                    out.println("<div style='text-align:center; font-size: 1rem; color:#CB3234; width:100%; min-width:300px;'>"+Error+"</div>");
                }
            %>
            <div class="petros" style="width: auto; margin: 0 auto">
                <form name="frmEsp" id="frmEsp" method="post" action="datos.do">
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
                                                <%
                                                    if(full){
                                                        if(Cost[i][j].equals("")){
                                                            out.println("<input type='text' style='width: 100%; border-color:#CB3234' id='Cost"+i+j+"' name='Cost"+i+j+"'  value='"+Cost[i][j]+"'>");
                                                        }else{
                                                            out.println("<input type='text' style='width: 100%;' id='Cost"+i+j+"' name='Cost"+i+j+"'  value='"+Cost[i][j]+"'>");
                                                        }
                                                    }else{
                                                        out.println("<input type='text' style='width: 100%' id='Cost"+i+j+"' name='Cost"+i+j+"'>");
                                                    }
                                                %>
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
                                        <%
                                            if(full){
                                                if(SH[i].equals("")){
                                                    out.println("<input type='text' style='height: 100%;' border-color:#CB3234' id='SH"+i+"' name='SH"+i+"' value='"+SH[i]+"'>");
                                                }else{
                                                    out.println("<input type='text' style='height: 100%;' id='SH"+i+"' name='SH"+i+"' value='"+SH[i]+"'>");
                                                }
                                            }else{
                                                out.println("<input type='text' style='height: 100%;' id='SH"+i+"' name='SH"+i+"'>");
                                            }
                                        %>
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
                            if(full){
                                if(SV[k].equals("")){
                                    out.println("<input type='text' style='height: 100%; border-color:#CB3234' id='SV"+k+"' name='SV"+k+"' value='"+SV[k]+"'>");
                                }else{
                                    out.println("<input type='text' style='height: 100%;' id='SV"+k+"' name='SV"+k+"' value='"+SV[k]+"'>");
                                }
                            }else{
                                out.println("<input type='text' style='height: 100%;' id='SV"+k+"' name='SV"+k+"'>");
                            }
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
