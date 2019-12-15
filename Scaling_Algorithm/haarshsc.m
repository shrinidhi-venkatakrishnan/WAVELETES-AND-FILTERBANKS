function H = haarshsc (temp,new)
%Shifting and Scaling algorithm- temp should be the template, and "new" is
%the result of shifting and scaling the template by some power of 2
[n,m]=size(temp);
Ht=hadamard(n)*temp;
x=zeros(n,log2(n));
%The first for loop runs the algorithm over every possible shift of 2^k,
%and the second and third for loop are copied almost exactly from the
%htransform2.m file
for k=1:log2(n)
if k<2
Hv=hadamard(n)*new;
else
Hv=hadamard(n)*(circshift(new, -2^(k-1)));
end
for i=1:n
for j=1:log2(n)
b=zeros(log2(n),1);
b(1:ceil(log2(i)))=de2bi(i-1);
x(i,j)= (Ht(i,1)*Hv(bi2de(circshift(b',[1,j-1]))+1,1));
H(k,1:log2(n))=ones(1,n)*x;
end
end
end