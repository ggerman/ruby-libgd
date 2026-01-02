#include "ruby_gd.h"

static VALUE gd_image_set_pixel(VALUE self, VALUE x, VALUE y, VALUE color) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int r = NUM2INT(rb_ary_entry(color,0));
  int g = NUM2INT(rb_ary_entry(color,1));
  int b = NUM2INT(rb_ary_entry(color,2));

  int c = gdImageColorAllocate(wrap->img, r, g, b);

  gdImageSetPixel(wrap->img, NUM2INT(x), NUM2INT(y), c);

  return Qnil;
}

static VALUE gd_image_get_pixel(VALUE self, VALUE x, VALUE y) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int c = gdImageGetPixel(wrap->img, NUM2INT(x), NUM2INT(y));

  int r = gdImageRed(wrap->img, c);
  int g = gdImageGreen(wrap->img, c);
  int b = gdImageBlue(wrap->img, c);

  VALUE ary = rb_ary_new_capa(3);
  rb_ary_push(ary, INT2NUM(r));
  rb_ary_push(ary, INT2NUM(g));
  rb_ary_push(ary, INT2NUM(b));

  return ary;
}

void gd_define_pixel(VALUE cGDImage) {
  rb_define_method(cGDImage, "set_pixel", gd_image_set_pixel, 3);
  rb_define_method(cGDImage, "get_pixel", gd_image_get_pixel, 2);
}
