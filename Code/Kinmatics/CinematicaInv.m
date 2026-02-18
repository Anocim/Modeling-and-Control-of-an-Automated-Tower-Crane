function [q,fueraRango] = CinematicaInv(pose)
x = pose(1);           % Posición cartesianas
y = pose(2);           % 
z = pose(3);           % 
phi = pose(4);         % Ángulos RPY
theta = pose(5);       %
psi = pose(6);   %
fueraRango = false;    % Suponemos inicialmente que existe solución

    L0= 45; % m
    L1B = 35; % m 
    L1A= L1B/2; % m
    L2= 15; % m

MRPY=rotz(phi)*roty(theta)*rotx(psi);

% Se compara con la matriz TB6 obtenida en la cinemática directa.

r11= MRPY(1,1);      r12= MRPY(1,2);      r13= MRPY(1,3);
r21= MRPY(2,1);      r22= MRPY(2,2);      r23= MRPY(2,3);
r31= MRPY(3,1);      r32= MRPY(3,2);      r33= MRPY(3,3);

q3 = atan2(-r32, sqrt(r31^2 + r33^2));
q4 = atan2(r31,-r33);
q1 = atan2(-r22,-r12);

% Analizamos los límites de las articulaciones

if (abs(q3)>= pi/3)
    fueraRango = true;
end

if (abs(q4)>= pi/3)
    fueraRango = true;
end

% Se desplaza q1 para que opte por valores entre 
% pi y -pi sin modificar la posición del extremo

 if q1<-pi
    q1= 2*pi+q1;

 elseif q1>pi
    q1= q1-2*pi;
 end

% Será necesario evitar la indeterminación del denominador de q5, sin
% embargo, como q3 y q4 se acotan entre +-pi/3 esto no ocurrirá nunca

if fueraRango == false
    q5 = (L0-z)/(cos(q3)*cos(q4)) -L2;

% Analizamos los límites de la articulación

    if (q5>= 4*(L0-L2)/5 || q5<= -4*L2/5)
        fueraRango = true;
    end

end

if fueraRango == false

    inter1_q2= x-(L2+q5)*r13;
    inter2_q2= y-(L2+q5)*r23;
    
    q2= inter1_q2*cos(q1) + inter2_q2*sin(q1) - L1A;

% Analizamos los límites de las articulaciones

    if (q2>= 4*(L1B-L1A)/5 || q2<= -4*L1A/5)
        fueraRango = true;
    end
end

 if (fueraRango == false)
    q = [q1; q2; q3; q4; q5];
    q = round(q,3);
 else
    q = zeros(5,1);
 end 

end

