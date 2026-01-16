#include "ruby_gd.h"

typedef struct {
  FILE *out;
  gdImagePtr prev;
  VALUE prev_rb;
  int started;
  int loop;
} gd_gif_wrapper;

static void gd_gif_free(void *p) {
  gd_gif_wrapper *gif = (gd_gif_wrapper *)p;

  if (gif->out) {
    if (gif->started) {
      gdImageGifAnimEnd(gif->out);
    }
    fclose(gif->out);
  }

  xfree(gif);
}

static size_t gd_gif_memsize(const void *p) {
  return sizeof(gd_gif_wrapper);
}

static const rb_data_type_t gd_gif_type = {
  "GD::Gif",
  {
    0,
    gd_gif_free,
    gd_gif_memsize,
  },
  0, 0, RUBY_TYPED_FREE_IMMEDIATELY
};

static VALUE gd_gif_alloc(VALUE klass) {
  gd_gif_wrapper *gif;
  VALUE obj = TypedData_Make_Struct(klass, gd_gif_wrapper, &gd_gif_type, gif);

  gif->out = NULL;
  gif->prev = NULL;
  gif->prev_rb = Qnil;
  gif->started = 0;
  gif->loop = 0;

  return obj;
}

/*
 * GD::Gif.new("file.gif", loop: true)
 */
static VALUE gd_gif_initialize(int argc, VALUE *argv, VALUE self) {
  VALUE path, opts;
  rb_scan_args(argc, argv, "11", &path, &opts);

  gd_gif_wrapper *gif;
  TypedData_Get_Struct(self, gd_gif_wrapper, &gd_gif_type, gif);

  const char *filename = StringValueCStr(path);
  gif->out = fopen(filename, "wb");
  if (!gif->out) rb_sys_fail(filename);

  gif->started = 0;
  gif->prev = NULL;
  gif->prev_rb = Qnil;

  gif->loop = 0;
  if (opts != Qnil) {
    VALUE loopv = rb_hash_aref(opts, ID2SYM(rb_intern("loop")));
    if (loopv == Qfalse) {
      gif->loop = -1;
    }
  }

  return self;
}

/*
 * gif.add_frame(img, delay: 50)
 */
static VALUE gd_gif_add_frame(int argc, VALUE *argv, VALUE self) {
  VALUE rb_img, opts;
  rb_scan_args(argc, argv, "11", &rb_img, &opts);

  gd_image_wrapper *wrap;
  TypedData_Get_Struct(rb_img, gd_image_wrapper, &gd_image_type, wrap);

  gd_gif_wrapper *gif;
  TypedData_Get_Struct(self, gd_gif_wrapper, &gd_gif_type, gif);

  int delay = 50;
  if (opts != Qnil) {
    VALUE d = rb_hash_aref(opts, ID2SYM(rb_intern("delay")));
    if (!NIL_P(d)) delay = NUM2INT(d);
  }

  if (!gif->started) {
    gdImageGifAnimBegin(wrap->img, gif->out, 1, gif->loop);
    gif->started = 1;
  }

  gdImageGifAnimAdd(
    wrap->img,
    gif->out,
    1,
    0, 0,
    delay,
    1,
    gif->prev
  );

  gif->prev = wrap->img;
  gif->prev_rb = rb_img;   /* prevent GC */

  return Qtrue;
}

/*
 * gif.close
 */
static VALUE gd_gif_close(VALUE self) {
  gd_gif_wrapper *gif;
  TypedData_Get_Struct(self, gd_gif_wrapper, &gd_gif_type, gif);

  if (gif->out) {
    if (gif->started) {
      gdImageGifAnimEnd(gif->out);
    }
    fclose(gif->out);
    gif->out = NULL;
  }

  gif->prev = NULL;
  gif->prev_rb = Qnil;

  return Qtrue;
}

/*
 * Init hook
 */
void gd_define_gif(VALUE mGD) {
  VALUE cGif = rb_define_class_under(mGD, "Gif", rb_cObject);

  rb_define_alloc_func(cGif, gd_gif_alloc);
  rb_define_method(cGif, "initialize", gd_gif_initialize, -1);
  rb_define_method(cGif, "add_frame", gd_gif_add_frame, -1);
  rb_define_method(cGif, "close", gd_gif_close, 0);
}
