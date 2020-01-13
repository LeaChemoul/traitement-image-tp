# Traitement d'Image

pkg load image

# TP4

# 1 - Fermeture

[cameraman, map_cameraman, alpha_cameraman] = imread("data/cameraman.jpg");

function [im_erode, im_dilate] = erode_dilate(im, strel_size, strel_shape = "square", shape = "same")
	se = 0;
	if (strcmp(strel_shape, "disk") == 1)
		se = strel(strel_shape, strel_size, 0);
	else
		se = strel(strel_shape, strel_size);
	endif
	im_erode = 255-imerode(255-im, se, shape);
	im_dilate = 255-imdilate(255-im, se, shape);
endfunction

[cameraman_erode_square_3, cameraman_dilate_square_3] = erode_dilate(cameraman, 3);

figure;
subplot(1, 3, 1);
imshow(cameraman);
title("Cameraman original");
subplot(1, 3, 2);
imshow(cameraman_erode_square_3);
title("Cameramn eroded");
f = subplot(1, 3, 3);
imshow(cameraman_dilate_square_3);
title("Cameraman dilated");
saveas(f, "output/cameraman_erode_dilate_square_3.png");

# Impact of strel size

[cameraman_erode_square_5, cameraman_dilate_square_5] = erode_dilate(cameraman, 5);
[cameraman_erode_square_10, cameraman_dilate_square_10] = erode_dilate(cameraman, 10);

figure;
subplot(3, 2, 1);
imshow(cameraman_erode_square_3);
title("Cameraman eroded 3x3");
subplot(3, 2, 2);
imshow(cameraman_dilate_square_3);
title("Cameraman dilated 3x3");
subplot(3, 2, 3);
imshow(cameraman_erode_square_5);
title("Cameraman eroded 5x5");
subplot(3, 2, 4);
imshow(cameraman_dilate_square_5);
title("Cameraman dilated 5x5");
subplot(3, 2, 5);
imshow(cameraman_erode_square_10);
title("Cameraman eroded 10x10");
f = subplot(3, 2, 6);
imshow(cameraman_dilate_square_10);
title("Cameraman dilated 10x10");
saveas(f, "output/cameraman_erode_dilate_square_3_5_10.png");

# Impact of strel shape

[cameraman_erode_diamond_5, cameraman_dilate_diamond_5] = erode_dilate(cameraman, 5, "diamond");
[cameraman_erode_disk_5, cameraman_dilate_disk_5] = erode_dilate(cameraman, 5, "disk");

figure;
subplot(3, 2, 1);
imshow(cameraman_erode_square_5);
title("Cameraman, eroded (square, 5x5)");
subplot(3, 2, 2);
imshow(cameraman_dilate_square_5);
title("Cameraman, dilated (square, 5x5)");
subplot(3, 2, 3);
imshow(cameraman_erode_diamond_5);
title("Cameraman, eroded (diamond, 5x5)");
subplot(3, 2, 4);
imshow(cameraman_dilate_diamond_5);
title("Cameraman, dilated (diamond, 5x5)");
subplot(3, 2, 5);
imshow(cameraman_erode_disk_5);
title("Cameraman, eroded (disk, 5x5)");
f = subplot(3, 2, 6);
imshow(cameraman_dilate_disk_5);
title("Cameraman, dilated (disk, 5x5)");
saveas(f, "output/cameraman_square_diamond_disk_5.png");

cameraman_fermeture = imerode(cameraman_dilate_square_3, strel("square", 3), 'same');
cameraman_ouverture = imdilate(cameraman_erode_square_3, strel("square", 3), 'same');

# closed/opened

function [im_closed, im_opened] = close_open(im, strel_size, strel_shape = "square", shape = "same")
	se = 0;
	if (strcmp(strel_shape, "disk") == 1)
		se = strel(strel_shape, strel_size, 0);
	else
		se = strel(strel_shape, strel_size);
	endif
	im_closed = 255 - imerode(imdilate(255-im, se, shape), se, shape);
	im_opened = 255 - imdilate(imerode(255-im, se, shape), se, shape);
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

# 2 - Contours

cameraman_gradient = imdilate(cameraman, strel("square", 3), 'same') - imerode(cameraman, strel("square", 3), 'same');

figure;
subplot(1, 2, 1);
imshow(cameraman);
title("Cameraman original");
f = subplot(1, 2, 2);
imshow(cameraman_gradient);
title("Cameramn gradient");

saveas(f, "output/cameraman_gradient.png");

# 3 - Débruitage

[lena, map_lena, alpha_lena] = imread("data/Lena_nb.jpg");

## 1. Bruit poivre et sel

lena_bruit_1 = num2cell(lena);
values = {0, 255};
p = 0.20;
lena_to_change=rand(size(lena,1),size(lena,2))<p;
lena_bruit_1(lena_to_change)= values(randi([1, 2], 1));

figure;
subplot(1, 2, 1);
imshow(lena);
title("Lena original");
f = subplot(1, 2, 2);
imshow(cell2mat(lena_bruit_1));
title("Lena bruit 1");

saveas(f, "output/lena_poivre_sel.png");

% Comment the following line to keep the images displayed during execution.
%close all hidden;
