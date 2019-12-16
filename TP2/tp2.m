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
std_lena = std(std(Lena_nb))
N = size(Lena_nb,1)
M = size(Lena_nb,2)

contraste_v1 = (max_lena - min_lena)/(max_lena + min_lena)
contraste_v2 = std_lena

figure();
histo = imhist(Lena_nb);
imhist(Lena_nb);

figure;
histo_cum = cumsum(histo);
plot(histo_cum);
title("Histogramme cumulé");

# 4 - Égalisation

figure;
histo_eg = histo_cum*(max_lena-1);
plot(histo_eg)

figure;
histeq(Lena_nb);