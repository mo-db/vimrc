" [vim-plug]
call plug#begin()
Plug 'habamax/vim-habamax'
Plug 'NLKNguyen/papercolor-theme'
Plug 'joshdick/onedark.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'nanotech/jellybeans.vim'
Plug 'arzg/vim-colors-xcode'
Plug 'ErichDonGubler/vim-sublime-monokai'
Plug 'ku1ik/vim-monokai'
Plug 'cormacrelf/vim-colors-github'
Plug 'wojciechkepka/vim-github-dark'
Plug 'hachy/eva01.vim'
Plug 'sainnhe/sonokai'
Plug 'rakr/vim-one'
Plug 'sainnhe/edge'
Plug 'jonathanfilip/vim-lucius'
Plug 'freeo/vim-kalisi'

Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'markonm/traces.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yegappan/lsp'
Plug 'bfrg/vim-c-cpp-modern'
" plug#end() automatically executes filetype plugin indent on and syntax enable
call plug#end()

" [Builtin Plugins]
packadd! hlyank
packadd! comment

" [Settings]
let mapleader=" "
set mouse=a
set clipboard^=unnamed
let g:hlyank_hlgroup = 'Search'
let g:hlyank_duration = 300
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set textwidth=80
set colorcolumn=80
set number
set hlsearch incsearch
if has('termguicolors')
	set termguicolors
endif

" [cursor shape]
" only apply this when $TERM is Ghostty’s
if &term ==# 'xterm-ghostty'
  " (see the xterm DECSCUSR spec for details)
	" 0 = blinking block
	" 1 = blinking block default
	" 2 = steady block
	" 3 = blinking underline
	" 4 = steady underline
	" 5 = blinking bar
	" 6 = steady bar

  " Insert‑mode: blinking bar
  let &t_SI = "\e[5 q"
  " Replace‑mode: blinking underline (optional)
  let &t_SR = "\e[3 q"
  " Normal‑mode: blinking block
  let &t_EI = "\e[2 q"
endif

" [Colorscheme]
let g:sonokai_style = 'shusia'
let g:sonokai_better_performance = 1
let g:edge_style = 'light'
let g:edge_better_performance = 1
let g:light_theme='morning'
let g:dark_theme='desert'

if system('defaults read -g AppleInterfaceStyle') =~? 'Dark'
	execute 'colorscheme ' . dark_theme
  set background=dark
else
	execute 'colorscheme ' . light_theme
  set background=light
endif

let g:current_background = &background

function! ToggleBackground()
  if &background ==# 'light'
		execute 'colorscheme ' . g:dark_theme
    set background=dark
  else
		execute 'colorscheme ' . g:light_theme
    set background=light
  endif
  let g:current_background = &background
endfunction

nnoremap <C-k> :call ToggleBackground()<CR>

" [Highlight Overwrites]
function! s:GlobalOverwrites()
	highlight! link markdownCodeBlock String
	highlight! link markdownCode String
	highlight! link markdownH1 Special
	highlight! link markdownH2 Special
	highlight! link markdownH3 Special
	highlight! link markdownH4 Special
	highlight! link markdownH5 Special
	highlight! link markdownH6 Special
	highlight! link LspDiagInlineInfo NONE
	highlight! link LspDiagInlineHint NONE
	highlight! link LspDiagSignInfoText NONE
	highlight! link LspDiagSignHintText NONE
endfunction

function! s:MonokaiOverwrites()
	highlight! link Pmenu LineNr
	highlight! link PmenuSel StatusLine
	highlight! link StatusLineNC LineNr
	highlight! MyError guisp=#e73c50 term=undercurl cterm=undercurl gui=undercurl
	highlight! link  SpellBad MyError
	highlight! MyWarning guisp=#e6db74 term=undercurl cterm=undercurl gui=undercurl
	highlight! link SpellCap MyWarning
	highlight! link Error MyWarning
	highlight! link LspDiagSignErrorText SublimeRed
	highlight! link LspDiagSignWarningText SublimeYellow
endfunction

function! s:DesertOverwrites()

	" highlight! MyStatement ctermfg=81 guifg=#6dceeb
	" highlight! link Statement MyStatement
	" highlight! link Function MyStatement
	" highlight! MyType term=bold cterm=bold gui=bold ctermfg=186 guifg=#f0e68c
	" highlight! MySpecial term=bold cterm=bold gui=bold ctermfg=186 guifg=#f0e68c
	" highlight! link Type MyType
	" highlight! link Special MySpecial
	" highlight! MyError  term=undercurl cterm=undercurl gui=undercurl
	" highlight! link  SpellBad MyError
	" highlight! MyWarning  term=undercurl cterm=undercurl gui=undercurl
	" highlight! link SpellCap MyWarning
	" highlight! link Error MyWarning
	highlight! MyLineNr ctermfg=143 guifg=#888888
	highlight! link LineNr MyLineNr
	highlight! MyComment ctermfg=143 guifg=#888888
	highlight! link Comment MyComment
	highlight! MyError guisp=#cd5c5c term=undercurl cterm=undercurl gui=undercurl
	highlight! link  SpellBad MyError
	highlight! MyWarning guisp=#ffde9b term=undercurl cterm=undercurl gui=undercurl
	highlight! link SpellCap MyWarning
	highlight! LspDiagSignErrorText guifg=#cd5c5c
	highlight! LspDiagSignWarningText guifg=#ffde9b
