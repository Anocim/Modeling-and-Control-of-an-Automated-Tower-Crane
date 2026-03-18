%% Archivo para ejecutar la simulación

%% Control PD o PID

    % Extraer de la funcion Funciones_transf los parámetros para el tiempo
    % de subida deseado y sustituir por los que se tenga en el archivo de
    % control

    Ts=1; % en segundos

    [Kp, Ti, Td, ~, ~, ~] = Funciones_transf(Ts);

    % Posteriormente ejecutar: sim('Sim_grua');

%% Control LQR

    % Extraer de la funcion K_LQR el valor de la ganancia del controlador
    % LQR y sustituir por los que se tenga en el archivo de
    % control
    
    K = K_LQR();

    % Posteriormente ejecutar: sim('Sim_grua');

%% Control MPC

    % Extraer el objeto del bloque MPC al ejecutar la función MPC_modelo y
    % simular directamente simulink ya que es necesario que este objeto
    % exista en el workspace previamente
    
    MPC_modelo;

    sim('Sim_grua_MPC');

%% Control NMPC

    % Extraer el objeto del bloque NMPC al ejecutar la función NMPC_modelo y
    % simular directamente simulink ya que es necesario que este objeto
    % exista en el workspace previamente
    
    NMPC_modelo;

    sim('Sim_grua_NMPC');    

%% Control NMPC + PD/PID

    % Extraer de la funcion Funciones_transf los parámetros para el tiempo
    % de subida deseado y sustituir por los que se tenga en el archivo de
    % control (En este caso solo se sustituye en los actuadores que no
    % controle el propio NMPC

    Ts=1; % en segundos

    [Kp, Ti, Td, ~, ~, ~] = Funciones_transf(Ts);
    % Extraer el objeto del bloque NMPC al ejecutar la función NMPC_modelo y
    % simular directamente simulink ya que es necesario que este objeto
    % exista en el workspace previamente
    
    NMPC_modelo;

    sim('Sim_grua_Fused');   

%% En caso de querer observar el movimiento resultante ejecutar el siguiente comando

    vis_robot;