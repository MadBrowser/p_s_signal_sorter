function GeneraCjtos()

for ventana = 100:50:500;
    for traslape = 50:50:100
        for filtro = 1:3
            if(ventana ~= traslape)
                [Tot Int] = obtenerValores(ventana,traslape,filtro);
                segundos = strcat('DataTest',strcat(num2str(ventana/50),'seg'));
                tras = strcat(num2str(traslape/50),'trasF');
                filter = strcat(num2str(filtro),'.mat');
                file = strcat(segundos,strcat(tras,filter));
                save(file,'Tot','Int');
            end
        end
    end    
end








end