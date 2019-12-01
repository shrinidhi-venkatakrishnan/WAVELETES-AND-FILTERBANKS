function H = hadamard(L)
%Creates an nxn Hademard matrix, where n is the smallest power of 2
%still greater than the input L
n=ceil(log2(L));
for i=1:2^n
for j=1:2^n
H(i,j)=(-1)^(de2bi(i-1,n)*de2bi(j-1,n)');
end
end
%The line below can be uncommented to create an orthonormal Hadamard matrix
%H = (1/sqrt(2^n))*H;