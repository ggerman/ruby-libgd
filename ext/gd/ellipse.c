/**
    - [ ] imageellipse — Draw an ellipse
    - [ ] imagefilledellipse — Draw a filled ellipse
 */
#include "ruby_gd.h"

static VALUE gd_image_ellipse(int argc, VALUE *argv, VALUE self)
{
  VALUE vcx, vcy, vw, vh, vcolor, opts;
  VALUE thickness = Qnil;
  opts = Qnil;

  rb_scan_args(argc, argv, "5:", &vcx, &vcy, &vw, &vh, &vcolor, &opts);

  if (!NIL_P(opts)) {
    thickness = rb_hash_aref(opts, ID2SYM(rb_intern("thickness")));
  }

  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int cx = NUM2INT(vcx);
  int cy = NUM2INT(vcy);
  int w  = NUM2INT(vw);
  int h  = NUM2INT(vh);
  int c  = color_to_gd(wrap->img, vcolor);

  int t = NIL_P(thickness) ? 1 : NUM2INT(thickness);
  int half = t / 2;

  for (int i = -half; i <= half; i++) {
    gdImageArc(wrap->img,
               cx, cy,
               w + i * 2, h + i * 2,
               0, 360,
               c);
  }

  return self;
}

static VALUE gd_image_filled_ellipse(int argc, VALUE *argv, VALUE self)
{
  VALUE vcx, vcy, vw, vh, vcolor, opts;
  VALUE thickness = Qnil;
  opts = Qnil;

  rb_scan_args(argc, argv, "5:", &vcx, &vcy, &vw, &vh, &vcolor, &opts);

  if (!NIL_P(opts)) {
    thickness = rb_hash_aref(opts, ID2SYM(rb_intern("thickness")));
  }

  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int cx = NUM2INT(vcx);
  int cy = NUM2INT(vcy);
  int w  = NUM2INT(vw);
  int h  = NUM2INT(vh);
  int c  = color_to_gd(wrap->img, vcolor);

  /* Fill */
  gdImageFilledEllipse(wrap->img, cx, cy, w, h, c);

  /* Stroke */
  int t = NIL_P(thickness) ? 1 : NUM2INT(thickness);
  int half = t / 2;

  for (int i = -half; i <= half; i++) {
    gdImageArc(wrap->img,
               cx, cy,
               w + i * 2, h + i * 2,
               0, 360,
               c);
  }

  return self;
}

void gd_define_ellipse(VALUE cGDImage) {
  rb_define_method(cGDImage, "ellipse",        gd_image_ellipse,        -1);
  rb_define_method(cGDImage, "filled_ellipse", gd_image_filled_ellipse, -1);
}
