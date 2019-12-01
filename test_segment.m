%% Read images
close all
clear all 
clc 

level = 1;

image = (im2double(imread('shelf_1.jpg')));
figure, imshow(image);
[m,n,z] = size(image);
image_resize_rgb = imresize3(image, [ceil(m/2^level), ceil(n/2^level),3]);
image = rgb2gray(image);
image_resize = imresize(image, [ceil(m/2^level), ceil(n/2^level)]);
template = (im2double(imread('shelf_1_template.jpg')));
[m_t,n_t,z_t] = size(template);

template_resize_rgb = imresize3(template, [ceil(m_t/2^level), ceil(n_t/2^level), 3]);
figure, imshow(template)

%% 
% disp(size(template_resize_rgb))

%% Apply DWT for images in 2 levels 

[c,s]=wavedec2(image,level,'haar');
[H2,V2,D2] = detcoef2('all',c,s,level);
A2 = appcoef2(c,s,'haar',level);
V2img = wcodemat(V2,255,'mat',1);
H2img = wcodemat(H2,255,'mat',1);
D2img = wcodemat(D2,255,'mat',1);
A2img = wcodemat(A2,255,'mat',1);

figure
subplot(2,2,1);
imagesc(A2img);
colormap gray
title('Approximation Coef. of Level 2');

subplot(2,2,2);
imagesc(H2img);
title('Horizontal Detail Coef. of Level 2');

subplot(2,2,3)
imagesc(V2img);
title('Vertical Detail Coef. of Level 2');

subplot(2,2,4);
imagesc(D2img);
title('Diagonal Detail Coef. of Level 2');

D2img = (D2img - mean2(D2img))*255/(max(D2img(:)) - min(D2img(:)));

%% Binarization

threshold = mean2(D2img);
r = ceil(m/(2^level));
c = ceil(n/(2^level));
d_binary = zeros(r,c);

for i= 1:r
    for j = 1:c
        if (D2img(i,j)>threshold)
            d_binary(i,j) = 1;
        end
    end
end

figure, imshow(d_binary);

%% Segmentation

figure, imshowpair(image_resize,d_binary);


%% Dilation 
se90 = strel('line',3,90);
se0 = strel('line',3,0);
BWs = d_binary
BWdfill = imfill(d_binary,'holes');
figure, imshow(BWdfill);
title('Binary Image with Filled Holes')
title('Dilated Gradient Mask')
BWsdil = imdilate(BWs,[se90 se0]);
figure, imshow(BWsdil);
title('Dilated Gradient Mask')
seD = strel('diamond',1);
BWnobord = imclearborder(BWdfill);
figure, imshow(BWnobord);
title('Cleared Border Image')
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);
figure, imshow(BWfinal);
title('Segmented Image');

% BWfinal = BWsdil
%% 
% read the input binary image 

% calculating size of the image 

[row col] = size(BWfinal);

% removing black portion on top side of the image 
  for i = 1:row
    if sum(BWfinal(i,:)) > 0
        top = i;
        break
    end
  end

% removing black portion on bottom side of the image 
  for i = row:(-1):1
    if sum(BWfinal(i,:)) > 0
        bottom = i;
        break
    end
  end

% removing black portion on left side of the image 
  for i = 1:col
    if sum(BWfinal(:,i)) > 0
        left = i;
        break
    end
  end

% removing black portion on right side of the image 
  for i = col:(-1):1
    if sum(BWfinal(:,i)) > 0
        right = i;
        break
    end
  end

% output image  
 output = image_resize_rgb(top:bottom, left:right,:);
 figure, imshow(output);
 
 %% Correlation of image and template
 
 tic; 
 red_cor_image = normxcorr2(template_resize_rgb(:,:,1), output(:,:,1));
 blue_cor_image = normxcorr2(template_resize_rgb(:,:,2), output(:,:,2));
 green_cor_image = normxcorr2(template_resize_rgb(:,:,3), output(:,:,3));
 elapsed_time = toc
 
 corr_output = (red_cor_image + green_cor_image + blue_cor_image)/3;
 
 %%
figure,
imagesc(corr_output); 
colorbar

%%
[m_rt, n_rt, z_rt] = size(template_resize_rgb);
maxx=max(corr_output(:));
[a,b,c]=find(corr_output==maxx);
disp(a);
disp(b);

[cor_m,cor_n,cor_z]=size(corr_output);

cor_resize=imresize(output,[cor_m,cor_n]);
figure,
imshow(cor_resize);
hold on;

% Then, from the help:
rectangle('Position',[(b-n_rt/2)-10,(a-m_rt/2)-10,n_rt+10,m_rt+10],'LineWidth',3);

%% 

tic 
red_cor_image_old = normxcorr2(template_resize_rgb(:,:,1), image_resize_rgb(:,:,1));
blue_cor_image_old = normxcorr2(template_resize_rgb(:,:,2), image_resize_rgb(:,:,2));
green_cor_image_old = normxcorr2(template_resize_rgb(:,:,3), image_resize_rgb(:,:,3));
corr_output_old = (red_cor_image_old + green_cor_image_old + blue_cor_image_old)/3;

elapsed_time_old = toc

%%