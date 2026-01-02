require 'mkmf'

abort "libgd not found" unless have_library("gd")
have_library("m")
create_makefile("gd/gd")
