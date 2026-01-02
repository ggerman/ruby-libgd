#include "ruby_gd.h"
/*
 - [ ] imagefontheight — Get font height
 - [ ] imagefontwidth — Get font width
 - [ ] imageftbbox — Give the bounding box of a text using fonts via freetype2
 - [ ] imagefttext — Write text to the image using fonts using FreeType 2
*/

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

void gd_define_text(VALUE cGDImage) {
  rb_define_method(cGDImage, "text", gd_image_text, 2);
}
