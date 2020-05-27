# common things across all mednafen cores

MEDNAFLAGS := \
	-Imednafen -Icommon -Imednafen/src/trio \
	-DHAVE_CONFIG_H=1 -DMDFN_DISABLE_NO_OPT_ERRWARN=1 \
	-fwrapv \
	-fno-strict-aliasing \
	-fomit-frame-pointer \
	-fsigned-char \
	-fno-aggressive-loop-optimizations \
	-fno-fast-math \
	-fno-unsafe-math-optimizations \
	-fjump-tables \
	-mfunction-return=keep \
	-mindirect-branch=keep \
	-mno-indirect-branch-register \
	-Wall -Wshadow -Wempty-body -Wignored-qualifiers \
	-Wvla -Wvariadic-macros -Wdisabled-optimization -Werror=write-strings \
	-Dprivate=public # the gods have abandoned us

CCFLAGS := $(MEDNAFLAGS) -std=gnu99
CXXFLAGS := $(MEDNAFLAGS) -std=gnu++11
EXTRA_LIBS := -lz

cppdir = $(shell find mednafen/src/$(1) -type f -name '*.cpp')
cdir = $(shell find mednafen/src/$(1) -type f -name '*.c')

MODULENAME := $(lastword $(filter-out $(lastword $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))
MODULENAME := $(MODULENAME:.mak=)

TARGET := $(MODULENAME).wbx

SRCS := \
	mednafen/src/error.cpp \
	mednafen/src/VirtualFS.cpp \
	mednafen/src/FileStream.cpp \
	mednafen/src/MemoryStream.cpp \
	mednafen/src/Stream.cpp \
	mednafen/src/file.cpp \
	mednafen/src/NativeVFS.cpp \
	mednafen/src/IPSPatcher.cpp \
	mednafen/src/Time.cpp \
	mednafen/src/git.cpp \
	mednafen/src/endian.cpp \
	$(call cppdir,string) \
	$(call cppdir,hash) \
	$(call cdir,trio) \
	$(call cdir,cputest) \
	$(call cppdir,compress) \
	$(call cppdir,video) \
	$(filter-out %generate.cpp,$(call cppdir,sound)) \
	Interfaces.cpp NymaCore.cpp
