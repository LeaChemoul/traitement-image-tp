# Traitement d'Image

pkg load image 

# TP2

# 1 - Arbre à chats

% Loading images
[chat, map_chat, alpha_chat] = imread("data/chat.jpg");
[arbre, map_arbre, alpha_arbre] = imread("data/arbre.jpg");

% Creating a mask to catch all pixels within a certain range
r_filter = (chat(:, :, 1) >= 106 - 20) & (chat(:, :, 1) <= 106 + 20);
g_filter = (chat(:, :, 2) >= 182 - 60) & (chat(:, :, 2) <= 182 + 60);
b_filter = (chat(:, :, 3) >= 107 - 30) & (chat(:, :, 3) <= 107 + 30);
% Create a global mask for all chanels
px_to_remove = r_filter & g_filter & b_filter;
chat_r = chat(:, :, 1);
chat_g = chat(:, :, 2);
chat_b = chat(:, :, 3);
% Replace all greenish pixels to '0' (black)
chat_r(px_to_remove) = 0;
chat_g(px_to_remove) = 0;
chat_b(px_to_remove) = 0;
% Create the image with transparency
chat_transp(:, :, 1) = chat_r;
chat_transp(:, :, 2) = chat_g;
chat_transp(:, :, 3) = chat_b;

f = figure;
im_chat_transp = imshow(chat_transp);
title("Chat sans fond vert");
saveas(f, "output/chat_transp.png");

result(:, :, :) = arbre(:, :, :) - min(255, 255 * chat_transp(:, :, :)) + chat_transp(:, :, :);
f = figure;
imshow(result);
title("Chat sur une balancoire avec un arbre derriere");
saveas(f, "output/chat_arbre.png");

# 2 - Segmentation
[noyaux, map, alpha] = imread("data/noyaux.jpeg");

#Methode 1 : a la main
seuil = 180;
ind = noyaux(:,:) > seuil; %grab indices where value is > seuil
noyaux_bin = num2cell(noyaux);
noyaux_bin(ind) = 1;
noyaux_bin(~ind) = 0;
noyaux_bin;
noyaux_bin = cell2mat(noyaux_bin);

#Methode 2 : im2bw
noyaux_bin2 = im2bw(noyaux);

#Methode 3 : with threshold
threshold = graythresh(noyaux);
noyaux_bin3 = im2bw(noyaux, threshold);

%{
figure;
subplot(2,2,1)
imshow(noyaux)
title("Original")
subplot(2,2,2)
imshow(noyaux_bin)
title("Methode 1 à la main")
subplot(2,2,3)
imshow(noyaux_bin2)
title("Methode im2bw")
f = subplot(2,2,4)
imshow(noyaux_bin3)
title("Methode im2bw with threshold")
saveas(f, "output/noyaux_seg.png");
%}

# 3 - Dynamique
[Lena_nb, map, alpha] = imread("data/Lena_nb.jpg");

max_lena = max(Lena_nb(:))
min_lena = min(Lena_nb(:))
mean_lena = mean(Lena_nb(:))
std_lena = std(Lena_nb(:))
N = size(Lena_nb,1)
M = size(Lena_nb,2)

contraste_v1 = (max_lena - min_lena)/(max_lena + min_lena)
contraste_v2 = std_lena

Lena_nb_etale = (Lena_nb)*(double)(255/235);
max(Lena_nb_etale(:))

figure;
imhist(Lena_nb);

figure;
imhist(Lena_nb_etale);

# 4 - Égalisation

function egalise(image, grayscale, hsv)

if(hsv == 0)
  image2  = image(:,:,3);
else
  image2 = image;
endif

histo = imhist(image2);

N = size(image2,1)
M = size(image2,2)

figure;
histo_cum = cumsum(histo/(N*M));
plot(histo_cum);
title("Histogramme cumule");

if(hsv == 0)
  image_eg = uint8(arrayfun(@(x) histo_cum((x*255)+1)*(grayscale-1), image2));
else
  image_eg = uint8(arrayfun(@(x) histo_cum(x+1)*(grayscale-1), image2));
endif

if(hsv == 0)
  image_eg_2(:,:,1) = image(:,:,1);
  image_eg_2(:,:,2) = image(:,:,2);
  image_eg_2(:,:,3) = image_eg/255;
  image_eg_final = hsv2rgb(image_eg_2);
else
  image_eg_final = image_eg;
endif

figure;
subplot(1,2,1)
if(hsv == 0)
  imshow(hsv2rgb(image))
else
  imshow(image)
endif
title("Original")
subplot(1,2,2)
imshow(image_eg_final)
title("Egalisee")

figure;
histo_eg = imhist(image_eg);
imhist(image_eg);
title("Histo egalisee")

figure;
histo_cum_eg = cumsum(histo_eg/(N*M));
plot(histo_cum_eg);
title("Histogramme egalisee cumule");

figure;
histo_eq_verif = histeq(histo_cum);
plot(histo_eq_verif);
title("Histogramme egalisee avec hist eq");

end

egalise(Lena_nb, 255, 1);

[mandrill, map, alpha] = imread("data/mandrill.bmp");
mandrill_hsv = rgb2hsv(mandrill);
egalise(mandrill_hsv,255, 0);