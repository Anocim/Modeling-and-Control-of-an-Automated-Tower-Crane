function I=Steiner(vg,Io,m)
% vg debe ser un vector fila de 3 componentes indicando la traslación del
% punto donde se ha calculado Io hacia el punto donde se quiere saber I. Io
% será el tensor de inercia 3x3 calculado en un punto conocido. m será la
% masa correspondiente al elemento en el q se ha calculado Io.

xg=vg(1,1);
yg=vg(1,2);
zg=vg(1,3);

A=[yg^2+zg^2    -xg*yg     -xg*zg;
   -xg*yg      xg^2+zg^2    -yg*zg;
   -xg*zg      -yg*zg     xg^2+yg^2];

I= Io + m* A;

end