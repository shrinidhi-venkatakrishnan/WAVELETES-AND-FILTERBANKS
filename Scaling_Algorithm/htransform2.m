function H = htransform2 (temp,new)
[n,m]=size(temp);
Ht=hadamard(n)*temp;
Hv=hadamard(n)*new;
%The vectors x and b created below are needed for the S permutation matrix,
%and adjustments of +/- 1 have to be made for the indices because Matlab
%labels vectors and matrices beginning with 1 instead of 0, as the
%algorithm dictates.
x=zeros(n,log2(n));
for i=1:n
for j=1:log2(n)
s=(spermutation(n,n))^(j-1);
sHv=s*Hv;
H(i,j) = (Ht(i,1))*(sHv(i,1));
end
end
%The line below gives the same result as taking the first row of the result
%of using the inverse Hadamard matrix
H=ones(1,n)*H;