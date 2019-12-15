close 
clear 
clc

path = 'C:\Users\ssree\Desktop\ECE251C\Segmentation_Paper\dataset\';

%% Read Images - Template and Write frames of a Scene
a = VideoReader('conveyor_video_1.mp4');
indx = 100000;
for img = 1:a.NumFrames
    filename_image=strcat(path,'Video_Frames\','frame',num2str(indx + img),'.jpg');
    b = read(a, img);
    b = imresize3(b, [512,512,3]);
    imshow(b);
    imwrite(b,filename_image);
end

%% Add noise to the image 
    
%add noise to image
indx = 100000;
variance  = 0.02;
k = 14;
for i = 107:107
    filename_image=strcat(path,'Video_Frames\','frame',num2str(indx + i),'.jpg');
    filename_template=strcat(path,'Template_Frames\','temp_',num2str(indx + i),'.jpg');
    
    template_original = (im2double(imread(filename_template)));
    template = imresize3(template_original, [128,128,3]);
    image_clear_rgb = im2double(imread(filename_image));
    image_noisy=imnoise(image_clear_rgb,'gaussian',0,0.02);
    test_translation(image_noisy,template,k, path);
    k = k+1;
    disp(i)
end 

%% 




