function [ExtrTotal] = ExtraFinal(max, datosfinales)

diary('extractores.txt');
diary on

ExtrTotal = zeros(max, 16);
for i = 1 : max
    disp(strcat('Revisando fila: ',num2str(i)));
    [valores] = ObtenerInfo(datosfinales{i,:});
    ExtrTotal(i,:) = valores;
end

diary off

end