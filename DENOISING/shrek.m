function [imageReconstSoft,imageReconstHard]=shrek(I)
% I = double(rgb2gray(imread('case.jpg')));
[row,col]=size(I);
I=imresize(I,[256,256]);
% Daubechies D4 Filter
lpfCoeff =[0.48296 0.83652 0.22414 -0.12941];
% lpfCoeff=[0.707,0.707]; % HAAR WAVELET LPF


% Change level of Decmposition HERE
J = 4;

variance  = 20;

%gaussain white noise
gWNoise = randn(size(I)).*sqrt(variance);

%add noise to image
Inoise = I + gWNoise;

% DWT
[C, S, wc] = discreteWavletTrans(Inoise, J, lpfCoeff);

%estimation of noise level
nEle = S(J,1) * S(J,2);
hf = [C(1, nEle+1:2*nEle) C(1, 2*nEle+1:3*nEle) C(1, 3*nEle+1:4*nEle)];

%calculate sigma
sigma=median(abs(hf))/0.6745;

threshold=3*sigma;

% Soft thresholding
CSoft = (sign(C).*(abs(C)-threshold)).*((abs(C)>threshold));

%Hard Thresholding
CHard = C.*((abs(C)>threshold));

%reconstruction with soft and hard thresholds
imageReconstSoft1 = InvdiscreteWavletTrans(CSoft, S, J, lpfCoeff);
imageReconstHard1 = InvdiscreteWavletTrans(CHard, S, J, lpfCoeff);
imageReconstSoft=imresize(imageReconstSoft1,[row,col]);
imageReconstHard=imresize(imageReconstHard1,[row,col]);
end
