# FlexLib - makefile
#
# (C) Stephen Fryatt, 2009

# Flags

CC = $(wildcard $(GCCSDK_INSTALL_CROSSBIN)/*gcc)
CCFlags = -static -mhard-float -mlibscl -mthrowback -Wall -O1 -fno-strict-aliasing
Include = -I$(GCCSDK_INSTALL_ENV)/include -I$(GCCSDK_LIBS)/FlexLib/


# Final Target

#OBJS = colpick.o config.o debug.o errors.o general.o heap.o icons.o menus.o msgs.o \
#       resources.o stack.o tasks.o string.o transfer.o url.o windows.o

#../libSFLib32.a: $(OBJS)
#		$(CC) $(CCFlags) -static -o ../libSFLib32.a $(OBJS)
#		libfile -c ^..oSFLib $(OBJS)

# Individual source files

libFlexLib32.a: flex.h opts.h swiextra.h flex.c
	$(CC) $(CCFlags) $(Include) -o libFlexLib32.a -c flex.c

