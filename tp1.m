# Traitement d'Image

pkg load image 

# TP1

# 1 - Définitions

printf("> Quelle est la taille minimale entre 2 objets pour qu’ils soient distinguables à 30cm?\n");

# On utilise le théorème de Pythagore étendu (loi des cosinus)
# $a^2 = b^2 + c^2 - 2 b c \cos(\alpha)$
taille_min_cm = sqrt(30^2 * ( 2 - 2 * cosd(1/60)));
printf("Taille minimale entre 2 objets : %f cm\n\n", taille_min_cm);

printf("> Quelle est la taille d’un pixel d’un smarphone de 5 pouces avec une définition HD 720? Si ce smarphone est tenu à 30cm de l’œil, cette définition est-elle suffisante?\n");

taille_pixel_mm = [111/1280, 620/720];
printf("Taille d'un pixel sur un smartphone 5 pouces HD 720 : %fx%f mm\n\n", taille_pixel_mm(1), taille_pixel_mm(2));

printf("> En dessous de quelle distance (entre la personne et l’écran) une personne peut-elle distinguer les pixels d’un écran d’ordinateur de 22 pouces avec une définition HD 1080?\n");

taille_pixel_mm = [487/1920, 274/1080];
printf("Taille d'un pixel sur un écran 22 pouces HD 1080 : %fx%f mm\n", taille_pixel_mm(1), taille_pixel_mm(2));

distance_min = sqrt(((taille_pixel_mm(1)/10)^2)/(2 * (1 - cosd(1/60))));
printf("Distance minimale : %f cm\n\n", distance_min);

#Ultra HD = 3840*2160
ultrahd1 = 3840;
ultrahd2 = 2160;

# HD 1080
hd1 = 1920;
hd2 = 1080;

#taille écran 55 pouces
taille_ecran1_1 = 1218;
taille_ecran1_2 = 685;
taille_pixel_mm1_1 = [taille_ecran1_1/ultrahd1, taille_ecran1_2/ultrahd2];
taille_pixel_mm1_2 = [taille_ecran1_1/hd1, taille_ecran1_2/hd2];

#taille écran 50 pouces
taille_ecran2_1 = 1107;
taille_ecran2_2 = 623;
taille_pixel_mm2_1 = [taille_ecran2_1/ultrahd1, taille_ecran2_2/ultrahd2];
taille_pixel_mm2_2 = [taille_ecran2_1/hd1, taille_ecran2_2/hd2];

#Calcul des distances minimales

distance_min2_1 = sqrt(((taille_pixel_mm2_1(1)/10)^2)/(2 * (1 - cosd(1/60))));
distance_min2_2 = sqrt(((taille_pixel_mm2_2(1)/10)^2)/(2 * (1 - cosd(1/60))));
printf("Distance minimale écran 50 pouces HD : %f cm\n\n", distance_min2_2);
printf("Distance minimale écran 50 pouces Ultra HD : %f cm\n\n", distance_min2_1);

distance_min1_1 = sqrt(((taille_pixel_mm1_1(1)/10)^2)/(2 * (1 - cosd(1/60))));
distance_min1_2 = sqrt(((taille_pixel_mm1_2(1)/10)^2)/(2 * (1 - cosd(1/60))));
printf("Distance minimale écran 55 pouces HD : %f cm\n\n", distance_min1_2);
printf("Distance minimale écran 55 pouces Ultra HD : %f cm\n\n", distance_min1_1);

printf("Entre 50 et 55 pouces, il est necessaire de passer en Ultra HD afin de bien distinguer un écran situé à 2m\n");

printf("\nMANDRILL.BMP\n\n")
#> Quelle est la définition de cette image?

# Install image package
# pkg install image-2.10.0.tar.gz

[cameraman, map, alpha] = imread("data/cameraman.jpg");
#imshow(cameraman, map);
dimen = size(cameraman);
printf("Dimension de l'image: %dx%d pixels\n\n", dimen(1), dimen(2));

#> Quelle est sa taille théorique sur le disque? Comparer avec la taille réelle et commenter.

printf("La taille théorique est de %d * %d * %d = %d bytes\n", dimen(1), dimen(2), 3, dimen(1) * dimen(2) * 3);

info = imfinfo("data/cameraman.jpg");
printf("Taille de l'image sur le disque : %d bytes\n\n", info.FileSize);

# 2 - Quantification

#> Ouvrir le fichier cameraman.jpg et l’afficher. Regarder les fonctions imread, imshow, image, imagesc et colorbar. Sur combien de bits sont représentés les niveaux de gris?

