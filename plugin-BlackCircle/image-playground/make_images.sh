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
#for i in [0-9]*.png; do cp $i ../../res/drawable-hdpi/charging$i; done

cd $d
for i in ../res/drawable-hdpi/default[0-9]*.png; do composite $i black-bg-hdpi-001.png $i; done


cd $d/numbers-mdpi
for i in [0-9]*.png; do cp $i ../../res/drawable/default$i; done
#for i in [0-9]*.png; do cp $i ../../res/drawable/charging$i; done

cd $d
for i in ../res/drawable/default[0-9]*.png; do composite $i black-bg-mdpi-001.png $i; done
