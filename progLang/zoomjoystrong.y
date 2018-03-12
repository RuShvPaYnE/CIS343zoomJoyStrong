%{
        #include <stdio.h>
	#include "zoomjoystrong.h"
	int yyerror(char* s);
	extern char * yytext;
%}

%union { int i; float f; }

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token <i> INT
%token <f> FLOAT


%%
program:                statement_list END END_STATEMENT
                        { finish(); return 0; }
	|		                  END END_STATEMENT
                        { finish(); return 0; }
;
statement_list:         statement
              |         statement statement_list
;
statement:              line
	            |		point
	            |		circle
	            |		rectangle
	            |		set_color
;

line:			              LINE INT INT INT INT END_STATEMENT
                        { line( $2, $3, $4, $5); 	}
;
point: 	                POINT INT INT END_STATEMENT
                        { point( $2, $3); 		}
;
circle:	                CIRCLE INT INT INT END_STATEMENT
                        { circle( $2, $3, $4); 		}
;
rectangle:              RECTANGLE INT INT INT INT END_STATEMENT
                        { rectangle( $2, $3, $4, $5); 	}
;
set_color:              SET_COLOR INT INT INT END_STATEMENT
                        { /*check size*/ set_color( $2, $3, $4); 	}
;

%%
int main() {
	setup();
	yyparse();
	return 0;
}
int yyerror(char* s)
{
	fprintf(stderr, "%s on %s\n", s,yytext);
}
