#include "ruby_gd.h"
/**
 - [ ] imagerectangle — Draw a rectangle
 - [ ] imagefilledrectangle — Draw a filled rectangle
 */
static VALUE gd_image_rect(VALUE self, VALUE x1, VALUE y1, VALUE x2, VALUE y2, VALUE color) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int c = color_to_gd(wrap->img, color);
  gdImageRectangle(wrap->img,
                   NUM2INT(x1), NUM2INT(y1),
                   NUM2INT(x2), NUM2INT(y2),
                   c);
  return Qnil;
}

static VALUE gd_image_filled_rect(VALUE self, VALUE x1, VALUE y1, VALUE x2, VALUE y2, VALUE color) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int c = color_to_gd(wrap->img, color);
  gdImageFilledRectangle(wrap->img,
                         NUM2INT(x1), NUM2INT(y1),
                         NUM2INT(x2), NUM2INT(y2),
                         c);
  return Qnil;
}

void gd_define_rect(VALUE cGDImage) {
  rb_define_method(cGDImage, "rect", gd_image_rect, 5);
  rb_define_method(cGDImage, "filled_rect", gd_image_filled_rect, 5);
}
