#include "ruby_gd.h"
/**
 - [ ] imagerectangle — Draw a rectangle
 - [ ] imagefilledrectangle — Draw a filled rectangle
 */
static VALUE gd_image_rectangle(int argc, VALUE *argv, VALUE self) {
  VALUE x1, y1, x2, y2, color, opts;
  VALUE thickness = Qnil;
  opts = Qnil;

  rb_scan_args(argc, argv, "5:", &x1, &y1, &x2, &y2, &color, &opts);
  if (!NIL_P(opts)) {
    thickness = rb_hash_aref(opts, ID2SYM(rb_intern("thickness")));
  }

  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int c = color_to_gd(wrap->img, color);

  if (!NIL_P(thickness)) {
    gdImageSetThickness(wrap->img, NUM2INT(thickness));
  }
  gdImageRectangle(wrap->img,
                   NUM2INT(x1), NUM2INT(y1),
                   NUM2INT(x2), NUM2INT(y2),
                   c);
  gdImageSetThickness(wrap->img, 1);
  return Qnil;
}

static VALUE gd_image_filled_rectangle(int argc, VALUE *argv, VALUE self) {
  VALUE x1, y1, x2, y2, color, opts;
  VALUE thickness = Qnil;
  opts = Qnil;

  rb_scan_args(argc, argv, "5:", &x1, &y1, &x2, &y2, &color, &opts);
  if (!NIL_P(opts)) {
    thickness = rb_hash_aref(opts, ID2SYM(rb_intern("thickness")));
  }

  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int c = color_to_gd(wrap->img, color);
  if (!NIL_P(thickness)) {
    gdImageSetThickness(wrap->img, NUM2INT(thickness));
  }
  gdImageFilledRectangle(wrap->img,
                         NUM2INT(x1), NUM2INT(y1),
                         NUM2INT(x2), NUM2INT(y2),
                         c);
  gdImageSetThickness(wrap->img, 1);
  return Qnil;
}

void gd_define_rectangle(VALUE cGDImage) {
  rb_define_method(cGDImage, "rectangle", gd_image_rectangle, -1);
  rb_define_method(cGDImage, "filled_rectangle", gd_image_filled_rectangle, -1);
}