endfunction

function! s:MorningOverwrites()
	highlight! Identifier ctermfg=21 guifg=#0000ff
	highlight! Function ctermfg=21 guifg=#0000ff
	highlight! Comment ctermfg=102 guifg=#878787
	highlight! link Special PreProc

	highlight! Pmenu guifg=#000000 guibg=#eeeeee
	highlight! PmenuMatch guifg=#a52a2a guibg=#eeeeee

	highlight! MyError guisp=#ff0000 term=undercurl cterm=undercurl gui=undercurl
	highlight! link  SpellBad MyError
	highlight! MyWarning guisp=#6a0dad term=undercurl cterm=undercurl gui=undercurl
	highlight! link SpellCap MyWarning
endfunction

function! s:ZellnerOverwrites()
	highlight! link Comment Conceal
	highlight! MyError guisp=#ff0000 term=undercurl cterm=undercurl gui=undercurl
	highlight! link  SpellBad MyError
	highlight! MyWarning guisp=#a020f0 term=undercurl cterm=undercurl gui=undercurl
	highlight! link SpellCap MyWarning
endfunction

function! s:XamabahOverwrites()
	highlight! Normal guifg=#000000 guibg=#eeeeee
	highlight! Pmenu guibg=#e4e4e4
	highlight! Identifier guifg=#008787
	highlight! Special guifg=#008700
	highlight! Constant guifg=#af0000
	highlight! link String Constant
	highlight! link Character Constant
	highlight! link Number Constant
endfunction

function! s:QuietOverwrites()
	highlight! Normal guibg=#dedede
	highlight! Identifier guifg=#0000ff
	highlight! Statement term=bold cterm=bold gui=bold guifg=#000000
	highlight! Constant guibg=#eeeeee
	highlight! link Comment NonText
	highlight! link LineNr NonText
	highlight! Search guibg=#ffffaf guifg=#000000
	highlight! SpellCap guibg=#ffffaf guifg=#000000
	highlight! SpellBad guibg=#ffafd7 guifg=#000000
	highlight! link LspDiagSignErrorText SpellBad
	highlight! link LspDiagSignWarningText SpellCap
	highlight! Pmenu guifg=#000000 guibg=#eeeeee
	highlight! PmenuMatch guifg=#d70000 guibg=#eeeeee
	" highlight! Type term=bold cterm=bold gui=bold guifg=#000000
endfunction

function! s:ColorOverwrites()
	" enable undercurl
	let &t_Cs = "\e[4:3m"
	let &t_Ce = "\e[4:0m"
	call s:GlobalOverwrites()
  if g:colors_name ==# 'sublimemonokai'
    call s:MonokaiOverwrites()
	elseif g:colors_name ==# 'desert'
		call s:DesertOverwrites()
	elseif g:colors_name ==# 'morning'
		call s:MorningOverwrites()
	elseif g:colors_name ==# 'zellner'
		call s:ZellnerOverwrites()
	elseif g:colors_name ==# 'xamabah'
		call s:XamabahOverwrites()
	elseif g:colors_name ==# 'quiet'
		call s:QuietOverwrites()
  endif
endfunction

" Gets executed when changing color scheme
augroup OnSchemeChange
  autocmd!
  autocmd ColorScheme * call s:ColorOverwrites()
augroup END

" Gets executed at startup
if exists('g:colors_name')
  call s:ColorOverwrites()
endif

let lspOpts = #{autoHighlightDiags: v:true, autoComplete: v:false}
autocmd User LspSetup call LspOptionsSet(lspOpts)
let lspServers = [#{
	\	  name: 'clang',
	\	  filetype: ['c', 'cpp'],
	\	  path: '/opt/homebrew/opt/llvm/bin/clangd',
	\	  args: [
	\			'--background-index',
	\			'--header-insertion=never',
	\		]
	\ }]
autocmd User LspSetup call LspAddServer(lspServers)

" [Formatter]
set formatprg="clang-format"

" [Mappings] - nnoremap applies only to normal mode
nmap <silent> <C-l> :noh<CR>
nmap <silent> <C-p> :bprev<CR>
nmap <silent> <C-n> :bnext<CR>
" FZF
nmap <silent> <Leader><Leader> :Buffers<CR>
nmap <silent> - :Files<CR>
" LSP
nmap <silent> gd :LspGotoDeclaration<CR>
nmap <silent> g[ :LspDiagPrev<CR>
nmap <silent> g] :LspDiagNext<CR>
nmap <silent> <Leader>d :LspDiagCurrent<CR>
nmap <silent> <Leader>k :LspHover<CR>

vnoremap <leader>f :<C-u>'<,'>s/\%u00A0/ /g \| '<,'>s/    /\t/g<CR>

" cool schemes:
" Bright: Zellner, kalisi
" Light: Quiet, Morning, Solarized8_high light
" Dark: OneDark, Monokai, Solarized, Desert, 
