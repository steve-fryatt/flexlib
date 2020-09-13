# Copyright 2009-2020, Stephen Fryatt
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#
# See the License for the specific language governing permissions and
# limitations under the License.
# 

# This file is for building Acorn's FlexLib using
# the GCCSDK.
#
# This file really needs to be run by GNUMake.
# It is intended for native compilation on Linux (for use in a GCCSDK
# environment) or cross-compilation under the GCCSDK.

.PHONY: all library clean install backup

# Build Tools

CC := $(wildcard $(GCCSDK_INSTALL_CROSSBIN)/*gcc)
AR := $(wildcard $(GCCSDK_INSTALL_CROSSBIN)/*riscos-ar)
MKDIR := mkdir -p
RM := rm -rf
CP := cp
INSTALL := install

# Build Flags

CCFLAGS := -mlibscl -mhard-float -static -mthrowback -Wall -O2 -fno-strict-aliasing
BUZIPFLAGS := -x "*/.svn/*" -r -9

# Target Files

LIBOBJ := libFlexLib32.a
LIBHDR := flex.h

# Set up the various build directories.

SRCDIR := src
OBJDIR := obj
OUTDIR := build

# Includes and libraries.

INCLUDES := -I$(GCCSDK_INSTALL_ENV)/include

# Targets

all: library
library: $(OUTDIR)/$(LIBOBJ)

$(OUTDIR)/$(LIBOBJ): $(OBJDIR) $(OBJDIR)/flex.o
	$(AR) -rcuv $(OUTDIR)/$(LIBOBJ) $(OBJDIR)/flex.o

# Create a folder to hold the object files.

$(OBJDIR):
	$(MKDIR) $(OBJDIR)

$(OBJDIR)/flex.o: $(SRCDIR)/flex.h $(SRCDIR)/opts.h $(SRCDIR)/swiextra.h $(SRCDIR)/flex.c
	$(CC) $(CCFLAGS) $(INCLUDES) -o $(OBJDIR)/flex.o -c $(SRCDIR)/flex.c


# Install the finished version in the GCCSDK, ready for use.

install: clean all
	$(RM) $(GCCSDK_INSTALL_ENV)/lib/$(LIBOBJ)
	$(RM) $(GCCSDK_INSTALL_ENV)/include/$(LIBHDR)
	$(INSTALL) -t $(GCCSDK_INSTALL_ENV)/lib $(OUTDIR)/$(LIBOBJ)
	$(INSTALL) -t $(GCCSDK_INSTALL_ENV)/include $(SRCDIR)/$(LIBHDR)


# Clean targets

clean:
	$(RM) $(OUTDIR)/$(LIBOBJ)


# Build a backup Zip file

backup:
	$(RM) ../$(BUZIPFILE)
	$(ZIP) $(BUZIPFLAGS) ../$(BUZIPFILE) *
