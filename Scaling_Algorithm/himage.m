function H = himage(temp, image)
[n1,m1,k1] = size(temp);
n1
m1
[n2,m2,k2] = size(image);
%First change the inputs to have values of +/-1 instead of 1s and0 0s
for i=1:n1
for j=1:m1
if temp(i,j)==0
temp(i,j)=-1;
end
if image(i,j)==0
image(i,j)=-1;
end
end
end
%The following is the implementation of the algorithm- to adapt it to
%images we have to multiply S by the transpose of the matrix twice
%essentially, so we look at S[((S^j)Hv')'] instead of just (S^j)Hv
H_temp = hadamard(n1);
disp(size(H_temp));

Ht=H_temp*temp;
Hv=hadamard(n1)*image;
for j=1:log2(n1)
s=(spermutation(n1,n1))^(j-1);
sHv=(spermutation(n1,n1)*(s*Hv)')';
H(1:n1,j) = (ones(1,n1)*(Ht.*sHv))';
end