#imshow(cameraman, map);
#image(cameraman);
#imagesc(cameraman);
#colorbar();

#> Afficher l’image en n’utilisant que 128, 64, 32, 16, 8, 4 et 2 niveaux de gris et observer la dégradation visuelle de l’image en cas de sous-quantification trop importante.

cameraman_128 = round(cameraman/2);
cameraman_64 = round(cameraman_128./2);
cameraman_32 = round(cameraman_64./2);
cameraman_16 = round(cameraman_32./2);
cameraman_8 = round(cameraman_16./2);
cameraman_4 = round(cameraman_8./2);
cameraman_2 = round(cameraman_4./2);
%{
subplot(4, 2, 1);
imshow(cameraman_128, map);
colorbar();
subplot(4, 2, 2);
imshow(cameraman_64, map);
colorbar();
subplot(4, 2, 3);
imshow(cameraman_32, map);
colorbar();
subplot(4, 2, 4);
imshow(cameraman_16, map);
colorbar();
subplot(4, 2, 5);
imshow(cameraman_8, map);
colorbar();
subplot(4, 2, 6);
imshow(cameraman_4, map);
colorbar();
subplot(4, 2, 7);
imshow(cameraman_2, map);
colorbar();
figure;
%}

# 3 - Échantillonnage

#> En utilisant toujours cameraman.jpg, créer en une autre sous-échantillonner avec 2 fois moins de lignes et colonnes.

cameraman_e2 = cameraman(1:2:size(cameraman)(1), 1:2:size(cameraman)(2));
%{
figure;
imshow(cameraman_e2, map);
colorbar();
%}

#> Même question mais avec 4 fois moins de lignes et de colonnes.

cameraman_e4 = cameraman(1:4:size(cameraman)(1), 1:4:size(cameraman)(2));
%{
figure;
imshow(cameraman_e4, map);
colorbar();
%}

#> Pour chacune des 2 images sous échantillonnées créées, sur échantillonner là (en utilisant interp2 et meshgrid) afin d’obtenir une image de la taille d’origine. Commenter (se rappeler du cours du traitement du signal, Shannon par exemple).

size(cameraman_e2)
[X, Y] = meshgrid(0:128);
[Xq,Yq] = meshgrid(0:0.50:128);
cameraman_se2 = interp2(X,Y,cameraman_e2,Xq,Yq);

#cameraman_se2 = interp2(cameraman_e2);
size(cameraman_se2)
subplot(1, 3, 1);
imshow(cameraman);
title('Original')
subplot(1, 3, 2);
imshow(cameraman_e2);
title('Sous echantillonage 2')
subplot(1, 3, 3);
imshow(cameraman_se2);
title('Sur echantillonage 2')
figure;

cameraman_se4 = interp2(cameraman_e4);
size(cameraman_se4)
subplot(1, 3, 1);
imshow(cameraman);
title('Original')
subplot(1, 3, 2);
imshow(cameraman_e4);
title('Sous echantillonage 4')
subplot(1, 3, 3);
imshow(cameraman_se4);
title('Sur echantillonage 4')
figure;

# 4- Espaces colorimétriques

%RGB color
[pool, map, alpha] = imread("data/pool.jpg");
%{
imshow(pool, map);
colorbar();
figure;
%}

% Extract color channels.
redChannel = pool(:,:,1);
greenChannel = pool(:,:,2);
blueChannel = pool(:,:,3);
blackChannel = zeros(size(pool, 1), size(pool, 2), 'uint8');

% Create color versions of the individual color channels.
just_red = cat(3, redChannel, blackChannel, blackChannel);
just_green = cat(3, blackChannel, greenChannel, blackChannel);
just_blue = cat(3, blackChannel, blackChannel, blueChannel);
gray_red = rgb2gray(just_red);
gray_green = rgb2gray(just_green);
gray_blue = rgb2gray(just_blue);

%{
subplot(3, 2, 1);
imshow(just_red);
colorbar();
title('Red Channel')
subplot(3, 2, 2);
imshow(gray_red)
colorbar();
title('Red gray')
subplot(3, 2, 3);
imshow(just_blue);
colorbar();
title('Blue Channel')
subplot(3, 2, 4);
imshow(gray_blue);
colorbar();
title('Blue gray')
subplot(3, 2, 5);
imshow(just_green);
colorbar();
title('Green Cannel')
subplot(3, 2, 6);
imshow(gray_green);
colorbar();
title('Green gray')
%}

%YUV color

yuv = rgb2ycbcr(pool);