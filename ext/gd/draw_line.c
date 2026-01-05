#include <math.h>
#include "ruby_gd.h"
#include "clip.h"

static VALUE gd_image_line(int argc, VALUE *argv, VALUE self) {
  VALUE x1, y1, x2, y2, color, opts;
  opts = Qnil;

  rb_scan_args(argc, argv, "5:", &x1, &y1, &x2, &y2, &color, &opts);

  VALUE thickness = Qnil;
  if (!NIL_P(opts)) {
    thickness = rb_hash_aref(opts, ID2SYM(rb_intern("thickness")));
  }

  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int ix1 = NUM2INT(x1);
  int iy1 = NUM2INT(y1);
  int ix2 = NUM2INT(x2);
  int iy2 = NUM2INT(y2);

  int ox1 = ix1;
  int oy1 = iy1;
  int ox2 = ix2;
  int oy2 = iy2;

  int w = wrap->img->sx;
  int h = wrap->img->sy;

  /* Clip to image bounds */
  int xmin = 0;
  int ymin = 0;
  int xmax = w - 1;
  int ymax = h - 1;

  if (!gd_clip_line_to_rect(&ix1, &iy1, &ix2, &iy2, xmin, ymin, xmax, ymax)) {
    rb_warn("Line is completely outside image bounds");
    return Qnil;
  }

  if (ix1 != ox1 || iy1 != oy1 || ix2 != ox2 || iy2 != oy2) {
    rb_warn("Line coordinates clipped to image bounds");
  }

  if (TYPE(color) != T_ARRAY || RARRAY_LEN(color) != 3) {
    rb_raise(rb_eArgError, "color must be [r,g,b]");
  }

  int c = color_to_gd(wrap->img, color);
  int old = 1;

  if (!NIL_P(thickness)) {
    gdImageSetThickness(wrap->img, NUM2INT(thickness));
  }
  gdImageLine(wrap->img, NUM2INT(x1), NUM2INT(y1), NUM2INT(x2), NUM2INT(y2), c);
  gdImageSetThickness(wrap->img, old);

  return Qnil;
}

void gd_define_line(VALUE cGDImage) {
  rb_define_method(cGDImage, "line", gd_image_line, -1);
}
