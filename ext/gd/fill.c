#include "ruby_gd.h"

/**
    - [x] imagefill — Flood fill
 */
static VALUE gd_image_fill(VALUE self, VALUE color) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  if (!wrap || !wrap->img)
    rb_raise(rb_eRuntimeError, "uninitialized GD::Image");

  int r = NUM2INT(rb_ary_entry(color,0));
  int g = NUM2INT(rb_ary_entry(color,1));
  int b = NUM2INT(rb_ary_entry(color,2));
  int c = gdImageColorAllocate(wrap->img,r,g,b);

  gdImageFilledRectangle(wrap->img,0,0,wrap->img->sx,wrap->img->sy,c);
  return Qnil;
}

void gd_define_fill(VALUE cGDImage) {
  rb_define_method(cGDImage,"fill",gd_image_fill,1);
}
