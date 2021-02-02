function [R_values,X_values,Y_values] = create_model(maskdata,no_of_images)
%{
this program calculates the average of radius and center coordinate values
in mask_data and uses the averaged out values to create third degree polynomial 
models for radius and center. Parameters of each model are returned separately as 
a vector.
%}

close all;
clear variables;
clc;

%extracting size of mask data, S represents The total number of samples
%whereas B represents the total number of batches 
[S, B] = size(maskdata);

%initlaizing variables to extract values and take average
radius_sum = 0; 
x_cord_sum = 0;
y_cord_sum = 0;

radius_avdata = zeros(1,S);
x_cord_avdata = zeros(1,S);
y_cord_avdata = zeros(1,S);

%{
x coordinates for creating the model will range for 1 to total no. of images
as we are trying to predict values for all images
%}
x_cord_model(1:no_of_images) = 1:no_of_images;

for i = 1:S          % for each sample image
    for j = 1:B        % for sample image data in each batch
        
        % sum radius, x-axis and y-axis values
        radius_sum = radius_sum + maskdata{i,j}(1);
        x_cord_sum = x_cord_sum + maskdata{i,j}(2);
        y_cord_sum = y_cord_sum + maskdata{i,j}(2);
    end 
    
    % take the average and store it in an array
    radius_avdata(1,i) = radius_sum/B;
    x_cord_avdata(1,i) = x_cord_sum/B;
    y_cord_avdata(1,i) = y_cord_sum/B;
end

%curve fitting (third degree polynomial) 
[p_R1,p_R2,p_R3,p_R4] = polyfit(x_cord_model,radius_avdata,3);
[p_X1,p_X2,p_X3,p_X4]= polyfit(x_cord_model,x_cord_avdata,3);
[p_Y1,p_Y2,p_Y3,p_Y4] = polyfit(x_cord_model,x_cord_avdata,3);

%3rd degree polynomial model for radius
R_values = (p_R1*x.^3) + (p_R2*x.^2) + (p_R3*x) + p_R4;

%3rd degree polynomial model for x-coordinates
X_values = (p_X1*x.^3) + (p_X2*x.^2) + (p_X3*x) + p_X4;

%3rd degree polynomial model for y-coordinates
Y_values = (p_Y1*x.^3) + (p_Y2*x.^2) + (p_Y3*x) + p_Y4;

end

