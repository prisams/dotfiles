" Author: Priyanka Samanta
" General leader mappings ---- {{{
let mapleader = ","
" }}}
" General global mappings ----- {{{
set completeopt=menuone,longest,preview

" Enable buffer deletion instead of having to write each buffer
set hidden

" Mouse: remove GUI mouse support
set mouse=""

" SwapFiles: prevent their creation
set nobackup
set noswapfile

" Do not wrap lines by default
set nowrap

" Set column to grey at 80 characters
if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=7
endif

" highlight all search results
set hlsearch
set incsearch

" Remove query for terminal version
" This prevents un-editable garbage characters from being printed
" after the 80 character highlight line
set t_RV=

filetype plugin indent on

set showtabline=2
set autoread

# Demoing the merge conflict

" When you type the first tab hit will complete as much as possible,
" the second tab hit will provide a list, the third and subsequent tabs
" will cycle through completion options so you can complete the file
" without further keys
set wildmode=longest,list,full
set wildmenu
autocmd FileType * setlocal nofoldenable

" Grep: program is 'git grep'
set grepprg=git\ grep\ -n\ $*

" AirlineSettings: specifics due to airline
set laststatus=2
set ttimeoutlen=50
set noshowmode

" Pasting: enable pasting without having to do 'set paste'
" NOTE: this is actually typed <C-/>, but vim thinks this is <C-_>
" set pastetoggle=<C-_>

" Turn off complete vi compatibility
set nocompatible

" Enable using local vimrc
set exrc

" Set line numbers on the vim
set number

" }}}
" General: Plugin Install --------------------- {{{

call plug#begin('~/.vim/plugged')
" Relative Numbering
Plug 'myusuf3/numbers.vim'

" Commands run in vim's virtual screen and don't pollute main shell
Plug 'fcpg/vim-altscreen'

" Basic coloring
Plug 'NLKNguyen/papercolor-theme'

" Utils
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Language-specific syntax
Plug 'hdima/python-syntax',

"NerdTree
Plug 'scrooloose/nerdtree'

"Indentation
Plug 'hynek/vim-python-pep8-indent'
Plug 'Yggdroot/indentLine'

"Git History
Plug 'cohama/agit.vim'

"Vim Jedi
Plug 'davidhalter/jedi-vim'

"Commenting
Plug 'tpope/vim-commentary'

Plug 'ctrlpvim/ctrlp.vim'

" Scala Plugin
Plug 'derekwyatt/vim-scala'

" Git commands ibn vim
Plug 'tpope/vim-fugitive'

" Rust plugin
Plug 'rust-lang/rust.vim'

"Ale Plugin: Asynchronous linter for vim
Plug 'w0rp/ale'

"Rust Syntax highlights
Plug 'rust-lang/rust.vim'

"For docker syntax"
Plug 'ekalinin/Dockerfile.vim'

"To take to the top of the repo
Plug 'airblade/vim-rooter'

"Easy find and replace across files
Plug 'dkprice/vim-easygrep'

Plug 'othree/eregex.vim'

"JavaScript and JSX highlighter
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

"PlantUml Plug
Plug 'aklt/plantuml-syntax'
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'

"TOML Plugin
Plug 'cespare/vim-toml'

"Rainbow parenthesis"
Plug 'junegunn/rainbow_parentheses.vim'

" Code prettifiers
Plug 'b4b4r07/vim-sqlfmt'
Plug 'tell-k/vim-autopep8'
Plug 'maksimr/vim-jsbeautify'

call plug#end()

" }}}
" General: Indentation (tabs, spaces, width, etc)------------- {{{

augroup indentation_sr
  autocmd!
  autocmd Filetype * setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=8
  autocmd Filetype python setlocal shiftwidth=4 softtabstop=4 tabstop=8
  autocmd Filetype yaml setlocal indentkeys-=<:>
augroup END

" }}}
" Config for rainbow parenthesis------- {{{
augroup rainbow_settings
  " Section to turn on rainbow parentheses
  autocmd!
  autocmd BufEnter,BufRead * :RainbowParentheses
  autocmd BufEnter,BufRead *.html,*.css,*.jsx,*.js :RainbowParentheses!
