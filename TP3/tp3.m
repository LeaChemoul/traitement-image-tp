# Traitement d'Image

pkg load image

# TP3

# 1 - Filtres passe haut

H3 = [-1, -1, -1; 0, 0, 0; 1, 1, 1];
H4 = [-1, -2, -1; 0, 0, 0; 1, 2, 1];
H5 = [0, 1, 0; 1, -4, 1; 0, 1, 0];

[dominos, map_dominos, alpha_dominos] = imread("data/dominos.png");
[monde, map_monde, alpha_monde] = imread("data/monde.png");
[lena, map_lena, alpha_lena] = imread("../TP2/data/Lena_nb.jpg");

# See https://fr.mathworks.com/help/matlab/ref/conv2.html

function img_conv = conv(img, mask)
	img_conv = uint8(conv2(img, mask, "same"));
endfunction

function [dominos_conv, monde_conv, lena_conv] = convImages(mask)
	global dominos;
	global monde;
	global lena;
	dominos_conv = conv(dominos, mask);
	monde_conv = conv(monde, mask);
	lena_conv = conv(lena, mask);
endfunction

% Plot all convolutions of images with convolution masks
[dominos_conv_h3, monde_conv_h3, lena_conv_h3] = convImages(H3);
[dominos_conv_h4, monde_conv_h4, lena_conv_h4] = convImages(H4);
[dominos_conv_h5, monde_conv_h5, lena_conv_h5] = convImages(H5);

figure;
subplot(3, 3, 1);
imshow(dominos_conv_h3);
title("dominos convoluted with H3");
subplot(3, 3, 2);
imshow(monde_conv_h3);
title("monde convoluted with H3");
subplot(3, 3, 3);
imshow(lena_conv_h3);
title("lena convoluted with H3");

subplot(3, 3, 4);
imshow(dominos_conv_h4);
title("dominos convoluted with H4");
subplot(3, 3, 5);
imshow(monde_conv_h4);
title("monde convoluted with H4");
subplot(3, 3, 6);
imshow(lena_conv_h4);
title("lena convoluted with H4");

subplot(3, 3, 7);
imshow(dominos_conv_h5);
title("dominos convoluted with H5");
subplot(3, 3, 8);
imshow(monde_conv_h5);
title("monde convoluted with H5");
f = subplot(3, 3, 9);
imshow(lena_conv_h5);
title("lena convoluted with H5");
saveas(f, "output/all_conv2_h3_h4_h5.png");

% Plot convolution of "monde" (normal and transposed) with H3 and H4
figure;
subplot(2, 2, 1);
imshow(monde_conv_h3);
title("monde convoluted with H3");
subplot(2, 2, 2);
imshow(monde_conv_h4);
title("monde convoluted with H4");
subplot(2, 2, 3);
imshow(conv2(monde', H3, "same"));
title("monde transposed convoluted with H3");
f = subplot(2, 2, 4);
imshow(conv2(monde', H4, "same"));
title("monde transposed convoluted with H4");
saveas(f, "output/monde_transposed_conv2_h3_h4.png");

# 2 - Filtres passe haut

H1 = (1/9) * ones([3, 3]);
H2 = (1/6) * [1, 2, 1; 2, 4, 2; 1, 2, 1];

% Plot all convolution of images with H1 and H2
[dominos_conv_h1, monde_conv_h1, lena_conv_h1] = convImages(H1);
[dominos_conv_h2, monde_conv_h2, lena_conv_h2] = convImages(H2);

figure;
subplot(2, 3, 1);
imshow(dominos_conv_h1);
title("dominos convoluted with H1");
subplot(2, 3, 2);
imshow(monde_conv_h1);
title("monde convoluted with H1");
subplot(2, 3, 3);
imshow(lena_conv_h1);
title("lena convoluted with H1");
subplot(2, 3, 4);
imshow(dominos_conv_h2);
title("dominos convoluted with H2");
subplot(2, 3, 5);
imshow(monde_conv_h2);
title("monde convoluted with H2");
f = subplot(2, 3, 6);
imshow(lena_conv_h2);
title("lena convoluted with H2");
saveas(f, "output/all_conv2_h1_h2.png");

% Plot convolution of "monde" with H1 and H2
figure;
subplot(1, 2, 1);
imshow(monde_conv_h1);
title("monde convoluted with H1");
f = subplot(1, 2, 2);
imshow(monde_conv_h2);
title("monde convoluted with H2");
saveas(f, "output/monde_conv2_h1_h2.png");



% Comment the following line to keep the images displayed during execution.
close all hidden;
