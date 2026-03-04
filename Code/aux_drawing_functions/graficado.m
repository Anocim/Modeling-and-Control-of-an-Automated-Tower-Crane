function graficado(X, Y_signals, options)
    % Grafica hasta 10 señales dinámicamente.
    % X: Vector de tiempo
    % Y_signals: Arreglo de celdas con las señales, ej. {Y1, Y2, Y3}
    
    arguments
        X (1,:) double
        Y_signals (1,:) cell % Acepta un grupo de variables como {Y1, Y2, Y3...}
        
        options.Separados (1,1) logical = false
        options.TituloPrincipal (1,1) string = "Análisis de Múltiples Señales"
        options.EtiquetaX (1,1) string = "Tiempo (s)"
        options.EtiquetaY (1,:) string = []
        options.Nombres (1,:) string = [] 
        options.GrosorLinea (1,1) double = 1
    end
    
    num_senales = length(Y_signals);
    
    if num_senales > 10
        warning('Has ingresado más de 10 señales. Por claridad visual, solo se graficarán las primeras 10.');
        num_senales = 10;
    end
    
    % Se generan nombres de los títulos y sus etiquetas si no se dan o si se dan menos

    if isempty(options.Nombres) || length(options.Nombres) < num_senales
        inicio = length(options.Nombres) + 1;
        for i = inicio:num_senales
            options.Nombres(i) = "Señal " + num2str(i);
        end
    end
    
    if options.Separados 
        if length(options.EtiquetaY) < num_senales
            inicio = length(options.Nombres) + 1;
            for i = inicio:num_senales
                options.EtiquetaY(i) = "Unidad " + num2str(i);
            end
        end
    elseif isempty(options.EtiquetaY)
            options.EtiquetaY = "Amplitud"; % Valor por defecto seguro para evitar el crash
    end
    
    

    figure;
    
    % graficado en sí
    if options.Separados
        ejes = zeros(1, num_senales); 
        
        for i = 1:num_senales
            ejes(i) = subplot(num_senales, 1, i);
            
            % Comprobación de seguridad: que la señal tenga la misma longitud que X
            if length(X) == length(Y_signals{i})
                plot(X, Y_signals{i}, 'LineWidth', options.GrosorLinea);
            else
                warning('La Señal %d no tiene la misma longitud que la variable independiente.', i);
            end
            
            grid on;
            title(options.Nombres(i));
            ylabel(options.EtiquetaY(i));
            
            % solo tiempo en la última gráfica de abajo
            if i == num_senales
                xlabel(options.EtiquetaX); 
            end
        end
        linkaxes(ejes, 'x'); % Sincroniza el zoom en el eje X de todos los subplots
        
    else
        hold on;
        for i = 1:num_senales
             if length(X) == length(Y_signals{i})
                % Pasamos el 'DisplayName' directo al plot para que la leyenda lo lea
                plot(X, Y_signals{i}, 'LineWidth', options.GrosorLinea, 'DisplayName', options.Nombres(i));
             end
        end
        grid on;
        title(options.TituloPrincipal);
        ylabel(options.EtiquetaY(1));
        xlabel(options.EtiquetaX);
        legend('show'); % Muestra la leyenda con los DisplayNames asignados
        hold off;
    end
end