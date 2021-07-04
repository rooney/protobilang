parser grammar BilangParser;
options {tokenVocab=BilangLexer;}

start: (SPACE|NEWLINE)? expr? (SPACE|NEWLINE)? EOF;

expr : expr expres                                 # app
     | expr COMMA COLON expres                     # pipe
     | <assoc=right> expr SPACE expr               # funcall
     | expr COMMA                                  # groupend
     | <assoc=right> op SPACE expr                 # funcall
     | expr COMMA COLON SPACE expr                 # pipe
     | <assoc=right> expr NEWLINE expr             # funcall
     | expr DOT var LPAREN args? RPAREN            # bind
     | expr DOT var                                # prop
     | expres                                      # es
     ;

args : SPACE arg (COMMA args)?
     ;

arg : expres                                       # expression
    | <assoc=right> arg SPACE arg                  # call
    ;

expres : expres expres                             # apply
       | INT                                       # literal
       | DECIMAL                                   # literal
       | QUOT string? UNQUOT                       # literal
       | COMMENT                                   # literal
       | (op|var) COLON                            # wordkey
       | COLON var?                                # keyword
       | DOT? var                                  # lookup
       | op                                        # lookup
       | LPAREN group RPAREN                       # parens
       | LBRACE group RBRACE                       # braces
       | LBRACKET group RBRACKET                   # brackets
       ;

group :                                            # empty
      | SPACE                                      # space
      | args                                       # list
      | expr                                       # subexpr
      ;

string: (CHARS|ESCAPED|LBRACE expr RBRACE)+;

op: OP|DASH|DOLLAR|QUESTION;

var: (DOLLAR|DASH)? NAME (DASH|QUESTION)?;
