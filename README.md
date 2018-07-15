# Thermal-Imaging-Project-update1
All unnecessary functions and files have been removed, however documentation still needs updation.


TECH-TAILOR THERMAL IMAGING PROJECT

1. TAKING IMAGES:
1. Install FLIR ONE App on your smart phone.
2. Now take the images of the person in different postures.
The different postures are:
i.	Front view with the hands of the person are away from the body making an angle of 45 degrees with the body.
ii.	The side view of the person with hands close to the body.
iii.	The side view of the person with one leg on the ground and another raised to a height from the ground, such that a 90 degree angle is made at the knee.
Note: Care should be taken that the distance of the person from the camera should not be changed while taking images in different postures, also the camera or the person shouldn’t move sideways.  

2. CONVERTING THE THERMAL IMAGE INTO A MATRIX:
3. Now transfer the images into your PC.
4. Install FLIR TOOLS application on your PC and open these images in the application.
5. After opening right click on the image and use ‘export to csv’ option to convert the image into a “.csv” format (matrix format) and save it with a name.

3. CONVERTING THE INTENSITY IMAGE INTO A BINARY IMAGE:
6. In MATLAB use “initiate2” function to convert the image into a binary image.
Ex: filename= 'n1.csv';
   comb=initiate2(filename);
Here comb is the binary image of the thermal image.
About “initiate2” function:
The “initiate2” function thresholds the intensity or grayscale image into a binary image.
Initially for thresholding methods like using mean, mode, median, Otsu’s method were tried. But they failed.
So, the current method being used for thresholding is to take the histogram of intensities in the image and smooth the histogram using Savitzky-Golay filter wit window length 45, polynomial order 3, eight times. And now the x-value on the histogram of the minimum after the global maximum is the required threshold value.
Now the pixels with higher than the threshold value are given value 255, else they are given 0.
The pixels with intensity=255 are our foreground and ones with intensity=0 are our background pixels.

5.ALIGNING THE FRONT VIEW IMAGE AND SIDE VIEW IMAGES
Now, the images of side view, front view should be adjusted such that the ‘ymin’ of both the images is equal ,inorder to find out the measurements.
It is done by using the function “alignfun”.
Ex: [a1,a2]=alignfun(A1,A2)
Here A1,A2 are the front and side views which are not adjusted and a1, a2 are the adjusted ones.

6. SMOOTHENING THE IMAGE BOUNDARIES
The image boundaries are smoothened by using Savitzky-Golay filterinorder to eliminate any unwanted irregularities on the boundary of the image. This is done by using “mysmooth” function.
Ex:[X1,Y1,x1,y1]=mysmooth(A1);
 A1 is the binary image and X1,Y1 are the matrices containing the x,y values of the boundaries of the smoothened image.
*For the front view images, checkthe graph of the distance from centroid to points on the boundary of the image and  reject the image if the graph is not symmetric to the vertical axis from the center of the graph*
7. Feature Points Detection
After the above step of removing the cloth distortion and smoothening out the edges we have to find out the feature points by using these functions.
I.cro=crotchfn(a1,C,X1,Y1);
This function is used to find out the Crotch point Index from the front view.
hip =hipfn(C2,X2,Y2);
This function is used to get the hip location from the side view. As both the images are aligned in previous steps now they are in same level to get the front view points.
hiplevel=y2(hip);
[location1,p1]=new_right_points(a1,X1,Y1,x1,y1,C,cro,hiplevel);
[location2,p2]=new_left_points(a1,X1,Y1,x1,y1,C,cro,hiplevel);
Above 2 functions are used to find out the feature points in the front view and later they are translated to the side view of to get same level. Input parameters are 
a1 : Image itself
X,y,X,Y are the boundaries in x and y axis and X & Y are smoothened boundaries.
And other parameters are cro crotch index, hiplevel height level of the hip and C is centroid of the blob from front view.
 II. Another front facing image is taken with the dropped hands to get shoulder curve edge to find out the shoulder and sleeve used in shirt measurement.
Function named 
function sh=leftsh(c,X,Y)
"sh" is the index in X and Y for the shoulder point and mapped on the blob
For getting the right shoulder just flip the image and use the same function to get the same point now we can mirror that point by (size(image,2)-x(rh) , y(rh)). This will be the required point.
III. We have to take another side facing image to find out knee point and knee measurement by taking an image of bent knee for location of edge and mapped in same way to find out its location to measure the knee.

8. Aligning 
Points are aligned and adjusted from front view and side view to get to get mapped points in both the views.
Now P consists of front view feature points and Ps consists of  side view.
Location 1 consists of Neck points.
Location 2 consists of High peak of shoulder points.
Location 3 consists of Armpit points.
Location 4 consists of Crotch or Thigh points.
Location 5 consists of Hip points.
Location 6 consists of Shirt Waist points.
Location 7 consists of Trouser waist points.

9.Finding Measurements from Feature Points.
After getting the featured points form Point detection function now we have do get the measurements. 
Functions like 
t1=measurethigh(P,ps); 
t2=measureneck(P,ps);
t3=measureinseam(Y,P);
t4=measurehip(P,ps);
t5=measurechest(P,ps);
t6= measurenbicep(leftloc,rightloc,X1,Y1);
t7=measuretrouserwaist(P,ps);
t8=measureshirtwaist(P,ps);
t9=measureoutseam(Y,P);
All these functions are used to find out to measureThigh , Neck , Inseam , Hip , Chest , Bicep , Trouser Waist , Shirt Waist and Out seam respectively.

10. Convert Pixel Length To Actual Length
For temporary purposes we take the physical or original height of the training example . In other side take the Height of blob by using maximum – minimum. From this ratio we will get the pixel to body ratio. 
From the measurements which we got from the above function we have to multiply with the ratio to get measurements in Inches.

