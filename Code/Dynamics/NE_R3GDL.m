% Ejemplo de la utilización del algoritmo de Newton Euler para la dinámica
% de un robot de 3 DGL
% M.G. Ortega (2020)
% Modificado C. Vivas (2023)
% Modificado Alejandro Noci (2025-2026)

clear
clc
% Elegir entre R (rotación) y P (prismática)
Tipo_Q1 = 'R'; % A modo de ejemplo
Tipo_Q2 = 'P';
Tipo_Q3 = 'R';
Tipo_Q4 = 'R';
Tipo_Q5 = 'P';

if ( (Tipo_Q1 ~= 'R') & (Tipo_Q1 ~='P')); error('Elegir R o P para Tipo_Q1'); end
if ( (Tipo_Q2 ~= 'R') & (Tipo_Q2 ~='P')); error('Elegir R o P para Tipo_Q2'); end
if ( (Tipo_Q3 ~= 'R') & (Tipo_Q3 ~='P')); error('Elegir R o P para Tipo_Q3'); end
if ( (Tipo_Q4 ~= 'R') & (Tipo_Q4 ~='P')); error('Elegir R o P para Tipo_Q4'); end
if ( (Tipo_Q5 ~= 'R') & (Tipo_Q5 ~='P')); error('Elegir R o P para Tipo_Q5'); end


% Definición de variables simbólicas
syms T1 T2 T3 T4 T5 q1 qd1 qdd1 q2 qd2 qdd2 q3 qd3 qdd3 q4 qd4 qdd4 q5 qd5 qdd5 real  
PI = sym(pi); % Importante para cáculo simbólico

% Definición de constantes simbólicas
syms L0 Lcp m Mt Mcp J0 g real
syms jm1 jm2 jm3 jm4 jm5 bm1 bm2 bm3 bm4 bm5 real

% DATOS CINEMÁTICOS DEL BRAZO DEL ROBOT

