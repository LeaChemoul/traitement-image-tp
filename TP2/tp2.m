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

# 3 - Dynamique

# 4 - Égalisation