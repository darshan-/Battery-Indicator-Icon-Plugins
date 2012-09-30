#!/usr/bin/env ruby

require 'RMagick'

class NumberImageGenerator
  attr_accessor :image_dir, :font_size, :dimen

  def initialize()
    set_hdpi()
  end

  def set_xhdpi()
    @image_dir = 'numbers-xhdpi/'
    @font_size = 40
    @dimen = 48
  end

  def set_xhdpi_100()
    @image_dir = 'numbers-xhdpi/'
    @font_size = 30
    @dimen = 48
  end

  def set_hdpi()
    @image_dir = 'numbers-hdpi/'
    @font_size = 28
    @dimen = 35
  end

  def set_hdpi_100()
    @image_dir = 'numbers-hdpi/'
    @font_size = 22
    @dimen = 35
  end

#  def set_mdpi()
#    @image_dir = 'numbers-mdpi/'
#    @font_size = 15
#    @dimen = 25
#  end

#  def set_mdpi_100()
#    @image_dir = 'numbers-mdpi/'
#    @font_size = 14
#    @dimen = 25
#  end

  def generate(text)
    filename = "" + sprintf("%03d", text) + ".png";

    image = Magick::Image.new(@dimen, @dimen) {self.background_color = "transparent"}

    font = Magick::Draw.new();
    font.font_family = 'Helvetica';
    font.pointsize = @font_size;
    font.gravity = Magick::CenterGravity;
    font.font_weight = 900;

    image.annotate(font, 0,0,0,0, text) {self.fill = 'white';};
    image.write(@image_dir + filename) {self.depth = 8;};
  end
end

system("mkdir -p numbers-hdpi")
system("mkdir -p numbers-mdpi")

ig = NumberImageGenerator.new;

for i in 0..99
  ig.generate(i.to_s);
end

ig.set_hdpi_100()
ig.generate("100")

ig.set_xhdpi()
for i in 0..99
  ig.generate(i.to_s);
end

ig.set_xhdpi_100()
ig.generate("100")

#system("gimp numbers-hdpi/100.png")
#system("for i in numbers-hdpi/[0-9]*.png; do convert $i -roll +1+0 $i; done")
system("for i in numbers-hdpi/[0-9]*.png; do convert $i -roll +0+2 $i; done")
#system("for i in numbers-hdpi/[0-9]*.png; do composite $i plug001.png $i; done")
#system("cp numbers-hdpi/[0-9]*.png numbers-mdpi");
#system("for i in numbers-mdpi/[0-9]*.png; do mogrify -resize 25x25 -sharpen 25x25 $i; done")

system("for i in numbers-xhdpi/[0-9]*.png; do convert $i -roll +0+3 $i; done")
