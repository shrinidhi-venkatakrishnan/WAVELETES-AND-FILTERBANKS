function X = convertbw(A)
[n,m,k] = size(A);
%First we convert the image to grayscale if it was in color
if k>1
A=rgb2gray(A);
end
%Take the treshold to be the average pixel value
thresh=mean(A(:));
X=zeros(n,m);
%For all pixels above the treshold, set them equal to 1, and all below
%the threshold set to 0
for i=1:n
for j=1:m
if A(i,j)>=thresh
X(i,j)=1;
else
X(i,j)=0;
end
end
end