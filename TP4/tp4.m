# Traitement d'Image

pkg load image

# TP4

# 1 - Fermeture

[cameraman, map_cameraman, alpha_cameraman] = imread("data/cameraman.jpg");

cameraman_erode = imerode(cameraman, strel("square", 3), 'same');
cameraman_dilate = imdilate(cameraman, strel("square", 3), 'same');

figure;
subplot(1, 3, 1);
imshow(cameraman);
title("Cameraman original");
subplot(1, 3, 2);
imshow(cameraman_erode);
title("Cameramn eroded");
f = subplot(1, 3, 3);
imshow(cameraman_dilate);
title("Cameraman dilated");

saveas(f, "output/cameraman_erode_dilate.png");

cameraman_fermeture = imerode(cameraman_dilate, strel("square", 3), 'same');
cameraman_ouverture = imdilate(cameraman_erode, strel("square", 3), 'same');

figure;
subplot(1, 3, 1);
imshow(cameraman);
title("Cameraman original");
subplot(1, 3, 2);
imshow(cameraman_fermeture);
title("Cameramn closed");
f = subplot(1, 3, 3);
imshow(cameraman_ouverture);
title("Cameraman opened");

saveas(f, "output/cameraman_closed_opened.png");

# 2 - Contours



# 3 - Débruitage



% Comment the following line to keep the images displayed during execution.
%close all hidden;
