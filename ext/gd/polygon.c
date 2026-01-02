/**
    - [ ] imagefilledpolygon — Draw a filled polygon
    - [ ] imageopenpolygon — Draws an open polygon
    - [ ] imagepolygon — Draws a polygon
*/
#include "ruby_gd.h"
#include <string.h>

static gdPointPtr build_points(VALUE points, int *count_out) {
  Check_Type(points, T_ARRAY);

  long n = RARRAY_LEN(points);
  if (n <= 0) {
    *count_out = 0;
    return NULL;
  }

  // Primero construimos todos los puntos (como antes)
  gdPoint *raw_pts = ALLOC_N(gdPoint, n);
  for (long i = 0; i < n; i++) {
    VALUE pair = rb_ary_entry(points, i);
    Check_Type(pair, T_ARRAY);
    if (RARRAY_LEN(pair) < 2) {
      xfree(raw_pts);
      rb_raise(rb_eArgError, "each point must be [x, y]");
    }
    raw_pts[i].x = NUM2INT(rb_ary_entry(pair, 0));
    raw_pts[i].y = NUM2INT(rb_ary_entry(pair, 1));
  }

  // Ahora eliminamos duplicados consecutivos
  long unique_n = 0;
  for (long i = 0; i < n; i++) {
    if (unique_n == 0 ||
        raw_pts[unique_n - 1].x != raw_pts[i].x ||
        raw_pts[unique_n - 1].y != raw_pts[i].y) {
      raw_pts[unique_n++] = raw_pts[i];
    }
  }

  *count_out = (int)unique_n;

  // Si hay menos de 3 puntos únicos, fallamos
  if (unique_n < 3) {
    xfree(raw_pts);
    *count_out = 0;
    return NULL;
  }

  // Reasignamos memoria para evitar desperdicio (opcional pero limpio)
  gdPoint *clean_pts = ALLOC_N(gdPoint, unique_n);
  MEMCPY(clean_pts, raw_pts, gdPoint, unique_n);
  xfree(raw_pts);

  return (gdPointPtr)clean_pts;
}

static VALUE gd_image_polygon(VALUE self, VALUE points, VALUE color) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  int count = 0;
  gdPointPtr pts = build_points(points, &count);
  int c = color_to_gd(wrap->img, color);

  gdImagePolygon(wrap->img, pts, count, c);

  xfree(pts);
  return self;
}

static VALUE gd_image_filled_polygon(VALUE self, VALUE points, VALUE color) {
  gd_image_wrapper *wrap;
  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, wrap);

  if (!wrap || !wrap->img) {
    rb_raise(rb_eRuntimeError, "uninitialized GD::Image");
  }

  int count = 0;
  gdPointPtr pts = build_points(points, &count);

  if (!pts || count < 3) {
    if (pts) xfree(pts);
    rb_raise(rb_eArgError, "points must be an Array of at least 3 [x,y] pairs");
  }

  int c = color_to_gd(wrap->img, color);
  gdImageFilledPolygon(wrap->img, pts, count, c);

  xfree(pts);
  return self;
}

void gd_define_polygon(VALUE cGDImage) {
  rb_define_method(cGDImage, "polygon", gd_image_polygon, 2);
  rb_define_method(cGDImage, "filled_polygon", gd_image_filled_polygon, 2);
}
