lexer grammar BilangLexer;
tokens {INDENT, DEDENT}

fragment ALPHA: [A-Za-z]+;
fragment ALNUM: ALPHA|DIGIT;
fragment DIGIT: [0-9]+;
NAME: ALPHA (DASH? ALNUM)*;
DEC: '-'? DIGIT ('_' DIGIT)* '.' DIGIT;
INT: '-'? DIGIT ('_' DIGIT)*;

SPACE: [ ]+;
NEWLINE: [\n\r ;]+;
COMMENT: '#! ' ~[\n\r]* | '#!' ~[ ]*;

COLON: ':';
COMMA: ',';
DOT: '.';
DASH: '-'+;
DOLLAR: '$';
QUESTION: '?';
OP: '..'|[~`!@#$%^&*_+=|<>?/-]+;

LPAREN: '(';
RPAREN: ')';
LBRACKET: '[';
RBRACKET: ']';
LBRACE: '{' -> pushMode(DEFAULT_MODE);
RBRACE: '}' -> popMode;
QUOTS: '\'' -> type(QUOT), pushMode(QUOTES);
QUOT:  '"'  -> pushMode(QUOTED);

mode QUOTED;
STRING: ~('\\'|'\n'|'\r'|'"')+ -> type(CHARS);
INTERPOLATION: '\\{' -> type(LBRACE), pushMode(DEFAULT_MODE);
ESCAPED: '\\' .;
UNQUOT: '"' -> popMode;

mode QUOTES;
CHARS: ~('{'|'\\'|'\n'|'\r'|'\'')+;
INTERPOLATIONS: '\\{' -> type(LBRACE), pushMode(DEFAULT_MODE);
ESCAPES: '\\' . -> type(ESCAPED);
UNQUOTS: '\'' -> type(UNQUOT), popMode;
