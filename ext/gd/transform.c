#include "ruby_gd.h"

static VALUE wrap_new_image(gdImagePtr im, VALUE klass) {
    gd_image_wrapper *w;
    VALUE obj = TypedData_Make_Struct(klass, gd_image_wrapper, &gd_image_type, w);
    w->img = im;
    w->owner = 1;
    return obj;
}

static VALUE gd_image_crop(VALUE self, VALUE vx, VALUE vy, VALUE vw, VALUE vh) {
    gd_image_wrapper *wrap;
    TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

    gdRect r;
    r.x = NUM2INT(vx);
    r.y = NUM2INT(vy);
    r.width  = NUM2INT(vw);
    r.height = NUM2INT(vh);

    gdImagePtr out = gdImageCrop(wrap->img, &r);
    if (!out) rb_raise(rb_eRuntimeError, "crop failed");

    return wrap_new_image(out, CLASS_OF(self));
}

static VALUE gd_image_scale(VALUE self, VALUE vw, VALUE vh) {
    gd_image_wrapper *wrap;
    TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

    int w = NUM2INT(vw);
    int h = NUM2INT(vh);

    gdImagePtr out = gdImageScale(wrap->img, w, h);
    if (!out) rb_raise(rb_eRuntimeError, "scale failed");

    return wrap_new_image(out, CLASS_OF(self));
}

void gd_define_transform(VALUE cGDImage) {
    rb_define_method(cGDImage, "crop", gd_image_crop, 4);
    rb_define_method(cGDImage, "scale", gd_image_scale, 2);
    rb_define_method(cGDImage, "resize", gd_image_scale, 2);
}
