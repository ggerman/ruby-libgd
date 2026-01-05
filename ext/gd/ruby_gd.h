#ifndef RUBY_GD_H
#define RUBY_GD_H

#include <ruby.h>
#include <gd.h>

typedef struct {
    gdImagePtr img;
    int owner;
} gd_image_wrapper;

extern const rb_data_type_t gd_image_type;

int color_to_gd(gdImagePtr im, VALUE color);

/* Image */
void gd_define_image(VALUE mGD);
void gd_define_blit(VALUE cGDImage);
void gd_define_fill(VALUE cGDImage);

void gd_define_pixel(VALUE cGDImage);
void gd_define_line(VALUE cGDImage);
void gd_define_arc(VALUE cGDImage);
void gd_define_rectangle(VALUE cGDImage);
void gd_define_circle(VALUE cGDImage);
void gd_define_ellipse(VALUE cGDImage);
void gd_define_polygon(VALUE cGDImage);

void gd_define_text(VALUE cGDImage);

void gd_define_transform(VALUE cGDImage);
void gd_define_filter(VALUE cGDImage);
void gd_define_encode(VALUE cGDImage);

/* Color */
void gd_define_color(VALUE mGD);
void gd_define_version(VALUE mGD);

#endif
