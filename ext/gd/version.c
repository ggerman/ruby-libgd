#include "ruby_gd.h"

VALUE rb_gd_version(VALUE self) {
  return rb_str_new_cstr(gdVersionString());
}

void gd_define_version(VALUE mGD) {
    rb_define_singleton_method(mGD, "version", rb_gd_version, 0);
}
