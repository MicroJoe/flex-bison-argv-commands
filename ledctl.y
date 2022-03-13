// SPDX-FileCopyrightText: 2022 Agathe Porte <microjoe@microjoe.org>
//
// SPDX-License-Identifier: MIT

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "ledctl.h"
#include "commands.h"

extern int yylex();
extern int yyparse();
extern int yy_scan_string(const char *);
extern int yylex_destroy();
extern FILE *yyin;

void yyerror(const char *s);
%}

%token ON
%token OFF
%token LED
%token POWER
%token SPACE
%token BLINK
%token UNKNOWN
%token LIST

%%

commands:
	command |
	commands command

command:
	POWER SPACE state {
		printf("echo %d > /dev/power\n", $3);
	} |
	LED SPACE state {
		printf("echo %d > /dev/led\n", $3);
	} |
	LED SPACE BLINK {
		printf("echo blink > /dev/led\n");
	} |
	LIST {
		ledctl_list();
	}
	;

state:
	ON | OFF
	;

%%

void usage(char *progname)
{
	fprintf(stderr, "usage: %s <command>\n", progname);
}

int main(int argc, char **argv)
{
	if (argc <= 1) {
		usage(argv[0]);
		return 1;
	}

	size_t len = 0;
	for (int i = 1; i < argc; i++) {
		len += strlen(argv[i]) + 1;
	}

	char *buf = malloc(len);
	buf[0] = '\0';
	if (!buf) {
		perror("malloc");
		return 1;
	}

	for (int i = 1; i < argc; i++) {
		strncat(buf, argv[i], len);
		if (i < argc - 1) strncat(buf, " ", len);
	}

	yy_scan_string(buf);
	free(buf);

	yyparse();
	yylex_destroy();

	return 0;
}

void yyerror(const char *s)
{
	fprintf(stderr, "error: %s\n", s);
	exit(-1);
}
