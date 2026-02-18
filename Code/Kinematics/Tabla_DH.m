%% Tabla de Denavit-Hartenberg

syms L0 L1 L2 real            % Declaración de las variables simbólicas

syms q1 q2 q3 q4 q5 phi theta psi real      % Declaración de las variables articulares

PI = sym(pi);

% Valores sacados de los ejes dispuestos en la figura de la grúa torre

[theta0, d0, a0, alpha0]=deal(q1, L0, 0, 0);

[theta1, d1, a1, alpha1]=deal(PI/2, 0, 0, PI/2);

[theta2, d2, a2, alpha2]=deal(-PI/2, L1+q2, 0, PI/2);

[theta3, d3, a3, alpha3]=deal(q3, 0, 0, PI/2);

[theta4, d4, a4, alpha4]=deal(q4+PI/2, 0, 0, PI/2);

[theta5, d5, a5, alpha5]=deal(0, q5, 0, 0);

[theta6, d6, a6, alpha6]=deal(0, L2, 0, 0);
