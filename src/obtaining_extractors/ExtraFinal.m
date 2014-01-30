function [ExtrTotal] = ExtraFinal(max, datosfinales)

diary('extractores.txt');
diary on

cont = 0;

ExtrTotal = [];
for i = 1 : max
    disp(strcat('Revisando fila: ',num2str(i)));
%       if( (~isempty(datosfinales{1,4}) || ~isempty(datosfinales{1,5})) || (cont == 0))
        [valores] = ObtenerInfo(datosfinales{i,:})
%          if( (valores(1,14) == 1 || valores(1,15) == 1) || (cont == 0) )
            ExtrTotal = [ExtrTotal ; valores];
%          else
%              cont = cont + 1;
%          end
%          if(cont == 95)
%              cont = 0;
%          end
      
end

diary off

end