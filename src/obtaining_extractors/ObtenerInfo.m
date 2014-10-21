function [extrac] = ObtenerInfo(N, E, Z, P, S)
extrac = [];
T = [N(:,1) E(:,1) Z(:,1)];

%  plot(N)
%  pause(1)


% primer caso la desviacion estandar para cada componente

extrac(1,1) = std(N(:,1));
extrac(1,2) = std(E(:,1));
extrac(1,3) = std(Z(:,1));

%varianza por ventana
% extrac(1,1) = VAR(N(:,1));
% extrac(1,2) = VAR(E(:,1));
% extrac(1,3) = VAR(Z(:,1));


% segundo caso la curtosis

extrac(1,4) = kurtosis(N(:,1));
extrac(1,5) = kurtosis(E(:,1));
extrac(1,6) = kurtosis(Z(:,1));

% kurtosis de ventana
% extrac(1,4) = KUR(N(:,1));
% extrac(1,5) = KUR(E(:,1));
% extrac(1,6) = KUR(Z(:,1));

%  tercer caso la skewnes

extrac(1,7) = skewness(N(:,1));
extrac(1,8) = skewness(E(:,1));
extrac(1,9) = skewness(Z(:,1));

% valores por ventana deslizante
% extrac(1,7) = SKEW(N(:,1));
% extrac(1,8) = SKEW(E(:,1));
% extrac(1,9) = SKEW(Z(:,1));


% el logaritmo de la varianza AIC

extrac(1,10) = AIC(N(:,1));
extrac(1,11) = AIC(E(:,1));
extrac(1,12) = AIC(Z(:,1));


% STA/LTA


% Metodo esloveno
extrac(1,13) = IDS(T);


if(isempty(P))
    extrac(1,14) = 0;
else
    extrac(1,14) = 1;
end

if(isempty(S))
    extrac(1,15) = 0;
else
    extrac(1,15) = 1;
end


end

%normaliza la salida AIC
function [DatosN]= normalizarEje(datos)
DatosN = datos;

aux1=min(datos);
aux2=range(datos);

DatosN(:,1)=(datos(:,1)-aux1)/aux2;

x = -1;
y = 1;
range2 = y - x;
DatosN = (DatosN*range2);

end

%genera el grafico y se escogen los maximos valores
function valor = AIC(datos)

tam = length(datos);
valores = [];

if(tam < 50 )
    valor = -1;
    return;
end

for i = 1: tam
    valores(i,1) = i * log( std(datos(1:i,1))^2) + (tam - i - 1)* log ( std( datos(i+1:tam,1))^2);
    
end

pos1 = isnan(valores);
pos2 = isinf(valores);
valores(pos1) = 0;
valores(pos2) = 0;
valores(valores == 0) = mean(valores);
valores = normalizarEje(abs(valores(2:tam-2,1)));

valor = std(valores); % deberia ser la desviacion estandar ya que a mas amplia sirve

% plot(valores);pause(1);

end

%extraccion de skewness mediante ventana % DONE
function valor = SKEW(datos)

tam = length(datos);
valores = [];
media = mean(datos);
des = std(datos);

inicio = 1;
final = tam/2;

numerador = 1/( tam + 1 );
for i = 1:tam
    acum = 0;
    %condicion de lectura al inicio
    if(i>tam/2)
        inicio = i - tam/2;
    end
    %condicion de lectura al final
    if(i+tam/2>tam)
        final = tam;
    end
    for j = inicio: final
        val = i+j;
        if(val > tam)
            val = tam;
        end
        acum = acum + (datos(val,1) - media)/des;
    end
    valores(i,1) = abs(numerador * acum^3);
end


% plot(valores);
valor = max(valores);
% pause(1)

end

%extraccion de varianza mediante ventana %DONE
function valor = VAR(datos)

tam = length(datos);
% datos = abs(datos);
% plot(datos)

valores = [];
media = mean(datos);

inicio = 1;
final = tam/2;

numerador = 1/tam;
for i = 1: tam
    acum = 0;
    %condicion de lectura al inicio
    if(i>tam/2)
        inicio = i - tam/2;
    end
    %condicion de lectura al final
    if(i+tam/2>tam)
        final = tam;
    end
    for j = inicio : final
        val = i+j;
        if(val > tam)
            val = tam;
        end
        acum = acum + (datos(val,1) - media);
    end
    valores(i,1) = (numerador * acum);
end
% plot(valores);
valor = mean(valores);
% pause(1)


end

%extraccion de varianza mediante ventana %REVISAR
function valor = CUR(datos)

tam = length(datos);
datos = abs(datos);
valores = [];
media = mean(datos);
des = std(datos);

inicio = 1;
final = tam/2;

numerador = 1/( tam + 1 );
for i = 1:tam
    acum = 0;
    %condicion de lectura al inicio
    if(i>tam/2)
        inicio = i - tam/2;
    end
    %condicion de lectura al final
    if(i+tam/2>tam)
        final = tam;
    end
    for j = inicio: final
        val = i+j;
        if(val > tam)
            val = tam;
        end
        acum = acum + (((datos(val,1) - media)/des)^4);
    end
    valores(i,1) = numerador * acum - 3;
end


% plot(valores);
valor = max(valores);% deberian ser la var de la var
% pause(1)

end


% IDS---------

%funcion encargada de obtener el clsificador de señal S
function valor = IDS(datos)
k = 150;
l = 50;

if(length(datos) < 149 && length(datos) > 50)
    k = length(datos);
end

% k es el largo del LTA + STA que en este caso es 3 = 150 muestras
% l es el largo del STA que es de 1 seg => 50 muestras


O = datos(:,1).^2 + datos(:,2).^2 + datos(:,3).^2;
E = abs(datos(:,2));
N = abs(datos(:,1));

FO = evalua(O,k,l);
FN = evalua(E,k,l);
FE = evalua(N,k,l);

C = FO.*FN.*FE;

valor = mean(C/1000000);

end

%funcion auxiliar para IDS
function [valores] = evalua(datos,k,l)

tam = length(datos);
valores = zeros(tam, 1);

for i = 1: tam
    acum = 0;
    acum2 = 0;
    %      for j = i: i + l - 1
    %          aux = j;
    %           if( aux > tam )
    %               aux = tam;
    %           end
    %          acum = acum + abs(datos(aux,1));
    %      end
    %
    %      for a = i: k %- l
    %          aux2 = j;
    %          if( aux2 > tam )
    %              aux2 = tam;
    %          end
    %          acum2 = acum2 + abs(datos(aux2,1));
    %      end
    
    % Cálculo de la ventana corta
    if(i+l-1 <= tam)
        lim = i + l -1;
    else
        lim = tam;
    end
    acum = acum + sumabs(datos(i:lim));
    
    % Cálculo de la ventana larga
    if(i+k-1 <= tam)
        lim2 = i + k -1;
    else
        lim2 = tam;
    end
    acum2 = acum2 + sumabs(datos(i:lim2));
    
    valores(i,1) = ((1/l)*acum)/((1/(k-i+1))*acum2);
end
end
% --------------
