#include "ruby_gd.h"

static VALUE gd_image_alloc(VALUE klass) {
  gd_image_wrapper *wrap;
  VALUE obj = TypedData_Make_Struct(klass, gd_image_wrapper, &gd_image_type, wrap);
  wrap->img = NULL;
  return obj;
}

/* ---------------------------------------------------------
 * Initialize
 * --------------------------------------------------------- */

static VALUE gd_image_initialize(int argc, VALUE *argv, VALUE self) {
  if (argc == 0) {
    rb_raise(rb_eArgError, "width and height are required");
    return self;
  }

  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  wrap->img = NULL;

  if (argc != 2) {
    rb_raise(rb_eArgError, "expected 0 or 2 arguments");
  }

  int w = NUM2INT(argv[0]);
  int h = NUM2INT(argv[1]);

  if (w <= 0 || h <= 0)
    rb_raise(rb_eArgError, "width and height must be positive");

  wrap->img = gdImageCreateTrueColor(w,h);

  if (!wrap->img)
    rb_raise(rb_eRuntimeError, "gdImageCreateTrueColor failed");

  gdImageSaveAlpha(wrap->img, 1);
  gdImageAlphaBlending(wrap->img, 0);

  int transparent = gdTrueColorAlpha(0,0,0,127);
  gdImageFilledRectangle(wrap->img, 0,0,w,h, transparent);

  gdImageAlphaBlending(wrap->img, 1);

  return self;
}

/* ---------------------------------------------------------
 * initialize_copy (correct way for clone/dup)
 * --------------------------------------------------------- */

static VALUE gd_image_initialize_copy(VALUE self, VALUE orig) {
  gd_image_wrapper *src;
  gd_image_wrapper *dst;

  if (self == orig) return self;

  TypedData_Get_Struct(orig, gd_image_wrapper, &gd_image_type, src);
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, dst);

  if (!src->img)
    rb_raise(rb_eRuntimeError, "cannot copy: image is NULL");

  if (dst->img) {
    gdImageDestroy(dst->img);
    dst->img = NULL;
  }

  dst->img = gdImageClone(src->img);

  if (!dst->img)
    rb_raise(rb_eRuntimeError, "gdImageClone failed");

  return self;
}

/* ---------------------------------------------------------
 * Free
 * --------------------------------------------------------- */

static void gd_image_free(void *ptr) {
  gd_image_wrapper *wrap = (gd_image_wrapper *)ptr;

  if (!wrap) return;

  if (wrap->img) {
    gdImageDestroy(wrap->img);
    wrap->img = NULL;
  }
}

static size_t gd_image_memsize(const void *ptr) {
  return ptr ? sizeof(gd_image_wrapper) : 0;
}

const rb_data_type_t gd_image_type = {
  "GD::Image",
  { 0, gd_image_free, gd_image_memsize, },
  0, 0,
  RUBY_TYPED_FREE_IMMEDIATELY
};

/* ---------------------------------------------------------
 * Image loading
 * --------------------------------------------------------- */

static VALUE gd_image_open(VALUE klass, VALUE path) {
  const char *filename = StringValueCStr(path);

  FILE *f = fopen(filename, "rb");
  if (!f) rb_sys_fail(filename);

  gdImagePtr img = NULL;

  const char *ext = strrchr(filename, '.');
  if (!ext) rb_raise(rb_eArgError, "unknown image type");

  if (strcmp(ext, ".png") == 0) {
    img = gdImageCreateFromPng(f);
  } else if (strcmp(ext, ".jpg") == 0 || strcmp(ext, ".jpeg") == 0) {
    img = gdImageCreateFromJpeg(f);
  } else if (strcmp(ext, ".webp") == 0) {
    img = gdImageCreateFromWebp(f);
  } else if (strcmp(ext, ".gif") == 0) {
    img = gdImageCreateFromGif(f);
  } else {
    fclose(f);
    rb_raise(rb_eArgError, "unsupported format");
  }

  fclose(f);

  if (!img)
    rb_raise(rb_eRuntimeError, "image decode failed");

  VALUE obj = rb_obj_alloc(klass);

  gd_image_wrapper *wrap;
  TypedData_Get_Struct(obj, gd_image_wrapper, &gd_image_type, wrap);

  wrap->img = img;

  return obj;
}

/* ---------------------------------------------------------
 * Image info
 * --------------------------------------------------------- */

static VALUE gd_image_width(VALUE self) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);
  if (!wrap->img)
    rb_raise(rb_eRuntimeError, "image not initialized");
  return INT2NUM(gdImageSX(wrap->img));
}

static VALUE gd_image_height(VALUE self) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);
  if (!wrap->img)
    rb_raise(rb_eRuntimeError, "image not initialized");
  return INT2NUM(gdImageSY(wrap->img));
}

