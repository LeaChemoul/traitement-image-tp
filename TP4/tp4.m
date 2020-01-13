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

# closed/opened

function [im_closed, im_opened] = close_open(im, strel_size, strel_shape = "square", shape = "same")
  im_closed = 255 - imerode(imdilate(255-im, strel(strel_shape, strel_size), shape), strel(strel_shape, strel_size), 'same');
  im_opened = 255 - imdilate(imerode(255-im, strel(strel_shape, strel_size), shape), strel(strel_shape, strel_size), 'same');
endfunction

[cameraman_fermeture, cameraman_ouverture] = close_open(cameraman, 3);

figure;
subplot(1, 3, 1);
imshow(cameraman);
title("Cameraman original");
subplot(1, 3, 2);
imshow(cameraman_fermeture);
title("Cameramn closed");
f = subplot(1, 3, 3);
imshow(cameraman_ouverture);
title("Cameraman opened");

saveas(f, "output/cameraman_closed_opened.png");
close all hidden;

# 2 - Contours

cameraman_gradient = imdilate(cameraman, strel("square", 3), 'same') - imerode(cameraman, strel("square", 3), 'same');

figure;
subplot(1, 2, 1);
imshow(cameraman);
title("Cameraman original");
subplot(1, 2, 2);
imshow(cameraman_gradient);
title("Cameramn gradient");

saveas(f, "output/cameraman_gradient.png");

# 3 - Débruitage



% Comment the following line to keep the images displayed during execution.
%close all hidden;
