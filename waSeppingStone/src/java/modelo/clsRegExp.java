/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author dansa
 */
public class clsRegExp {
    public Pattern expresion;
    public Matcher cadena;
    public boolean resVal=false;
    public boolean validarNumeros(String numero){
        //se crea la expresión regular
        expresion=Pattern.compile("-?\\d{1,5}");//
        //se compara la cadena contra la expresión para validar
        
        cadena= expresion.matcher(numero);
        //si cumple el patrón el resultado del
        resVal=cadena.matches();
        return resVal;
    }
    public boolean validarNumerosSS(String numero){
        //se crea la expresión regular
        expresion=Pattern.compile("\\d{1,5}");//
        //se compara la cadena contra la expresión para validar
        
        cadena= expresion.matcher(numero);
        //si cumple el patrón el resultado del
        resVal=cadena.matches();
        return resVal;
    }
}
