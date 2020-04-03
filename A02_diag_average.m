function R = diag_average(A)
B=fliplr(A);
[m,n] = size(A);
R1 = zeros(1,m+n-1);
for i = (-m+1)+m:n-1+m
   R1(i) = sum(diag(B,i-m))/length(diag(B,i-m)); 
end
R = fliplr(R1);
end

