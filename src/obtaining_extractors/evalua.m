function [valores] = evalua(datos,k,l)

tam = length(datos);

for i = 1: tam
    acum = 0;
    acum2 = 0;
    
    if(i+l-1 <= tam)
        lim = i + l -1;
    else
        lim = tam;
    end
    acum = acum + sumabs(datos(i:lim));
    acum2 = acum + sumabs(datos(i:k));
    valores(i,1) = ((1/l)*acum)/((1/(k-i+1))*acum2);
end
end