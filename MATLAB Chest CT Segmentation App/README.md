Chest CT Segmentation Guide
The chest CT segmentation app was created using the MATLAB app designer tool. This application provides the user with a under friendly interface to segment chest CT scan images and create a completely new series of images with a new Unique Identifier(uid). Unique Identifiers are a series of numbers unique to each set of medical imaging data in DICOM format. 
Note: The Chest CT Segmentation app is exclusively created for segmentation of medical images in DICOM format (.dcm extension). The program works best with axial scans.

Axial Chest CT scan example: 
 
                          Image obtained from https://radiologykey.com/cardiac-anatomy-using-ct/
Application UI
The application exhibits a simple interface with self-explanatory features designed to guide the user through a seamless segmentation experience. To install the app, open MATLAB first and then click on the application file. On being asked whether you want to install the file, click ‘install’. The application will appear under ‘APPS’.

<img src = "Images/chest_CT-example.jpg" width = 600>


A)	Loading Your Images 
1.	To load your images, simply enter the filename and press the ‘Load File’ button if the file is in the same folder as your MATLAB interface.
2.	If your files are in a different location, enter the file path instead.
3.	Note: You DICOM series of images MUST be placed in a folder and the same folder name must be used to load your files.





























4.	After loading a file, you can either use the series uid created by the program or enter a custom uid.
5.	Note: Every time you load a new folder, the images get associated with a newly created uid.
6.	Using custom uid allows you to write images as a part of the same series. This can be useful while working with file containing a large number of pictures as segmenting all images in one sitting may be unfeasible. 
 
























	





















	
B)	Cropping
Cropping the images to get rid of black regions towards the boundary can be beneficial especially in cases of images in which histogram equalization must be done for accurate edge detection. 

1.	To create a rectangular crop on the image, click ‘Manual Entry’ and enter coordinate points (x, y, width, height) of the rectangle. After entering all four values, click ‘Apply’. 

  






























2.	You can also crop by clicking ‘Crop Image’ and drawing a rectangular region directly on top of the image. 






































3.	Note: Click ‘Manual Entry’ or ‘Crop Image’ to reset the image and start cropping again.

C)	Selecting Circular Region of Interest (ROI)

1.	After cropping, click ‘Draw ROI’ to draw a circular region of interest on top of the image. 
















	

2.	The circular ROI drawn will behave as a staring point for active contours edge detection algorithm. Region inside the circular ROI will be saved and everything outside the ROI will be eliminated.




















3.	Click ‘Redraw’ to remove the previous ROI and draw a new one.


















	

D)	Apply Binary Mask

1.	Once the circular ROI has been drawn, the isolated image will appear under ‘ROI Image’. Click ‘Apply Mask’ to save this image.
2.	Click ‘Proceed’ to move to the next image or “Exit’ to close the program.

















E)	Histogram Equalization

Applying histogram equalization can increase efficiency of edge detection in some scenarios where the boundary of an object cannot be distinguished easily. 
 
1.	The histogram equalization switch will be enabled after the image has been cropped. 



















2.	The equalized image can be seen under ‘Equalized Image’. 
3.	Click ‘Apply Equalization’ to use equalized image.



















4.	Click ‘Draw ROI’ to draw circular region of interest.



















	
 	



F)	Using Last ROI

The ‘Last ROI’ button can be used to apply the last binary mask to the current image. This can be useful during medical image segmentation as consecutive images tend to have very similar or same regions of interest.

1.	After clicking ‘Proceed’ the program will load the next image. Click ‘Last ROI’ to direly obtained the segmented image without having to crop or draw circular ROI. 
 
















	

2.	Click ‘Apply Mask’ to save the ‘ROI Image’ or click ‘Manual Entry’/’Crop Image’ to reset the image.

 


3.	After all the images have been segmented, the user will be prompted to exit. 

















Added functionality as of 2/10/21
G)	Using Freehand
The freehand option allows the user to draw any ROI on the image freely.

1.	To begin drawing, crop the image and click on ‘Freehand’.
















2.	Hover your mouse pointer on top of the image until a ‘+’ cursor appears and start drawing. 



















 
