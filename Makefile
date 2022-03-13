# SPDX-FileCopyrightText: 2022 Agathe Porte <microjoe@microjoe.org>
#
# SPDX-License-Identifier: MIT

override LDFLAGS += -lfl

TARGET := ledctl

all: $(TARGET)

lex.yy.c: ledctl.l ledctl.tab.h
	flex $<

%.tab.c %.tab.h: %.y
	bison -d $<

$(TARGET): ledctl.c lex.yy.c commands.c

clean:
	rm -rf ledctl.c lex.yy.c ledctl.tab.c ledctl.tab.h $(TARGET)
