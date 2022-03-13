/* SPDX-FileCopyrightText: 2022 Agathe Porte <microjoe@microjoe.org>
 *
 * SPDX-License-Identifier: MIT
 */
%{
#include "ledctl.h"
#include "ledctl.tab.h"


%}

digit         [0-9]
letter        [a-zA-Z]

%%

"power"              { return POWER; }
"led"                { return LED; }
"on"                 { yylval = 1; return ON; }
"off"                { yylval = 0; return OFF; }
"blink"              { yylval = 42; return BLINK; }
"list"               { return LIST; }

[ \t\r]+             { return SPACE; }
.                    { printf("Unknown character [%c]\n",yytext[0]);
                       return UNKNOWN;    }

%%

int nextargument(struct arguments *args)
{
	if (YY_CURRENT_BUFFER) {
		yy_delete_buffer(YY_CURRENT_BUFFER);
	}

	if (args->argc == args->arg) {
		return 1;
	}

	printf("scanning string \"%s\"\n", args->argv[args->arg]);
	yy_scan_string(args->argv[args->arg]);
	args->arg++;

	return 0;
}
