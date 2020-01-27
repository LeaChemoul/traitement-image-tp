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

function [min, max] = computeRange(img)
  fftImage = fourier(img);
  amplitudeImage = abs(fftImage);
  min = min(min(amplitudeImage))
  max = max(max(amplitudeImage))
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

# Filtre passe-haut

function i = removeCircle(img, x, y, radius)
	i = zeros(size(img));
	i = img(:, :);
	xmin = floor(x - radius);
	xmax = ceil(x + radius);
	ymin = floor(y - radius);
	ymax = ceil(y + radius);
	for x1 = xmin:xmax
		for y1 = ymin:ymax
			distance = sqrt((x1 - x)^2 + (y1 - y)^2);
			if distance <= radius
				i(x1, y1) = 0;
			endif
		endfor
	endfor
endfunction

lena_fft_circle = removeCircle(lena_fft, 257.5, 258, 100);
lena_inv = ifft2(lena_fft_circle);

lena_fft_circle = arrayfun(@choosePixel, lena_fft_circle);

figure;
subplot(1, 2, 1);
imagesc(abs(lena_fft_circle));
colorbar();
title("Lena FFT Mask (High-Pass Filter)");
f = subplot(1, 2, 2);
imagesc(abs(lena_inv));
colorbar();
title("Lena inverted from Fourier Transform");
saveas(f, "output/lena_high_pass_filter.png");

# Filtre passe-bas

function i = iremoveCircle(img, x, y, radius)
	i = zeros(size(img));
	xmin = floor(x - radius);
	xmax = ceil(x + radius);
	ymin = floor(y - radius);
	ymax = ceil(y + radius);
	for x1 = xmin:xmax
		for y1 = ymin:ymax
			distance = sqrt((x1 - x)^2 + (y1 - y)^2);
			if distance <= radius
				i(x1, y1) = img(x1, y1);
			endif
		endfor
	endfor
endfunction

lena_fft_icircle = iremoveCircle(lena_fft, 257.5, 258, 50);
lena_inv = ifft2(lena_fft_icircle);

lena_fft_icircle = arrayfun(@choosePixel, lena_fft_icircle);

figure;
subplot(1, 2, 1);
imagesc(abs(lena_fft_icircle));
colorbar();
title("Lena FFT Mask (Low-Pass Filter)");
f = subplot(1, 2, 2);
imagesc(abs(lena_inv));
colorbar();
title("Lena inverted from Fourier Transform");
saveas(f, "output/lena_low_pass_filter.png");


## Bruit poivre et sel

p = 0.05;
lena_bruit_1 = imnoise(lena,'salt & pepper',p);

## Bruit Gaussien

lena_bruit_2 = lena;
mu = 0;
var = 10;
X = mu + randn(size(lena,1), size(lena,2))*var;
lena_bruit_2 = lena_bruit_2 + X;

## Debruitage

function distance = euclidean_distance_img(img1, img2)
	distance = sqrt(sum((img1(:) - img2(:)).^2));
endfunction

function img = delNoise(original, noise)
  [img_fft, magnitude_img, arg_img] = ftcomponent(noise, true);
  img_fft_icircle = iremoveCircle(img_fft, 257.5, 258, 65);
  img_inv = ifft2(img_fft_icircle);

  img_fft_icircle = arrayfun(@choosePixel, img_fft_icircle);

  figure;
  subplot(1, 2, 1);
  imshow(noise);
  colorbar();
  title("Noise image");
  f = subplot(1, 2, 2);
  imagesc(abs(img_inv));
  text(0, 580, ["Euclidean distance: " num2str(euclidean_distance_img(original, abs(img_inv)))]);
  colorbar();
  title("Image inverted from Fourier Transform");
  saveas(f, "output/del_noise_low_pass_filter.png");
endfunction

delNoise(lena, lena_bruit_1);
delNoise(lena, lena_bruit_2);

% Comment the following line to keep the images displayed during execution.
%close all hidden;
