# Traitement d'Image

> Auteurs :
>
> * Léa CHEMOUL
> * Valentin Berger

## TP3 - Filtres linéaires

### 1 - Filtres passe haut

Pour réaliser une convolution 2D sur les images, nous utilisons la fonction Matlab `conv2`.

```matlab
% Convolution 2D de l'image domino avec le masque de convolution H3 :
dominos_conv_h3 = conv2(dominos, H3);
```

Les bords ne sont pas très bien traité avec cette fonction : en effet, `domino` et `lena` ont des bords noirs, ce qui signifie que la convolution a commencé sur les bordure, sans *offset*. Pour résoudre ce problème, nous utilisons le paramètre `shape='same'` :

```matlab
dominos_conv_h3 = conv2(dominos, H3, 'same');
```

![Convolution 2D des images avec les masques H3, H4 et H5](output/all_conv2_h3_h4_h5.png)

![Convolution 2D de monde et sa transposé avec les masques H3, H4](output/monde_transposed_conv2_h1_h2.png)

Pour détecter les diagonales, nous utilisons le masque suivant :

|    |    |    |
|----|----|----|
| -1 | -1 | 0  |
| -1 | 0  | 1  |
| 0  | 1  | 1  |

### 2 - Filtres passe bas

![Convolution 2D des images avec les masques H1 et H2](output/all_conv2_h1_h2.png)

![Convolution 2D de monde avec les masques H1 et H2](output/monde_conv2_h1_h2.png)
