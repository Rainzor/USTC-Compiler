%option noyywrap

%{
/*****************声明和选项设置  begin*****************/
#include <stdio.h>
#include <stdlib.h>

#include "syntax_tree.h"
#include "syntax_analyzer.h"

int lines=1;
int pos_start;
int pos_end=1;

void pass_node(char *text){
    yylval.node = new_syntax_tree_node(text);
}
void maintain_text(int cnt)
{
    pos_start=pos_end;
    pos_end+=cnt;
    pass_node(yytext);
}
/*****************声明和选项设置  end*****************/
%}

digit [0-9]


%%
 /* TODO: for students */
 /* two cases for you, pass_node will send flex's token to bison */
return {maintain_text(6); return RETURN;}
if {maintain_text(2); return IF;}
else {maintain_text(4); return ELSE;}
while {maintain_text(5); return WHILE;}
void {maintain_text(4); return VOID;}
int {maintain_text(3); return INT;}
float {maintain_text(5); return FLOAT;}
\= {maintain_text(1); return ASSIGN;}
\+ {maintain_text(1); return PLUS;}
\- {maintain_text(1); return MINUS;}
\* {maintain_text(1); return STAR;}
\/ {maintain_text(1); return DIV;}
; {maintain_text(1); return SEMI;}
, {maintain_text(1); return COMMA;}
\( {maintain_text(1); return LP;}
\) {maintain_text(1); return RP;}
\[ {maintain_text(1); return LB;}
\] {maintain_text(1); return RB;}
\{ {maintain_text(1); return LC;}
\} {maintain_text(1); return RC;}
\>\= {maintain_text(2); return GE;}
\<\= {maintain_text(2); return LE;}
\=\= {maintain_text(2); return EQ;}
\!\= {maintain_text(2); return NE;}
\> {maintain_text(1); return GT;}
\< {maintain_text(1); return LT;}
\n {lines+=1; pos_end=1;}
\t {pos_start=pos_end;pos_end+=1;}
\r {pos_start=pos_end;pos_end+=1;}
" " {pos_start=pos_end;pos_end+=1;}
[a-zA-Z]+ {maintain_text(strlen(yytext)); return ID;}
{digit}+ {maintain_text(strlen(yytext)); return INTEGER;}
{digit}+\. {maintain_text(strlen(yytext)); return FLOATNUM;}
{digit}*\.{digit}+ {maintain_text(strlen(yytext)); return FLOATNUM;}

\/\*\**([^\*]*[^\/\*]\*+)*[^\*]*\*\/  {
    pos_start=pos_end;
    for(int i=0;i<strlen(yytext);i++){
        if(yytext[i]=='\n'){
            lines+=1;
            pos_end=1;
        }
        else{
            pos_end+=1;
        }
    }
}
. { pos_start = pos_end; pos_end++; return ERROR; }

 /****请在此补全所有flex的模式与动作  end******/
%%
