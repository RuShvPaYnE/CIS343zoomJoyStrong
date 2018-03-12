%{
        #include <stdio.h>
        #include <stdlib.h>
        #include "zoomjoystrong.tab.h"
        int i = 0;
        float f = 0;
%}

%option noyywrap

%%

end             { return END; }
;   	          { return END_STATEMENT; }
point           { return POINT; }
line            { return LINE; }
circle          { return CIRCLE; }
rectangle       { return RECTANGLE; }
set_color       { return SET_COLOR; }
[0-9]+		      { yylval.i = atoi(yytext); return INT; }
[0-9]*\.[0-9]+	{ yylval.f = atof(yytext); return FLOAT; }
[ \t\n]		;
.               { printf("That's not right"); }

%%
