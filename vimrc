" [vim-plug]
call plug#begin()
Plug 'habamax/vim-habamax'
Plug 'NLKNguyen/papercolor-theme'
Plug 'joshdick/onedark.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'nanotech/jellybeans.vim'
Plug 'arzg/vim-colors-xcode'
Plug 'ErichDonGubler/vim-sublime-monokai'
" Plug 'ku1ik/vim-monokai'
Plug 'crusoexia/vim-monokai'

Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yegappan/lsp'
" plug#end() automatically executes filetype plugin indent on and syntax enable
call plug#end()

" [Builtin Plugins]
packadd! hlyank
packadd! comment

" [Settings]
let mapleader=" "
set mouse=a
set clipboard^=unnamed
colorscheme desert
let g:hlyank_hlgroup = 'Search'
let g:hlyank_duration = 300

set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set textwidth=80
set number
set hlsearch incsearch
if has('termguicolors')
	set termguicolors
endif

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
	highlight! MyStatement ctermfg=81 guifg=#6dceeb
	highlight! link Statement MyStatement
	highlight! link Function MyStatement
	highlight! MyType term=bold cterm=bold gui=bold ctermfg=186 guifg=#f0e68c
	highlight! MySpecial term=bold cterm=bold gui=bold ctermfg=186 guifg=#f0e68c
	highlight! link Type MyType
	highlight! link Special MySpecial
	highlight! MyLineNr ctermfg=143 guifg=#888888 guibg=#3b3b3b
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

function! s:ColorOverwrites()
	" enable undercurl
	let &t_Cs = "\e[4:3m"
	let &t_Ce = "\e[4:0m"
	call s:GlobalOverwrites()
  if g:colors_name ==# 'sublimemonokai'
    call s:MonokaiOverwrites()
	elseif g:colors_name ==# 'desert'
		call s:DesertOverwrites()
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

let lspOpts = #{autoHighlightDiags: v:true}
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

" cool schemes:
" slate, retrobox, desert, habamax, wildcharm, 
