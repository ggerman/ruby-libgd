#include "ruby_gd.h"

static VALUE gd_image_circle(VALUE self, VALUE cx, VALUE cy, VALUE r, VALUE color) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int red = NUM2INT(rb_ary_entry(color, 0));
  int green = NUM2INT(rb_ary_entry(color, 1));
  int blue = NUM2INT(rb_ary_entry(color, 2));
  int c = gdImageColorAllocate(wrap->img, red, green, blue);

  gdImageArc(wrap->img,
             NUM2INT(cx), NUM2INT(cy),
             NUM2INT(r)*2, NUM2INT(r)*2,
             0, 360,
             c);
  return Qnil;
}

static VALUE gd_image_filled_circle(VALUE self, VALUE cx, VALUE cy, VALUE r, VALUE color) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int red = NUM2INT(rb_ary_entry(color, 0));
  int green = NUM2INT(rb_ary_entry(color, 1));
  int blue = NUM2INT(rb_ary_entry(color, 2));
  int c = gdImageColorAllocate(wrap->img, red, green, blue);

  gdImageFilledEllipse(wrap->img,
                       NUM2INT(cx), NUM2INT(cy),
                       NUM2INT(r)*2, NUM2INT(r)*2,
                       c);
  return Qnil;
}

void gd_define_circle(VALUE cGDImage) {
  rb_define_method(cGDImage, "circle", gd_image_circle, 4);
  rb_define_method(cGDImage, "filled_circle", gd_image_filled_circle, 4);
}
