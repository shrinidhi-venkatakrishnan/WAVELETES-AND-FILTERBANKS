function S = spermutation(n,m)
S=zeros(n,m);
for i=1:n
for j=1:m
a=zeros(log2(n),1);
a(1:ceil(log2(i)))=de2bi(i-1);
b=zeros(log2(n),1);
b(1:ceil(log2(j)))=de2bi(j-1);
if a==circshift(b,-1)
S(i,j)=1;
end
end
end