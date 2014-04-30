function [DATA] = revisaDoble(DATATOT)

tar = DATATOT(:,14:15);
tar2 = tar(:,1) + tar(:,2);
DATATOT(tar2 >= 2,:) = [];
DATA = DATATOT;
end