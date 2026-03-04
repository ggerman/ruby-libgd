#include "ruby_gd.h"
#include <string.h>

static float kernel_sobel[3][3] = {
  {-1,0,1},
  {-2,0,2},
  {-1,0,1}
};

static float kernel_sharpen[3][3] = {
  {0,-1,0},
  {-1,5,-1},
  {0,-1,0}
};

static float kernel_edge[3][3] = {
  {-1,-1,-1},
  {-1,8,-1},
  {-1,-1,-1}
};

static float kernel_box_blur[3][3] = {
  {1,1,1},
  {1,1,1},
  {1,1,1}
};

static float kernel_gaussian[3][3] = {
  {1,2,1},
  {2,4,2},
  {1,2,1}
};

static float kernel_emboss2[3][3] = {
  {-2,-1,0},
  {-1,1,1},
  {0,1,2}
};

static float kernel_laplacian[3][3] = {
  {0,-1,0},
  {-1,4,-1},
  {0,-1,0}
};

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
  else if (strcmp(name, "contrast") == 0) {
    /* libgd: double contrast */
    gdImageContrast(wrap->img, NUM2DBL(arg1));
  }
  else if (strcmp(name, "colorize") == 0) {
    /* libgd calls this "gdImageColor": add to channels */
    /* Ruby: img.filter(:colorize, r, g, b [, a]) */
    if (NIL_P(arg1) || NIL_P(arg2) || NIL_P(arg3)) {
      rb_raise(rb_eArgError, "colorize requires r, g, b (and optional alpha)");
    }
    int r = NUM2INT(arg1);
    int g = NUM2INT(arg2);
    int b = NUM2INT(arg3);
    int a = NIL_P(arg4) ? 0 : NUM2INT(arg4);

    if (!gdImageColor(wrap->img, r, g, b, a)) {
      rb_raise(rb_eRuntimeError, "colorize failed");
    }
  }
  else if (strcmp(name, "smooth") == 0) {
    /* libgd: float weight */
    gdImageSmooth(wrap->img, (float)NUM2DBL(arg1));
  }
  else if (strcmp(name, "scatter_color") == 0) {
    /* Ruby: img.filter(:scatter_color, sub, plus, [colors...]) */
    if (NIL_P(arg1) || NIL_P(arg2) || NIL_P(arg3)) {
      rb_raise(rb_eArgError, "scatter_color requires sub, plus, colors_array");
    }

    Check_Type(arg3, T_ARRAY);
    long n = RARRAY_LEN(arg3);
    if (n <= 0) {
      rb_raise(rb_eArgError, "colors_array must not be empty");
    }

    int *colors = ALLOC_N(int, n);
    for (long i = 0; i < n; i++) {
      colors[i] = NUM2INT(rb_ary_entry(arg3, i));
    }

    int ok = gdImageScatterColor(
      wrap->img,
      NUM2INT(arg1),
      NUM2INT(arg2),
      colors,
      (unsigned int)n
    );
    xfree(colors);

    if (!ok) {
      rb_raise(rb_eRuntimeError, "scatter_color failed");
    }
  }
  else if (strcmp(name, "scatter_ex") == 0) {
    /*
      Ruby: img.filter(:scatter_ex, opts)
      opts is a Hash:
        { sub: 2, plus: 5, seed: 123, colors: [ ... ] }
      colors is optional
      seed is optional
    */
    if (NIL_P(arg1) || TYPE(arg1) != T_HASH) {
      rb_raise(rb_eArgError, "scatter_ex requires a hash: {sub:, plus:, seed:, colors:}");
    }

    VALUE v_sub    = rb_hash_aref(arg1, ID2SYM(rb_intern("sub")));
    VALUE v_plus   = rb_hash_aref(arg1, ID2SYM(rb_intern("plus")));
    VALUE v_seed   = rb_hash_aref(arg1, ID2SYM(rb_intern("seed")));
    VALUE v_colors = rb_hash_aref(arg1, ID2SYM(rb_intern("colors")));

    if (NIL_P(v_sub) || NIL_P(v_plus)) {
      rb_raise(rb_eArgError, "scatter_ex hash must include :sub and :plus");
    }

    gdScatter s;
    memset(&s, 0, sizeof(gdScatter));

    s.sub  = NUM2INT(v_sub);
    s.plus = NUM2INT(v_plus);
    s.seed = NIL_P(v_seed) ? 0 : (unsigned int)NUM2UINT(v_seed);

    int *colors = NULL;
    unsigned int num_colors = 0;

    if (!NIL_P(v_colors)) {
      Check_Type(v_colors, T_ARRAY);
      long n = RARRAY_LEN(v_colors);
      if (n > 0) {
        colors = ALLOC_N(int, n);
        for (long i = 0; i < n; i++) {
          colors[i] = NUM2INT(rb_ary_entry(v_colors, i));
        }
        num_colors = (unsigned int)n;
      }
    }

    s.num_colors = num_colors;
    s.colors     = colors;

    int ok = gdImageScatterEx(wrap->img, &s);

    if (colors) xfree(colors);

    if (!ok) {
      rb_raise(rb_eRuntimeError, "scatter_ex failed");
    }
  }
  else if (strcmp(name, "sobel") == 0) {
    if (!gdImageConvolution(wrap->img, kernel_sobel, 1.0, 0.0)) {
      rb_raise(rb_eRuntimeError, "sobel convolution failed");
    }
  }
  else if (strcmp(name, "sharpen") == 0) {
    if (!gdImageConvolution(wrap->img, kernel_sharpen, 1.0, 0.0)) {
      rb_raise(rb_eRuntimeError, "sharpen convolution failed");
    }
  }
  else if (strcmp(name, "edge") == 0) {
    if (!gdImageConvolution(wrap->img, kernel_edge, 1.0, 0.0)) {
      rb_raise(rb_eRuntimeError, "edge convolution failed");
    }
  }
  else if (strcmp(name, "box_blur") == 0) {
    if (!gdImageConvolution(wrap->img, kernel_box_blur, 9.0, 0.0)) {
      rb_raise(rb_eRuntimeError, "box_blur convolution failed");
    }
  }
  else if (strcmp(name, "gaussian_kernel") == 0) {
    if (!gdImageConvolution(wrap->img, kernel_gaussian, 16.0, 0.0)) {
      rb_raise(rb_eRuntimeError, "gaussian_kernel convolution failed");
    }
  }
  else if (strcmp(name, "emboss2") == 0) {
    if (!gdImageConvolution(wrap->img, kernel_emboss2, 1.0, 128.0)) {
      rb_raise(rb_eRuntimeError, "emboss2 convolution failed");
    }
  }
  else if (strcmp(name, "laplacian") == 0) {
    if (!gdImageConvolution(wrap->img, kernel_laplacian, 1.0, 0.0)) {
      rb_raise(rb_eRuntimeError, "laplacian convolution failed");
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
