#include "ruby_gd.h"

static VALUE
gd_image_arc(int argc, VALUE *argv, VALUE self)
{
  VALUE vcx, vcy, vw, vh, vstart, vend, vcolor, opts;
  VALUE thickness = Qnil;
  opts = Qnil;

  rb_scan_args(argc, argv, "7:", &vcx, &vcy, &vw, &vh, &vstart, &vend, &vcolor, &opts);

  if (!NIL_P(opts)) {
    thickness = rb_hash_aref(opts, ID2SYM(rb_intern("thickness")));
  }

  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int cx = NUM2INT(vcx);
  int cy = NUM2INT(vcy);
  int w  = NUM2INT(vw);
  int h  = NUM2INT(vh);
  int s  = NUM2INT(vstart);
  int e  = NUM2INT(vend);
  int c  = color_to_gd(wrap->img, vcolor);

  int t = NIL_P(thickness) ? 1 : NUM2INT(thickness);
  int half = t / 2;

  for (int i = -half; i <= half; i++) {
    gdImageArc(wrap->img, cx + i, cy, w, h, s, e, c);
  }

  return self;
}

static VALUE
gd_image_filled_arc(int argc, VALUE *argv, VALUE self)
{
  VALUE vcx, vcy, vw, vh, vstart, vend, vcolor;
  rb_scan_args(argc, argv, "7", &vcx, &vcy, &vw, &vh, &vstart, &vend, &vcolor);

  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int cx = NUM2INT(vcx);
  int cy = NUM2INT(vcy);
  int w  = NUM2INT(vw);
  int h  = NUM2INT(vh);
  int s  = NUM2INT(vstart);
  int e  = NUM2INT(vend);
  int c  = color_to_gd(wrap->img, vcolor);

  gdImageFilledArc(wrap->img, cx, cy, w, h, s, e, c, gdArc);

  return self;
}

void
gd_define_arc(VALUE cGDImage)
{
  rb_define_method(cGDImage, "arc",        gd_image_arc,        -1);
  rb_define_method(cGDImage, "filled_arc", gd_image_filled_arc, -1);
}
