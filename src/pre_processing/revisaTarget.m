function [TF, TD, estado] = revisaTarget(Tiempo, T, horaP, horaS)

tam = length(Tiempo);

estadoS = -1;
estadoP = -1;
T3 = Tiempo;
TD = T;

if(isempty(horaP))
    horaP = '00:00:00.0000';
    estadoP = -3;
    disp('horaP vacia');
end
if(isempty(horaS))
    horaS = '00:00:00.0000';
    estadoS = -3;
    disp('horaS vacia');
end

horaPDate = datevec(horaP,'HH:MM:SS.FFF');
horaSDate = datevec(horaS,'HH:MM:SS.FFF');


[~, targetT] = strtok(Tiempo,'T');
targetT = strrep(targetT, 'T', '');

for i=1:tam(1,1)
    aux = datevec(targetT(i,1),'HH:MM:SS.FFF');
    P = etime(aux,horaPDate);
    S = etime(aux,horaSDate);
    if(P == 0)
        estadoP = 1;
        P = i
    end
    if(S == 0)
        estadoS = 1;
        S = i
    end
    if(P > 0 && estadoP == -1)
        if(i == 1)
            disp('Error fuera de rango');
            estadoP = -2;
        else
            T1 = T3(1:i-1,:);
            T2 = T3(i:end,:);
            T3 = vertcat(T1,vertcat(strcat(resto(i-1,1),strcat('T',horaP)),T2));
            [~,targetT2] = strtok(T3,'T');
            targetT = strrep(targetT2, 'T', '');
            TD = Interpola(i,TD);
            disp('se Paso');
            estadoP = 1;
        end
    end
    if(S > 0 && estadoS == -1)
        if(i == 1)
            disp('Error fuera de rango');
            estadoS = -2;
        else
            T1 = T3(1:i-1,:);
            T2 = T3(i:end,:);
            T3 = vertcat(T1,vertcat(strcat(resto(i-1,1),strcat('T',horaS)),T2));
            TD = Interpola(i,TD);
            disp('se paSo');
            estadoS = 1;
        end
    end
end

if(estadoP == 1 && estadoS == 1)
    estado = 1;
elseif(estadoP == -1 || estadoS == -1)
   disp('Error falto un valor');
   estado = -1;
elseif(estadoP == -2 || estadoS == -2)
    estado = -2;
end

TF = T3;

end