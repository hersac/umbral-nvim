" Comentarios
syntax match umbralComentario /!!.*$/ contains=NONE containedin=ALL
highlight link umbralComentario Comment

" Interpolación (referencia) - Contained in strings
syntax match umbralEscapeRef /&[a-zA-Z_][a-zA-Z0-9_]*\(\(\.[a-zA-Z_][a-zA-Z0-9_]*\)\|\((\[^)]*)\)\|\(\[[^]]*\]\)\)*/ contained

" Strings triple '''
syntax region umbralStringTriple start=/'''/ end=/'''/ contains=umbralEscape,umbralEscapeRef
syntax match umbralEscape /\\./ contained
highlight link umbralStringTriple String
highlight link umbralEscape SpecialChar
highlight link umbralEscapeRef SpecialChar

" Strings simples
syntax region umbralStringSingle start=/'/ end=/'/
highlight link umbralStringSingle String

" Strings dobles
syntax region umbralStringDouble start=/"/ end=/"/ contains=umbralEscape,umbralEscapeRef
highlight link umbralStringDouble String

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

" Tipos primitivos
syntax match umbralType /\<\(Int\|Str\|Flo\|Bool\|Void\|Error\)\>/
highlight link umbralType Type

" Arreglos
syntax match umbralArrayType /\[\]\[\]/
syntax match umbralArrayType /\[\]/
highlight link umbralArrayType Type

" Números
syntax match umbralNumero /\<[0-9]\+\(\.[0-9]\+\)\?\>/
highlight link umbralNumero Number

" Booleanos
syntax match umbralBoolean /\<\(true\|false\)\>/
highlight link umbralBoolean Boolean

" Llaves y Delimitadores
syntax match umbralDelimiter /[{}[\]]/
highlight link umbralDelimiter Delimiter

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
