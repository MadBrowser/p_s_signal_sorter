function [ExtrTotal] = Reduce(datosfinales)

diary('Reducir.txt');
diary on

ExtrTotal = [];
tam = 0;
sirve = 0;

for i = 1 : length(datosfinales)
    descarte = 0;
    disp(strcat('Revisando Intervalo: ',num2str(i)));
    
    if(datosfinales(i,14) == 1 || datosfinales(i,15) == 1 )
        disp('Datos que sirven');
        sirve = 1;
    end
    
    maxS = size(ExtrTotal);
    
    maxD = maxS(1,1);
    
    for j = 1 : maxD
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
        tam = tam + 1;
        ExtrTotal = [ExtrTotal ; datosfinales(i,:)];
        sirve = 0;
    end
end

diary off

end


function [ExtrTotal] = ReduceORIG(max, datosfinales)

diary('Reducir.txt');
diary on

ExtrTotal = [];
tam = 0;

for i = 1 : max
    disp(strcat('Revisando Intervalo: ',num2str(i)));
    %     [valores] = ObtenerInfo(datosfinales{i,:})
    %     ExtrTotal = [ExtrTotal ; valores];
    if(~isempty(datosfinales{i,4}) || ~isempty(datosfinales{i,5}))
        disp('datos verdaderos');
        continue;
    end
    
    descarte = 0;
    
    for j = i + 1 : i + 10000
        %     disp(strcat('Con Intervalo: ',num2str(j)));
        
        %     subplot(3,2,1)
        %     plot(datosfinales{i,1});
        %     subplot(3,2,3)
        %     plot(datosfinales{i,2});
        %     subplot(3,2,5)
        %     plot(datosfinales{i,3});
        %     subplot(3,2,2)
        %     plot(datosfinales{j,1});
        %     subplot(3,2,4)
        %     plot(datosfinales{j,2});
        %     subplot(3,2,6)
        %     plot(datosfinales{j,3});
        if( length(datosfinales{i,1}) ~= length(datosfinales{j,1}) )
            continue;
        end
        correlacionN = corrcoef(datosfinales{i,1},datosfinales{j,1});
        correlacionE = corrcoef(datosfinales{i,2},datosfinales{j,2});
        correlacionZ = corrcoef(datosfinales{i,3},datosfinales{j,3});
        
        corrF = (correlacionN(2,1) + correlacionE(2,1) + correlacionZ(2,1))/3;
        
        if(corrF > 0.9)
            disp('descartado');
            i
            descarte = 1;
            pause(1);
            break;
        else
        end
    end
    
    if(descarte == 0)
        tam = tam + 1;
        ExtrTotal = [ ExtrTotal ; datosfinales{i,:} ];
    end
    
end

diary off

end