# Traitement d'Image

pkg load image

# TP5

# 1 - Prise en main

[sinus, map_sinus, alpha_sinus] = imread("data/sinus.png");
[monde, map_monde, alpha_monde] = imread("data/monde.png");
[dominos, map_dominos, alpha_dominos] = imread("data/dominos.png");
[lena, map_lena, alpha_lena] = imread("data/Lena_nb.jpg");

function transformed = fourier(img)
	transformed = fft2(img);
	transformed = fftshift(transformed);
endfunction

function [transformed, magnitude, phase] = ftcomponent(img)
	transformed = fourier(img);
	magnitude = abs(transformed);
	phase = arg(transformed);
endfunction

[sinus_fft, magnitude_sinus, arg_sinus] = ftcomponent(sinus);
[monde_fft, magnitude_monde, arg_monde] = ftcomponent(monde);
[dominos_fft, magnitude_dominos, arg_dominos] = ftcomponent(dominos);
[lena_fft, magnitude_lena, arg_lena] = ftcomponent(lena);

figure(1, "position", [0, 0, 1920, 1000]);

subplot(4, 3, 1);
imshow(sinus);
title("Sinus");
subplot(4, 3, 2);
imagesc(magnitude_sinus);
title("Module de sinus");
subplot(4, 3, 3);
imagesc(arg_sinus);
title("Phase de sinus");

subplot(4, 3, 4);
imshow(monde);
title("Monde");
subplot(4, 3, 5);
imagesc(magnitude_monde);
title("Module de monde");
subplot(4, 3, 6);
imagesc(arg_monde);
title("Phase de monde");

subplot(4, 3, 7);
imshow(dominos);
title("Dominos");
subplot(4, 3, 8);
imagesc(magnitude_dominos);
title("Module de dominos");
subplot(4, 3, 9);
imagesc(arg_dominos);
title("Phase de dominos");

subplot(4, 3, 10);
imshow(lena);
title("Lena");
subplot(4, 3, 11);
imagesc(magnitude_lena);
title("Module de lena");
f = subplot(4, 3, 12);
imagesc(arg_lena);
title("Phase de lena");

saveas(f, "output/fourier_components.png");

# 2 - Module et phase



# 3 - Filtrage



% Comment the following line to keep the images displayed during execution.
%close all hidden;
