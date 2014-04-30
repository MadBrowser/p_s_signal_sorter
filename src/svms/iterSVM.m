% funcion que genera la busqueda de grilla mas chica
function [svmFinal, Exac, Cfinal, Sfinal] = iterSVM(C,S,DATAFIN)
i=0;
svmFinal = [];

Exac(round(C(1,2) - C(1,1) + 1), round(S(1,2) - S(1,1) + 1 )) = 0; 

for c = C(1,1):0.2:C(1,2)
    i = i + 1;
    j = 0;
    for s = S(1,1):0.2:S(1,2)
        j = j + 1; 
        [sist, matriz] = SVM(DATAFIN,c,s);
        Exac(i,j) = calculaError(matriz,0);
        % Escoje a la mejor svm y se almacenan sus datos
        if(Exac(i,j) >= max(Exac(:)))
            Cfinal = c;
            Sfinal = s;
            svmFinal = sist;
        end
    end
end

end