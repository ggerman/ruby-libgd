#include "ruby_gd.h"
#include <string.h>

static void gd_image_apply_sepia(gdImagePtr img) {
  int x, y;
  for (y = 0; y < img->sy; y++) {
    for (x = 0; x < img->sx; x++) {
      int c = gdImageGetTrueColorPixel(img, x, y);

      int r = gdTrueColorGetRed(c);
      int g = gdTrueColorGetGreen(c);
      int b = gdTrueColorGetBlue(c);

      int tr = (int)(0.393*r + 0.769*g + 0.189*b);
      int tg = (int)(0.349*r + 0.686*g + 0.168*b);
      int tb = (int)(0.272*r + 0.534*g + 0.131*b);

      if (tr > 255) tr = 255;
      if (tg > 255) tg = 255;
      if (tb > 255) tb = 255;

      gdImageSetPixel(img, x, y, gdTrueColor(tr, tg, tb));
    }
  }
}

static VALUE gd_image_filter(int argc, VALUE *argv, VALUE self) {
  VALUE type, arg1, arg2, arg3, arg4;
  rb_scan_args(argc, argv, "14", &type, &arg1, &arg2, &arg3, &arg4);

  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  type = rb_obj_as_string(type);
  const char *name = StringValueCStr(type);

  if (strcmp(name, "negate") == 0) {
    gdImageNegate(wrap->img);
  }
  else if (strcmp(name, "grayscale") == 0) {
    gdImageGrayScale(wrap->img);
  }
  else if (strcmp(name, "brightness") == 0) {
    gdImageBrightness(wrap->img, NUM2INT(arg1));
  }
  else if (strcmp(name, "contrast") == 0) {
    gdImageContrast(wrap->img, NUM2INT(arg1));
  }
  else if (strcmp(name, "colorize") == 0) {
    rb_raise(rb_eNotImpError, "colorize not supported by libgd");
  }
  else if (strcmp(name, "edge_detect") == 0) {
    gdImageEdgeDetectQuick(wrap->img);
  }
  else if (strcmp(name, "emboss") == 0) {
    gdImageEmboss(wrap->img);
  }
  else if (strcmp(name, "gaussian_blur") == 0) {
    gdImageGaussianBlur(wrap->img);
  }
  else if (strcmp(name, "selective_blur") == 0) {
    gdImageSelectiveBlur(wrap->img);
  }
  else if (strcmp(name, "mean_removal") == 0) {
    gdImageMeanRemoval(wrap->img);
  }
  else if (strcmp(name, "smooth") == 0) {
    gdImageSmooth(wrap->img, NUM2INT(arg1));
  }
  else if (strcmp(name, "pixelate") == 0) {
    gdImagePixelate(
      wrap->img,
      NUM2INT(arg1),
      RTEST(arg2)
    );
  }
  else if (strcmp(name, "scatter") == 0) {
    gdImageScatter(
      wrap->img,
      NUM2INT(arg1),
      NUM2INT(arg2)
    );
  }
  else if (strcmp(name, "sepia") == 0) {
    gd_image_apply_sepia(wrap->img);
  }
  else if (strcmp(name, "convolve") == 0) {

    Check_Type(arg1, T_ARRAY);
    if (RARRAY_LEN(arg1) != 3) {
      rb_raise(rb_eArgError, "kernel must be a 3x3 array");
    }

    float filter[3][3];

    for (int i = 0; i < 3; i++) {
      VALUE row = rb_ary_entry(arg1, i);
      Check_Type(row, T_ARRAY);

      if (RARRAY_LEN(row) != 3) {
        rb_raise(rb_eArgError, "kernel must be a 3x3 array");
      }

      for (int j = 0; j < 3; j++) {
        filter[i][j] = (float)NUM2DBL(rb_ary_entry(row, j));
      }
    }

    float divisor = NIL_P(arg2) ? 1.0f : (float)NUM2DBL(arg2);
    float offset  = NIL_P(arg3) ? 0.0f : (float)NUM2DBL(arg3);

    if (!gdImageConvolution(wrap->img, filter, divisor, offset)) {
      rb_raise(rb_eRuntimeError, "convolution failed");
    }
  }
  else {
    rb_raise(rb_eArgError, "unknown filter");
  }

  return self;
}

void gd_define_filter(VALUE cGDImage) {
  rb_define_method(cGDImage, "filter", gd_image_filter, -1);
}
