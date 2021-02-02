%{
This program takes a DICOM series as input and writes  new set of DICOM
series with isolated region of interest
%}

close all;
clear variables;
clc;

[mask_data,no_of_images,sampling_interval,filename,all_images] = read_dicom_data();                       %returns a cell array with each column containg a set of sample data 
[R_values,X_values,Y_values] = create_model(mask_data,no_of_images);         %returns parameters for third degree polynomial model as a row vector

%reading filedata to apply mask
no_of_images = numel(all_images);

%defining structural element size
se_size = 5;

%creating strcuturing elements 
se_open1 = strel('disk',5);
se_open2 = strel('disk',10);
se_dilate = strel('disk',5);

%average filter
av_filter = fspecial('average',5);             

%obtaining uid for new dicomseries
uid = dicomuid; 

%creating and applying mask to each image
for n = 1:no_of_images
    
    %extract single image from file
    F = fullfile(filename, all_images(n).name);
    I = dicomread(F);
    I = double(I);
    I_copy = I/max(I,[],'all');
    
    %apply average filter and image opening 
    I_copy = histeq(I_copy,10);
    I_copy = imfilter(I_copy,av_filter);
    I_copy = imopen(I_copy,se_open1);
    
    %creating circular mask from model data
    circ = drawcircle('Center',[X_values(1,n),Y_values(1,n)],'Radius',R_values(1,n));
    BW = createMask(circ,I);
    
    %apply active contour taking image I as reference
    countours = activecontour(I_copy,BW,700);
    
    %combine circular and mask created via active contour
    BW = countours.*BW;
    
    %open the mask further to get rid of extrusions 
    BW = imopen(BW,se_open2);
    BW = imdilate(BW,se_dilate);
    
    %apply binary mask on original image adn display result
    I = I.*BW;
    max_value = max(I{n,1}, [], 'all');
    min_value = min(I{n,1}, [], 'all');
    imshow(I,[min_value max_value]);
    
    %store info to write new series
    info = dicominfo(F);
    info.SeriesInstanceUID = uid;
    
    %write new series with islated ROI
    str = strcat('B',num2str(n),'.dcm');
    A = uint16(I);
    dicomwrite(A,str,info);
end

