function dxdt = dinamica_grua_estado(x, u)
    % x = [q1; q2; q3; q4; q5; qd1; qd2; qd3; qd4; qd5] (10x1)
    % u = [Tau1; Tau2; Tau5] (3x1)
    
    % 1. Mapear las entradas a un vector de 5 torques
    % IMPORTANTE: Los grados 3 y 4 (balanceo) no tienen motor, su torque es 0
    Tau_completo = [0; u(1); 0; 0; u(2)];
    
    % 2. Calcular la aceleración usando tu función numérica precompilada
    % (Asumimos que usaste matlabFunction para crear 'calc_qdd_numerico')
    qdd = calc_qdd_numerico(x(1), x(2), x(3), x(4), x(5), ...
                            x(6), x(7), x(8), x(9), x(10), ...
                            Tau_completo(1), Tau_completo(2), Tau_completo(5));
                            
    % 3. Construir el vector de derivadas [velocidades; aceleraciones]
    qd = x(6:10);
    
    % Asegurarnos de que dxdt sea un vector columna (10x1)
    dxdt = [qd; qdd];
end