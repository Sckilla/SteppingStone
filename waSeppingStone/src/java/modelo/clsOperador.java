/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author dansa
 */
public class clsOperador {
    int F;
    int C;
    int[][] X;
    int[][] Cost;
    String[][] Ind;//W agua, S roca
    int[] SH;
    int[] SV;
    
    List<int[]> Coef;
    List<int[]> Cf;
    List<List<int[]>> W;
    List<List<int[]>> STP;
    Boolean Obt=false;
    Boolean Opt=false;
    
    
    public clsOperador(int f, int c) {
        this.F = f;
        this.C = c;
    }
    
    public int getCoefl(){
        return Cf.size();
    }
    
    public int getCoefx(int id){
        return Cf.get(id)[0];
    }
    
    public int getCoefy(int id){
        return Cf.get(id)[1];
    }
    
    public int getCoefv(int id){
        return Cf.get(id)[2];
    }

    public int getF() {
        return F;
    }

    public void setF(int F) {
        this.F = F;
    }

    public int getC() {
        return C;
    }

    public void setC(int C) {
        this.C = C;
    }

    public Boolean getOpt() {
        return Opt;
    }

    public int[][] getX() {
        return X;
    }

    public void setX() {
        this.X=new int[F][C];
        for(int i=0; i<F; i++){
            for(int j=0; j<C; j++){
                this.X[i][j]=0;
            }
        }
    }

    public int[][] getCost() {
        return Cost;
    }

    public void setCost(String[][] Cost) {
        this.Cost = new int[F][C];
        for(int i=0; i<F; i++){
            for(int j=0; j<C; j++){
                this.Cost[i][j]=Integer.parseInt(Cost[i][j]);
            }
        }
    }

    public String[][] getInd() {
        return Ind;
    }

    public void setInd() {
        this.Ind=new String[F][C];
        for(int i=0; i<F; i++){
            for(int j=0; j<C; j++){
                this.Ind[i][j]="W";
            }
        }
    }

    public int[] getSH() {
        return SH;
    }

    public void setSH(String[] SH) {
        this.SH = new int[SH.length];
        for(int i=0; i<SH.length; i++){
            this.SH[i]=Integer.parseInt(SH[i]);
        }
    }

    public int[] getSV() {
        return SV;
    }

    public void setSV(String[] SV) {
        this.SV = new int[SV.length];
        for(int i=0; i<SV.length; i++){
            this.SV[i]=Integer.parseInt(SV[i]);
        }
    }
    
    
    
    public void cuadrar(){
        int sdh=0;
        int sdv=0;
        int dif;
        for(int i=0; i<F; i++){
            sdh=sdh+SH[i];
        }
        for(int i=0; i<C; i++){
            sdv=sdv+SV[i];
        }
        dif=sdh-sdv;
        if(dif!=0){
            int[][] cost=Cost; 
            if(dif>0){//sdh mayor, agregar agregar columna
                int sv[]=SV;
                SV=new int[C+1];
                for(int i=0;i<C;i++){
                    SV[i]=sv[i];                    
                }
                SV[C]=dif;
                Cost=new int[F][C+1];
                for(int i=0; i<F; i++){
                    for(int j=0; j<C; j++){
                        Cost[i][j]=cost[i][j];
                    }
                }
                for(int i=0; i<F; i++){
                    Cost[i][C]=0;
                }
                C++;
            }else{//sdv mayor, agregar fila
                int sh[]=SH;
                SH=new int[F+1];
                for(int i=0;i<F;i++){
                    SH[i]=sh[i];                    
                }
                SH[F]=dif*-1;
                Cost=new int[F+1][C];
                for(int i=0; i<F; i++){
                    for(int j=0; j<C; j++){
                        Cost[i][j]=cost[i][j];
                    }
                }
                for(int i=0; i<C; i++){
                    Cost[F][i]=0;
                }
                F++;
            }
        }
        setX();
        setInd();
    }
    
    public void primSol(){
        int f=0, c=0;
        int[] sh= new int[SH.length];
        int[] sv= new int[SV.length];
        
        for(int i=0; i<SH.length; i++){
            sh[i]=SH[i];
        }
        for(int i=0; i<SV.length; i++){
            sv[i]=SV[i];
        }
        
        while(f<sh.length && c<sv.length){
            if(sh[f]>sv[c]){//sh mayor
                X[f][c]=sv[c];
                Ind[f][c]="S";
                sv[c]=sv[c]-X[f][c];
                sh[f]=sh[f]-X[f][c];
                c++;
            }else if(sh[f]<sv[c]){//sh menor
                X[f][c]=sh[f];
                Ind[f][c]="S";
                sv[c]=sv[c]-X[f][c];
                sh[f]=sh[f]-X[f][c];
                f++;
            }else{//iguales
                if(f<sh.length-1){
                    X[f][c]=sh[f];
                    Ind[f][c]="S";
                    sv[c]=sv[c]-X[f][c];
                    sh[f]=sh[f]-X[f][c];
                    f++;
                }else{
                    X[f][c]=sv[c];
                    Ind[f][c]="S";
                    sv[c]=sv[c]-X[f][c];
                    sh[f]=sh[f]-X[f][c];
                    c++;
                }
            }
        }
    }
    