/* ---------------------------------------------------------
 * Copy operations
 * --------------------------------------------------------- */

static VALUE gd_image_copy (
  VALUE self, VALUE src,
  VALUE dx, VALUE dy,
  VALUE sx, VALUE sy,
  VALUE w, VALUE h
) {
  gd_image_wrapper *dst;
  gd_image_wrapper *srcw;

  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, dst);
  TypedData_Get_Struct(src,  gd_image_wrapper, &gd_image_type, srcw);

  if (!dst->img)  rb_raise(rb_eRuntimeError, "image not initialized");
  if (!srcw->img) rb_raise(rb_eRuntimeError, "source image not initialized");

  gdImageCopy(
    dst->img,
    srcw->img,
    NUM2INT(dx), NUM2INT(dy),
    NUM2INT(sx), NUM2INT(sy),
    NUM2INT(w),  NUM2INT(h)
  );

  return Qnil;
}

static VALUE gd_image_copy_resize(int argc, VALUE *argv, VALUE self) {
  VALUE src_img;
  VALUE dst_x, dst_y, src_x, src_y, src_w, src_h, dst_w, dst_h, resample;

  rb_scan_args(argc, argv, "91",
    &src_img, &dst_x, &dst_y, &src_x, &src_y,
    &src_w, &src_h, &dst_w, &dst_h,
    &resample
  );

  gd_image_wrapper *dst, *src;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, dst);
  TypedData_Get_Struct(src_img, gd_image_wrapper, &gd_image_type, src);

  if (!dst->img)  rb_raise(rb_eRuntimeError, "image not initialized");
  if (!src->img)  rb_raise(rb_eRuntimeError, "source image not initialized");

  int dx = NUM2INT(dst_x);
  int dy = NUM2INT(dst_y);
  int sx = NUM2INT(src_x);
  int sy = NUM2INT(src_y);
  int sw = NUM2INT(src_w);
  int sh = NUM2INT(src_h);
  int dw = NUM2INT(dst_w);
  int dh = NUM2INT(dst_h);

  if (RTEST(resample)) {
    gdImageCopyResampled(
      dst->img, src->img,
      dx, dy,
      sx, sy,
      dw, dh,
      sw, sh
    );
  } else {
    gdImageCopyResized(
      dst->img, src->img,
      dx, dy,
      sx, sy,
      dw, dh,
      sw, sh
    );
  }

  return self;
}

/* ---------------------------------------------------------
 * Flags
 * --------------------------------------------------------- */

static VALUE gd_image_alpha_blending(VALUE self, VALUE flag) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);
  if (!wrap->img)
    rb_raise(rb_eRuntimeError, "image not initialized");
  gdImageAlphaBlending(wrap->img, RTEST(flag));
  return self;
}

static VALUE gd_image_save_alpha(VALUE self, VALUE flag) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);
  if (!wrap->img)
    rb_raise(rb_eRuntimeError, "image not initialized");
  gdImageSaveAlpha(wrap->img, RTEST(flag));
  return self;
}

static VALUE gd_image_antialias(VALUE self, VALUE flag) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  if (!wrap->img)
    rb_raise(rb_eRuntimeError, "image not initialized");

  if (RTEST(flag)) {
    int aa = gdTrueColorAlpha(255,255,255,0);
    gdImageSetAntiAliased(wrap->img, aa);
    gdImageAlphaBlending(wrap->img, 1);
  } else {
    gdImageSetAntiAliased(wrap->img, -1);
  }

  return flag;
}

/* ---------------------------------------------------------
 * Class definition
 * --------------------------------------------------------- */

void gd_define_image(VALUE mGD) {

  VALUE cGDImage = rb_define_class_under(mGD, "Image", rb_cObject);

  rb_define_alloc_func(cGDImage, gd_image_alloc);

  rb_define_method(cGDImage, "initialize", gd_image_initialize, -1);
  rb_define_method(cGDImage, "initialize_copy", gd_image_initialize_copy, 1);

  rb_define_method(cGDImage, "width",  gd_image_width,  0);
  rb_define_method(cGDImage, "height", gd_image_height, 0);

  rb_define_method(cGDImage, "copy_resize", gd_image_copy_resize, -1);
  rb_define_method(cGDImage, "copy", gd_image_copy, 7);

  rb_define_singleton_method(cGDImage, "open", gd_image_open, 1);

  rb_define_method(cGDImage, "alpha_blending=", gd_image_alpha_blending, 1);
  rb_define_method(cGDImage, "save_alpha=", gd_image_save_alpha, 1);

  rb_define_method(cGDImage, "antialias=", gd_image_antialias, 1);
  rb_define_method(cGDImage, "antialias",  gd_image_antialias, 1);
}
