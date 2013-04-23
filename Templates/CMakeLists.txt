cmake_minimum_required (VERSION 2.8)

#############################################
# Project
#############################################
project (Practise)
set (VERSION_MAJOR 0)
set (VERSION_MINOR 1)

#############################################
# path & flags
#############################################
# '~' not support here
include_directories (/usr/local/include)
link_directories (/usr/local/lib)
add_definitions (-std=gnu++0x)

#############################################
# external lib
#############################################
  # Boost Lib
  #include (Boost)
  # Qt4 GUI platform
  #include (Qt4)
  # Open Source Computer Vision Lib
  #include (OpenCV)
  # Safe CPP Lib
  #include (scpp)
  # CLI Output Control C Lib (author: LIU Yang)
  #include (clicntl)

#############################################
# Build all One file C++ Source files
#############################################
#include (buildall)
