function [DATA] = revisaDoble(DATATOT)

tar = DATATOT(:,15:17);
tar2 = tar(:,1) + tar(:,2) + tar(:,3);
find(tar2 >=2);
DATATOT(find(tar2 >=2),:) = [];

DATA = DATATOT;


end