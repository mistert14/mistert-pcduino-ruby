#Introduction
# Introduction #

Ici je vous laisse un petit compte rendu de mes tests avec pcDuino, le miniPc à 60 euros qui permet une tonne d'applications domotiques.

La dernière version propose une IDE Arduino qui permet l'upload des programmes directement sur le pcDuino. J'ai testé ArduBlock qui permet en outre une programmation graphique.

J'ai un peu fouillé côté Python mais finalement j'ai préféré me reporter sur du code Ruby.

L'installation est simple:
```
apt-get install ruby, rubygems, libfox16-dev
```
puis:
```
 gem install pcduino
 gem install fxruby
```

L'installation fxruby prend un temps certain mais réussit finalement à conclure.

Le programme test1.rb propose un code qui intègre une classe Duino qui hérite de MxMainWindow et intègre une broche GPIO Pin du module pcduino.

L'appui sur le bouton fait bien basculer la sortie. :)

misterT