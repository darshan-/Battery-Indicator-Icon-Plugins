#!/bin/bash

#ruby generate_images.rb
#for i in res/drawable/b[0-9]*.png; do mogrify -resize 25x25 $i; done
#gimp res/drawable/b100.png
#for i in res/drawable/*.png; do mogrify -sharpen 25x25 $i; done

# shift ("roll") images 1px to the right
# for i in numbers/*.png; do convert $i -roll +1+0 $i; done

d=`dirname $(readlink -f $0)`

cd $d/numbers-hdpi
for i in [0-9]*.png; do cp $i ../../res/drawable-hdpi/default$i; done
for i in [0-9]*.png; do cp $i ../../res/drawable-hdpi/charging$i; done

cd $d
for i in ../res/drawable-hdpi/charging[0-9]*.png; do composite $i bolt-hdpi-001.png $i; done


cd $d/numbers-mdpi
for i in [0-9]*.png; do cp $i ../../res/drawable/default$i; done
for i in [0-9]*.png; do cp $i ../../res/drawable/charging$i; done

cd $d
for i in ../res/drawable/charging[0-9]*.png; do composite $i bolt-mdpi-001.png $i; done
