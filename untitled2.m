clc
cla
clf
% Aluminium: 20mm x(60mm - 50mm- 40mm- ) Nylon: 82 Mässing:
 r = 0.001.*[40, 50, 60];
 %V med hastigheter
 % W med rotationshastigheter
 files = dir('/chalmers/users/filwes/MatLab/Projekt/opm/operation_momentum/2dim2/*tsv');
 [r,B] = size(files);
 T = cell(1,r);
 P = 0;
 m = zeros(r,1);
for i= 1:r
 fname = fullfile(files(i).folder,files(i).name);
 f = files(i).name
 fiter = dlmread(fname);
 if r == 14
 fiter(:,[1,5,8,11,14]) = [];
 T{1,i} = fiter;
 else 
 fiter(:,[4,7,10,13]) = [];
 T{1,i} = fiter;
 f = f(1:2);
 end
 P = strcmp(f,'d1');
 if P == 1
     m(i,1) = 0.06;
 end
 P = strcmp(f,'d2');
 if P == 1
     m(i,1) = 0.120;
 end
 P = strcmp(f,'d3');
 if P == 1
     m(i,1) = 0.180;
 end
end
for j = 1:r
    [M,N] = size(T{1,j});
    t = transpose((0:0.01:(M-1)*0.01)); % 0.01s i tidsteg
    V = zeros(M,4); R = zeros(M,4); W = zeros(M,2); RMX = zeros(M,1); RMY = zeros(M,1); Vtot = zeros(M,2); E = zeros(M,1); 
    for i = 1:M-1
    % Translationshastighet för objekt 1
        V(i,1) = (T{1,j}(i+1,2)-T{1,j}(i,2))/10;
        V(i,2) = (T{1,j}(i+1,3)-T{1,j}(i,3))/10;   
        Vtot(i,1) = sqrt(V(i,1)^2+V(i,2)^2);
    % Translationshastighet för objekt 2
        V(i,3) = (T{1,j}(i+1,6)-T{1,j}(i,6))/10;
        V(i,4) = (T{1,j}(i+1,7)-T{1,j}(i,7))/10;    
        Vtot(i,2) = sqrt(V(i,3)^2+V(i,4)^2);
    % Vill finna rotationshastighet för objekt 3,4 (kolonn 4,5 - 8,9)
    % Vektorn från centrum till kant för objekt 1
        R(i,1) = T{1,j}(i,4)-T{1,j}(i,2);
        R(i,2) = T{1,j}(i,5)-T{1,j}(i,3);
    % Vektorn från centrum till kant för objekt 2
        R(i,3) = T{1,j}(i,8)-T{1,j}(i,6);
        R(i,4) = T{1,j}(i,9)-T{1,j}(i,7);      
    end
    % Skapa matrisen W för rotationshastigheten 
    for k = 1:M-1
        a = [R(k,1), R(k,2)];
        b = [R(k,3), R(k,4)];
        a1= [R(k+1,1), R(k+1,2)];
        b1= [R(k+1,3), R(k+1,4)];
        W(k,1) = acos(dot(a,a1)/(norm(a)*norm(a1)))/0.01;
        W(k,2) = acos(dot(b,b1)/(norm(b)*norm(b1)))/0.01;
    end
    for l = 1:M
    E(l) = 1/2.*(m(1,1).*Vtot(l,1).^2+m(1,1).*Vtot(l,2)^2)+m(1,1)*(0.05)^2/2*(W(l,1)^2+W(l,1)^2)/2;
    RMX(l,1) = m(1,1)*(V(l,1)+V(l,3));
    RMY(l,1) = m(1,1)*(V(l,2)+V(l,4));
    end
     figure(j)
     plot(t,W);
     xlabel([files(j).name]);
     grid;
    
   
end
