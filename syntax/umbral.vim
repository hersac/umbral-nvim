" Comentarios
syntax region umbralComentario start=/!!/ end=/$/ keepend contains=NONE containedin=ALL transparent
highlight link umbralComentario Comment

" Strings triple '''
syntax region umbralStringTriple start=/'''/ end=/'''/ contains=umbralEscape,umbralEscapeRef
syntax match umbralEscape /\\./
syntax match umbralEscapeRef /&[a-zA-Z_][a-zA-Z0-9_]*\(\.[a-zA-Z_][a-zA-Z0-9_]*\)*/
highlight link umbralStringTriple String
highlight link umbralEscape SpecialChar
highlight link umbralEscapeRef SpecialChar

" Strings simples
syntax region umbralStringSingle start=/'/ end=/'/
highlight link umbralStringSingle String

" Strings dobles
syntax region umbralStringDouble start=/"/ end=/"/ contains=umbralEscape,umbralEscapeRef
highlight link umbralStringDouble String

" Palabras clave
syntax match umbralKeywordControl /\<\(i\|e\|wh\|r\|th\|n\|out\|equip\|origin\|as\)\>/
highlight link umbralKeywordControl Keyword

" Declaraciones v: c: f: cs: pr: pu:
syntax match umbralKeywordDecl /\<\(v\|c\|f\|cs\|pr\|pu\):/
highlight link umbralKeywordDecl Keyword

" Modificadores
syntax match umbralModifier /\<\(pu\|pr\)\>/
highlight link umbralModifier StorageClass

" Operadores
syntax match umbralOperator /\(->\|+\|-\|\*\|\/\|%\|==\|!=\|<=\|>=\|<\|>\|&&\|||\|!\|=\)/
highlight link umbralOperator Operator

syntax match umbralOperatorSpread /&/
highlight link umbralOperatorSpread Operator

" Tipos primitivos
syntax match umbralType /\<\(Int\|Str\|Flo\|Bool\|Void\)\>/
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

" Llamadas de funciones con punto
syntax match umbralFuncionPunto /[a-zA-Z_][a-zA-Z0-9_]*\.[a-zA-Z_][a-zA-Z0-9_]*\ze\s*(/
highlight link umbralFuncionPunto Function

" Llamadas de funciones simples
syntax match umbralFuncionSimple /\<[a-zA-Z_][a-zA-Z0-9_]*\ze\s*(/
highlight link umbralFuncionSimple Function

" Builtins
syntax match umbralBuiltin /\<tprint\>/
highlight link umbralBuiltin Function
