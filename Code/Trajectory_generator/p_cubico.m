function PL=p_cubico(q,t,met,qd)
%Dibuja el resultado de interpolar mediante spline cubico los valores q en
%los instantes tt con las velocidades de paso qd.
% Devuelve un vector con 1 fila por punto con los 
% resultados (t,q,qd,qdd)de muestrear el polinomio interpolador 
% Utiliza la funcion i_cubico que obtiene los valores de los coeficientes
% Las velocidades de paso pueden ser expecificadas o en caso contrario se
% utiliza la expresión [6.8]
% Ejercicio 6.2
%   (c) FUNDAMENTOS DE ROBOTICA   (A. Barrientos) McGrawHill 2007
%________________________________________________________________

 
npuntos=200;  %numero de puntos a pintar por intervalo
n=length(q);    % numero de intervalos
 
PL=[];
% figure;
% hold on
 
% Obtiene los coeficientes de los splines cubicos 
% [ti,tf,a,b,c,d] para cada intervalo
if nargin==4
    P=i_cubico(q,t,qd,met);
else
    P=i_cubico(q,t,met);
end
 

for intervalo=1:n-1
    ti =P(intervalo,1);
    tf =P(intervalo,2);
    a  =P(intervalo,3);
    b  =P(intervalo,4);
    c  =P(intervalo,5);
    d  =P(intervalo,6);
    
    inc=(tf-ti)/npuntos;
    for tt=ti:inc:tf
        qt=a+b*(tt-ti)+c*(tt-ti)^2+d*(tt-ti)^3; 
        qdt=b+2*c*(tt-ti)+3*d*(tt-ti)^2;
        qddt=2*c+6*d*(tt-ti);
        % plot(tt,qt,'k');
        PL=vertcat(PL,[tt,qt,qdt,qddt]);
    end

% plot(t,q,'o');
% grid;
% hold on;
% plot(PL(:,1),PL(:,2),'r');
% hold on;
% plot(PL(:,1),PL(:,3),'b');
% hold on;
% plot(PL(:,1),PL(:,4),'g');
% hold on;
% hold off;  
end


