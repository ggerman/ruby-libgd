#include "clip.h"
#include <math.h>

/* Cohen–Sutherland outcodes */
#define CS_LEFT   1
#define CS_RIGHT  2
#define CS_BOTTOM 4
#define CS_TOP    8

/**
 - [ ] imagegetclip — Get the clipping rectangle
 - [ ] imagesetclip — Set the clipping rectangle
*/

static int cs_outcode(int x, int y, int xmin, int ymin, int xmax, int ymax)
{
  int code = 0;
  if (x < xmin) code |= CS_LEFT;
  else if (x > xmax) code |= CS_RIGHT;

  if (y < ymin) code |= CS_TOP;
  else if (y > ymax) code |= CS_BOTTOM;

  return code;
}

/*
 * Clips a line segment to rectangle [xmin..xmax] × [ymin..ymax].
 * On success, updates (*x1,*y1,*x2,*y2) to clipped endpoints and returns 1.
 * If outside (no intersection), returns 0.
 */
int gd_clip_line_to_rect(int *x1, int *y1, int *x2, int *y2,
                     int xmin, int ymin, int xmax, int ymax)
{
  int x1i = *x1, y1i = *y1, x2i = *x2, y2i = *y2;
  int out1 = cs_outcode(x1i, y1i, xmin, ymin, xmax, ymax);
  int out2 = cs_outcode(x2i, y2i, xmin, ymin, xmax, ymax);

  while (1) {
    if ((out1 | out2) == 0) {
      /* Trivially accept */
      *x1 = x1i; *y1 = y1i; *x2 = x2i; *y2 = y2i;
      return 1;
    }
    if ((out1 & out2) != 0) {
      /* Trivially reject */
      return 0;
    }

    /* At least one endpoint is outside; choose it */
    int out = out1 ? out1 : out2;

    /* Intersection point (use double to avoid integer rounding traps) */
    double x = 0.0, y = 0.0;
    double dx = (double)(x2i - x1i);
    double dy = (double)(y2i - y1i);

    if (out & CS_TOP) {
      /* y = ymin */
      if (dy == 0.0) return 0; /* horizontal line outside */
      x = x1i + dx * ( (double)(ymin - y1i) / dy );
      y = (double)ymin;
    } else if (out & CS_BOTTOM) {
      /* y = ymax */
      if (dy == 0.0) return 0;
      x = x1i + dx * ( (double)(ymax - y1i) / dy );
      y = (double)ymax;
    } else if (out & CS_RIGHT) {
      /* x = xmax */
      if (dx == 0.0) return 0; /* vertical line outside */
      y = y1i + dy * ( (double)(xmax - x1i) / dx );
      x = (double)xmax;
    } else { /* CS_LEFT */
      /* x = xmin */
      if (dx == 0.0) return 0;
      y = y1i + dy * ( (double)(xmin - x1i) / dx );
      x = (double)xmin;
    }

    /* Round to nearest int (you can also use floor/ceil if prefieres) */
    int xi = (int)lround(x);
    int yi = (int)lround(y);

    if (out == out1) {
      x1i = xi; y1i = yi;
      out1 = cs_outcode(x1i, y1i, xmin, ymin, xmax, ymax);
    } else {
      x2i = xi; y2i = yi;
      out2 = cs_outcode(x2i, y2i, xmin, ymin, xmax, ymax);
    }
  }
}
