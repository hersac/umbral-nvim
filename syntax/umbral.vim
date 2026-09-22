" Comentarios
syntax match umbralComentario /!!.*$/ contains=NONE containedin=ALL
highlight link umbralComentario Comment

" Interpolación (referencia) - Contained in strings
syntax match umbralEscape /\\./ contained
syntax match umbralEscapeRef /&[a-zA-Z_][a-zA-Z0-9_]*\(\(\.[a-zA-Z_][a-zA-Z0-9_]*\)\|\(([^)]*)\)\|\(\[[^]]*\]\)\)*/ contained
highlight link umbralEscape SpecialChar
highlight link umbralEscapeRef SpecialChar

" Strings simples (literales, sin interpolación)
" El start evita capturar los delimitadores ''' de las plantillas literales:
" - '\@<! -> no precedido por '
" - (''\)\@! -> no seguido por ''
syntax region umbralStringSingle start=/'\@<!'\(''\)\@!/ end=/'/ keepend
highlight link umbralStringSingle String

" Strings dobles (con interpolación)
syntax region umbralStringDouble start=/"/ end=/"/ keepend contains=umbralEscape,umbralEscapeRef
highlight link umbralStringDouble String

" Plantillas literales triple ''' (multilínea, CON interpolación &variable)
" Se define AL ÚLTIMO para que tenga prioridad sobre umbralStringSingle
" cuando ambas coinciden en la misma posición (''' ).
syntax region umbralStringTriple start=/'''/ end=/'''/ keepend contains=umbralEscape,umbralEscapeRef
highlight link umbralStringTriple String

" Sincronización desde el inicio para que las plantillas ''' multilínea
" siempre se resalten bien, incluso en archivos largos
syntax sync fromstart

" Palabras clave de control (sin dos puntos)
syntax match umbralKeywordControl /\<\(i\|ie\|e\|wh\|r\|th\|n\|out\|equip\|origin\|as\)\>/
" Await es control flow, sin dos puntos
syntax match umbralKeywordControl /\<awa\>/
highlight link umbralKeywordControl Keyword

" Palabras clave condicionales con dos puntos
syntax match umbralKeywordConditional /\<\(sw\|ca\|def\|tr\|ct\|tw\|fy\):/
highlight link umbralKeywordConditional Keyword

" Palabras clave OOP con dos puntos
syntax match umbralKeywordOOP /\<\(ext\|imp\|in\):/
highlight link umbralKeywordOOP Keyword

" Declaraciones con dos puntos
syntax match umbralKeywordDecl /\<\(v\|c\|f\|fo\|fe\|cs\|pr\|pu\):/
highlight link umbralKeywordDecl Keyword

" Cadena de prefijos antes de dos puntos (cantidad arbitraria):
" pu f: | pu asy f: | pr pu asy f: | tw n: | etc.
" Cubre cualquier combinación de palabras reconocidas separadas por
" espacios/tabs en la misma línea y terminadas en ':'.
" Se define DESPUÉS de las reglas simples para tener prioridad en la cadena,
" y usa contains para conservar StorageClass en modificadores.
syntax match umbralChainModifier /\<\(pu\|pr\|asy\)\>/ contained
highlight link umbralChainModifier StorageClass
syntax match umbralChainColon /:/ contained
highlight link umbralChainColon Keyword
syntax match umbralKeywordChain /\<\(i\|ie\|e\|wh\|r\|th\|n\|out\|equip\|origin\|as\|awa\|asy\|sw\|ca\|def\|tr\|ct\|tw\|fy\|ext\|imp\|in\|v\|c\|f\|fo\|fe\|cs\|pr\|pu\)\([ \t]\+\(i\|ie\|e\|wh\|r\|th\|n\|out\|equip\|origin\|as\|awa\|asy\|sw\|ca\|def\|tr\|ct\|tw\|fy\|ext\|imp\|in\|v\|c\|f\|fo\|fe\|cs\|pr\|pu\)\)*[ \t]*:/ contains=umbralChainModifier,umbralChainColon
highlight link umbralKeywordChain Keyword

" Modificadores (sin dos puntos)
" asy es un modificador, pu y pr también pueden ser modificadores (según tmLanguage)
syntax match umbralModifier /\<\(pu\|pr\|asy\)\>/
highlight link umbralModifier StorageClass

" Operadores
syntax match umbralOperator /\(->\|+\|-\|\*\|\/\|%\|==\|!=\|<=\|>=\|<\|>\|&&\|||\|!\|=\)/
" Operador spread & (según tmLanguage negativo lookahead para letra)
syntax match umbralOperatorSpread /&\ze[^a-zA-Z_]/
highlight link umbralOperator Operator
highlight link umbralOperatorSpread Operator

" Llaves y Delimitadores
" Se define ANTES de los tipos de arreglo para que [] y []Tipo
" (definidos después, más específicos) tengan prioridad sobre [ ] sueltos.
syntax match umbralDelimiter /[{}[\]]/
highlight link umbralDelimiter Delimiter

" Tipos primitivos
syntax match umbralType /\<\(Int\|Str\|Flo\|Bool\|Void\|Error\)\>/
highlight link umbralType Type

" Tipos personalizados / objetos después de -> (p. ej. prueba->Usuario; req->Request,)
" Se usa lookbehind \@<= para no competir con umbralOperator en la misma
" posición: el match arranca en el identificador, no en '-'.
" El tipo termina antes de espacio, coma, punto y coma, igual, ) } { o fin de línea.
syntax match umbralCustomType /\(->\)\@<=[A-Za-z_][A-Za-z0-9_]*\ze\(\s\|,\|;\|=\|)\|}\|{\|$\)/
highlight link umbralCustomType Type

" Arreglos
syntax match umbralArrayType /\[\]\[\]/
syntax match umbralArrayType /\[\]/
highlight link umbralArrayType Type
" Arreglos de tipos personalizados (p. ej. ->[]Users).
" Después de umbralArrayType para tener prioridad sobre el [] suelto.
syntax match umbralArrayCustomType /\(->\)\@<=\(\[\]\)\+[A-Za-z_][A-Za-z0-9_]*\ze\(\s\|,\|;\|=\|)\|}\|{\|$\)/
highlight link umbralArrayCustomType Type

" Números
syntax match umbralNumero /\<[0-9]\+\(\.[0-9]\+\)\?\>/
highlight link umbralNumero Number

" Booleanos
syntax match umbralBoolean /\<\(true\|false\)\>/
highlight link umbralBoolean Boolean

" Llamadas de funciones
" Resaltar solo el nombre del método en obj.metodo()
syntax match umbralFuncionPunto /[a-zA-Z_][a-zA-Z0-9_]*\.\zs[a-zA-Z_][a-zA-Z0-9_]*\ze\s*(/
" Resaltar función simple func()
syntax match umbralFuncionSimple /\<[a-zA-Z_][a-zA-Z0-9_]*\ze\s*(/
highlight link umbralFuncionPunto Function
highlight link umbralFuncionSimple Function

" Builtins
syntax match umbralBuiltin /\<tprint\>/
highlight link umbralBuiltin Function

" Propiedades builtin
syntax match umbralProperty /\.length\>/
highlight link umbralProperty Special
