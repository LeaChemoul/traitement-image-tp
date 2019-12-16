# Traitement d'Image

> Auteurs :
>
> * Léa CHEMOUL
> * Valentin Berger

## TP2 - Histogrammes

### 2 - Segmentation

![](output/noyaux_seg.png)

Qu'est ce qu'un bon seuil ? Ici nous pouvons choisir notre seuil qu'à titre subjectif à l'oeil
(étant donné que nous n'avons pas de moyen objectif de mesurer et verifier nos valeurs).
Reste à choisir si nous souhaitaons :
- être stricte et ne prendre que les noyaux bien definis dont nous sommmes certains (ex: seuil = 120)
- être plus laxiste afin de detecter les noyaux moins bien définis (ex: seuil = 180)
Dans le cas de la recherche d'un cancer il est évident qu'on cherche a être precis et à detecter plus de noyaux possibles quitte à se tromper (cancer alors que sain)

### 3 -
Le contraste global calculé est de 1 ce qui est cohérent avec le fait qu'on a un minimum de 0 et un maximum de 1.
Le constrate calculé a partie de l'écart type est plus pertinent.

```
contraste_v1 = 1
contraste_v2 =  44.192
```
