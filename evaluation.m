function [fap sumr]=evaluation(p)
%Esta función evalua la funcion objetivo del problema de optimización
%del griper de  pinza. Dicha funcion es la diferencia entre las fuerzas de agarre
%entre la minima y maxima posicion

%La entrada de la función es el conjunto de las 8 variables de diseño
% y tiene el siguiente orden: p=[r1, r2min, r2max, r3, r4,r0,rf,teta1]

% Edgar Alfredo Portilla Flores
%5 de marzo de 2015

%Esta es la variable donde se almacenan las violaciones de las restricciones
svr=0;

%Parametros del objeto de agarre
R2max=50;
Xmin=20;
Xmax=150;
XG=200;

%Calculos para la posicion minima de r2
Amin=2*p(4)*(p(6)+p(1)*cos(p(8)));
Bmin=2*p(4)*(p(1)*sin(p(8))-p(2));
Cmin=p(6)^2+p(1)^2+p(2)^2+p(4)^2-p(5)^2+2*p(6)*p(1)*cos(p(8))-2*p(1)*p(2)*sin(p(8));
teta3min1=2*atan((-Bmin-sqrt(Bmin^2+Amin^2-Cmin^2))/(Cmin-Amin));
teta3min2=2*atan((-Bmin+sqrt(Bmin^2+Amin^2-Cmin^2))/(Cmin-Amin));

Dmin=-2*p(5)*(p(6)+p(1)*cos(p(8)));
Emin=2*p(5)*(p(2)-p(1)*sin(p(8)));
Fmin=p(6)^2+p(1)^2+p(2)^2+p(5)^2-p(4)^2+2*p(6)*p(1)*cos(p(8))-2*p(1)*p(2)*sin(p(8));
teta4min1=2*atan((-Emin+sqrt(Emin^2+Dmin^2-Fmin^2))/(Fmin-Dmin));
teta4min2=2*atan((-Emin-sqrt(Emin^2+Dmin^2-Fmin^2))/(Fmin-Dmin));

%Calculos para la posicion maxima de r2
Amax=2*p(4)*(p(6)+p(1)*cos(p(8)));
Bmax=2*p(4)*(p(1)*sin(p(8))-p(3));
Cmax=p(6)^2+p(1)^2+p(3)^2+p(4)^2-p(5)^2+2*p(6)*p(1)*cos(p(8))-2*p(1)*p(3)*sin(p(8));
teta3max1=2*atan((-Bmax-sqrt(Bmax^2+Amax^2-Cmax^2))/(Cmax-Amax));
teta3max2=2*atan((-Bmax+sqrt(Bmax^2+Amax^2-Cmax^2))/(Cmax-Amax));

Dmax=-2*p(5)*(p(6)+p(1)*cos(p(8)));
Emax=2*p(5)*(p(3)-p(1)*sin(p(8)));
Fmax=p(6)^2+p(1)^2+p(3)^2+p(5)^2-p(4)^2+2*p(6)*p(1)*cos(p(8))-2*p(1)*p(3)*sin(p(8));
teta4max1=2*atan((-Emax+sqrt(Emax^2+Dmax^2-Fmax^2))/(Fmax-Dmax));
teta4max2=2*atan((-Emax-sqrt(Emax^2+Dmax^2-Fmax^2))/(Fmax-Dmax));

%Se toman los valores teta3min2,teta4min2,teta3max2,teta4max2

%verificamos que los angulos sean reales
verifica1=isreal(teta3min2);
verifica2=isreal(teta4min2);
verifica3=isreal(teta3max2);
verifica4=isreal(teta4max2);

if (verifica1~=0 && verifica2~=0 && verifica3~=0 && verifica4~=0)
   %Calculamos las demas restricciones
   Pxmin=p(1)*cos(p(8))+p(7)*cos(teta3min2);
   Pymin=p(1)*sin(p(8))+p(7)*sin(teta3min2);
   Pxmax=p(1)*cos(p(8))+p(7)*cos(teta3max2);
   Pymax=p(1)*sin(p(8))+p(7)*sin(teta3max2);
   
   %Se evaluan las demas restricciones
   g1=abs(Pxmin)-Xmin;
   if g1>Xmin
       svr=svr+g1;
   end
   g2=-abs(Pxmin);
   if g2>0
       svr=svr+g2;
   end
   g3=abs(Pxmax)-XG;
   if g3>0
       svr=svr+g3;
   end
   g4=Xmax-abs(Pxmax);
   if g4>0
       svr=svr+g4;
   end
   g5=Xmax+R2max-Pymax;
   if g5>0
       svr=svr+g5;
   end
   g6=p(2)-p(3);
   if g6>0
       svr=svr+g6;
   end
   g7=p(4)-p(7);
   if g7>0
       svr=svr+g7;
   end
   %Calculo de la funcion objetivo si el individuo es factible
   
   if (svr==0)
       tetamin=pi-teta4min2;
       tetamax=pi-teta4max2;
       FTmin=(p(4)*sin(tetamin+teta3min2))/(2*p(7)*sin(teta3min2)*sin(tetamin));
       FTmax=(p(4)*sin(tetamax+teta3max2))/(2*p(7)*sin(teta3max2)*sin(tetamax));
       fap=(FTmin-FTmax)^2;
       sumr=svr;
   else
       sumr=svr;
       fap=1000;
   end
 else
    fap=1000;
    sumr=1000;
end
