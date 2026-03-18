%% MPC no lineal Recortado

Extr_A_B_SS;

nx = 10; % Número de estados
ny = 8; % Número de salidas
nu = 2;  % Número de entradas (tau1, tau2, tau5)

nmpcObj_pend = nlmpc(nx, ny, nu);
nmpcObj_pend.Ts = 1;

% Definimos los horizontes (Esto sustituye a tu bucle for de 10 etapas)
nmpcObj_pend.PredictionHorizon = 20; 
nmpcObj_pend.ControlHorizon = 3;     % Cuántos pasos hacia adelante calcula la acción de control

% 1. Asignar la dinámica y los jacobianos
% En MATLAB es más seguro y eficiente pasar el nombre de la función como string
nmpcObj_pend.Model.StateFcn = "dinamica_grua_estado";
nmpcObj_pend.Model.OutputFcn = "mi_funcion_salida";
% 2. Asignar la función de costo (Pesos)
% En lugar de una función customizada, usa los pesos integrados (es muchísimo más rápido de simular)
% Orden: [q1, q2, q3, q4, q5, qd1, qd2, qd3, qd4, qd5]
nmpcObj_pend.Weights.OutputVariables = [100 50 50 1000 100 5000 5000 100]; % Equivalente a Q
nmpcObj_pend.Weights.ManipulatedVariables = [1 1]; % Equivalente a R
%nmpcObj_pend.Weights.ManipulatedVariablesRate = [1 1]; % Penaliza los tirones bruscos

% 3. Límites físicos (Saturación de los motores)

