clc
cla
clf
r = 1;
 T = cell(1,r);
 d = [1,2,3];
 m = 0.001.*[97,97,69,69];
 L = [2.67, 1.67, 1.33];
 e = zeros(1,r);
 Vi = zeros(1,r);
for i= 1:r

 fiter = dlmread('operation_momentum/2dim/d1_h1_m1_v1.tsv');
 fiter(:,1) = []; fiter(:,7) = []; fiter(:,4) =  [];
 T{1,i} = fiter;
end
for j = 1:r
    [M,N] = size(T{1,j});
    t = transpose(linspace(T{1,j}(1,1),T{1,j}(M,1),M));
    V = zeros(M,2); R = zeros(M,1);
    for i = 1:M-1
    
        V(i,1) = m(1,j)*(T{1,j}(i+1,2)-T{1,j}(i,2))/10;
        V(i,2) = m(1,j)*(T{1,j}(i+1,3)-T{1,j}(i,3))/10;      
        Vtot(i)=sqrt(V(i,1)^2+V(i,2)^2)
   end
   R(:,1) = V(:,1)+V(:,2);
   index = round((L(j)-t(1))*100,1)
   e(1,j) = (V(index+2,2)+V(index+2,1))./V(index-1,1);
   Vi(1,j) = V(index-1,1)./m(1,j);
   R(end-3:1:end,:) = [];
   t(end-3:1:end,:) = [];

   %figure(j);
  % hold on;
   %plot(t,R)
  % plot(L(j),R(index+1),'o');
   %grid; 
  
end