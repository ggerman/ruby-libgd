#include "ruby_gd.h"

int color_to_gd(gdImagePtr im, VALUE color) {
    Check_Type(color, T_ARRAY);
    if (RARRAY_LEN(color) < 3)
        rb_raise(rb_eArgError, "color must be [r,g,b] or [r,g,b,a]");

    int r = NUM2INT(rb_ary_entry(color, 0));
    int g = NUM2INT(rb_ary_entry(color, 1));
    int b = NUM2INT(rb_ary_entry(color, 2));

    if (gdImageTrueColor(im)) {
        if (RARRAY_LEN(color) >= 4) {
            int a = NUM2INT(rb_ary_entry(color, 3));
            return gdTrueColorAlpha(r,g,b,a);
        }
        return gdTrueColor(r,g,b);
    }

    return gdImageColorAllocate(im, r,g,b);
}

static VALUE gd_color_rgb(VALUE self, VALUE r, VALUE g, VALUE b) {
  VALUE ary = rb_ary_new_capa(3);
  rb_ary_push(ary, r);
  rb_ary_push(ary, g);
  rb_ary_push(ary, b);
  return ary;
}

static VALUE gd_color_rgba(VALUE self, VALUE vr, VALUE vg, VALUE vb, VALUE va) {
    int r = NUM2INT(vr);
    int g = NUM2INT(vg);
    int b = NUM2INT(vb);
    int a = NUM2INT(va);

    if (a < 0) a = 0;
    if (a > 127) a = 127;   // GD usa 0=opaco, 127=transparente

    VALUE ary = rb_ary_new2(4);
    rb_ary_push(ary, INT2NUM(r));
    rb_ary_push(ary, INT2NUM(g));
    rb_ary_push(ary, INT2NUM(b));
    rb_ary_push(ary, INT2NUM(a));

    return ary;
}

void gd_define_color(VALUE mGD) {
  VALUE mGDColor = rb_define_module_under(mGD, "Color");
  rb_define_singleton_method(mGDColor, "rgb", gd_color_rgb, 3);
  rb_define_singleton_method(mGDColor, "rgba", gd_color_rgba, 4);
}
