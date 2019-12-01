close all
clear all
clc

%% 
image = double(rgb2gray(imread('tiger_template.jpg')));
template =  double(rgb2gray(imread('tiger_template.jpg')));
image_64 = imresize(image, [128 128]);
template_32 = imresize(template, [32 32]);
% image_64 = image;
% template_32 = template;
%%
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
%% 
% template_position = imagecorrelation2(temp_template, image)
H_1 = himage(template_mod,image_mod);
% H_1 = haarshsc(template_mod, image_mod);

%%
[max_val, translation_row] = max(H_1');
% [max_val2 , 





%%
% template_scaled = imresize(template_32, [mt*scale_factor, nt*scale_factor]);
% c = normxcorr2(template_scaled,image_64);
% figure, imagesc(c); colorbar;
% 
% figure, surf(c), shading flat
% 
% %%
% % 
% % [ypeak, xpeak] = find(c==max(c(:)));
% % yoffSet = ypeak-size(template_scaled,1);
% % xoffSet = xpeak-size(template_scaled,2);
% % 
% % figure
% % imshow(image_64,[]);
% % imrect(gca, [xoffSet+1, yoffSet+1, size(template_scaled,2), size(template_scaled,1)]);
% 
% % figure, 
% % subplot(1,2,1)
% % imshow(uint8(template_scaled))
% % 
% % subplot(1,2,2)
% % imshow(uint8(image_64))
% 
% 
% 
% % [trans_max, transition_row] = max(max_val);
% % [val, scale_column] = max(H_1(transition_row,:));
% % disp(scale_column);
% % disp(transition_row);
% 
% 
% 
% %% 
% 




    



