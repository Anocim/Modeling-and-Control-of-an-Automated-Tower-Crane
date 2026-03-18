function [Q_res]=planificador_grua_torre(opcion)

    animar = opcion;        % Elegir entre visualización de la trayectoria (cualquier otro valor) o animación (1)
    
    %% Configuración de la Trayectoria
    tipo = 'recta';  % Opciones: 'recta' o 'circulo'
    
    % Intervalos
    paso = 0.1; 
    total = 20; 
    intervalos = 0:paso:total;
    
    % Altura de operación constante para la prueba
    z_prueba = 20; 

    %% 2. Generación de posición

    if strcmp(tipo, 'recta')
        x_ini = 5; y_ini = 20;
        x_f = 20;   y_f = 5;
        
        % Interpolación lineal
        x = linspace(x_ini, x_f, length(intervalos));
        y = linspace(y_ini, y_f, length(intervalos));
        z = ones(size(intervalos)) * z_prueba;
        
    elseif strcmp(tipo, 'circulo')
        % Trayectoria Circular
        radio = 10;
        omega = 0.3; % rad/s
        centro_x = 15; 
        centro_y = 0;
        
        x = centro_x + radio * cos(omega * intervalos);
        y = centro_y + radio * sin(omega * intervalos);
        z = ones(size(intervalos)) * z_prueba;
    end

    %% 3. Cálculo de Orientación

    Q_res = zeros(5, length(intervalos));   % resultado de las var. articulares
    Pos_res = zeros(3, length(intervalos)); % Para comprobar con la directa
    valid = true(1, length(intervalos));    % Indica si válido o no
    
    % Calculamos la orientación 
    % se va a suponer que q3 y q4 no se mueven, solo cambia la orientación
    % del yaw (phi). Inicialmente, (todas las articulaciones a 0), la
    % orintación es phi=-pi/2, theta=0 y psi= -pi
    
    phi = atan2(y, x)-pi/2; 
    theta = 0; 
    psi = -pi;
    
    for i = 1:length(intervalos)

        pose_deseada = [x(i); y(i); z(i); phi(i); theta; psi];
        
        [q_sol, fueraRango] = CinematicaInv(pose_deseada);
        
        if fueraRango
            valid(i) = false;
            % Si falla, se pone todo a cero
                Q_res(:, i) = [0;0;0;0;0];
        else
            Q_res(:, i) = q_sol;
        end
        
        % Verificación con Cinemática Directa
        [xyz] = CinematicaDir(Q_res(:, i));
        Pos_res(:, i) = xyz(1:3);
    end

    %% 4 Visualización
    % Trayectoria 

    if animar==1

        plot3(x, y, z, 'k--', 'LineWidth', 1.5); hold on;
        plot3(Pos_res(1, valid), Pos_res(2, valid), Pos_res(3, valid), 'ro', 'MarkerSize', 1);

    else
        figure('Name', 'Trayectoria de la Grúa', 'Color', 'w');
        plot3(x, y, z, 'k--', 'LineWidth', 1.5); hold on;
        plot3(Pos_res(1, valid), Pos_res(2, valid), Pos_res(3, valid), 'ro', 'MarkerSize', 1);
        
        grid on; axis equal;
        xlabel('X [m]'); ylabel('Y [m]'); zlabel('Z [m]');
        legend('Trayectoria deseada', 'Trayectoria seguida');
        title(['Seguimiento de ' tipo]);
        view(45, 30);
    
        margen = 5; 
        
        % límites de datos
        min_x = min(x); max_x = max(x);
        min_y = min(y); max_y = max(y);
        
        % límites + margen
        axis([min_x - margen, max_x + margen, ...
              min_y - margen, max_y + margen, ...
              0,              z_prueba + margen]);
    
        
        % Evolución de q
        figure('Name', 'Estados Articulares', 'Color', 'w');
        nombres_q = {'q1', 'q2', 'q3', 'q4', 'q5'};
        for k = 1:5
            subplot(5, 1, k);
            plot(intervalos, Q_res(k, :), 'LineWidth', 1.5);
            ylabel(nombres_q{k});
            grid on;
            if k==1, title('Evolución de las Articulaciones'); end
        end
        xlabel('Intervalos');
        
        if any(~valid)
            disp('ADVERTENCIA: Algunos puntos estuvieron fuera de rango (ver gráfica)');
        end
        
    
    end

end