# Umbral.nvim

Plugin de Neovim que agrega detección de archivos, resaltado de sintaxis y base para futuras integraciones con LSP y Tree-sitter del lenguaje de programación **Umbral**.

---

## 1. ¿Qué es Umbral?

Umbral es un lenguaje de programación moderno, modular y minimalista, diseñado para ser claro, consistente y altamente portable. El lenguaje soporta:

- Declaración de **variables** y **constantes**
- **Funciones** y **clases**
- **Importación modular** mediante palabras clave definidas por el desarrollador
- **Objetos**, estructuras, operadores y tipado básico
- Ejecución en múltiples plataformas

Este plugin provee soporte inicial para Neovim, incluyendo detección automática del filetype `.um` y reglas básicas de sintaxis.

---

## 2. Características del plugin

- Detección automática de archivos `.um`
- Resaltado básico de:
  - Palabras clave del lenguaje
  - Constantes
  - Funciones
  - Strings
  - Números
  - Comentarios
- Implementado con `syntax/` estándar de Vim para máxima compatibilidad
- Preparado para futura integración con:
  - Tree-sitter
  - LSP personalizado de Umbral
  - Snippets y autocompletado

---

## 3. Instalación

### Lazy.nvim

```lua
{
  "hersac/umbral-nvim",
  ft = "umbral",
}
```

### Vim-Plug

```vim
Plug 'hersac/umbral-nvim'
```

### Packer

```lua
use 'hersac/umbral-nvim'
```

---

## 4. Detección de archivos

El plugin registra automáticamente la extensión:

```
*.um → filetype=umbral
```

Esto ocurre mediante:

```
ftdetect/umbral.vim
```

---

## 5. Sintaxis soportada

La sintaxis del lenguaje está definida en:

```
syntax/umbral.vim
```

### Comentarios

```
!! comentario de línea
```

### Strings

```umbral
'texto literal'
"texto con &variable"
'''texto multilínea con
&interpolacion'''
```

### Palabras clave de control

```
i       !! if (condicional)
ie      !! if-else (condicional con alternativa)
e       !! else
wh      !! while (bucle)
r       !! return
th      !! this (referencia al objeto actual)
n       !! new (crear instancia)
out     !! salida/output
equip   !! importar módulo
origin  !! origen del módulo
as      !! alias para importación
```

### Palabras clave condicionales

```
sw:     !! switch (selector)
ca:     !! case (caso)
def:    !! default (caso por defecto)
tr:     !! try (intentar)
ct:     !! catch (capturar error)
tw:     !! throw (lanzar error)
fy:     !! finally (finalmente)
```

### Palabras clave OOP

```
ext:    !! extends (herencia)
imp:    !! implements (implementar interfaz)
in:     !! interface (interfaz)
```

### Palabras clave asíncronas

```
asy:    !! async (función asíncrona)
awa:    !! await (esperar promesa)
```

### Declaradores

```
v:      !! variable
c:      !! constante
f:      !! función
fo:     !! for (bucle for)
fe:     !! foreach (bucle para cada elemento)
cs:     !! class (clase)
pr:     !! private (privado)
pu:     !! public (público)
```

### Tipos de datos

```
Int     !! entero
Str     !! cadena de texto
Flo     !! flotante
Bool    !! booleano
Void    !! sin retorno
Error   !! tipo de error
[]      !! array unidimensional
[][]    !! array bidimensional
```

### Operadores

```
->  +  -  *  /  %
==  !=  <=  >=  <  >
&&  ||  !  =
```

### Operador Spread

```
&array
```

### Números y booleanos

```
42
3.14
true
false
```

### Funciones y propiedades built-in

```
tprint      !! función de impresión
.length     !! propiedad de longitud (arrays, strings)
```

### Invocaciones

Identificadores seguidos de `(` se destacan como llamadas de función o método.

---

## 6. Ejemplo de sintaxis en Umbral

```umbral
!! Comentario de una línea

!! Declaración de variables y constantes
v: contador = 0;
c: PI = 3.14159;

!! Funciones
f: sumar(a->Int, b->Int)->Int {
    r: (a + b);
}

!! Condicionales
i: (contador > 0) {
    tprint("Contador positivo");
} e: {
    tprint("Contador cero o negativo");
}

!! Bucles
wh: (contador < 10) {
    tprint("Contador: &contador");
    contador = contador + 1;
}

!! Clases
cs: Persona {
    pr: nombre->Str;
    pr: edad->Int;
    
    pu f: Persona(nombre->Str, edad->Int) {
        th.nombre = nombre;
        th.edad = edad;
    }
    
    pu f: presentarse()->Void {
        tprint("Hola, soy &th.nombre");
    }
}

!! Instanciar y usar
c: persona = n: Persona("Juan", 25);
persona.presentarse();

!! Arrays y Operador Spread
c: numeros = {1, 2, 3};
c: masNumeros = {&numeros, 4, 5, 6};

!! Strings con interpolación
v: nombre = "Umbral";
tprint("Lenguaje: &nombre");
v: literal = 'Sin interpolación &nombre';
```

---

## 7. Estructura del proyecto

```
umbral-nvim/
├── LICENSE
├── README.md
├── VERSION
├── .github/
│   └── workflows/
│       ├── auto-tag.yml
│       └── release.yml
├── ftdetect/
│   └── umbral.vim
├── syntax/
│   └── umbral.vim
└── plugin/
    └── umbral-devicons.vim
```

### Versionado y releases

La versión (archivo `VERSION`) sigue la versión del lenguaje Umbral
soportada (`1.2.5`, `1.3.6`, `1.4.0`, ...). Al mezclar a `main`, el workflow
**Auto Tag** crea el tag `vX.Y.Z` y la release si no existen; el push del
tag dispara el workflow **Release**, que sube el código fuente versionado
(`umbral-nvim-X.Y.Z.zip` + `.tar.gz`). Para publicar una nueva versión,
el PR debe actualizar `VERSION`.

---

## 7b. Icono para archivos `.um` (NERDTree, neo-tree, nvim-tree)

El plugin registra automáticamente un icono de fuego (glifo `fa-fire` de
Nerd Fonts) para la extensión `um`:

- Con [vim-devicons](https://github.com/ryanoasis/vim-devicons) (NERDTree):
  no requiere configuración, funciona al estar ambos plugins instalados.
- Con [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
  (neo-tree, nvim-tree, lualine, ...): se registra solo si aún no definiste
  un icono para `um`.

Requisitos y notas:

- Necesitas una **Nerd Font** activa en tu terminal: NERDTree es texto y no
  puede mostrar imágenes SVG. No es necesario copiar ningún `.svg` a este
  repo para el icono del árbol.
- Si ya tienes tu propio icono para `um`, se respeta y no se sobrescribe.
- Personalización opcional:

```vim
let g:umbral_icon = 'X'          " glifo propio (vim-devicons)
let g:umbral_icon_color = '#E25822' " color propio (nvim-web-devicons)
```

---

## 8. Roadmap

- Integración oficial con **Tree-sitter**
- LSP para Umbral (autocompletado, diagnósticos, formato)
- Snippets oficiales
- Compatibilidad con plugins de Neovim como Telescope, nvim-cmp, etc.

---

## 9. Contribuciones

Las contribuciones son bienvenidas.  
Puedes enviar PRs o abrir issues en el repositorio oficial.

---

## 10. Licencia

Este proyecto se distribuye bajo la **Apache License 2.0**.

Puedes consultar el texto completo en el archivo `LICENSE` incluido en este repositorio o en la documentación oficial:

https://www.apache.org/licenses/LICENSE-2.0
