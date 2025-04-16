" [vim-plug]
call plug#begin()
Plug 'habamax/vim-habamax'
Plug 'NLKNguyen/papercolor-theme'
Plug 'junegunn/seoul256.vim'
Plug 'joshdick/onedark.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'nanotech/jellybeans.vim'
Plug 'arzg/vim-colors-xcode'
Plug 'jonathanfilip/vim-lucius'
Plug 'wadackel/vim-dogrun'
Plug 'sainnhe/sonokai'

Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }

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
let g:sonokai_style = 'shusia'
let g:sonokai_better_performance = 1
colorscheme slate
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

highlight link LspDiagSignErrorText SpellBad
highlight link LspDiagSignWarningText SpellCap
highlight link LspDiagInlineInfo NONE
highlight link LspDiagInlineHint NONE
highlight link LspDiagSignInfoText NONE
highlight link LspDiagSignHintText NONE
augroup CustomLSPHighlights
  autocmd!
  autocmd ColorScheme * highlight link LspDiagSignErrorText SpellBad
  autocmd ColorScheme * highlight link LspDiagSignWarningText SpellCap
  autocmd ColorScheme * highlight link LspDiagInlineInfo NONE
  autocmd ColorScheme * highlight link LspDiagInlineHint NONE
  autocmd ColorScheme * highlight link LspDiagSignInfoText NONE
  autocmd ColorScheme * highlight link LspDiagSignHintText NONE
augroup END

let lspOpts = #{autoHighlightDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)
let lspServers = [#{
        \         name: 'clang',
        \         filetype: ['c', 'cpp'],
        \         path: '/opt/homebrew/opt/llvm/bin/clangd',
        \         args: ['--background-index']
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
