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
	transformed = fft2(img); % , 2^nextpow2(200), 2^nextpow2(600)
	transformed = fftshift(transformed);
endfunction

function p = choosePixel(pixel)
	threshold = 30000;
	if pixel < threshold
		p = pixel;
	else
		p = threshold;
	endif
endfunction

function [transformed, magnitude, phase] = ftcomponent(img, maxMagnitude = false)
	transformed = fourier(img);
	magnitude = abs(transformed);
	if maxMagnitude
		magnitude = arrayfun(@choosePixel, magnitude);
	endif
	phase = arg(transformed);
endfunction

[sinus_fft, magnitude_sinus, arg_sinus] = ftcomponent(sinus, true);
[monde_fft, magnitude_monde, arg_monde] = ftcomponent(monde, true);
[dominos_fft, magnitude_dominos, arg_dominos] = ftcomponent(dominos, true);
[lena_fft, magnitude_lena, arg_lena] = ftcomponent(lena, true);

figure(1, "position", [0, 0, 1920, 1000]);

subplot(4, 3, 1);
imshow(sinus);
title("Sinus");
subplot(4, 3, 2);
imagesc(magnitude_sinus);
colorbar();
title("Module de sinus");
subplot(4, 3, 3);
imagesc(arg_sinus);
title("Phase de sinus");

subplot(4, 3, 4);
imshow(monde);
title("Monde");
subplot(4, 3, 5);
imagesc(magnitude_monde);
colorbar();
title("Module de monde");
subplot(4, 3, 6);
imagesc(arg_monde);
title("Phase de monde");

subplot(4, 3, 7);
imshow(dominos);
title("Dominos");
subplot(4, 3, 8);
imagesc(magnitude_dominos);
colorbar();
title("Module de dominos");
subplot(4, 3, 9);
imagesc(arg_dominos);
title("Phase de dominos");

subplot(4, 3, 10);
imshow(lena);
title("Lena");
subplot(4, 3, 11);
imagesc(magnitude_lena);
colorbar();
title("Module de lena");
f = subplot(4, 3, 12);
imagesc(arg_lena);
title("Phase de lena");

saveas(f, "output/fourier_components.png");

# 2 - Module et phase

[manh_fft, magnitude_manh, arg_manh] = ftcomponent(manhattan, true);
[beach_ff, magnitude_beach, arg_beach] = ftcomponent(beach, true);

figure;
subplot(1, 2, 1);
imshow(manhattan);
title("Manhattan");
f = subplot(1, 2, 2);
imagesc(magnitude_manh);
title("Transformation de Fourier de Manhattan");
saveas(f, "output/manhattan_fft.png");

figure;
subplot(1, 2, 1);
imshow(beach);
title("Beach");
f = subplot(1, 2, 2);
imagesc(magnitude_beach);
title("Transformation de Fourier de Beach");
saveas(f, "output/beach_fft.png");


function combinated = combinate(img1, img2, scale)
    [ft_img1, mod_img1, phase_img1] = ftcomponent(img1, scale);
    [ft_img2, mod_img2, phase_img2] = ftcomponent(img2, scale);
    combinated = mod_img1.*exp(i*phase_img2);   
endfunction

combinated_manh_beach_fft = combinate(manhattan, beach, true);
combinated_manh_beach_image = ifft2(combinate(manhattan, beach, false));

figure;
subplot(2, 2, 1);
imshow(manhattan);
title("Manhattan");
subplot(2, 2, 2);
imshow(beach);
title("Beach");
f = subplot(2, 2, 3);
imagesc(abs(combinated_manh_beach_fft));
title("Combinaison of manhattan and beach: Fourier");
f = subplot(2, 2, 4);
imagesc(abs(combinated_manh_beach_image));
title("Combinaison of manhattan and beach: Image");
saveas(f, "output/manh_beach_image.png");


# 3 - Filtrage



% Comment the following line to keep the images displayed during execution.
%close all hidden;
