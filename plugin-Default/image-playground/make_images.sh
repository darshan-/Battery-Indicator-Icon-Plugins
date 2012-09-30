#!/bin/bash

#ruby generate_images.rb
#for i in res/drawable/b[0-9]*.png; do mogrify -resize 25x25 $i; done
#gimp res/drawable/b100.png
#for i in res/drawable/*.png; do mogrify -sharpen 25x25 $i; done

# shift ("roll") images 1px to the right
# for i in numbers/*.png; do convert $i -roll +1+0 $i; done

mkdir -p ../res/drawable-hdpi
mkdir -p ../res/drawable-hdpi-v14
mkdir -p ../res/drawable

d=`dirname $(readlink -f $0)`



cd $d/numbers-xhdpi
for i in [0-9]*.png; do cp $i ../../res/drawable-hdpi-v14/default$i; done

#cd $d
#for i in ../res/drawable-hdpi-v14/default[0-9]*.png; do composite $i black-bg-xhdpi-001.png $i; done
#cd $d/numbers-xhdpi
for i in [0-9]*.png; do cp ../../res/drawable-hdpi-v14/default$i ../../res/drawable-hdpi-v14/charging$i; done
cd $d
for i in ../res/drawable-hdpi-v14/charging[0-9]*.png; do composite bolt-xhdpi-002.png $i $i; done



cd $d/numbers-hdpi
for i in [0-9]*.png; do cp $i ../../res/drawable-hdpi/default$i; done

#cd $d
#for i in ../res/drawable-hdpi/default[0-9]*.png; do composite $i black-bg-hdpi-001.png $i; done
#cd $d/numbers-hdpi
for i in [0-9]*.png; do cp ../../res/drawable-hdpi/default$i ../../res/drawable-hdpi/charging$i; done
cd $d
for i in ../res/drawable-hdpi/charging[0-9]*.png; do composite bolt-hdpi-002.png $i $i; done



#cd $d/numbers-mdpi
#for i in [0-9]*.png; do cp $i ../../res/drawable/default$i; done

##cd $d
##for i in ../res/drawable/default[0-9]*.png; do composite $i black-bg-mdpi-001.png $i; done
##cd $d/numbers-mdpi
#for i in [0-9]*.png; do cp ../../res/drawable/default$i ../../res/drawable/charging$i; done
#cd $d
#for i in ../res/drawable/charging[0-9]*.png; do composite bolt-mdpi-002.png $i $i; done

cp ../res/drawable-hdpi/charging*.png ../res/drawable/
cp ../res/drawable-hdpi/default*.png ../res/drawable/
for i in ../res/drawable/charging*.png; do mogrify -resize 25x25 -sharpen 25x25 $i; done
for i in ../res/drawable/default*.png; do mogrify -resize 25x25 -sharpen 25x25 $i; done
