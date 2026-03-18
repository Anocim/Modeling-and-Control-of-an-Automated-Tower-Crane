[M,N]= size(q);

q_ = {q(1:M-1,1), q(1:M-1,2), q(1:M-1,3), q(1:M-1,4), q(1:M-1,5)};
qd_ = {qd(1:M-1,1), qd(1:M-1,2), qd(1:M-1,3), qd(1:M-1,4), qd(1:M-1,5)};
qdd_ = {qdd(1:M-1,1), qdd(1:M-1,2), qdd(1:M-1,3), qdd(1:M-1,4), qdd(1:M-1,5)};

qr_ = {qr(1:M-1,1), qr(1:M-1,2), qr(1:M-1,3), qr(1:M-1,4), qr(1:M-1,5)};
qdr_ = {qdr(1:M-1,1), qdr(1:M-1,2), qdr(1:M-1,3), qdr(1:M-1,4), qdr(1:M-1,5)};
qddr_ = {qddr(1:M-1,1), qddr(1:M-1,2), qddr(1:M-1,3), qddr(1:M-1,4), qddr(1:M-1,5)};

e_ = {qr(1:M-1,1)-q(1:M-1,1), qr(1:M-1,2)-q(1:M-1,2), qr(1:M-1,3)-q(1:M-1,3), qr(1:M-1,4)-q(1:M-1,4), qr(1:M-1,5)-q(1:M-1,5)};
ed_ = {qdr(1:M-1,1)-qd(1:M-1,1), qdr(1:M-1,2)-qd(1:M-1,2), qdr(1:M-1,3)-qd(1:M-1,3), qdr(1:M-1,4)-qd(1:M-1,4), qdr(1:M-1,5)-qd(1:M-1,5)};
edd_ = {qdr(1:M-1,1)-qd(1:M-1,1), qdr(1:M-1,2)-qd(1:M-1,2), qdr(1:M-1,3)-qd(1:M-1,3), qdr(1:M-1,4)-qd(1:M-1,4), qdr(1:M-1,5)-qd(1:M-1,5)};

Tau_ = {Tau(:,1), Tau(:,2), Tau(:,3), Tau(:,4), Tau(:,5)};


nombres = ["q1", "q2", "q3", "q4", "q5"];
etiquetas = ["rad", "m", "rad", "rad", "m"];

graficado(t(1:M-1), e_, ...
    "Separados", true, ...
    "TituloPrincipal", "Evolución de variables articulares",...
    "Nombres", nombres, ...
    "EtiquetaX", "tiempo (s)",...
    "EtiquetaY", etiquetas, ...
    "GrosorLinea", 1.5);