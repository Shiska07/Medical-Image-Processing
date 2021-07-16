clc;
clear;
close all;

folder_name = "Blurred";
all_images = dir(fullfile(folder_name,'*.jpg')); 

no_of_images = numel(all_images);
single_file = fullfile(folder_name, all_images(1).name);
single_image = imread(single_file);

% store size
[R,C,Ch] = size(single_image);

% parameters for resizing image
R1 = 504;
C1 = 504; 

box_images(1:no_of_images,1:R1, 1:C1) = 0;      

% projection angles
theta = 0:11:360;

% extract same single layer from each image
for i = 1:no_of_images
    single_file = fullfile(folder_name, all_images(i).name);
    single_image = imread(single_file);
    I_gray = rgb2gray(single_image);
    I_gray = imresize(I_gray, [R1 C1]);
    I_gray = medfilt2(I_gray,[3,3]);
    
    imshow(I_gray); 
    impixelinfo;
    
    for j = 1:R1        % for each row/layer in the image
        box_images(i,j,:) = I_gray(j,:);
    end 
end

% single_vector will store one row of an image at a time
single_vector(1:C1) = 0;

% 2D array that stores single layer values for all images
% Eg: 500th row/layer of all 36 images stored as a 2D array
single_layer(1:no_of_images, 1:C1) = 0;

% transform and store values
for i = 1:R1                
    % this loop stores ith row of all 36 images into single_later
    for j = 1:no_of_images                
        single_vector = box_images(j,i,:);
        single_layer(j,:) = single_vector;
    end
    
    % transpose the 2D array and get the inverse radon transform
    single_layer_t = transpose(single_layer);
    IR = iradon(single_layer_t, theta);
    
    % get size of the transformed image
    [R_I,C_I] = size(IR);              
    max_value = max(IR,[],'all');
    
    % normalize image values for displaying
    IR = IR/max_value;
    IR = imcomplement(IR);
    imagesc(IR);
    colormap gray;
    impixelinfo;
    
    % store in a 3D array 
    transformed_layer(i,1:C_I,1:R_I) = IR;
end

intensity = [-3024,-16.45,641.38,3071];
alpha = [0, 0, 0.72, 0.72];
color = ([0 0 0; 186 65 77; 231 208 141; 255 255 255]) ./ 255;
queryPoints = linspace(min(intensity),max(intensity),256);
alphamap = interp1(intensity,alpha,queryPoints)';
colormap = interp1(intensity,color,queryPoints);

volshow(transformed_layer,'Colormap',colormap,'Alphamap',alphamap);
