#include "ruby_gd.h"

static VALUE mGD;
static VALUE cGDImage;

static VALUE gd_info(VALUE self) {
    return rb_str_new_cstr(gdVersionString());
}

static VALUE gd_types(VALUE self) {
    VALUE h = rb_hash_new();

    rb_hash_aset(h, ID2SYM(rb_intern("png")),
        gdSupportsFileType("test.png", 1) ? Qtrue : Qfalse);

    rb_hash_aset(h, ID2SYM(rb_intern("jpeg")),
        gdSupportsFileType("test.jpg", 1) ? Qtrue : Qfalse);

    rb_hash_aset(h, ID2SYM(rb_intern("gif")),
        gdSupportsFileType("test.gif", 1) ? Qtrue : Qfalse);

    rb_hash_aset(h, ID2SYM(rb_intern("webp")),
        gdSupportsFileType("test.webp", 1) ? Qtrue : Qfalse);

    rb_hash_aset(h, ID2SYM(rb_intern("bmp")),
        gdSupportsFileType("test.bmp", 1) ? Qtrue : Qfalse);

    return h;
}

static VALUE gd_mime_for(VALUE self, VALUE sym) {
    const char *t = rb_id2name(SYM2ID(sym));

    if (!strcmp(t,"png"))  return rb_str_new_cstr("image/png");
    if (!strcmp(t,"jpeg")) return rb_str_new_cstr("image/jpeg");
    if (!strcmp(t,"jpg"))  return rb_str_new_cstr("image/jpeg");
    if (!strcmp(t,"gif"))  return rb_str_new_cstr("image/gif");
    if (!strcmp(t,"webp")) return rb_str_new_cstr("image/webp");
    if (!strcmp(t,"bmp"))  return rb_str_new_cstr("image/bmp");

    return Qnil;
}

static VALUE gd_ext_for(VALUE self, VALUE sym) {
    const char *t = rb_id2name(SYM2ID(sym));

    if (!strcmp(t,"png"))  return rb_str_new_cstr(".png");
    if (!strcmp(t,"jpeg")) return rb_str_new_cstr(".jpg");
    if (!strcmp(t,"jpg"))  return rb_str_new_cstr(".jpg");
    if (!strcmp(t,"gif"))  return rb_str_new_cstr(".gif");
    if (!strcmp(t,"webp")) return rb_str_new_cstr(".webp");
    if (!strcmp(t,"bmp"))  return rb_str_new_cstr(".bmp");

    return Qnil;
}

void Init_gd(void) {
  mGD = rb_define_module("GD");

  rb_define_singleton_method(mGD, "info",     gd_info,     0);
  rb_define_singleton_method(mGD, "types",    gd_types,    0);
  rb_define_singleton_method(mGD, "mime_for", gd_mime_for, 1);
  rb_define_singleton_method(mGD, "ext_for",  gd_ext_for,  1);

  gd_define_image(mGD);

  cGDImage = rb_path2class("GD::Image");

  gd_define_blit(cGDImage);
  gd_define_fill(cGDImage);

  gd_define_pixel(cGDImage);
  gd_define_line(cGDImage);
  gd_define_arc(cGDImage);
  gd_define_rectangle(cGDImage);
  gd_define_circle(cGDImage);
  gd_define_ellipse(cGDImage);
  gd_define_polygon(cGDImage);

  gd_define_text(cGDImage);

  gd_define_filter(cGDImage);
  gd_define_transform(cGDImage);
  gd_define_encode(cGDImage);

  gd_define_color(mGD);
  gd_define_version(mGD);
}