% Elección entre modelo simplificado (S) o completo (C)
  Tipo_modelo = 'C';
  if ( (Tipo_modelo ~= 'S') & (Tipo_modelo ~='C')); error('Elegir S o C para Tipo_modelo'); end


  if (Tipo_modelo=='S') % Comprobar todas las ecuaciones
      L0=0; 
      L1B=0;
      L1A=0;
      L2=0;

  % DATOS DINÁMICOS DEL BRAZO DEL ROBOT
    % Eslabón 0 (fijo. No hace falta especificarlo porque no se mueve respecto al sistema Base B)
      m0= 0; % kg
      s00 = [0,0,-L0/2]'; % m
      I00=zeros(3); % kg.m2
    
    % Eslabón 1, Pluma, J0 masa equivalente de la grúa en el
    % extremo
      m1= 1; % kg
      s11 = [ 0,  0, L1B/2]'; % m
      I11=[ J0,  0,  0; 0,  J0, 0; 0, 0, J0]; % kg.m2 
    
    % Eslabón 2
      m2= Mt; % kg
      s22 = [ 0,  0, 0]'; % m
      I22= zeros(3); % kg.m2
    
    % Eslabón 3
      m3= 0; % kg
      s33 = [ 0,  0, 0]'; % m
      I33= zeros(3); % kg.m2
    
    % Eslabón 4
      m4= 0; % kg
      s44 = [ 0,  0, 0]'; % m
      I44= zeros(3); % kg.m2
    
    % Eslabón 5
      m5= m; % kg
      s55 = [ 0,  0, L2/2]'; % m 
      I55= zeros(3); % kg.m2
    
      R1=1;
      R2=1;
      R5=1;
  else 
      syms L0 L1A L1B L2 M1 M0 M5 R1 R2 R5 R real

      L0=L0; 
      L1B=L1B;
      L1A=L1A;
      L2=L2;

  % DATOS DINÁMICOS DEL BRAZO DEL ROBOT
    % Eslabón 0 (fijo. No hace falta especificarlo porque no se mueve respecto al sistema Base B)
      m0= M0; % kg
      s00 = [ 0,  0, -L0/2]'; % m
      I00=[ m0*L0^2/12,           0,          0; 
                       0,  m0*L0^2/12,          0; 
                       0,           0,  m0*R^2]; % kg.m2
    
    % Eslabón 1, pluma
      m1= M1 + Mcp; % kg
      s11 = [ 0,  0, L1B/2]'; % m
      I11g= [ m1*L1B^2/12,           0,          0;        
               0,  m1*L1B^2/12,          0; 
               0,           0,  m1*R^2]; % kg.m2 
      I11= I11g + Steiner([0, 0, Lcp+L1B/2],zeros(3),Mcp); % kg.m2 

    % Eslabón 2
      m2= Mt; % kg
      s22 = [ 0,  0, 0]'; % m
      I22= zeros(3); % kg.m2

    % Eslabón 3
      m3= 0; % kg
      s33 = [ 0,  0, 0]'; % m
      I33= zeros(3); % kg.m2
    
    % Eslabón 4
      m4= 0; % kg
      s44 = [ 0,  0, 0]'; % m
      I44= zeros(3); % kg.m2
    
    % Eslabón 5
      m5= m + M5; % kg
      s55 = [ 0,  0, L2/2]'; % m           

      I55g= [ m5*L2^2/12,           0,      0;         
                       0,  m5*L2^2/12,      0; 
                       0,           0,     0]; % kg.m2 
      I55= I55g + Steiner(-s55',zeros(3),m); % kg.m2
  end
  
% Parámetros de Denavit-Hartenberg (utilizado en primera regla de Newton-Euler)
% Eslabón base
  theta0=0; d0=L0; a0=0; alpha0=0;
% Eslabón 1:
  theta1= q1+PI/2; d1= 0; a1= 0; alpha1= PI/2;
% Eslabón 2:
  theta2= -PI/2; d2= L1A+q2; a2= 0; alpha2= PI/2;
% Eslabón 3:
  theta3= q3; d3= 0; a3= 0; alpha3= PI/2;
% Eslabón 4:
  theta4= q4+PI/2; d4= 0; a4= 0; alpha4= PI/2;
% Eslabón 5:
  theta5= 0; d5= q5; a5= 0; alpha5= 0;
% Entre eslabón 5 y marco donde se ejerce la fuerza (a definir según
% experimento)
  theta6= 0; d6= L2; a6= 0; alpha6= 0;

% DATOS DE LOS MOTORES
% Inercias
  Jm1=jm1 ; Jm2=jm2 ; Jm3=jm3 ; Jm4=jm4 ; Jm5=jm5 ; % kg.m2
% Coeficientes de fricción viscosa
  Bm1= bm1; Bm2= bm2; Bm3= bm3; Bm4= bm4; Bm5= bm5; % N.m / (rad/s)
% Factores de reducción
  R1= R1; R2= R2; R3= 1; R4= 1; R5= R5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ALGORÍTMO DE NEWTON-EULER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% wij : velocidad angular absoluta de eje j expresada en i
% wdij : aceleración angular absoluta de eje j expresada en i
% vij : velocidad lineal absoluta del origen del marco j expresada en i
% vdij : aceleración lineal absoluta del origen del marco j expresada en i
% aii : aceleración del centro de gravedad del eslabón i, expresado en i?

% fij : fuerza ejercida sobre la articulación j-1 (unión barra j-1 con j),
% expresada en i-1
%
% nij : par ejercido sobre la articulación j-1 (unión barra j-1 con j),
% expresada en i-1

% pii : vector (libre) que une el origen de coordenadas de i-1 con el de i,
% expresadas en i : [ai, di*sin(alphai), di*cos(alphai)] (a,d,aplha: parámetros de DH)
%
% sii : coordenadas del centro de masas del eslabón i, expresada en el sistema
% i

% Iii : matriz de inercia del eslabón i expresado en un sistema paralelo al
% i y con el origen en el centro de masas del eslabón
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% N-E 1: Asignación a cada eslabón de sistema de referencia de acuerdo con las normas de D-H.
% Eslabón 0:
    p00 = [a0, d0*sin(alpha0), d0*cos(alpha0)]';  
% Eslabón 1:
    p11 = [a1, d1*sin(alpha1), d1*cos(alpha1)]';   
  % Eslabón 2:
    p22 = [a2, d2*sin(alpha2), d2*cos(alpha2)]'; 
  % Eslabón 3:
    p33 = [a3, d3*sin(alpha3), d3*cos(alpha3)]'; 
  % Eslabón 4:
    p44 = [a4, d4*sin(alpha4), d4*cos(alpha4)]';
  % Eslabón 5:
    p55 = [a5, d5*sin(alpha5), d5*cos(alpha5)]';
  % Eslabón 6
    p66 = [a6, d6*sin(alpha6), d6*cos(alpha6)]';

% N-E 2: Condiciones iniciales de la base
%   w00=[0 0 0]';
%   wd00 = [0 0 0]';
%   v00 = [0 0 0]';
%   vd00 = [0 0 g]'; % Aceleración de la gravedad en el eje Z0 negativo

  wBB=[0 0 0]';
  wdBB = [0 0 0]';
  vBB = [0 0 0]';
  vdBB = [0 0 g]'; % Aceleración de la gravedad en el eje Z0 negativo

% Condiciones iniciales para el extremo del robot
  f66= [0 0 0]';
  n66= [0 0 0]';

%% Definición de vector local Z
  Z=[0 0 1]';


% N-E 3: Obtención de las matrices de rotación (i)R(i-1) y de sus inversas
  RB0=[cos(theta0) -cos(alpha0)*sin(theta0) sin(alpha0)*sin(theta0);
      sin(theta0)  cos(alpha0)*cos(theta0)  -sin(alpha0)*cos(theta0);
      0            sin(alpha0)                cos(alpha0)           ];
  R0B= RB0';

  R01=[cos(theta1) -cos(alpha1)*sin(theta1) sin(alpha1)*sin(theta1);
      sin(theta1)  cos(alpha1)*cos(theta1)  -sin(alpha1)*cos(theta1);
      0            sin(alpha1)                cos(alpha1)           ];
  R10= R01';

  R12=[cos(theta2) -cos(alpha2)*sin(theta2) sin(alpha2)*sin(theta2);
      sin(theta2)  cos(alpha2)*cos(theta2)  -sin(alpha2)*cos(theta2);
      0            sin(alpha2)              cos(alpha2)           ];
  R21= R12';

  R23=[cos(theta3) -cos(alpha3)*sin(theta3) sin(alpha3)*sin(theta3);
      sin(theta3)  cos(alpha3)*cos(theta3)  -sin(alpha3)*cos(theta3);
      0            sin(alpha3)              cos(alpha3)           ];
  R32= R23';

  R34=[cos(theta4) -cos(alpha4)*sin(theta4) sin(alpha4)*sin(theta4);
      sin(theta4)  cos(alpha4)*cos(theta4)  -sin(alpha4)*cos(theta4);
      0            sin(alpha4)              cos(alpha4)           ];
  R43= R34';

  R45=[cos(theta5) -cos(alpha5)*sin(theta5) sin(alpha5)*sin(theta5);
      sin(theta5)  cos(alpha5)*cos(theta5)  -sin(alpha5)*cos(theta5);
      0            sin(alpha5)              cos(alpha5)           ];
  R54= R45';

  R56=[cos(theta6) -cos(alpha6)*sin(theta6) sin(alpha6)*sin(theta6);
      sin(theta6)  cos(alpha6)*cos(theta6)  -sin(alpha6)*cos(theta6);
      0            sin(alpha6)              cos(alpha6)           ];
  R65= R56';


%%%%%%% ITERACIÓN HACIA EL EXTERIOR (CINEMÁTICA)

% N-E 4: Obtención de las velocidades angulares absolutas
% Articulación 0
    w00 = R0B*wBB;
 % Articulación 1
    if (Tipo_Q1=='R');
        w11= R10*(w00+Z*qd1);  % Si es de rotación
    else
        w11 = R10*w00;      % Si es de translación
    end
 % Articulación 2
    if (Tipo_Q2=='R');
        w22= R21*(w11+Z*qd2);  % Si es de rotación
    else
        w22 = R21*w11;      % Si es de translación
    end
 % Articulación 3
    if (Tipo_Q3=='R');
        w33= R32*(w22+Z*qd3);  % Si es de rotación
    else
        w33 = R32*w22;      % Si es de translación
    end

% Articulación 4
    if (Tipo_Q4=='R');
        w44= R43*(w33+Z*qd4);  % Si es de rotación
    else
        w44 = R43*w33;      % Si es de translación
    end
% Articulación 5
    if (Tipo_Q5=='R');
        w55= R54*(w44+Z*qd5);  % Si es de rotación
    else
        w55 = R54*w44;      % Si es de translación
    end    

% N-E 5: Obtención de las aceleraciones angulares absolutas
% Articulación 0
        wd00 = R0B*wdBB;
 % Articulación 1
    if (Tipo_Q1=='R');
        wd11 = R10*(wd00+Z*qdd1+cross(w00,Z*qd1));  % si es de rotación
    else
        wd11 = R10*wd00;                            % si es de translación
    end
 % Articulación 2
     if (Tipo_Q2=='R');
         wd22 = R21*(wd11+Z*qdd2+cross(w11,Z*qd2));  % si es de rotación
     else
         wd22 = R21*wd11;                            % si es de translación
     end
 % Articulación 3
     if (Tipo_Q3=='R');
         wd33 = R32*(wd22+Z*qdd3+cross(w22,Z*qd3));  % si es de rotación
     else
         wd33 = R32*wd22;                            % si es de translación
     end
 
 % Articulación 4
     if (Tipo_Q4=='R');
         wd44 = R43*(wd33+Z*qdd4+cross(w33,Z*qd4));  % si es de rotación
     else
         wd44 = R43*wd33;                            % si es de translación
     end

 % Articulación 5
     if (Tipo_Q5=='R');
         wd55 = R54*(wd44+Z*qdd5+cross(w44,Z*qd5));  % si es de rotación
     else
         wd55 = R54*wd44;                            % si es de translación
     end

% N-E 6: Obtención de las aceleraciones lineales de los orígenes de los
% sistemas
 % Articulación 0
     vd00 = cross(wd00,p00)+cross(w00,cross(w00,p00))+R0B*vdBB;
 % Articulación 1
     if (Tipo_Q1=='R');
         vd11 = cross(wd11,p11)+cross(w11,cross(w11,p11))+R10*vd00;  % si es de rotación
     else
         vd11 = R10*(Z*qdd1+vd00)+cross(wd11,p11)+2*cross(w11,R10*Z*qd1) + cross(w11,cross(w11,p11));    % si es de translación
     end
 % Articulación 2
     if (Tipo_Q2=='R');
         vd22 = cross(wd22,p22)+cross(w22,cross(w22,p22))+R21*vd11;  % si es de rotación
     else
         vd22 = R21*(Z*qdd2+vd11)+cross(wd22,p22)+2*cross(w22,R21*Z*qd2) + cross(w22,cross(w22,p22));    % si es de translación
     end
 % Articulación 3
     if (Tipo_Q3=='R');
         vd33 = cross(wd33,p33)+cross(w33,cross(w33,p33))+R32*vd22;  % si es de rotación
     else
        vd33 = R32*(Z*qdd3+vd22)+cross(wd33,p33)+2*cross(w33,R32*Z*qd3) + cross(w33,cross(w33,p33));    % si es de translación
     end

 % Articulación 4
     if (Tipo_Q4=='R');
         vd44 = cross(wd44,p44)+cross(w44,cross(w44,p44))+R43*vd33;  % si es de rotación
     else
        vd44 = R43*(Z*qdd4+vd33)+cross(wd44,p44)+2*cross(w44,R43*Z*qd4) + cross(w44,cross(w44,p44));    % si es de translación
     end

 % Articulación 5
     if (Tipo_Q5=='R');
         vd55 = cross(wd55,p55)+cross(w55,cross(w55,p55))+R54*vd44;  % si es de rotación
     else
        vd55 = R54*(Z*qdd5+vd44)+cross(wd55,p55)+2*cross(w55,R54*Z*qd5) + cross(w55,cross(w55,p55));    % si es de translación
     end

% N-E 7: Obtención de las aceleraciones lineales de los centros de gravedad
    a00 = cross(wd00,s00)+cross(w00,cross(w00,s00))+vd00;
    a11 = cross(wd11,s11)+cross(w11,cross(w11,s11))+vd11;
    a22 = cross(wd22,s22)+cross(w22,cross(w22,s22))+vd22;
    a33 = cross(wd33,s33)+cross(w33,cross(w33,s33))+vd33;
    a44 = cross(wd44,s44)+cross(w44,cross(w44,s44))+vd44;
    a55 = cross(wd55,s55)+cross(w55,cross(w55,s55))+vd55;


%%%%%%% ITERACIÓN HACIA EL INTERIOR (DINÁMICA)

% N-E 8: Obtención de las fuerzas ejercidas sobre los eslabones
  f55=R56*f66+m5*a55;
  f44=R45*f55+m4*a44;
  f33=R34*f44+m3*a33;
  f22=R23*f33+m2*a22;
  f11=R12*f22+m1*a11;
  f00=R01*f11+m0*a00;
  fBB=RB0*f00;


% N-E 9: Obtención de los pares ejercidas sobre los eslabones
  n55 = R56*(n66+cross(R65*p55,f66))+cross(p55+s55,m5*a55)+I55*wd55+cross(w55,I55*w55);
  n44 = R45*(n55+cross(R54*p44,f55))+cross(p44+s44,m4*a44)+I44*wd44+cross(w44,I44*w44);
  n33 = R34*(n44+cross(R43*p33,f44))+cross(p33+s33,m3*a33)+I33*wd33+cross(w33,I33*w33);
  n22 = R23*(n33+cross(R32*p22,f33))+cross(p22+s22,m2*a22)+I22*wd22+cross(w22,I22*w22);
  n11 = R12*(n22+cross(R21*p11,f22))+cross(p11+s11,m1*a11)+I11*wd11+cross(w11,I11*w11);
  n00 = R01*(n11+cross(R10*p00,f11))+cross(p00+s00,m0*a00)+I00*wd00+cross(w00,I00*w00);
  nBB = RB0*n00;

% N-E 10: Obtener la fuerza o par aplicado sobre la articulación
  N5z = n55'*R54*Z;  % Si es de rotación
  N5  = n55'*R54;    % Para ver todos los pares, no solo el del eje Z
  F5z = f55'*R54*Z;  % Si es de translacion;
  F5  = f55'*R54;    % Para ver todas las fuerzas, no solo la del eje Z
  N4z = n44'*R43*Z;  % Si es de rotación
  N4  = n44'*R43;    % Para ver todos los pares, no solo el del eje Z
  F4z = f44'*R43*Z;  % Si es de translacion;
  F4  = f44'*R43;    % Para ver todas las fuerzas, no solo la del eje Z
  N3z = n33'*R32*Z;  % Si es de rotación
  N3  = n33'*R32;    % Para ver todos los pares, no solo el del eje Z
  F3z = f33'*R32*Z;  % Si es de translacion;
  F3  = f33'*R32;    % Para ver todas las fuerzas, no solo la del eje Z
  N2z = n22'*R21*Z;  % Si es de rotación
  N2  = n22'*R21;    % Para ver todos los pares, no solo el del eje Z
  F2z = f22'*R21*Z;  % Si es de translacion;
  F2  = f22'*R21;    % Para ver todas las fuerzas, no solo la del eje Z
  N1z = n11'*R10*Z;  % Si es de rotación
  N1  = n11'*R10;    % Para ver todos los pares, no solo el del eje Z
  F1z = f11'*R10*Z;  % Si es de translacion;
  F1  = f11'*R10;    % Para ver todas las fuerzas, no solo la del eje Z
  N0z = n00'*R0B*Z;  % Si es de rotación
  N0  = n00'*R0B;    % Para ver todos los pares, no solo el del eje Z
  F0z = f00'*R0B*Z;  % Si es de translacion;
  F0  = f00'*R0B;    % Para ver todas las fuerzas, no solo la del eje Z

  % Robot RRR o PPP
    if (Tipo_Q1=='R'); T1=N1z; else T1=F1z; end
    if (Tipo_Q2=='R'); T2=N2z; else T2=F2z; end
    if (Tipo_Q3=='R'); T3=N3z; else T3=F3z; end
    if (Tipo_Q4=='R'); T4=N4z; else T4=F4z; end
    if (Tipo_Q5=='R'); T5=N5z; else T5=F5z; end
 
%%% MANIPULACIÓN SIMBÓLICA DE LAS ECUACIONES %%%
% En ecuaciones matriciales (solo parte del brazo):
%
% T= M(q)qdd+V(q,qd)+G(q) = M(q)qdd+VG(q,qd)
%

% Primera ecuación
% -----------------
% Cálculo de los términos de la matriz de inercia (afines a qdd)
M11 = diff(T1,qdd1);
Taux = simplify(T1 - M11*qdd1);
M12 = diff(Taux,qdd2);
Taux = simplify(Taux-M12*qdd2);
M13= diff(Taux,qdd3);
Taux = simplify(Taux-M13*qdd3);
M14= diff(Taux,qdd4);
Taux = simplify(Taux-M14*qdd4);
M15= diff(Taux,qdd5);
Taux = simplify(Taux-M15*qdd5);
% Taux restante contiene términos Centrípetos/Coriolis y Gravitatorios
% Términos gravitatorios: dependen linealmente de "g"
G1=diff(Taux,g)*g;
Taux=simplify(Taux-G1);
% Taux restante contiene términos Centrípetos/Coriolis
V1=Taux;

% Segunda ecuación
% -----------------
% Cálculo de los términos de la matriz de inercia (afines a qdd)
M21 = diff(T2,qdd1);
Taux = simplify(T2 - M21*qdd1);
M22 = diff(Taux,qdd2);
Taux = simplify(Taux-M22*qdd2);
M23 = diff(Taux,qdd3);
Taux = simplify(Taux-M23*qdd3);
M24 = diff(Taux,qdd4);
Taux = simplify(Taux-M24*qdd4);
M25 = diff(Taux,qdd5);
Taux = simplify(Taux-M25*qdd5);
% Taux restante contiene términos Centrípetos/Coriolis y Gravitatorios
% Términos gravitatorios: dependen linealmente de "g"
G2=diff(Taux,g)*g;
Taux=simplify(Taux-G2);
% Taux restante contiene términos Centrípetos/Coriolis
V2=Taux;

% Tercera ecuación
% -----------------
% Cálculo de los términos de la matriz de inercia (afines a qdd)
M31 = diff(T3,qdd1);
Taux = simplify(T3 - M31*qdd1);
M32 = diff(Taux,qdd2);
Taux = simplify(Taux-M32*qdd2);
M33 = diff(Taux,qdd3);
Taux = simplify(Taux-M33*qdd3);
M34 = diff(Taux,qdd4);
Taux = simplify(Taux-M34*qdd4);
M35 = diff(Taux,qdd5);
Taux = simplify(Taux-M35*qdd5);
% Taux restante contiene términos Centrípetos/Coriolis y Gravitatorios
% Términos gravitatorios: dependen linealmente de "g"
G3=diff(Taux,g)*g;
Taux=simplify(Taux-G3);
% Taux restante contiene términos Centrípetos/Coriolis
V3=Taux;

% Cuarta ecuación
% -----------------
% Cálculo de los términos de la matriz de inercia (afines a qdd)
M41 = diff(T4,qdd1);
Taux = simplify(T4 - M41*qdd1);
M42 = diff(Taux,qdd2);
Taux = simplify(Taux-M42*qdd2);
M43 = diff(Taux,qdd3);
Taux = simplify(Taux-M43*qdd3);
M44 = diff(Taux,qdd4);
Taux = simplify(Taux-M44*qdd4);
M45 = diff(Taux,qdd5);
Taux = simplify(Taux-M45*qdd5);
% Taux restante contiene términos Centrípetos/Coriolis y Gravitatorios
% Términos gravitatorios: dependen linealmente de "g"
G4=diff(Taux,g)*g;
Taux=simplify(Taux-G4);
% Taux restante contiene términos Centrípetos/Coriolis
V4=Taux;

% Quinta ecuación
% -----------------
% Cálculo de los términos de la matriz de inercia (afines a qdd)
M51 = diff(T5,qdd1);
Taux = simplify(T5 - M51*qdd1);
M52 = diff(Taux,qdd2);
Taux = simplify(Taux-M52*qdd2);
M53 = diff(Taux,qdd3);
Taux = simplify(Taux-M53*qdd3);
M54 = diff(Taux,qdd4);
Taux = simplify(Taux-M54*qdd4);
M55 = diff(Taux,qdd5);
Taux = simplify(Taux-M55*qdd5);
% Taux restante contiene términos Centrípetos/Coriolis y Gravitatorios
% Términos gravitatorios: dependen linealmente de "g"
G5=diff(Taux,g)*g;
Taux=simplify(Taux-G5);
% Taux restante contiene términos Centrípetos/Coriolis
V5=Taux;


% Simplificación de expresiones
M11=simplify(M11); M12=simplify(M12); M13=simplify(M13); M14=simplify(M14);M15=simplify(M15);
M21=simplify(M21); M22=simplify(M22); M23=simplify(M23); M24=simplify(M24);M25=simplify(M25);
M31=simplify(M31); M32=simplify(M32); M33=simplify(M33); M34=simplify(M34);M35=simplify(M35);
M41=simplify(M41); M42=simplify(M42); M43=simplify(M43); M44=simplify(M44);M45=simplify(M45);
M51=simplify(M51); M52=simplify(M52); M53=simplify(M53); M54=simplify(M54);M55=simplify(M55);


V1=simplify(V1); V2=simplify(V2); V3=simplify(V3); V4=simplify(V4); V5=simplify(V5);
G1=simplify(G1); G2=simplify(G2); G3=simplify(G3); G4=simplify(G4); G5=simplify(G5);


% Apilación en matrices y vectores
M = [M11 M12 M13 M14 M15; 
    M21 M22 M23 M24 M25; 
    M31 M32 M33 M34 M35;
    M41 M42 M43 M44 M45;
    M51 M52 M53 M54 M55];

V = [V1; V2; V3; V4; V5];
G = [G1; G2; G3; G4; G5];


% Inclusión de los motores en la ecuación dinámica
%
% T= Ma(q)qdd+Va(q,qd)+Ga(q)
%
% Ma = M + R^2*Jm     Va=V + R^2*Bm*qd     Ga=G
%
R=diag([R1 R2 R3 R4 R5]);
Jm=diag([Jm1 Jm2 Jm3 Jm4 Jm5]);
Bm=diag([Bm1 Bm2 Bm3 Bm4 Bm5]);
% Kt=diag([Kt1 Kt2 Kt3]); % No utilizado

Ma=M+R*R*Jm;
Va=V+R*R*Bm*[qd1 ; qd2 ; qd3; qd4; qd5];
Ga = G;

% La función vpa del Symbolic Toolbox evalua las expresiones de las
% fracciones de una función simbólica, redondeándolas con la precisión que podría pasarse como segundo
% argumento.
 Ma_ne=vpa(Ma,5);
 Va_ne=vpa(Va,5);
 Ga_ne=vpa(Ga,5);

