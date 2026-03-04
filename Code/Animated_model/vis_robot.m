clear all; clc; close all;

%% ======================
% PARÁMETROS
%% ======================
L0  = 45;
L1B = 35;
L1A = L1B/2;
L2  = 15;

robot = rigidBodyTree('DataFormat','column');

%% ======================
% BASE → TB0 (FIJA)
%% ======================
body0 = rigidBody('Base');

jnt0 = rigidBodyJoint('jnt0','fixed');
TB0 = [1 0 0 0; 0 1 0 0; 0 0 1 L0; 0 0 0 1];
setFixedTransform(jnt0, TB0);

addVisual(body0,"Cylinder",[0.6 L0], ...
          trvec2tform([0 0 -L0/2]));

body0.Joint = jnt0;
addBody(robot, body0,'base');



%% ======================
% T01 → q1
%% ======================
body1 = rigidBody('PlumaRot');

jnt1 = rigidBodyJoint('jnt1','revolute');
jnt1.JointAxis = [0 1 0];   % eje Y

% Parte fija = rotación π/2
T01_fixed = [cos(pi/2) 0 sin(pi/2) 0; sin(pi/2) 0 -cos(pi/2) 0; 0 1 0 0; 0 0 0 1];
setFixedTransform(jnt1, T01_fixed);

jnt1.PositionLimits = [-pi pi];

body1.Joint = jnt1;

addVisual(body1,"Cylinder",[0.6 L1B], ...
          trvec2tform([0 0 L1B/2]));

addBody(robot, body1,'Base');

%% ======================
% T12 → q2
%% ======================
body2 = rigidBody('Carrito');

jnt2 = rigidBodyJoint('jnt2','prismatic');
jnt2.JointAxis = [0 1 0];

T12_f = [ 0 0 -1 0;
         -1 0  0 0;
          0 1  0 L1A;
          0 0  0 1];

setFixedTransform(jnt2,T12_f);

jnt2.PositionLimits = [ -4*L1A/5 , 4*(L1B-L1A)/5 ];

body2.Joint = jnt2;

addVisual(body2,"Box",[2 2 1]);

addBody(robot, body2,'PlumaRot');

%% ======================
% T23 → q3
%% ======================
body3 = rigidBody('CableRot1');

jnt3 = rigidBodyJoint('jnt3','revolute');
jnt3.JointAxis = [0 1 0];

T23_fixed = [1 0 0 0; 0 0 -1 0; 0 1 0 0; 0 0 0 1]; % T23 con q3=0
setFixedTransform(jnt3, T23_fixed);

jnt3.PositionLimits = [-pi/3 pi/3];

body3.Joint = jnt3;

addVisual(body3,"Sphere",0.6);

addBody(robot, body3,'Carrito');

%% ======================
% T34 → q4
%% ======================
body4 = rigidBody('CableRot2');

jnt4 = rigidBodyJoint('jnt4','revolute');
jnt4.JointAxis = [0 1 0];

T34_fixed = [cos(pi/2) 0 sin(pi/2) 0; sin(pi/2) 0 -cos(pi/2) 0; 0 1 0 0; 0 0 0 1];
setFixedTransform(jnt4, T34_fixed);

jnt4.PositionLimits = [-pi/3 pi/3];

body4.Joint = jnt4;

addVisual(body4,"Sphere",0.6, ...
          trvec2tform([0 0 1]));

addBody(robot, body4,'CableRot1');

%% ======================
% T45 → q5
%% ======================
body5 = rigidBody('CableExt');

jnt5 = rigidBodyJoint('jnt5','prismatic');
jnt5.JointAxis = [0 0 1];

setFixedTransform(jnt5, eye(4));

jnt5.PositionLimits = [ -4*L2/5 , 4*(L0-L2)/5 ];

body5.Joint = jnt5;

L_cable = L2;
% addVisual(body5,"Cylinder",[0.2 L_cable], ...
%           trvec2tform([0 0 L_cable/2]));

addBody(robot, body5,'CableRot2');

%% ======================
% T56 → GANCHO
%% ======================
body6 = rigidBody('Gancho');

jnt6 = rigidBodyJoint('jnt6','fixed');
setFixedTransform(jnt6, trvec2tform([0 0 L2]));

body6.Joint = jnt6;

addVisual(body6,"Box",[1 1 0.5]);

addBody(robot, body6,'CableExt');

%% ======================
% CONFIGURACIÓN INICIAL
%% ======================
q_home = [0; 0; 0; 0; 0];

%% ======================
% VISUALIZACIÓN CORRECTA
%% ======================
figure('Color','w');

show(robot,q_home,...
    'Frames','on', ...
    'Visuals','on');
patches = findobj(gca,'Type','Patch');

% Asignar colores
for k = 1:length(patches)
    patches(k).EdgeColor = 'none';
end

patches(1).FaceColor = [0.8 0.8 0.8];     % torre
patches(2).FaceColor = [0.8 0.8 0.8];     % torre
patches(3).FaceColor = [0.8 0.8 0.8];     % torre

patches(4).FaceColor = [1 0.9 0];     % torre
patches(5).FaceColor = [1 0.9 0];     % torre
patches(6).FaceColor = [1 0.9 0];     % torre
patches(7).FaceColor = [1 0.9 0];     % torre
patches(8).FaceColor = [1 0.9 0];     % torre
patches(9).FaceColor = [1 0.9 0];     % torre


hold on;
[X,Y] = meshgrid(-30:5:30);
Z = zeros(size(X));
surf(X,Y,Z,'FaceColor',[0.9 0.9 0.9],'EdgeColor','none')
axis equal
axis auto
grid on
view(140,25)
light('Position',[50 50 100],'Style','infinite')
material metal
lighting phong
title('Grúa torre 5GDL subactuada');
hold on;
cable_plot = plot3([0 0],[0 0],[0 0],'Color',[0.5 0.5 0.5],'LineWidth',3);
%% 
sim('Sim_grua');

plot3(xr, yr, zr,'--b','LineWidth',1.5)
hold on;

trayectoria = animatedline('Color','r','LineWidth',2);

for k = 1:length(t)

    qk = q(k,:)';  % columna
    
    % actualizar robot
    show(robot,qk,'PreservePlot',false,'Frames','off');
    
    % Posición del punto superior del cable
    T_top = getTransform(robot,qk,'CableRot2');
    pos_top = tform2trvec(T_top);
  
    % obtener posición del efector final
    T_ee = getTransform(robot,qk,'Gancho');
    pos = tform2trvec(T_ee);

    % Actualizar cable
    set(cable_plot,...
        'XData',[pos_top(1) pos(1)],...
        'YData',[pos_top(2) pos(2)],...
        'ZData',[pos_top(3) pos(3)]);


    
    % dibujar trayectoria
    addpoints(trayectoria,pos(1),pos(2),pos(3));
    
    drawnow;
end