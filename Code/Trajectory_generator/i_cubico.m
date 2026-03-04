function P=i_cubico(q,t,met,qd)
% Obtiene los coeficientes de los splines cubicos
% que interpolan los valores q en los instantes t
% con las velocidades de paso qd
% Las velocidades de paso pueden ser especificadas
% o en caso contrario se utiliza la expresión [6.8]
% Retorna un vector con una fila por cada tramo
% con [ti,tf,a,b,c,d] siendo el polinomio:
% q(t)=a+b(t-ti)+c(t-ti)^2+d(t-ti)^3   para ti<t<tf
% Ejercicio 6.2
%   (c) FUNDAMENTOS DE ROBOTICA   (A. Barrientos) McGrawHill 2007
%________________________________________________________________

n=length(q);
if n~=length(t)
    error('ERROR en i_cubico: Las dimensiones de q y t deben ser iguales')
end
 
if (met ~= 1 && met ~= 2)
    error('ERROR en i_cubico: El método seleccionado debe ser o 1 o 2')
end

if nargin~= 4    % qd no definida. La obtiene  segun [6.8]
   qd(1)=0;
   qd(n)=0;
   if met==1
      for i=2:n-1
          if (sign(q(i)-q(i-1))==sign(q(i+1)-q(i)))...
                  |q(i)==q(i+1)...
                  |q(i-1)==q(i)
              qd(i)=0.5*((q(i+1)-q(i))/(t(i+1)-t(i))+ ...
             +(q(i)-q(i-1))/(t(i)-t(i-1)));
          else
              qd(i)=0;
          end
      end

   elseif met == 2
        h = diff(t); %incremento entre intervalos
        
        num_int = n-2;
        A = zeros(num_int, num_int);
        B = zeros(num_int, 1);
        
        %velocidades en extremos
        qd_inicio = 0; 
        qd_final = 0;

        for i = 1:num_int
            idx = i + 1; % indice del punto real en q y t
            
            %A%
            if i > 1
                A(i, i-1) = h(idx);      
            end
            
            A(i, i) = 2*(h(idx-1) + h(idx)); 
            
            if i < num_int
                A(i, i+1) = h(idx-1);    
            end
            
            %B%
            term1 = (h(idx-1)^2) * (q(idx+1) - q(idx));
            term2 = (h(idx)^2) * (q(idx) - q(idx-1));
            denominador = h(idx-1) * h(idx);
            
            B(i) = (3 / denominador) * (term1 + term2);
            
            % Por si las v en los extremos ~ de 0
            if i == 1
                B(i) = B(i) - h(idx) * qd_inicio;
            end
            if i == num_int
                B(i) = B(i) - h(idx-1) * qd_final;
            end
        end
        
        vel_paso = A \ B;
        
        % 4. Componemos el vector final de velocidades de paso
        qd = [qd_inicio; vel_paso; qd_final];
   end
end

% obtiene los coeficientes de los polinomios
    for i=1:n-1
        ti=t(i);
        tii=t(i+1);
        if tii<=ti
            error ('ERROR en i_cubico. Los tiempos deben estar ordenados: t(i) debe ser < t(i+1)')
        end
        T=tii-ti;
        TT(:,i)=[ti;tii];
        a(i)=q(i);
        b(i)=qd(i);
        c(i)= 3/T^2*(q(i+1)-q(i)) - 1/T  *(qd(i+1)+2*qd(i));
        d(i)=-2/T^3*(q(i+1)-q(i)) + 1/T^2*(qd(i+1)  +qd(i));
    end
         
    P=[TT;a; b; c; d]';

end