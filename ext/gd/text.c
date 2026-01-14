#include "ruby_gd.h"

static VALUE gd_image_text(VALUE self, VALUE text, VALUE opts) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  VALUE x = rb_hash_aref(opts, ID2SYM(rb_intern("x")));
  VALUE y = rb_hash_aref(opts, ID2SYM(rb_intern("y")));
  VALUE size = rb_hash_aref(opts, ID2SYM(rb_intern("size")));
  VALUE color = rb_hash_aref(opts, ID2SYM(rb_intern("color")));
  VALUE font = rb_hash_aref(opts, ID2SYM(rb_intern("font")));

  if (NIL_P(x) || NIL_P(y) || NIL_P(size) || NIL_P(color) || NIL_P(font))
    rb_raise(rb_eArgError, "missing options");

  int fg = color_to_gd(wrap->img, color);

  int brect[8];
  char *err = gdImageStringFT(
    wrap->img,
    brect,
    fg,
    StringValueCStr(font),
    NUM2DBL(size),
    0,
    NUM2INT(x),
    NUM2INT(y),
    StringValueCStr(text)
  );

  if (err) rb_raise(rb_eRuntimeError, "%s", err);

  return Qnil;
}

static VALUE gd_image_text_bbox(VALUE self, VALUE text, VALUE opts) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  VALUE fontV = rb_hash_aref(opts, ID2SYM(rb_intern("font")));
  VALUE sizeV = rb_hash_aref(opts, ID2SYM(rb_intern("size")));

  if (NIL_P(fontV) || NIL_P(sizeV))
    rb_raise(rb_eArgError, "font and size are required");

  VALUE angleV = rb_hash_aref(opts, ID2SYM(rb_intern("angle")));
  double angle = NIL_P(angleV) ? 0.0 : NUM2DBL(angleV);

  const char *font = StringValueCStr(fontV);
  const char *str  = StringValueCStr(text);
  double size = NUM2DBL(sizeV);

  int brect[8];

  gdFTStringExtra extra;
  memset(&extra, 0, sizeof(extra));

  char *err = gdImageStringFTEx(
    wrap->img,
    brect,
    0,           /* no color, we don't draw */
    font,
    size,
    angle,
    0,
    0,
    str,
    &extra
  );

  if (err) rb_raise(rb_eRuntimeError, "%s", err);

  int w = brect[2] - brect[0];
  int h = brect[1] - brect[7];

  VALUE ary = rb_ary_new2(2);
  rb_ary_push(ary, INT2NUM(w));
  rb_ary_push(ary, INT2NUM(h));
  return ary;
}


static VALUE gd_image_text_ft(VALUE self, VALUE text, VALUE opts) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  VALUE xV = rb_hash_aref(opts, ID2SYM(rb_intern("x")));
  VALUE yV = rb_hash_aref(opts, ID2SYM(rb_intern("y")));
  VALUE sizeV = rb_hash_aref(opts, ID2SYM(rb_intern("size")));
  VALUE colorV = rb_hash_aref(opts, ID2SYM(rb_intern("color")));
  VALUE fontV = rb_hash_aref(opts, ID2SYM(rb_intern("font")));

  if (NIL_P(xV)||NIL_P(yV)||NIL_P(sizeV)||NIL_P(colorV)||NIL_P(fontV))
    rb_raise(rb_eArgError, "missing required options");

  int x = NUM2INT(xV);
  int y = NUM2INT(yV);
  double size = NUM2DBL(sizeV);
  const char *font = StringValueCStr(fontV);
  const char *str = StringValueCStr(text);

  VALUE angleV = rb_hash_aref(opts, ID2SYM(rb_intern("angle")));
  double angle = NIL_P(angleV) ? 0.0 : NUM2DBL(angleV);

  VALUE dpiV = rb_hash_aref(opts, ID2SYM(rb_intern("dpi")));
  int dpi = NIL_P(dpiV) ? 96 : NUM2INT(dpiV);
//
  VALUE lsV = rb_hash_aref(opts, ID2SYM(rb_intern("line_spacing")));
  double ls = NIL_P(lsV) ? 1.0 : NUM2DBL(lsV);

  int fg = color_to_gd(wrap->img, colorV);

  gdFTStringExtra extra;
  memset(&extra, 0, sizeof(extra));
  extra.flags = gdFTEX_LINESPACE | gdFTEX_RESOLUTION;
  extra.linespacing = ls;
  extra.hdpi = dpi;
  extra.vdpi = dpi;

  char *err = gdImageStringFTEx(
    wrap->img,
    NULL,
    fg,
    font,
    size,
    angle,
    x,
    y,
    str,
    &extra
  );

  if (err) rb_raise(rb_eRuntimeError, "%s", err);
  return Qnil;
}

void gd_define_text(VALUE cGDImage) {
  rb_define_method(cGDImage, "text", gd_image_text, 2);
  rb_define_method(cGDImage, "text_bbox", gd_image_text_bbox, 2);
  rb_define_method(cGDImage, "text_ft", gd_image_text_ft, 2);
}
