#ifndef RUBY_LIBGD_CLIP_H
#define RUBY_LIBGD_CLIP_H

int gd_clip_line_to_rect(int *x1, int *y1, int *x2, int *y2,
                         int xmin, int ymin, int xmax, int ymax);

#endif
