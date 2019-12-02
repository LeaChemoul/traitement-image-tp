# Traitement d'Image

pkg load image 

# TP2

# 1 - Arbre à chats

[chat, map_chat, alpha_chat] = imread("data/chat.jpg");
[arbre, map_arbre, alpha_arbre] = imread("data/arbre.jpg");

chat_transp = chat;
%chat_transp(:, :, 2) = 0;
%{
for x = 1:size(chat_transp, 1)
    for y = 1:size(chat_transp, 2)
		if chat_transp(x, y, 1) == 106 && chat_transp(x, y, 2) == 182 && chat_transp(x, y, 3) == 107
			chat_transp(x, y, 1) = 255;
			chat_transp(x, y, 2) = 255;
			chat_transp(x, y, 3) = 255;
		endif
	endfor
endfor
%}

r_filter = (chat(:, :, 1) >= 106 - 10) & (chat(:, :, 1) <= 106 + 10);
g_filter = (chat(:, :, 2) >= 182 - 30) & (chat(:, :, 2) <= 182 + 30);
b_filter = (chat(:, :, 3) >= 107 - 20) & (chat(:, :, 3) <= 107 + 20);
px_to_remove = r_filter & g_filter & b_filter;
chat_r = chat(:, :, 1);
chat_g = chat(:, :, 2);
chat_b = chat(:, :, 3);
chat_r(px_to_remove) = 255;
chat_g(px_to_remove) = 255;
chat_b(px_to_remove) = 255;
chat_transp(:, :, 1) = chat_r;
chat_transp(:, :, 2) = chat_g;
chat_transp(:, :, 3) = chat_b;
%chat_transp(px_to_remove) = 0;

f = figure;
imshow(chat_transp);
title("Chat sans fond vert");


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

figure();
imhist(Lena_nb);

# 4 - Égalisation

%{
sum = 0;
for i = 1:N-1
  for j = 1:M-1
      sum += power((Lena_nb(i,j) - mean_lena), 2);
  endfor
endfor
%}

%{
a = unique(Lena_nb);
out = [a,histc(Lena_nb(:),a)];

P = out/(N*M);
figure;
hist(out(:))
%}

#figure();
#histeq(Lena_nb);