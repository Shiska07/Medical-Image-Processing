function [maskdata,no_of_images,sampling_interval,filename,all_images] = read_dicom_data()
%This program will read in images so that a circular mask can be created
%for each image and used as a basis to create a function  for the mask
%function parameters for circle : radius and center 

close all;
clear variables;
clc;

filename = input('Please enter a filename containing the DICOM series data: ','s');
all_images = dir(fullfile(filename,'*.dcm'));                                                        %readind dicomimage data from a file
no_of_images = numel(all_images);

sampling_percent  = input('Please enter percentage of the data you would like to sample: ');
no_of_samples = ceil(sampling_percent/100*no_of_images);
sampling_interval = ceil(no_of_images/no_of_samples);

no_of_batches = input('How many batches would you like to sample? : ');

%initializing 2D cell array to store data for each sample in each batch
maskdata = cell(no_of_samples,no_of_batches);                                                                          

for k = 1:no_of_batches
    
    %initializing each cell to store a vector of size [1x3]
    for j = 1:no_of_samples
        maskdata{j,k} = zeros(1,3);
    end
    
    n = 1;
    for i = 1:sampling_interval:no_of_images               
        f = fullfile(filename, all_images(i).name);                                                   %reading one image at a time from the file
        A = dicomread(f);
        A = double(A);                                                                           %converting image to double
        imshow(A,[min(A,[],'all') max(A,[],'all')]);
        h = drawcircle();
        C = h.Center;
        R = h.Radius;
        maskdata{n,k}(1) = R;             %storing radius value
        maskdata{n,k}(2) = C(1);          %storing center x-coordinate
        maskdata{n,k}(3) = C(2);          %storing center y-coordinate
        n = n + 1;
    end
end

end
