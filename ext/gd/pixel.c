#include "ruby_gd.h"

static VALUE gd_image_set_pixel(VALUE self, VALUE x, VALUE y, VALUE color) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int c = color_to_gd(wrap->img, color);

  gdImageSetPixel(wrap->img, NUM2INT(x), NUM2INT(y), c);

  return Qnil;
}

static VALUE gd_image_get_pixel(VALUE self, VALUE vx, VALUE vy) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int x = NUM2INT(vx);
  int y = NUM2INT(vy);

  if (!wrap || !wrap->img) rb_raise(rb_eRuntimeError, "uninitialized GD::Image");

  int p = gdImageGetTrueColorPixel(wrap->img, x, y);

  int r = gdTrueColorGetRed(p);
  int g = gdTrueColorGetGreen(p);
  int b = gdTrueColorGetBlue(p);
  int a = gdTrueColorGetAlpha(p);

  VALUE ary = rb_ary_new_capa(4);
  rb_ary_push(ary, INT2NUM(r));
  rb_ary_push(ary, INT2NUM(g));
  rb_ary_push(ary, INT2NUM(b));
  rb_ary_push(ary, INT2NUM(a));

  return ary;
}


void gd_define_pixel(VALUE cGDImage) {
  rb_define_method(cGDImage, "set_pixel", gd_image_set_pixel, 3);
  rb_define_method(cGDImage, "get_pixel", gd_image_get_pixel, 2);
}
