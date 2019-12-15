close all
clear all
clc


k = 1 
path = 'test'
template_original = (im2double(imread('shelf_1_template.jpg')));
template = imresize3(template_original, [64,64,3]);
image_clear_rgb = im2double(imread('shelf_1.jpg'));
image_clear_rgb = imresize3(image_clear_rgb, [512,512,3]);
image_noisy=imnoise(image_clear_rgb,'gaussian',0,0.02);
test_translation(image_noisy,template,k, path);

