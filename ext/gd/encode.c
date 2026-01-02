#include "ruby_gd.h"

static VALUE gd_image_save(int argc, VALUE *argv, VALUE self) {
  VALUE path, opts;
  rb_scan_args(argc, argv, "11", &path, &opts);

  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  const char *filename = StringValueCStr(path);

  const char *ext = strrchr(filename, '.');
  if (!ext) rb_raise(rb_eArgError, "file extension required");

  FILE *f = fopen(filename, "wb");
  if (!f) rb_sys_fail(filename);

  if (strcmp(ext, ".png") == 0) {
    gdImageSaveAlpha(wrap->img, 1);
    gdImageAlphaBlending(wrap->img, 0);
    gdImagePng(wrap->img, f);
  } else if (strcmp(ext, ".jpg") == 0 || strcmp(ext, ".jpeg") == 0) {
    int quality = 90;
    if (opts != Qnil) {
      VALUE q = rb_hash_aref(opts, ID2SYM(rb_intern("quality")));
      if (!NIL_P(q)) quality = NUM2INT(q);
    }
    gdImageJpeg(wrap->img, f, quality);
  } else if (strcmp(ext, ".webp") == 0) {
    gdImageWebp(wrap->img, f);
  } else {
    fclose(f);
    rb_raise(rb_eArgError, "unsupported format");
  }

  fclose(f);
  return Qtrue;
}

static VALUE gd_image_to_png(VALUE self) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int size = 0;
  void *data = gdImagePngPtr(wrap->img, &size);
  if (!data) rb_raise(rb_eRuntimeError, "PNG encode failed");

  VALUE str = rb_str_new((const char*)data, size);
  gdFree(data);
  return str;
}

void gd_define_encode(VALUE cGDImage) {
  rb_define_method(cGDImage, "save", gd_image_save, -1);
  rb_define_method(cGDImage, "to_png", gd_image_to_png, 0);
}
