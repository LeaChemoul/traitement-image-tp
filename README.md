# Traitement d'Image

> Auteurs :
> 
> * Léa CHEMOUL
> * Valentin Berger

## TP1 - Échantillonnage et Quantification

### 1 - Définition

> Quelle est la taille minimale entre 2 objets pour qu’ils soient distinguables à 30cm?

On utilise le théorème de Pythagore généralisé :

$a^2 = b^2 + c^2 - 2 b c \cos(\alpha)\\
= 30^2 + 30^2 - 2 \cdot 30 \cdot 30 \cdot cos(\frac{1}{60})\\
= 0.008727 \text{ cm}$

La taille minimale entre deux objets situés à 30cm est de 0.087 millimètres.

> Quelle est la taille d’un pixel d’un smarphone de 5 pouces avec une définition HD 720

Le nombre de pixels est de 1280x720 (car HD 720), et on sait que l'écran mesure 11,1x6,2 cm.

La taille d'un pixel en millimètres est donc :

$\frac{111}{1280}, \frac{620}{720} = 0.086719, 0.861111$

Ainsi un pixel mesure 0.087mm de large sur 0.86mm de long.

>  Si ce smarphone est tenu à 30cm de l’œil, cette définition est-elle suffisante?

Dans la première question, on a calculé que la distance minimale entre deux objets (ici des pixels) est de 0.25 cm pour qu'ils soient distinguables. Or, la largeur d'un pixel est de $0.008 \text{ cm}, 0.086 \text{ cm} \lt 0.0087 \text{ cm}$. Donc les pixels sont distinguables à 30 centimètres de l'utilisateur, donc la définition n'est pas suffisante.

> En dessous de quelle distance (entre la personne et l’écran) une personne peut-elle distinguer les pixels d’un écran d’ordinateur de 22 pouces avec une définition HD 1080?

Un écran 22 pouces est de dimension 48,7x27,4 cm. Un défintion HD 1080 a une résolution de 1920x1080. La taille d'un pixel est de :

$\frac{487}{1920}, \frac{274}{1080} = 0.253646, 0.253704$

Ainsi, un pixel est de 0.25x0.25mm.

On calcule maintenant la distance minimale :

$a^2 = 2 d^2 - 2 d^2 \cos(\frac{1}{60}) \quad \text{ avec } d \text{ étant la distance } (d := b = c)\\
a^2 = 2 d^2 (1 - \cos(\frac{1}{60}))\\
\Leftrightarrow d^2 = 2 \frac{a^2}{1 - \cos(\frac{1}{60})}\\
\Leftrightarrow d = \sqrt{\frac{a^2}{2 (1 - \cos(\frac{1}{60}))}}$

> Quelle est la définition de cette image?

```matlab
[cameraman, map, alpha] = imread("data/cameraman.jpg");
imshow(cameraman, map);
dimen = size(cameraman);
printf("Dimension de l'image: %dx%d pixels\n\n", dimen(1), dimen(2));
```

La dimension de l'image est de 256x256 pixels.

> Quelle est sa taille théorique sur le disque? Comparer avec la taille réelle et commenter.

```matlab
taille_theorique = dimen(1) * dimen(2) * 3

info = imfinfo("data/cameraman.jpg");
taille_reelle = info.FileSize
```

La taille théorique est de 196 608 octets, soit 192 Ko.
La taille sur le disque est de 10 515 octets, soit 10.27 Ko.

Cette différence peut s'expliquer car le standard JPEG utilise un algorithme de compression permettant d'optimiser la taille réelle sur le disque.

### 2 - Quantification

> Ouvrir le fichier cameraman.jpg et l’afficher. Regarder les fonctions imread, imshow, image, imagesc et colorbar. Sur combien de bits sont représentés les niveaux de gris?

```matlab
imshow(cameraman, map);
colorbar();
```

![](output/cameraman-imshow.png)

```matlab
image(cameraman);
colorbar();
```

![](output/cameraman-image.png)

```matlab
imagesc(cameraman);
colorbar();
```

![](output/cameraman-imagesc.png)

On observe qu'il y a 256 niveaux de gris correspondant à 8 bits.

> Afficher l’image en n’utilisant que 128, 64, 32, 16, 8, 4 et 2 niveaux de gris et observer la dégradation visuelle de l’image en cas de sous-quantification trop importante.

```
// TODO: Insert all images here
```

### 3 - Échantillonnage

> En utilisant toujours cameraman.jpg, créer en une autre sous-échantillonner avec 2 fois moins de lignes et colonnes.

```matlab
cameraman_e2 = cameraman(1:2:size(cameraman)(1), 1:2:size(cameraman)(2));
```

// TODO Insert image

> Même question mais avec 4 fois moins de lignes et de colonnes.

```matlab
cameraman_e4 = cameraman(1:4:size(cameraman)(1), 1:4:size(cameraman)(2));
```

// TODO Insert image

> Pour chacune des 2 images sous échantillonnées créées, sur échantillonner là (en utilisant interp2 et meshgrid) afin d’obtenir une image de la taille d’origine. Commenter (se rappeler du cours du traitement du signal, Shannon par exemple).
