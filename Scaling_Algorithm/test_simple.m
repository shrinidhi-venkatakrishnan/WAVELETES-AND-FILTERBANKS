close all
clear all
clc

%% Input Image and Template
image = double(rgb2gray(imread('shelf_1_template.jpg')));
template =  double(rgb2gray(imread('shelf_1_template.jpg')));
image_64 = imresize(image, [128 128]);
template_32 = imresize(template, [32 32]);
% image_64 = image;
% template_32 = template;
%% Dispay Image and Template
[m,n] = size(image_64);
% n_new = min(m,n);
% image_64 = imresize(image_64, [m,n]);
[mt, nt] = size(template_32);
temp_template = zeros(m, n);

temp_template(1:mt,1:nt) = template_32;

figure, imshow((temp_template),[]);
figure, imshow((image_64),[]);

%% Silhouettes of image and template

avg_image = mean2(image_64);
image_mod = zeros(m,n);
for i= 1:m
    for j = 1:n
        if (image_64(i,j)>avg_image)
            image_mod(i,j) = 1;
        else 
            image_mod(i,j) = -1;
        end
    end
end
            
avg_template = mean2(temp_template);
template_mod = zeros(m,n);
for i= 1:m
    for j = 1:n
        if (temp_template(i,j)>avg_template)
            template_mod(i,j) = 1;
        else 
            template_mod(i,j) = -1;
        end
    end
end
%% Perform Hadamard Transform 
H_1 = himage(template_mod,image_mod);

%%




    



