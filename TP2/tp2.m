# Traitement d'Image

pkg load image 

# TP2

# 1 - Arbre à chats

[chat, map, alpha] = imread("data/chat.jpg");
[arbre, map2, alpha2] = imread("data/arbre.jpg");



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