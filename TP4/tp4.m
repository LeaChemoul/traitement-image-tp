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
lena_bruit_1(lena_to_change)= values{randi([1, 2], 1)};

figure;
subplot(1, 2, 1);
imshow(lena);
title("Lena original");
f = subplot(1, 2, 2);
imshow(cell2mat(lena_bruit_1));
title("Lena bruit 1");

saveas(f, "output/lena_poivre_sel.png");

## 1. Bruit Gaussien

lena_bruit_2= lena;
mu = 0;
var = 10;
X = mu + randn(size(lena,1), size(lena,2))*var;
lena_bruit_2 = lena_bruit_2 + X;

figure;
subplot(1, 2, 1);
imshow(lena);
title("Lena original");
f = subplot(1, 2, 2);
imshow(lena_bruit_2);
title("Lena bruit gaussien");

saveas(f, "output/lena_gaussien.png");

## Filtre passe bas

function img_mean = mean_blur(img, mask_size, shape = 'same')
	mask = (1/(mask_size * mask_size)) * ones([mask_size, mask_size]);
	img_mean = uint8(conv2(img, mask, shape));
endfunction

function img_gaussian = gaussian_blur(img, mask_size, sigma, shape = 'same')
	mask = fspecial("gaussian", [mask_size, mask_size], sigma);
	img_gaussian = uint8(conv2(img, mask, shape));
endfunction

function distance = euclidean_distance_img(img1, img2)
	distance = sqrt(sum((img1(:) - img2(:)).^2));
endfunction

function [img_mean_blur, img_gaussian_blur, img_median, img_open, img_closed] = del_noise(img, size, sigma, strel_shape = 'square', shape = 'same')
	img_mean_blur = mean_blur(img, size, shape);
	img_gaussian_blur = gaussian_blur(img, size, sigma, shape);
	[img_closed, img_open] = close_open(img, size, strel_shape, shape);
	img_median = medfilt2(img, [size, size]);
endfunction

function display_all_del_noise(img_original, img_noise, img_name, filename, size, sigma, strel_shape = 'square', shape = 'same')
	[i_mean_blur_sq3, i_gaussian_blur_sq3, i_median_sq3, i_open_sq3, i_closed_sq3] = del_noise(img_noise, size, sigma, strel_shape, shape);
	
	figure(1, "position", [0, 0, 1920, 1000]);
	subplot(2, 3, 1);
	imshow(img_noise);
	title([img_name ", bruite"]);
	subplot(2, 3, 2);
	imshow(i_mean_blur_sq3);
	title([img_name ", flou moyenneur"]);
	text(0, 540, ["Voisinage " strel_shape " " num2str(size) "x" num2str(size)]);
	text(0, 580, ["Euclidean distance: " num2str(euclidean_distance_img(img_original, i_mean_blur_sq3))]);
	subplot(2, 3, 3);
	imshow(i_gaussian_blur_sq3);
	title([img_name ", flou gaussien"]);
	text(0, 540, ["Voisinage " strel_shape " " num2str(size) "x" num2str(size) " (sigma=" num2str(sigma) ")"]);
	text(0, 580, ["Euclidean distance: " num2str(euclidean_distance_img(img_original, i_gaussian_blur_sq3))]);
	subplot(2, 3, 4);
	imshow(i_median_sq3);
	title([img_name ", flou median"]);
	text(0, 540, ["Voisinage " strel_shape " " num2str(size) "x" num2str(size)]);
	text(0, 580, ["Euclidean distance: " num2str(euclidean_distance_img(img_original, i_median_sq3))]);
	subplot(2, 3, 5);
	imshow(i_open_sq3);
	title([img_name ", filtre ouvert"]);
	text(0, 540, ["Voisinage " strel_shape " " num2str(size) "x" num2str(size)]);
	text(0, 580, ["Euclidean distance: " num2str(euclidean_distance_img(img_original, i_open_sq3))]);
	f = subplot(2, 3, 6);
	imshow(i_closed_sq3);
	title([img_name ", filtre ferme"]);
	text(0, 540, ["Voisinage " strel_shape " " num2str(size) "x" num2str(size)]);
	text(0, 580, ["Euclidean distance: " num2str(euclidean_distance_img(img_original, i_closed_sq3))]);
	%set(f, "position", [0, 0, 1920, 1000]);
	saveas(f, ["output/" filename "_del_noise_" strel_shape "_" num2str(size) ".png"]);
endfunction

display_all_del_noise(lena, cell2mat(lena_bruit_1), "Lena", "lena_poivre_sel", 3, 10, 'square');
display_all_del_noise(lena, cell2mat(lena_bruit_1), "Lena", "lena_poivre_sel", 5, 10, 'square');
display_all_del_noise(lena, cell2mat(lena_bruit_1), "Lena", "lena_poivre_sel", 8, 10, 'square');

display_all_del_noise(lena, lena_bruit_2, "Lena", "lena_gaussien", 3, 10, 'square');
display_all_del_noise(lena, lena_bruit_2, "Lena", "lena_gaussien", 5, 10, 'square');
display_all_del_noise(lena, lena_bruit_2, "Lena", "lena_gaussien", 8, 10, 'square');

% Comment the following line to keep the images displayed during execution.
%close all hidden;
