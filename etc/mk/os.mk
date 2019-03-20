# -*- explicit-buffer-name: "os.mk<alliance-check-toolkit>" -*-
#
# Setup variables:
# * LIB_SUFFIX
# * LIB_SUFFIX_
# * BUILD_VARIANT
# * BUILD_TYPE_DIR
# * DEBUG_OPTION
# * USE_DEVTOOLSET_2


 UNAME_S          = $(shell uname -s)
 UNAME_R          = $(shell uname -r)
 UNAME_M          = $(shell uname -m)

 LIB_SUFFIX  = ""
 LIB_SUFFIX_ = ""
 ifeq ($(UNAME_M),x86_64)
   LIB_SUFFIX  = 64
   LIB_SUFFIX_ = _64
 endif

# We must use devtoolset-2 only under SL6.
 BUILD_VARIANT    = Linux
 USE_DEVTOOLSET_2 = No
 ifeq ($(UNAME_S),Linux)
   ifneq ($(findstring .el6.,$(UNAME_R)),)
     USE_DEVTOOLSET_2 = Yes
     BUILD_VARIANT    = Linux.slsoc6x
   endif
   ifneq ($(findstring .slsoc6.,$(UNAME_R)),)
     USE_DEVTOOLSET_2 = Yes
     BUILD_VARIANT    = Linux.slsoc6x
   endif
   ifneq ($(findstring .el7.,$(UNAME_R)),)
     BUILD_VARIANT    = Linux.el7
   endif
   ifneq ($(findstring -generic,$(UNAME_R)),)
     BUILD_VARIANT    = Linux.x86
   endif
  # Debian seems not to put a tag in the kernel revision,
  # so if no tag is found, assume Debian. 
   ifneq ($(findstring -amd64,$(UNAME_R)),)
     BUILD_VARIANT    = Linux.x86
   endif
 endif


# Select between release/debug versions.
 DEBUG_OPTION   = 
 BUILD_TYPE_DIR = Release.Shared
 ifeq ($(USE_DEBUG),Yes)
   DEBUG_OPTION   = --debug
   BUILD_TYPE_DIR = Debug.Shared
 endif

 VALGRIND_COMMAND =
 ifeq ($(USE_DEBUG),Yes)
  #VALGRIND_COMMAND = valgrind --keep-stacktraces=alloc-and-free --read-var-info=yes --trace-children=yes
  #VALGRIND_COMMAND = valgrind --keep-stacktraces=alloc-and-free --read-var-info=yes --trace-children=yes --free-fill=0xff
 endif


 ifeq ($(USE_DEVTOOLSET_2),Yes)
   scl_dts2 = scl enable devtoolset-2 '$(1)'
 else
   scl_dts2 = $(1)
 endif


# Standart System binary access paths.
 STANDART_BIN = /usr/bin:/bin:/usr/sbin:/sbin
