function A= MDH(theta,d,a,alfa)

A=rotz(theta)*trast(0,0,d)*trast(a,0,0)*rotx(alfa);
end