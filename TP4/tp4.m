# Traitement d'Image

pkg load image

# TP4

# 1 - Fermeture

[cameraman, map_cameraman, alpha_cameraman] = imread("data/cameraman.jpg");

function [im_erode, im_dilate] = erode_dilate(im, strel_size, strel_shape = "square", shape = "same")
	im_erode = 255-imerode(255-im, strel(strel_shape, strel_size), shape);
	im_dilate = 255-imdilate(255-im, strel(strel_shape, strel_size), shape);
endfunction

[cameraman_erode, cameraman_dilate] = erode_dilate(cameraman, 3);

figure;
subplot(1, 3, 1);
imshow(cameraman);
title("Cameraman original");
subplot(1, 3, 2);
imshow(cameraman_erode);
title("Cameramn eroded");
f = subplot(1, 3, 3);
imshow(cameraman_dilate);
title("Cameraman dilated");
saveas(f, "output/cameraman_erode_dilate.png");

# Impact of strel size

[cameraman_erode_5, cameraman_dilate_5] = erode_dilate(cameraman, 5);
[cameraman_erode_10, cameraman_dilate_10] = erode_dilate(cameraman, 10);

figure;
subplot(3, 2, 1);
imshow(cameraman_erode);
title("Cameramn eroded 3x3");
subplot(3, 2, 2);
imshow(cameraman_dilate);
title("Cameraman dilated 3x3");
subplot(3, 2, 3);
imshow(cameraman_erode_5);
title("Cameramn eroded 5x5");
subplot(3, 2, 4);
imshow(cameraman_dilate_5);
title("Cameraman dilated 5x5");
subplot(3, 2, 5);
imshow(cameraman_erode_10);
title("Cameramn eroded 10x10");
f = subplot(3, 2, 6);
imshow(cameraman_dilate_10);
title("Cameraman dilated 10x10");
saveas(f, "output/cameraman_erode_dilate_3_5_10.png");

# 2 - Contours



# 3 - Débruitage



% Comment the following line to keep the images displayed during execution.
%close all hidden;
