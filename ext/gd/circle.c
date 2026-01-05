#include "ruby_gd.h"

static VALUE gd_image_circle(int argc, VALUE *argv, VALUE self)
{
  VALUE vcx, vcy, vradius, vcolor, opts;
  VALUE thickness = Qnil;
  opts = Qnil;

  rb_scan_args(argc, argv, "4:", &vcx, &vcy, &vradius, &vcolor, &opts);

  if (!NIL_P(opts)) {
    thickness = rb_hash_aref(opts, ID2SYM(rb_intern("thickness")));
  }

  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int cx = NUM2INT(vcx);
  int cy = NUM2INT(vcy);
  int r  = NUM2INT(vradius);
  int c  = color_to_gd(wrap->img, vcolor);

  int t = NIL_P(thickness) ? 1 : NUM2INT(thickness);
  int half = t / 2;

  for (int i = -half; i <= half; i++) {
    gdImageArc(wrap->img,
               cx, cy,
               (r + i) * 2, (r + i) * 2,
               0, 360,
               c);
  }

  return self;
}

static VALUE gd_image_filled_circle(int argc, VALUE *argv, VALUE self)
{
  VALUE vcx, vcy, vradius, vcolor, opts;
  VALUE thickness = Qnil;
  opts = Qnil;

  rb_scan_args(argc, argv, "4:", &vcx, &vcy, &vradius, &vcolor, &opts);

  if (!NIL_P(opts)) {
    thickness = rb_hash_aref(opts, ID2SYM(rb_intern("thickness")));
  }

  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int cx = NUM2INT(vcx);
  int cy = NUM2INT(vcy);
  int r  = NUM2INT(vradius);
  int c  = color_to_gd(wrap->img, vcolor);

  /* Fill */
  gdImageFilledEllipse(wrap->img,
                       cx, cy,
                       r * 2, r * 2,
                       c);

  /* Stroke */
  int t = NIL_P(thickness) ? 1 : NUM2INT(thickness);
  int half = t / 2;

  for (int i = -half; i <= half; i++) {
    gdImageArc(wrap->img,
               cx, cy,
               (r + i) * 2, (r + i) * 2,
               0, 360,
               c);
  }

  return self;
}

void gd_define_circle(VALUE cGDImage)
{
  rb_define_method(cGDImage, "circle",        gd_image_circle,        -1);
  rb_define_method(cGDImage, "filled_circle", gd_image_filled_circle, -1);
}
