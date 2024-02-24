call plug#begin()
Plug 'easymotion/vim-easymotion'
Plug 'lambdalisue/fern.vim'
Plug 'navarasu/onedark.nvim'
Plug 'mattn/emmet-vim'
Plug 'github/copilot.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'is0n/fm-nvim'
call plug#end()
colorscheme onedark

set autoindent
set cursorline
set clipboard+=unnamed
set expandtab
set fileencodings=utf-8
set hidden
set history=200
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set nrformats=
set nocompatible
set noswapfile
set number
set relativenumber
set shiftwidth=4
set smartindent
set tabstop=4
set wildmenu

augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.tf setlocal shiftwidth=2 tabstop=2
    autocmd BufNewFile,BufRead *.js setlocal shiftwidth=2 tabstop=2
    autocmd BufNewFile,BufRead *.jsx setlocal shiftwidth=2 tabstop=2
    autocmd BufNewFile,BufRead *.ts setlocal shiftwidth=2 tabstop=2
    autocmd BufNewFile,BufRead *.tsx setlocal shiftwidth=2 tabstop=2
    autocmd BufNewFile,BufRead *.yml setlocal shiftwidth=2 tabstop=2
    autocmd BufNewFile,BufRead *.yaml setlocal shiftwidth=2 tabstop=2
    autocmd BufNewFile,BufRead *.json setlocal shiftwidth=2 tabstop=2
augroup END

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>
let g:fern#renderer = 'nerdfont'

inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap <silent> jj <ESC>

let mapleader = "\<Space>"

filetype plugin indent on 

if has("autocmd")
    autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
endif

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

syntax enable 
let g:onedark_termcolors=16

function! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

function! AddIndentWhenEnter()
    if getline(".")[col(".")-1] == "}" && getline(".")[col(".")-2] == "{"
        return "\n\t\n\<UP>\<END>"
    else
        return "\n"
    endif
endfunction
inoremap <silent> <expr> <CR> AddIndentWhenEnter()

runtime macros/matchit.vim

if has('persistent_undo')
    let undo_path = expand('~/.vim/undo')
    exe 'set undodir=' .. undo_path
    set undofile
endif

" fzf.vim
" Ctrl+pでファイル検索を開く
" git管理されていれば:GFiles、そうでなければ:Filesを実行する
fun! FzfOmniFiles()
    let is_git = system('git status')
    if v:shell_error
        :Files
    else
        :GFiles
    endif
endfun
nnoremap <C-p> :call FzfOmniFiles()<CR>

" Ctrl+gで文字列検索を開く
" <S-?>でプレビューを表示/非表示する
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
\ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}, 'right:50%:hidden', '?'),
\ <bang>0)
nnoremap <C-g> :Rg<CR>

" frでカーソル位置の単語をファイル検索する
nnoremap fr vawy:Rg <C-R>"<CR>
" frで選択した単語をファイル検索する
xnoremap fr y:Rg <C-R>"<CR>

" fbでバッファ検索を開く
nnoremap fb :Buffers<CR>
" fpでバッファの中で1つ前に開いたファイルを開く
nnoremap fp :Buffers<CR><CR>
" flで開いているファイルの文字列検索を開く
nnoremap fl :BLines<CR>
" fmでマーク検索を開く
nnoremap fm :Marks<CR>
" fhでファイル閲覧履歴検索を開く
nnoremap fh :History<CR>
" fcでコミット履歴検索を開く
nnoremap fc :Commits<CR>

highlight Normal ctermbg=none guibg=none
highlight NonText ctermbg=none guibg=none
highlight LineNr ctermbg=none guibg=none
highlight Folded ctermbg=none guibg=none
highlight EndOfBuffer ctermbg=none guibg=none

" terminalモードの設定
" 新規タブでターミナルモードを開く
nnoremap <silent> tt <cmd>terminal<CR>
" 下分割でターミナルモードを起動
nnoremap <silent> tx <cmd>belowright new<CR><cmd>terminal<CR>
" ターミナルモードを開いたらinsertモードに入る
autocmd TermOpen * :startinsert
" ターミナルモードで行番号を非表示
autocmd TermOpen * setlocal norelativenumber
autocmd TermOpen * setlocal nonumber
