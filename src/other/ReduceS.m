function [ExtrTotal] = ReduceS(datosfinales, int)

% datosfinales = vertcat(ext,tar)';
% diary('Reducir.txt');
% diary on

ExtrTotal = [];
cont = 0;
contSi = 0;
sirve = 0;

for i = 1 : length(datosfinales)
    if(length(datosfinales)<i)
%         disp('Termino');
        break;
    end
%     disp(strcat('Revisando Intervalo: ',num2str(i)));
    sirve = 0;
%     [valores] = ObtenerInfo(datosfinales{i,:})
%     ExtrTotal = [ExtrTotal ; valores];
    if(datosfinales(i,16) == 1 )
%         disp('Datos que sirven');
        contSi = contSi + 1;
        continue;
    end
    cont = cont + 1;
    for j = i + 1 : length(datosfinales)
        corrF = corrcoef(datosfinales(i,1:14),datosfinales(j,1:14));
        if( corrF(1,2) > int  & sirve == 0)
            if(datosfinales(j,16) == 1 )
%                 disp('No borrado, Sirve');
                continue;
            end
%             disp(strcat('Eliminado :',num2str(j)));
            datosfinales(j,:) = [];
            break;
        end
    end
end

% diary off
% cont
% contSi

ExtrTotal = datosfinales;

end