%% Image Denoising
%reference of base code Gopikrishna et al. (2018)

% read the  imagE
I = double(imread('case.jpg'));

% Daubechies D4 Filter
lpfCoeff =[0.48296 0.83652 0.22414 -0.12941];
% HAAR Filter
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
imageReconstSoft = InvdiscreteWavletTrans(CSoft, S, J, lpfCoeff);
imageReconstHard = InvdiscreteWavletTrans(CHard, S, J, lpfCoeff);

figure(4)
subplot(2,2,1), affiche(I), title('original image');
subplot(2,2,2),affiche(Inoise), title(['Noise Image,  variance :', num2str(variance)]);
subplot(2,2,3),affiche(imageReconstSoft), title('Denoise Soft Thresholding')
subplot(2,2,4),affiche(imageReconstHard), title('Denoise Hard Thresholding')

meanSqErrorSoft = mean((I(:)-imageReconstSoft(:)).^2)
meanSqErrorHard = mean((I(:)-imageReconstHard(:)).^2)

% performance metric calculation
meanSqErrorSoft = mean((I(:)-imageReconstSoft(:)).^2);
meanSqErrorHard = mean((I(:)-imageReconstHard(:)).^2);
psnr_hard=10*log10(max(255^2/meanSqErrorHard))
ssim_hard=ssim(I,imageReconstHard)
psnr_soft=10*log10(max(255^2/meanSqErrorSoft))
ssim_soft=ssim(I,imageReconstSoft)


