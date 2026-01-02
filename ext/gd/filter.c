#include "ruby_gd.h"
#include <string.h>

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
  else {
    rb_raise(rb_eArgError, "unknown filter");
  }

  return self;
}

void gd_define_filter(VALUE cGDImage) {
  rb_define_method(cGDImage, "filter", gd_image_filter, -1);
}
