#include "ruby_gd.h"

static VALUE gd_image_arc(VALUE self,
    VALUE vcx, VALUE vcy,
    VALUE vw, VALUE vh,
    VALUE vstart, VALUE vend,
    VALUE vcolor
) {
    gd_image_wrapper *wrap;
    TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

    int cx = NUM2INT(vcx);
    int cy = NUM2INT(vcy);
    int w  = NUM2INT(vw);
    int h  = NUM2INT(vh);
    int s  = NUM2INT(vstart);
    int e  = NUM2INT(vend);

    int c = color_to_gd(wrap->img, vcolor);

    gdImageArc(wrap->img, cx, cy, w, h, s, e, c);

    return self;
}

static VALUE gd_image_filled_arc(VALUE self,
    VALUE vcx, VALUE vcy,
    VALUE vw, VALUE vh,
    VALUE vstart, VALUE vend,
    VALUE vcolor
) {
    gd_image_wrapper *wrap;
    TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

    int cx = NUM2INT(vcx);
    int cy = NUM2INT(vcy);
    int w  = NUM2INT(vw);
    int h  = NUM2INT(vh);
    int s  = NUM2INT(vstart);
    int e  = NUM2INT(vend);

    int c = color_to_gd(wrap->img, vcolor);

    gdImageFilledArc(wrap->img, cx, cy, w, h, s, e, c, gdArc);

    return self;
}

void gd_define_arc(VALUE cGDImage) {
    rb_define_method(cGDImage, "arc", gd_image_arc, 7);
    rb_define_method(cGDImage, "filled_arc", gd_image_filled_arc, 7);
}
