function [ExtrTotal] = Reduce(datosfinales)

diary('Reducir.txt');
diary on

ExtrTotal = zeros(size(datosfinales));
n_filas_agregadas = 0;
sirve = 0;

for i = 1 : length(datosfinales)
    descarte = 0;
    disp(strcat('Revisando Intervalo: ',num2str(i)));
    
    if(datosfinales(i,14) == 1 || datosfinales(i,15) == 1)
        disp('Datos que sirven');
        sirve = 1;
    end
    
    for j = 1 : n_filas_agregadas
        corrF = corrcoef(datosfinales(i,1:13), ExtrTotal(j,1:13));
        
        if((corrF > 0.99))
            disp('descartado');
            descarte = 1;
            break;
        else
            descarte = 0;
        end
    end
    
    if(descarte == 0 || sirve == 1)
        disp('------------------> agregado');
        n_filas_agregadas = n_filas_agregadas + 1;
        ExtrTotal(n_filas_agregadas,:) = datosfinales(i,:);
        sirve = 0;
    end
end

% Se corta la matriz hasta el número de filas agregadas.
ExtrTotal = ExtrTotal(1:n_filas_agregadas,:);

diary off
end