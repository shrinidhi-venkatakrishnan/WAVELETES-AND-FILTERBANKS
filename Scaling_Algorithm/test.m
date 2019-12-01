close all 
clear all 


image = double(rgb2gray(imread('shelf_big.jpg')));
n_bit = ceil(log2(max(max(image))))
[m,n] = size(image);
% n_new = min(m,n);
image = imresize(image, [m,n]);
template = double(rgb2gray(imread('template.jpg')));
[mt, nt] = size(template);
temp_template = zeros(m, n);

temp_template(1:mt,1:nt) = template;

figure, imshow(uint8(temp_template));
figure, imshow(uint8(image));

%% Silhouettes of image and template

avg_image = mean2(image);
image_mod = zeros(m,n);
for i= 1:m
    for j = 1:n
        if (image(i,j)>avg_image)
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
%% 
% template_position = imagecorrelation2(temp_template, image)
H_1 = himage(template_mod,image_mod)

    

