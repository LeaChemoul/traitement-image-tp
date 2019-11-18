# Traitement d'Image

# TP1

# 1 - D�finitions

printf("> Quelle est la taille minimale entre 2 objets pour qu�ils soient distinguables � 30cm?\n");

# On utilise le th�or�me de Pythagore �tendu (loi des cosinus)
# $a^2 = b^2 + c^2 - 2 b c \cos(\alpha)$
taille_min_cm = sqrt(30^2 * ( 2 - 2 * cosd(1/60)));
printf("Taille minimale entre 2 objets : %f cm\n\n", taille_min_cm);

printf("> Quelle est la taille d�un pixel d�un smarphone de 5 pouces avec une d�finition HD 720? Si ce smarphone est tenu � 30cm de l��il, cette d�finition est-elle suffisante?\n");

taille_pixel_mm = [111/1280, 620/720];
printf("Taille d'un pixel sur un smartphone 5 pouces HD 720 : %fx%f mm\n\n", taille_pixel_mm(1), taille_pixel_mm(2));

printf("> En dessous de quelle distance (entre la personne et l��cran) une personne peut-elle distinguer les pixels d�un �cran d�ordinateur de 22 pouces avec une d�finition HD 1080?\n");

taille_pixel_mm = [487/1920, 274/1080];
printf("Taille d'un pixel sur un �cran 22 pouces HD 1080 : %fx%f mm\n", taille_pixel_mm(1), taille_pixel_mm(2));

# distance_min = sqrt(((taille_pixel_mm(1)/10)^2)/(2 * (1 - cos(1/60))));
a_squared = (taille_pixel_mm(1)/10)^2;
ratio = a_squared / (1 - cosd(1/60))
printf("Distance minimale : %f cm\n\n", distance_min);

#> Quelle est la d�finition de cette image?

# Install image package
# pkg install image-2.10.0.tar.gz

[cameraman, map, alpha] = imread("data/cameraman.jpg");
#imshow(cameraman, map);
dimen = size(cameraman);
printf("Dimension de l'image: %dx%d pixels\n\n", dimen(1), dimen(2));

#> Quelle est sa taille th�orique sur le disque? Comparer avec la taille r�elle et commenter.

printf("La taille th�orique est de %d * %d * %d = %d bytes\n", dimen(1), dimen(2), 3, dimen(1) * dimen(2) * 3);

info = imfinfo("data/cameraman.jpg");
printf("Taille de l'image sur le disque : %d bytes\n\n", info.FileSize);

# 2 - Quantification

#> Ouvrir le fichier cameraman.jpg et l�afficher. Regarder les fonctions imread, imshow, image, imagesc et colorbar. Sur combien de bits sont repr�sent�s les niveaux de gris?

#imshow(cameraman, map);
#image(cameraman);
#imagesc(cameraman);
#colorbar();

#> Afficher l�image en n�utilisant que 128, 64, 32, 16, 8, 4 et 2 niveaux de gris et observer la d�gradation visuelle de l�image en cas de sous-quantification trop importante.

cameraman_128 = round(cameraman/2);
%{
figure;
imshow(cameraman_128, map);
colorbar();
%}

cameraman_64 = round(cameraman_128./2);
%{
figure;
imshow(cameraman_64, map);
colorbar();
%}

cameraman_32 = round(cameraman_64./2);
%{
figure;
imshow(cameraman_32, map);
colorbar();
%}

cameraman_16 = round(cameraman_32./2);
%{
figure;
imshow(cameraman_16, map);
colorbar();
%}

cameraman_8 = round(cameraman_16./2);
%{
figure;
imshow(cameraman_8, map);
colorbar();
%}

cameraman_4 = round(cameraman_8./2);
%{
figure;
imshow(cameraman_4, map);
colorbar();
%}

cameraman_2 = round(cameraman_4./2);
%{
figure;
imshow(cameraman_2, map);
colorbar();
%}

# 3 - �chantillonnage

#> En utilisant toujours cameraman.jpg, cr�er en une autre sous-�chantillonner avec 2 fois moins de lignes et colonnes.

cameraman_e2 = cameraman(1:2:size(cameraman)(1), 1:2:size(cameraman)(2));
%{
figure;
imshow(cameraman_e2, map);
colorbar();
%}

#> M�me question mais avec 4 fois moins de lignes et de colonnes.

cameraman_e4 = cameraman(1:4:size(cameraman)(1), 1:4:size(cameraman)(2));
%{
figure;
imshow(cameraman_e4, map);
colorbar();
%}

#> Pour chacune des 2 images sous �chantillonn�es cr��es, sur �chantillonner l� (en utilisant interp2 et meshgrid) afin d�obtenir une image de la taille d�origine. Commenter (se rappeler du cours du traitement du signal, Shannon par exemple).

cameraman_se2 = interp2(cameraman_e2, 2);
size(cameraman_se2)
figure;
imshow(cameraman, map);
figure;
imshow(cameraman_se2, map);
colorbar();
