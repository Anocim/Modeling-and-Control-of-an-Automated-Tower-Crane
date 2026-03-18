%% Control Predictivo por Modelo

Extr_A_B_SS;

Ts = 1; 

% 2. Crear el objeto MPC
mpcobj = mpc(grua, Ts);

% 3. Definir los Horizontes (Mirar al futuro)
mpcobj.PredictionHorizon = 10;  % Cuántos pasos a futuro predice
mpcobj.ControlHorizon = 4;     % Cuántos pasos de control calcula

% 4. PONER RESTRICCIONES (La gran magia del MPC)
% Suponiendo que tus entradas son [Torque_giro, Fuerza_carro, Fuerza_cable]
% mpcobj.MV(1).Min = -500; mpcobj.MV(1).Max = 500; % Límites motor giro (Nm)
% mpcobj.MV(2).Min = -1000; mpcobj.MV(2).Max = 1000; % Límites motor carro (N)
% mpcobj.MV(3).Min = -800; mpcobj.MV(3).Max = 800; % Límites motor elevación (N)

% También puedes limitar los estados (ej. el cable no puede ser más corto de 1m)
% mpcobj.OV(2).Min = -12; 
% mpcobj.OV(2).Max = 14;

% Límites para la longitud del cable (Salida 3)
% mpcobj.OV(3).Min = -14; 
% mpcobj.OV(3).Max = 24;

% 5. Definir los pesos (equivalentes a Q y R del LQR)
% Pesos para la salida (Output Variables - OV) -> Equivalente a Q
mpcobj.Weights.OV = 1e1*[100 10 20 20 10 5 1 5 5 1]; 

% Pesos para el control (Manipulated Variables - MV) -> Equivalente a R
mpcobj.Weights.MV = [0.001 20 15];
