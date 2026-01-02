#include "ruby_gd.h"

/**
    - [x] imagefill — Flood fill
 */
static VALUE gd_image_fill(VALUE self, VALUE color) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  if (!wrap || !wrap->img)
    rb_raise(rb_eRuntimeError, "uninitialized GD::Image");

  int c = color_to_gd(wrap->img, color);

  gdImageFilledRectangle(
    wrap->img,
    0, 0,
    gdImageSX(wrap->img) - 1,
    gdImageSY(wrap->img) - 1,
    c
  );

  return self;
}

void gd_define_fill(VALUE cGDImage) {
  rb_define_method(cGDImage,"fill",gd_image_fill,1);
}
