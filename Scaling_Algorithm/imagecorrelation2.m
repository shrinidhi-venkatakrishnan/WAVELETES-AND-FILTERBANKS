function out = imagecorrelation2(A,B)
%Finds the point of correlation between a template and an image
%input order doesn't matter- template or image could be first
[m1,n1,k1] = size(A);
[m2,n2,k2] = size(B);
%In case the input images are in color, we convert them to black&white
if k1>1
A=rgb2gray(A);
end
if k2>1
B=rgb2gray(B);
end
%The following group of code normalizes the pixel to all be roots of unity
%Without this step the program won't find the correct correlation
C=zeros(1,257);
C(1,1)=1;
C(1,257)=-1;
w=roots(C);
w
A2=zeros(m1,n1);
B2=zeros(m2,n2);
for i=1:m1
for j=1:n1
A2(i,j)=w(A(i,j)+1);
end
end
for i=1:m2
for j=1:n2
B2(i,j)=w(B(i,j)+1);
end
end
%Here is the one line which implements the Correlation Theorem
X= ifft2((conj(fft2(A2, m2, n2)).*fft2(B2)));
%We find the maximum and output the indices at which it occurs
[x,y]=max(X(:));
[i,j]=ind2sub(size(X), y)
%This simply makes the point of correlation easier to visually see- now it
%is a 10x10 box of white instead of only 1 pixel
corr=zeros(size(X));
for a=i:i+10
for b=j:j+10
corr(a,b)=1;
end
end
%We plot the inputs and results
subplot(2,2,1), imshow(A);
title('Template');
subplot(2,2,2), imshow(B);
title('Image');
subplot(2,2,3), imshow(corr);
title('Point of Correlation')