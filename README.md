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

### Palabras clave

```
i
e
wh
r
th
n
out
equip
origin
as
```

### Declaradores

```
v:
c:
f:
cs:
pr:
pu:
```

### Tipos de datos

```
Int
Str
Flo
Bool
Void
[]
[][]
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

### Funciones built-in

```
tprint
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
├── ftdetect/
│   └── umbral.vim
└── syntax/
    └── umbral.vim
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
