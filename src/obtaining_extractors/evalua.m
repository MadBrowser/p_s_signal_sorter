function [valores] = evalua(datos,k,l)

tam = length(datos);
valores = zeros(tam, 1);

for i = 1: tam
    acum = 0;
    acum2 = 0;
    
    if(i+l-1 <= tam)
        lim = i + l -1;
    else
        lim = tam;
    end
    acum = acum + sumabs(datos(i:lim));
    
    if(i+k-1 <= tam)
        lim2 = i + k -1;
    else
        lim2 = tam;
    end
    
    acum2 = acum2 + sumabs(datos(i:lim2));
    valores(i,1) = ((1/l)*acum)/((1/(k-i+1))*acum2);
end
end