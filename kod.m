 T = cell(1,3);
 m1 = 0.0646;
 m2 = 0.0597;
 L = [0.75, 1.28, 2.01];
for i= 1:3
 files = dir('/chalmers/users/filwes/Downloads/1dim/*.tsv');
 fname = files(i).name;
 fiter = dlmread(fname);
 fiter(:,1) = [];
 fiter(:,7) = [];
 fiter(:,4) =  [];
 T{1,i} = fiter;
end
s = 0;
for j = 1:3
    [M,N] = size(T{1,j});
    t = transpose(linspace(T{1,j}(1,1),T{1,j}(M,1),M));
    V = zeros(M,2); % sparar magnituden av lägesförändringen
    R = zeros(M,1);
for i = 1:M-1
    
        V(i,1) = m1*(T{1,j}(i+1,2)-T{1,j}(i,2));
        V(i,2) = m1*(T{1,j}(i+1,4)-T{1,j}(i,4));      
end
    R(:,1) = V(:,1)+V(:,2);
    %hejhej
   figure(j);
   hold on;
   index = round((L(j)-t(1))*100,1)
   plot(t,R)
   plot(L(j),R(index),'o');
   grid; 
end