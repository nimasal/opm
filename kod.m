 T = cell(1,3);
 m1 = 0.062;
 m2 = m1;
 L = [0.75, 1.28, 2.01];
 e = zeros(1,3);
 Vi = zeros(1,3);
for i= 1:3
 files = dir('/chalmers/users/filwes/Downloads/1dim/m1_*_d1.tsv');
 fname = fullfile('/chalmers/users/filwes/Downloads/1dim/',files(i).name);
 fiter = dlmread(fname);
 fiter(:,1) = []; fiter(:,7) = []; fiter(:,4) =  [];
 T{1,i} = fiter;
end
for j = 1:3
    [M,N] = size(T{1,j});
    t = transpose(linspace(T{1,j}(1,1),T{1,j}(M,1),M));
    V = zeros(M,2); R = zeros(M,1);
for i = 1:M-1
    
        V(i,1) = m1*(T{1,j}(i+1,2)-T{1,j}(i,2))/10;
        V(i,2) = m1*(T{1,j}(i+1,4)-T{1,j}(i,4))/10;      
end

   R(:,1) = V(:,1)+V(:,2);
   index = round((L(j)-t(1))*100,1);
   e(1,j) = (V(index+1,1)-V(index+1,2))./V(index-1,1);
   Vi(1,j) = V(index-1,1)./m1;
   R(end-3:1:end,:) = [];
   t(end-3:1:end,:) = [];
   figure(j);
   hold on;
   plot(t,R)
   plot(L(j),R(index+1),'o');
   grid; 
   
end
figure(4)
plot(Vi,e);
T = polyfit(Vi,e,2);
plot(Vi,polyval(T,Vi));