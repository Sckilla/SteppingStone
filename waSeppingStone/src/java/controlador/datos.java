/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.clsRegExp;

/**
 *
 * @author dansa
 */
public class datos extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        clsRegExp ER=new clsRegExp();
        boolean val=true;
        boolean full=false;
        boolean format=false;
        
        String f;
        String c;
        
        request.getSession().setAttribute("SH", null);
        request.getSession().setAttribute("SV", null);
        request.getSession().setAttribute("X", null);
        request.getSession().setAttribute("Cost", null);
        request.getSession().setAttribute("Ind", null);
            
        if(request.getParameter("Filas")!=null && request.getParameter("Columnas")!=null){
            val=false;
            f=request.getParameter("Filas");
            c=request.getParameter("Columnas");
            request.getSession().setAttribute("f", f);
            request.getSession().setAttribute("c", c);
        }else{
            f=request.getSession().getAttribute("f").toString();
            c=request.getSession().getAttribute("c").toString();
        }
        if(ER.validarNumerosSS(f) && ER.validarNumerosSS(c)){
            String[][] X=new String[Integer.parseInt(f)][Integer.parseInt(c)];
            String[][] Cost=new String[Integer.parseInt(f)][Integer.parseInt(c)];
            String[][] Ind=new String[Integer.parseInt(f)][Integer.parseInt(c)];

            String[] SH= new String [Integer.parseInt(f)];
            String[] SV= new String [Integer.parseInt(c)];

            if(val){
                full=true;
                format=true;
                for(int i=0; i<Integer.parseInt(f);i++){
                    for(int j=0; j<Integer.parseInt(c);j++){
                        if(request.getParameter("Cost"+i+j)==null || request.getParameter("Cost"+i+j).equals("")){
                            Cost[i][j]="";
                            full=false;
                        }else if(!ER.validarNumeros(request.getParameter("Cost"+i+j))){
                            Cost[i][j]="";
                            format=false;
                        }else{
                            Cost[i][j]=request.getParameter("Cost"+i+j);
                        }
                        X[i][j]="";
                        Ind[i][j]="";

                        if(i==Integer.parseInt(f)-1){//VALORES DE ABAJO
                            if(request.getParameter("SV"+j)==null || request.getParameter("SV"+j).equals("")){
                                SV[j]="";
                                full=false;
                            }else if(!ER.validarNumeros(request.getParameter("SV"+j))){
                                SV[j]="";
                                format=false;
                            }else{
                                SV[j]=request.getParameter("SV"+j);
                            }
                        }
                    }// VALORES DE LA DERECHA
                    if(request.getParameter("SH"+i)==null || request.getParameter("SH"+i).equals("")){
                        SH[i]="";
                        full=false;
                    }else if(!ER.validarNumeros(request.getParameter("SH"+i))){
                        SH[i]="";
                        format=false;
                    }else{
                        SH[i]=request.getParameter("SH"+i);
                    }
                }
            }

            if(full && format){
                request.getSession().setAttribute("SH", SH);
                request.getSession().setAttribute("SV", SV);
                request.getSession().setAttribute("X", X);
                request.getSession().setAttribute("Cost", Cost);
                request.getSession().setAttribute("Ind", Ind);
                request.getRequestDispatcher("jspStep.jsp").forward(request, response);
            }else{
                if(val==false){
                    full=true;
                    format=true;
                }else{
                    request.getSession().setAttribute("SH", SH);
                    request.getSession().setAttribute("SV", SV);
                    request.getSession().setAttribute("Cost", Cost);
                }
                if(!full && !format){
                    request.getSession().setAttribute("Error", "Algunos campos están vacíos, no se llenaron o no tenían el formato correcto");// no han sido llenados y no tienen el formato correcto
                }else if(!full){
                    request.getSession().setAttribute("Error", "Algunos campos están vacíos");// no han sido llenados
                }else if(!format){
                    request.getSession().setAttribute("Error", "Algunos campos están vacíos, no tenían el formato correcto");// no tienen el formato correcto
                }else{
                    request.getSession().setAttribute("Error", null);
                }
                request.getRequestDispatcher("jspFill.jsp").forward(request, response);
            }     
        }else{
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }   
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
