function [T1] = Interpola(numero, T)

% T = insertrows(T, 0, numero);

T1 = T(1:numero-1,:);

T2 = T(numero:end,:);

% T3 = [T1;[0,0,0]; T2 ];
T3 = vertcat(T1,vertcat([0,0,0],T2));
% T3
T3(numero,1) = mean([ T3(numero - 1,1) ; T3(numero + 1,1)]);
T3(numero,2) = mean([ T3(numero - 1,2) ; T3(numero + 1,2)]);
T3(numero,3) = mean([ T3(numero - 1,3) ; T3(numero + 1,3)]);



T1 = T3;
end