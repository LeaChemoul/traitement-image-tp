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

seuil = 180;
ind = noyaux(:,:) > seuil; %grab indices where value is > seuil
noyaux_bin = num2cell(noyaux);
noyaux_bin(ind) = 1;
noyaux_bin(~ind) = 0;
noyaux_bin;
noyaux_bin = cell2mat(noyaux_bin);

figure;
subplot(2,1,1)
imshow(noyaux)
f = subplot(2,1,2)
imshow(noyaux_bin);
saveas(f, "output/noyaux_seg.png");

# 3 - Dynamique

# 4 - Égalisation