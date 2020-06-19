NDK= ~/Android/Sdk/ndk/21.3.6528147
TOOLCHAIN=$(NDK)/toolchains/llvm/prebuilt/linux-x86_64
# Only choose one of these, depending on your device...
#TARGET=aarch64-linux-android
TARGET=armv7a-linux-androideabi
# Set this to your minSdkVersion.
API=27
# Configure
AR=$(TOOLCHAIN)/bin/$(TARGET)-ar
AS=$(TOOLCHAIN)/bin/$(TARGET)-as
CC=$(TOOLCHAIN)/bin/$(TARGET)$(API)-clang
CXX=$(TOOLCHAIN)/bin/$(TARGET)$(API)-clang++
LD=$(TOOLCHAIN)/bin/$(TARGET)-ld
RANLIB=$(TOOLCHAIN)/bin/$(TARGET)-ranlib
STRIP=$(TOOLCHAIN)/bin/$(TARGET)-strip


# You know, there are pre-compile DEBs of this...
PLATF_KIT = /platforms/android-$(API)
ARM_INC = $(TOOLCHAIN)/include
INC_EXTRA = ../android-include-extras
ARM_LIB = $(TOOLCHAIN)/lib
LIB_EXTRA = ../android-lib-extras

CXX ?= g++
INCS = -I $(ARM_INC) -I $(INC_EXTRA) -I /usr/include
CXXFLAGS ?= -O2 -Wall $(INCS)
LDFLAGS += -Wl,-Bsymbolic-functions -Wl,--dynamic-linker,/system/bin/linker \
		-Wl,-rpath,/system/lib -Wl,-rpath,$(ARM_LIB) -Wl,-rpath-link,$(ARM_LIB) \
        --sysroot=$(TOOLCHAIN)/ \
		-Wl,-L$(ARM_LIB) -L$(LIB_EXTRA)

GASIA_GAMEPAD_HACKS = true

ifeq ($(GASIA_GAMEPAD_HACKS),true)
CXXFLAGS += -DGASIA_GAMEPAD_HACKS
endif

all: sixad_bins

sixad_bins:
	mkdir -p bins
	$(CXX) $(CXXFLAGS) $(LDFLAGS) sixad-bin.cpp bluetooth.cpp shared.cpp textfile.cpp __ppoll.S poll.cpp __set_errno.cpp -o bins/sixad-bin -lc -lbluetooth -fpermissive
	$(CXX) $(CXXFLAGS) $(LDFLAGS) sixad-sixaxis.cpp sixaxis.cpp shared.cpp uinput.cpp textfile.cpp __ppoll.S poll.cpp __set_errno.cpp -o bins/sixad-sixaxis -lc

clean:
	rm -f *~ bins/*