augroup END
" }}}
" Auto Fold Settings ----- {{{

augroup fold_settings
  autocmd!
  autocmd FileType vim,tmux setlocal foldmethod=marker
  autocmd FileType vim,tmux setlocal foldlevelstart=0
  autocmd FileType * setlocal foldnestmax=1
augroup END
" }}}
" Cursor Line Settings ----- {{{
augroup cursorline_setting
  autocmd!
  autocmd WinEnter,BufEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END
" }}}
" Different file type recognistion ---- {{{
augroup filetype_recognition
  autocmd!
  autocmd BufNewFile,BufRead,BufEnter *.md,*.markdown set filetype=markdown
  autocmd BufNewFile,BufRead,BufEnter *.hql,*.q set filetype=hive
  autocmd BufNewFile,BufRead,BufEnter *.config set filetype=yaml
  autocmd BufNewFile,BufRead,BufEnter *.cfg,*.ini,.coveragerc,.pylintc
        \ set filetype=dosini
  autocmd BufNewFile,BufRead,BufEnter *.tsv set filetype-=tsv
augroup END
" }}}
" Plugin: global var config ------ {{{
" Ctrl p
let g:ctrlp_working_path_mode = 'rw' " start from cwd
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" open first in current window and others as hidden
let g:ctrlp_open_multiple_files = '1r'
let g:ctrlp_use_caching = 0

" EasyGrep - use git grep
set grepprg=git\ grep\ -n\ $*
let g:EasyGrepCommand = 1 " use grep, NOT vimgrep
let g:EasyGrepJumpToMatch = 0 " Do not jump to the first match
let g:EasyGrepPerlStyle = 1 " Use eregex to handle perl regular expressions

" ERegex
let g:eregex_default_enable = 0

" Rainbow parenthesis
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']']]
let g:pymode_rope = 0
" PythonVirtualenv:
" " necessary for jedi-vim to discover virtual environments
let g:virtualenv_auto_activate = 1
"" }}}
" General: Syntax highlighting ---------------- {{{

" Papercolor: options
let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0
let g:used_javascript_libs = 'react,requirejs'
" Python: Highlight self and cls keyword in class definitions
augroup python_syntax
  autocmd!
  autocmd FileType python syn keyword pythonBuiltinObj self
  autocmd FileType python syn keyword pythonBuiltinObj cls
augroup end

" Syntax: select global syntax scheme
try
  set t_Co=256 " says terminal has 256 colors
  set background=dark
  colorscheme PaperColor
catch
endtry

" Python Highlight self and cls keyword in the class definitions
augroup python_syntax
  autocmd!
  autocmd FileType python syn keyword pythonBuiltinObj self
  autocmd FileType python syn keyword pythonBuiltinObj cls
augroup end

" }}}
" General: Key remappings ----------------------- {{{

" moving forward and backward with vim tabs
nnoremap T gT
nnoremap t gt

" BuffersAndWindows:
" Move from one window to another
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
" Scroll screen up, down, left, and right
nnoremap <silent> K <c-e>
nnoremap <silent> J <c-y>
nnoremap <silent> H zh
nnoremap <silent> L zl
" Move cursor to top, bottom, and middle of screen
nnoremap <silent> gJ L
nnoremap <silent> gK H
nnoremap <silent> gM M

" }}}
" General: Trailing whitespace ------------- {{{
" This section should go before syntax highlighting
" because autocommands must be declared before syntax library is loaded
function! TrimWhitespace()
  if &ft == 'markdown'
    return
  endif
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfunction
highlight EOLWS ctermbg=red guibg=red
match EOLWS /\s\+$/
augroup whitespace_color
  autocmd!
  autocmd ColorScheme * highlight EOLWS ctermbg=red guibg=red
  autocmd InsertEnter * match EOLWS /\s\+\%#\@<!$/
  autocmd InsertLeave * match EOLWS /\s\+$/
augroup END
augroup fix_whitespace_save
  autocmd!
  autocmd BufWritePre * call TrimWhitespace()
augroup END
" }}}
" General: Cleanup ------------------ {{{
" commands that need to run at the end of my vimrc
set secure

" }}}
