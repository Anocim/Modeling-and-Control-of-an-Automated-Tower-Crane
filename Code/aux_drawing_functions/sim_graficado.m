q_ = {q(:,1), q(:,2), q(:,3), q(:,4), q(:,5)};
qd_ = {qd(:,1), qd(:,2), qd(:,3), qd(:,4), qd(:,5)};
qdd_ = {qdd(:,1), qdd(:,2), qdd(:,3), qdd(:,4), qdd(:,5)};

qr_ = {qr(:,1), qr(:,2), qr(:,3), qr(:,4), qr(:,5)};
qdr_ = {qdr(:,1), qdr(:,2), qdr(:,3), qdr(:,4), qdr(:,5)};
qddr_ = {qddr(:,1), qddr(:,2), qddr(:,3), qddr(:,4), qddr(:,5)};

e_ = {qr(:,1)-q(:,1), qr(:,2)-q(:,2), qr(:,3)-q(:,3), qr(:,4)-q(:,4), qr(:,5)-q(:,5)};
ed_ = {qdr(:,1)-qd(:,1), qdr(:,2)-qd(:,2), qdr(:,3)-qd(:,3), qdr(:,4)-qd(:,4), qdr(:,5)-qd(:,5)};
edd_ = {qdr(:,1)-qd(:,1), qdr(:,2)-qd(:,2), qdr(:,3)-qd(:,3), qdr(:,4)-qd(:,4), qdr(:,5)-qd(:,5)};

Tau_ = {Tau(:,1), Tau(:,2), Tau(:,3), Tau(:,4), Tau(:,5)};


nombres = ["q1", "q2", "q3", "q4", "q5"];
etiquetas = ["rad", "m", "rad", "rad", "m"];

graficado(t, ed_, ...
    "Separados", true, ...
    "TituloPrincipal", "Evolución de variables articulares",...
    "Nombres", nombres, ...
    "EtiquetaX", "tiempo (s)",...
    "EtiquetaY", etiquetas, ...
    "GrosorLinea", 1.5);