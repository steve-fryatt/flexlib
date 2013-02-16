# Copyright 2009-2012, Stephen Fryatt
#
# This file is for building Acorn's FlexLib using
# the GCCSDK.
#
#   http://www.stevefryatt.org.uk/software/
#
# Licensed under the EUPL, Version 1.1 only (the "Licence");
# You may not use this work except in compliance with the
# Licence.
#
# You may obtain a copy of the Licence at:
#
#   http://joinup.ec.europa.eu/software/page/eupl
#
# Unless required by applicable law or agreed to in
# writing, software distributed under the Licence is
# distributed on an "AS IS" basis, WITHOUT WARRANTIES
# OR CONDITIONS OF ANY KIND, either express or implied.
#
# See the Licence for the specific language governing
# permissions and limitations under the Licence.

# This file really needs to be run by GNUMake.
# It is intended for native compilation on Linux (for use in a GCCSDK
# environment) or cross-compilation under the GCCSDK.

.PHONY: all library clean install backup

# Build Tools

CC := $(wildcard $(GCCSDK_INSTALL_CROSSBIN)/*gcc)
AR := $(wildcard $(GCCSDK_INSTALL_CROSSBIN)/*ar)
MKDIR := mkdir
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
OUTDIR := build

# Includes and libraries.

INCLUDES := -I$(GCCSDK_INSTALL_ENV)/include

# Targets

all: library
library: $(OUTDIR)/$(LIBOBJ)


$(OUTDIR)/$(LIBOBJ): $(SRCDIR)/flex.h $(SRCDIR)/opts.h $(SRCDIR)/swiextra.h $(SRCDIR)/flex.c
	$(CC) $(CCFLAGS) $(INCLUDES) -o $(OUTDIR)/$(LIBOBJ) -c $(SRCDIR)/flex.c


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

