/**
  - [ ] imagecopy — Copy part of an image
  - [ ] imagecopymerge — Copy and merge part of an image
  - [ ] imagecopymergegray — Copy and merge part of an image with gray scale
  - [ ] imagecopyresampled — Copy and resize part of an image with resampling
  - [ ] imagecopyresized — Copy and resize part of an image
*/
#include "ruby_gd.h"

static VALUE gd_image_copy_merge(
  VALUE self, VALUE src,
  VALUE dx, VALUE dy,
  VALUE sx, VALUE sy,
  VALUE w, VALUE h,
  VALUE pct
) {
  gd_image_wrapper *dst_wrap;
  gd_image_wrapper *src_wrap;

  TypedData_Get_Struct(self, gd_image_wrapper, &gd_image_type, dst_wrap);
  TypedData_Get_Struct(src,  gd_image_wrapper, &gd_image_type, src_wrap);

  gdImageCopyMerge(
    dst_wrap->img,
    src_wrap->img,
    NUM2INT(dx), NUM2INT(dy),
    NUM2INT(sx), NUM2INT(sy),
    NUM2INT(w),  NUM2INT(h),
    NUM2INT(pct)
  );

  return self;
}

void gd_define_blit(VALUE cGDImage) {
  rb_define_method(cGDImage, "copy_merge", gd_image_copy_merge, 8);
}
