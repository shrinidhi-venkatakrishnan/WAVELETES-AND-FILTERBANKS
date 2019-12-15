function [] = test_translation (image, template, k, path)
indx = 100000;
%% Code for translation and Scale Invariant template matching

[m,n,~] = size(image);
[m_t,n_t,~] = size(template);

%% Display noisy image and template

figure, imshow(template);
figure, imshow(image);


%% Denoise Image 

denoise_rgb = denoise_final(image);
figure, imshow(denoise_rgb);
image = rgb2gray(denoise_rgb);
template = rgb2gray(template);
%% Translation determination using SIFT Matching  

% average_translation = translation_SIFT(image, template);


%% Translation determination using SURF Matching  

average_translation = translation_SURF_1(image, template)

%% Plot Translation 
figure,
RGB = insertShape(denoise_rgb,'circle',[average_translation,5],'LineWidth',5);
imshow(RGB)

%% Translate template by same factor
template_translated = zeros(m,n);
template_translated(average_translation(2):average_translation(2)+m_t-1,average_translation(1):average_translation(1)+n_t-1) = template;

%% 
temp_template = template_translated ;

%% Dispay Image and Template
figure, imshow((temp_template),[]);
figure, imshow((image),[]);
image_64 = image;
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

%% find the first row with unique values 

for i = 1:m
    temp = unique(H_1(i,:));
    if (length(temp)>1)
        [~, argument] = max(H_1(i,:));
        break;
    end
end

scale = 2^(argument-1);
%% 
disp(scale)
%% 
m_rt = m_t*scale;
n_rt = n_t*scale;

h = figure;
imshow(denoise_rgb);
hold on;
rectangle('Position',[average_translation(1), average_translation(2), ceil(m_rt), ceil(n_rt) ],'LineWidth',3);
hold off
% filename = strcat(path,'Result_video\','track_frame',num2str(indx + k),'.jpg');
% saveas(h,filename);






