# Traitement d'Image

> Auteurs :
>
> * Léa CHEMOUL
> * Valentin Berger

## TP2 - Histogrammes

### 2 - Segmentation

![](output/noyaux_seg.png)

Qu'est ce qu'un bon seuil ? Ici nous pouvons choisir notre seuil qu'à titre subjectif à l'oeil
(étant donné que nous n'avaons pas de moyen objectif de mesurer et verifier nos valeurs).
Reste à choisir si nous souhaitaons :
- être stricte et ne prendre que les noyaux bien definis dont nous sommmes certains (ex: seuil = 120)
- être plus laxiste afin de detecter les noyaux moins bien définis (ex: seuil = 180)
Dans le cas de la recherche d'un cancer il est évident qu'on cherche a être precis et à detecter plus de noyaux possibles quitte à se tromper (cancer alors que sain)