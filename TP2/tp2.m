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
chat_transp(chat_transp(:, :, 1) == 106 && chat_transp(:, :, 2) == 182 && chat_transp(:, :, 3) == 107) = [255 255 255];
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
subplot(2,1,2)
imshow(noyaux_bin);

# 3 - Dynamique

# 4 - Égalisation