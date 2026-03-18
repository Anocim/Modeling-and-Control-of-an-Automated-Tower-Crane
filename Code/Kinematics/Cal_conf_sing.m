function [Deter_Ja,Sol] = Cal_conf_sing()
syms q1 q2 q3 q4 q5 real
[Ja Jpi] = Modelo_Diferencial_simb;

Ja_cuadrada=Ja'*Ja;

Deter_Ja= simplify(det(Ja_cuadrada), 'IgnoreAnalyticConstraints', true);

Sol= solve(Deter_Ja == 0, [q1 q2 q3 q4 q5]);

end

