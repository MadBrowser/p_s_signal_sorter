%% Funcion que tiene como fin calcular los errores en base a la matriz de
%% confusion, para esto se discrimina entre conjuntos de entrenamiento y el
%% de test, el cual se obtienen mas indicadores de error
function error = calculaError(matriz,origen)
P0 = 0;
Pe = 0;
if(origen == 0)
    error = sum(diag(matriz));
    denominador = error + matriz(1,2) + matriz(1,3) + matriz(2,1) + matriz(2,3) +matriz(3,1) + matriz(3,2);
    % error por ahora es la exactitud
    error = error/denominador;
elseif(origen >= 1)% indicadores de exactitud por clase y general
    % Exactitud Clase P
    error{1,1} = matriz(1,1) / sum(matriz(:,1));
    % Exactitud Clase S
    error{1,2} = matriz(2,2) / sum(matriz(:,2));
    % Exactitud Clase Ruido
    error{1,3} = matriz(3,3) / sum(matriz(:,3));
    % Exactitud general
    error{1,4} = sum(diag(matriz)) / (sum(matriz(:,1)) + sum(matriz(:,2)) + sum(matriz(:,3)));
    if(origen == 2)
        % ????
        error{1,5} = (matriz(1,1)/sum(matriz(1,:)) + matriz(2,2)/sum(matriz(2,:)) + matriz(3,3)/sum(matriz(3,:))) / 3;
        % Índice Kappa
        P0 = sum(diag(matriz))/(sum(matriz(1,:)) + sum(matriz(2,:)) + sum(matriz(3,:))); 
        Pe = (sum(matriz(1,:))*sum(matriz(:,1)) + sum(matriz(2,:))*sum(matriz(:,2)) + (sum(matriz(3,:))*sum(matriz(:,3))))/(sum(matriz(1,:)) + sum(matriz(2,:)) + sum(matriz(3,:)))^2; 
        error{1,6} = (P0 - Pe)/ (1 - Pe) ;
    elseif(origen == 3)% Precision por clase e indice kappa (cjto. Prueba)
        % Precisión clase P
        error{1,5} = matriz(1,1)/sum(matriz(1,:));
        % Precisión clase S
        error{1,6} = matriz(2,2)/sum(matriz(2,:));
        % Precisión clase Ruido
        error{1,7} = matriz(3,3)/sum(matriz(3,:));
        % Índice Kappa
        P0 = sum(diag(matriz))/(sum(matriz(1,:)) + sum(matriz(2,:)) + sum(matriz(3,:))); 
        Pe = (sum(matriz(1,:))*sum(matriz(:,1)) + sum(matriz(2,:))*sum(matriz(:,2)) + (sum(matriz(3,:))*sum(matriz(:,3))))/(sum(matriz(1,:)) + sum(matriz(2,:)) + sum(matriz(3,:)))^2; 
        error{1,8} = (P0 - Pe)/ (1 - Pe) ;
    end
end

end