    public void shipping(){
        List<int[]> coef;
        STP = new ArrayList<>();
        coef = new ArrayList<>();
        for(int i=0; i<F; i++){
            for(int j=0; j<C; j++){
                if(Ind[i][j].equals("W")){
                    int cv=coefVal(i,j);
                    coef.add(new int[]{i,j,cv});
                    STP.add(new ArrayList<>(Coef));
                }
            }
        }
        Cf=new ArrayList<>(coef);
        int min = 0;
        int nmin = coef.get(0)[2];
        for (int i=1;i<coef.size();i++) {
            if (coef.get(i)[2] < nmin) {
                nmin=coef.get(i)[2];
                min = i;
            }
        }
        Coef=STP.get(min);
        if(coef.get(min)[2]<0){
            nmin=X[Coef.get(1)[0]][Coef.get(1)[1]];
            int mini=1;
            for(int i=3; i<Coef.size(); i+=2){
                if(X[Coef.get(i)[0]][Coef.get(i)[1]]<nmin){
                    nmin=X[Coef.get(i)[0]][Coef.get(i)[1]];
                    mini=i;
                }
            }
            Ind[Coef.get(0)[0]][Coef.get(0)[1]]="S";
            Ind[Coef.get(mini)[0]][Coef.get(mini)[1]]="W";
            for(int i=0; i<Coef.size(); i++){
                X[Coef.get(i)[0]][Coef.get(i)[1]]+=nmin;
                nmin=nmin*-1;
            }
        }else{
            Opt=true;
        }
    }
    
    int coefVal(int f, int c){
        W=new ArrayList<>();
        List<int[]> ux;
        W.add(new ArrayList<>());
        W.get(W.size()-1).add(new int[]{f,c,0});
        Obt=false;
        while(Obt==false){
            int m=obtMenor();
            int l=W.get(m).size()-1;
            int ant=W.get(m).get(l)[2];
            ux=new ArrayList<>(W.get(m));
            W.remove(m);
            switch (ant){
                case 0://inicio
                    derecha(ux);
                    izquierda(ux);
                    arriba(ux);
                    abajo(ux);
                    break;
                case 1://viene de derecha o izquierda
                    arriba(ux);
                    abajo(ux);
                    break;
                case 2://vienede arriba o abajo
                    derecha(ux);
                    izquierda(ux);
                    break;
            }
        }
        int r=0, sig=1;
        for(int i=0; i<Coef.size();i++){
            r=r+sig*Cost[Coef.get(i)[0]][Coef.get(i)[1]];
            sig=sig*-1;
        }
        return r;
    }
    
    int obtMenor(){
        int men=0;
        for(int i=0;i<W.size();i++){
            if(W.get(i).size()<men){
                men=i;
            }
        }
        return men;
    }
    
    int derecha(List<int[]> ca){
//        List<String> ca=W.get(idL);
//        W.remove(idL);
        int f=ca.get(ca.size()-1)[0];
        int c=ca.get(ca.size()-1)[1];
        List<List<int[]>> xu;
        xu = new ArrayList<>();
        for(int i=c+1; i<C; i++){
            if(Ind[f][i].equals("S")){
                xu.add(new ArrayList<>(ca));
                xu.get(xu.size()-1).add(new int[]{f,i,1});
                if(ca.get(0)[1]==i){
                    Coef=new ArrayList<>(xu.get(xu.size()-1));
                    Obt=true;
                }
            }
        }
        for(int j=0; j<xu.size(); j++){
            W.add(new ArrayList<>(xu.get(j)));
        }
        return xu.size();
    }
    
    int izquierda(List<int[]> ca){
//        List<String> ca=W.get(idL);
//        W.remove(idL);
        int f=ca.get(ca.size()-1)[0];
        int c=ca.get(ca.size()-1)[1];
        List<List<int[]>> xu;
        xu = new ArrayList<>();
        for(int i=c-1; i>=0; i--){
            if(Ind[f][i].equals("S")){
                xu.add(new ArrayList<>(ca));
                xu.get(xu.size()-1).add(new int[]{f,i,1});
                if(ca.get(0)[1]==i){
                    Coef=new ArrayList<>(xu.get(xu.size()-1));
                    Obt=true;
                }
            }
        }
        for(int j=0; j<xu.size(); j++){
            W.add(new ArrayList<>(xu.get(j)));
        }
        return xu.size();
    }
    
    int arriba(List<int[]> ca){
//        List<String> ca=W.get(idL);
//        W.remove(idL);
        int f=ca.get(ca.size()-1)[0];
        int c=ca.get(ca.size()-1)[1];
        List<List<int[]>> xu;
        xu = new ArrayList<>();
        for(int i=f-1; i>=0; i--){
            if(Ind[i][c].equals("S")){
                xu.add(new ArrayList<>(ca));
                xu.get(xu.size()-1).add(new int[]{i,c,2});
                if(ca.get(0)[0]==i){
                    Coef=new ArrayList<>(xu.get(xu.size()-1));
                    Obt=true;
                }
            }
        }
        for(int j=0; j<xu.size(); j++){
            W.add(new ArrayList<>(xu.get(j)));
        }
        return xu.size();
    }
    
    int abajo(List<int[]> ca){
//        List<String> ca=W.get(idL);
//        W.remove(idL);
        int f=ca.get(ca.size()-1)[0];
        int c=ca.get(ca.size()-1)[1];
        List<List<int[]>> xu;
        xu = new ArrayList<>();
        for(int i=f+1; i<F; i++){
            if(Ind[i][c].equals("S")){
                xu.add(new ArrayList<>(ca));
                xu.get(xu.size()-1).add(new int[]{i,c,2});
                if(ca.get(0)[0]==i){
                    Coef=new ArrayList<>(xu.get(xu.size()-1));
                    Obt=true;
                }
            }
        }
        for(int j=0; j<xu.size(); j++){
            W.add(new ArrayList<>(xu.get(j)));
        }
        return xu.size();
    }
}