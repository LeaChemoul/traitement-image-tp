# Traitement d'Image

> Auteurs :
>
> * Léa CHEMOUL
> * Valentin Berger

## TP4 - Filtres non linéaires


### 1 - Prise en main



### 2 - Module et phase

La phase permet de mettre en évidence le décalage entre les fréquences, cela permet de determiner à peu près ou se situe notre image.
Le module quand à lui indique l'intensité.
Nous combinons le module de Manhattan ainsi que la phase de Beach puis nous appliquons la transfomrée de Fourier inverse afin de retrouver l'image associée. Voici ce que nous obtenons :

![](output/manh_beach_image.png)

Nous pouvons bien :
- distinguer la plage (puisque nous avons récupéré la phase de Beach donc la position des fréquences)
- apercevoir les différences de fréquences propres à Manhattan

### 3 - Filtrage
