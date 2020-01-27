# Traitement d'Image

pkg load image

# TP5

# 1 - Prise en main

[sinus, map_sinus, alpha_sinus] = imread("data/sinus.png");
[monde, map_monde, alpha_monde] = imread("data/monde.png");
[dominos, map_dominos, alpha_dominos] = imread("data/dominos.png");
[lena, map_lena, alpha_lena] = imread("data/Lena_nb.jpg");
[manhattan, map_manhattan, alpha_manhattan] = imread("data/manhattan.tif");
[beach, map_ebach, alpha_beach] = imread("data/beach.tif");

function transformed = fourier(img)
	transformed = fft2(img);
	transformed = fftshift(transformed);
endfunction

sinus_fft = fourier(sinus);
arg_sinus = arg(sinus_fft);
phase_sinus = abs(sinus_fft);

figure;
subplot(1, 2, 1);
imshow(sinus);
title("Sinus");
f = subplot(1, 2, 2);
imagesc(abs(sinus_fft));
title("Transformation de Fourier de sinus");
saveas(f, "output/sinus_fft.png");

# 2 - Module et phase

manhattan_fft = fourier(manhattan);
beach_fft = fourier(beach);

figure;
subplot(1, 2, 1);
imshow(manhattan);
title("Manhattan");
f = subplot(1, 2, 2);
imagesc(abs(manhattan_fft));
title("Transformation de Fourier de Manhattan");
saveas(f, "output/manhattan_fft.png");

figure;
subplot(1, 2, 1);
imshow(beach);
title("Beach");
f = subplot(1, 2, 2);
imagesc(abs(beach_fft));
title("Transformation de Fourier de Beach");
saveas(f, "output/beach_fft.png");

# 3 - Filtrage



% Comment the following line to keep the images displayed during execution.
%close all hidden;
