# Traitement d'Image

> Auteurs :
>
> * Léa CHEMOUL
> * Valentin Berger

## TP5 - Transformée de Fourier


### 1 - Prise en main

L'image ci-dessous montre pour chaque image son module et sa phase après transformation de Fourier :

![Module et phases de différentes images avec une transformation de Fourier](output/fourier_components.png)

On peut voir que le module nous donne en effet beaucoup d'information sur les bords des images. Par exemple, dans l'image "*dominos*", nous observons une diagonal partant d'en haut à droite et allant en bas à gauche (la suite de dominos en arrière-plan). On retrouve cette diagonal dans le module, avec une ligne inversée en jaune.

Inversement, on observe que le module de "*monde*" n'a pas de ligne distincte. En effet, comme les contours des continents ne sont pas constants, il est normal d'avoir un module formant un nuage de points plutôt que de voir apparaître des lignes.

Pour terminer, l'image "*lena*" est une fusion des deux images précédant : la diagonale crée par le contour du chapeau est distinguable sur le module, mais on peut également y voir un nuage de points au centre, formé par la complexité des contours de l'image originale.

### 2 - Module et phase

Manhattan : Sur le module de cette image on reconnait bien les deux diagonales caractéristiques propres à l'image et à son décor aux diagonales prononcées (buildings rectangulaires penchés).  

![](output/manhattan_fft.png)

Beach : Sur le module de cette image on reconnait bien :
- la verticale propre à la démarcation plage/mer ainsi que la barrière en premier plan
- la diagonale propre à la barrière au centre

![](output/beach_fft.png)

#### Combiner deux images

La phase permet de mettre en évidence le décalage entre les fréquences, cela permet de déterminer à peu près où se situe notre image.
Le module quant à lui indique l'intensité.
Nous combinons le module de Manhattan ainsi que la phase de Beach puis nous appliquons la transformée de Fourier inverse afin de retrouver l'image associée. Voici ce que nous obtenons :

![](output/manh_beach_image.png)

Nous pouvons bien :
- distinguer la plage (puisque nous avons récupéré la phase de Beach donc la position des fréquences)
- apercevoir les différences de fréquences propres à Manhattan

### 3 - Filtrage


**Filtrage passe-haut : seules les hautes fréquences sont conservées**

Le module nous permet de mettre en évidence les pointes lumineuses. Afin d'effectuer un filtre passe-haut, nous allons exclure les points du centre.
Cette méthode nous permet d'accentuer les contours et les détails de l’image.

![](output/lena_high_pass_filter.png)

**Filtrage passe-bas : seules les basses fréquences sont conservées**

Cette méthode nous permet de diminuer le bruit mais atténue par la même occasion les détails de l’image et érode les contours (donc on obtient un flou plus prononcé)

![](output/lena_low_pass_filter.png)

**Comparaison avec le débruitage du TP 4**

**Bruit poivre et sel**

![](../TP4/output/lena_poivre_sel_del_noise_square_3.png)

![](output/del_noise_poivre_sel_low_pass_filter.png)

Ce filtrage passe-bas est très similaire au filtre gaussien du TP4 et ne permet pas d'enlever totalement le bruit. Un filtrage plus grand risquerait de flouter trop l'image. Le filtre médian reste le plus efficace afin de supprimer du bruit ponctuel comme le bruit poivre et sel.

**Bruit gaussien**

![](../TP4/output/lena_gaussien_del_noise_square_3.png)

![](output/del_noise_low_pass_filter.png)

Ce filtrage passe-bas est très similaire au filtre médian vu au TP4. L'image obtenue est en effet plus lisse que l'image bruitée même si légèrement plus floue que l'originale.
