function [out]=GTCL_R5GDL(in)

posini=[in(1), in(2), in(3)];
posfin=[in(4), in(5), in(6)];
n=in(7);
inicio=in(8);
intervalo=in(9);
tiempo=in(10);

persistent PL_q1 PL_q2 PL_q3 PL_q4 PL_q5 Ts 
if isempty(PL_q1)

    %% definición de variables
    xyz= ones(n,3);
    phi= ones(n);
    theta= ones(n);
    psi_= ones(n);
    
    % inicialización

    xyz(1,:) = posini;
    xyz(n,:) = posfin;

    %% Tiempo
    t= inicio:intervalo/(n-1):intervalo+inicio;

    %% cálculo de la orientación
    
    phi(1) = atan2(posini(2), posini(1))-pi/2; 
    phi(n) = atan2(posfin(2), posfin(1))-pi/2; 
    theta = 0*theta; 
    psi_ = -pi*psi_;
    
    %% Posición inicial y final a var articulares
    
    posedeseada_ini=[xyz(1,1); xyz(1,2); xyz(1,3); phi(1); theta(1); psi_(1)];        
    
    posedeseada_fin=[xyz(n,1); xyz(n,2); xyz(n,3); phi(n); theta(n); psi_(n)];        
    
    [q_ini, val_ini] = CinematicaInv(posedeseada_ini);
    [q_fin, val_fin] = CinematicaInv(posedeseada_fin);
    
    %% Si no da error se interpola
    
    tipo_tray=2;
    if(val_ini==1 || val_fin==1)
            error('ERROR en posición inicial o final: Una de las dos posiciones no es alcanzable')
    else
        if tipo_tray == 0
            % --- TRAYECTORIA EN LÍNEA RECTA ---
            xyz(:,1) = linspace(posini(1), posfin(1), n);
            xyz(:,2) = linspace(posini(2), posfin(2), n);
            xyz(:,3) = linspace(posini(3), posfin(3), n);

            for i = 1:n
                phi(i)=atan2(xyz(i,2), xyz(i,1))-pi/2;

                pose_i = [xyz(i,1); xyz(i,2); xyz(i,3); phi(i); theta(i); psi_(i)];        
                [q_sol, val] = CinematicaInv(pose_i);

                % Comprobación de error punto por punto
                if val == 1
                    error(['ERROR: La posición cartesiana en el paso ', num2str(i), ' no es alcanzable.']);
                end
                
                Q(:, i) = q_sol;
            end

        elseif tipo_tray == 1
            % --- TRAYECTORIA EN CURVA LATERAL (PLANO XY) ---
            % Mantenemos Z como línea recta pura
            s = linspace(0, 1, n); % Vector de progreso normalizado (0 a 1)
            xyz(:,3) = posini(3) + (posfin(3) - posini(3)) * s;
            
            % Vector de dirección en el plano XY
            dx = posfin(1) - posini(1);
            dy = posfin(2) - posini(2);
            longitud_xy = norm([dx, dy]);
            
            % Vector perpendicular normalizado en XY (-dy, dx)
            if longitud_xy > 1e-4 % Evitar división por 0 si el movimiento es  vertical
                nx = -dy / longitud_xy;
                ny = dx / longitud_xy;
            else
                nx = 0; ny = 0;
            end
            
            % Definimos cuánto queremos que sea el max de la curva hacia los lados (m)
            desviacion_maxima = 5; 
            
            % Perfil parabólico que vale 0 al inicio/fin y el máximo en el centro
            curva_lateral = desviacion_maxima * 4 * (s .* (1 - s));
            
            % Sumamos a la línea recta la desviación perpendicular
            xyz(:,1) = (posini(1) + dx * s) + curva_lateral * nx;
            xyz(:,2) = (posini(2) + dy * s) + curva_lateral * ny;
            for i = 1:n
                phi(i)=atan2(xyz(i,2), xyz(i,1))-pi/2;

                pose_i = [xyz(i,1); xyz(i,2); xyz(i,3); phi(i); theta(i); psi_(i)];        
                [q_sol, val] = CinematicaInv(pose_i);
                
                % Comprobación de error punto por punto
                if val == 1
                    error(['ERROR: La posición cartesiana en el paso ', num2str(i), ' no es alcanzable.']);
                end
                
                Q(:, i) = q_sol;
            end

        else
            % --- TRAYECTORIA PTO A PTO (INTERPOLADO EN Q) ---

            q1 = linspace(q_ini(1), q_fin(1), n);
            q2 = linspace(q_ini(2), q_fin(2), n);
            q3 = linspace(q_ini(3), q_fin(3), n);
            q4 = linspace(q_ini(4), q_fin(4), n);
            q5 = linspace(q_ini(5), q_fin(5), n);
        
            Q=[q1;q2;q3;q4;q5];
        end

    end
    
    %% Ver las posiciones a las que corresponden la orientación y se sacan las 
    % trayectorias de cada articulación
    
    for i= 1:n
        [result] = CinematicaDir(Q(:, i));
        xyz(i,:)=result(1:3);
    end
    
    PL_q1= p_cubico(Q(1,:)',t',2);
    PL_q2= p_cubico(Q(2,:)',t',2);
    PL_q3= p_cubico(Q(3,:)',t',2);
    PL_q4= p_cubico(Q(4,:)',t',2);
    PL_q5= p_cubico(Q(5,:)',t',2);

    Ts= PL_q1(2,1) - PL_q1(1,1)
end
%% Mandar referencias correspondientemente al tiempo

idx = floor((tiempo - inicio)/Ts) + 1;

% Saturación
if idx < 1
    idx = 1;
elseif idx > length(PL_q1(:,1))
    idx = length(PL_q1(:,1));
end

if isempty(Ts) || tiempo < inicio
    q = [
        PL_q1(1,2);
        PL_q2(1,2);
        PL_q3(1,2);
        PL_q4(1,2);
        PL_q5(1,2);
    ];
    
    qd = [
        PL_q1(1,3);
        PL_q2(1,3);
        PL_q3(1,3);
        PL_q4(1,3);
        PL_q5(1,3);
    ];
    
    qdd = [
        PL_q1(1,4);
        PL_q2(1,4);
        PL_q3(1,4);
        PL_q4(1,4);
        PL_q5(1,4);
    ];
else
    q = [
        PL_q1(idx,2);
        PL_q2(idx,2);
        PL_q3(idx,2);
        PL_q4(idx,2);
        PL_q5(idx,2);
    ];
    
    qd = [
        PL_q1(idx,3);
        PL_q2(idx,3);
        PL_q3(idx,3);
        PL_q4(idx,3);
        PL_q5(idx,3);
    ];
    
    qdd = [
        PL_q1(idx,4);
        PL_q2(idx,4);
        PL_q3(idx,4);
        PL_q4(idx,4);
        PL_q5(idx,4);
    ];

end

out=[q;qd;qdd];
end