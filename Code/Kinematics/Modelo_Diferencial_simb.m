function [Ja Jpi] = Modelo_Diferencial_simb
syms L0 L1A L2 q1 q2 q3 q4 q5 x y z phi theta psi_sym real            % Declaración de las variables simbólicas

PI=sym(pi);

 [x_1, y_1, z_1, phi_1, theta_1, psi_1, TB6]= CinematicaDirSim();


Ja=simplify([diff(x_1,q1) diff(x_1,q2) diff(x_1,q3) diff(x_1,q4) diff(x_1,q5);
    diff(y_1,q1) diff(y_1,q2) diff(y_1,q3) diff(y_1,q4) diff(y_1,q5);
    diff(z_1,q1) diff(z_1,q2) diff(z_1,q3) diff(z_1,q4) diff(z_1,q5);
    diff(phi_1,q1) diff(phi_1,q2) diff(phi_1,q3) diff(phi_1,q4) diff(phi_1,q5);
    diff(theta_1,q1) diff(theta_1,q2) diff(theta_1,q3) diff(theta_1,q4) diff(theta_1,q5);
    diff(psi_1,q1) diff(psi_1,q2) diff(psi_1,q3) diff(psi_1,q4) diff(psi_1,q5)]);


[q1_1, q2_1, q3_1, q4_1, q5_1]= CinematicaInvSim();

Jpi= simplify([diff(q1_1,x) diff(q1_1,y) diff(q1_1,z) diff(q1_1,phi) diff(q1_1,theta) diff(q1_1,psi_sym); ...
               diff(q2_1,x) diff(q2_1,y) diff(q2_1,z) diff(q2_1,phi) diff(q2_1,theta) diff(q2_1,psi_sym); ...
               diff(q3_1,x) diff(q3_1,y) diff(q3_1,z) diff(q3_1,phi) diff(q3_1,theta) diff(q3_1,psi_sym); ...
               diff(q4_1,x) diff(q4_1,y) diff(q4_1,z) diff(q4_1,phi) diff(q4_1,theta) diff(q4_1,psi_sym); ...
               diff(q5_1,x) diff(q5_1,y) diff(q5_1,z) diff(q5_1,phi) diff(q5_1,theta) diff(q5_1,psi_sym)]);

end