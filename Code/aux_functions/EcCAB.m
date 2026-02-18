function Sol= EcCAB(C,A,B)

alfa=simplify(atan2(B,A));

R=simplify(sqrt(A^2+B^2));

Sol=[alfa,R];
end