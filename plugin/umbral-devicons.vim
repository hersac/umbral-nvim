" umbral-devicons.vim — icono de fuego para archivos *.um
" Integración OPCIONAL con vim-devicons (NERDTree) y nvim-web-devicons
" (neo-tree, nvim-tree, lualine, ...). No crea dependencias duras: si esos
" plugins no están instalados, este archivo no hace nada.
" El icono es un glifo de Nerd Font (fa-fire, U+F06D): NERDTree es texto
" en terminal y no puede mostrar SVG/imágenes, así que se necesita una
" Nerd Font en la terminal para verlo.
" Override del usuario (en su vimrc/init.lua, antes o después de cargar):
"   let g:umbral_icon = 'X'          " glifo propio para vim-devicons
"   let g:umbral_icon_color = '#...' " color propio para nvim-web-devicons
if exists('g:loaded_umbral_devicons')
  finish
endif
let g:loaded_umbral_devicons = 1

" 1. vim-devicons (NERDTree y demás): solo registra el valor por defecto.
"    La lectura del diccionario ocurre al renderizar, así que el orden de
"    carga no importa. Se respeta cualquier valor ya definido por el usuario.
if !exists('g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols')
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
endif
if !has_key(g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols, 'um')
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['um'] = get(g:, 'umbral_icon', "\uf06d")
endif

" 2. nvim-web-devicons: se registra en VimEnter porque ese plugin suele
"    cargarse después (lazy managers). Solo si aún no hay icono para 'um'.
if has('nvim')
  function! s:umbral_register_nvim_devicons() abort
    lua << EOF
      local ok, devicons = pcall(require, 'nvim-web-devicons')
      if ok then
        local icons = devicons.get_icons and devicons.get_icons() or {}
        if icons.um == nil then
          devicons.set_icon({
            um = {
              icon = vim.g.umbral_icon or vim.fn.nr2char(0xF06D),
              color = vim.g.umbral_icon_color or '#E25822',
              name = 'Umbral',
            },
          })
        end
      end
EOF
  endfunction
  augroup umbral_devicons
    autocmd!
    autocmd VimEnter * ++once call <SID>umbral_register_nvim_devicons()
  augroup END
endif
