set rtp+=$HOME/vim/.vim,$HOME/vim/.vim/bundle/vundle

set nocompatible
filetype off

"このif文が必要。
if has("win32") || has("win64")
  call vundle#rc('~/.vim/bundle/')
else
  call vundle#rc('$HOME/vim/.vim/bundle/')
endif

Bundle 'gmarik/vundle.git'
Bundle 'Shougo/neocomplete'
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/neosnippet-snippets'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimfiler'
Bundle 'Shougo/vimshell'
" Bundle 'Shougo/vimproc'
Bundle 'nathanaelkane/vim-indent-guides'
" Bundle 'thinca/vim-localrc'
" Bundle 'adinapoli/vim-markmultiple.git'
Bundle 'h1mesuke/vim-alignta.git'
Bundle 'Lokaltog/vim-easymotion.git'
" Bundle 'tsaleh/vim-matchit.git'
Bundle 'Lokaltog/vim-powerline.git'

filetype plugin indent on
let mapleader="t"

"Setting the keymap"
noremap <C-k> <ESC>
noremap! <C-k> <ESC>
nnoremap <C-j> :w<CR>
noremap! <C-j> <Nop>
nnoremap <C-l> <Nop>
nnoremap <C-l> za
nnoremap <C-y> <Nop>
nnoremap <C-y> :<C-u>!test.bat<CR>
nmap f <Nop>
noremap fp "+p
noremap fP "+P
vnoremap fp "+p
vnoremap fP "+P
noremap fy "+y
noremap fY "+Y
vnoremap fy "+y
vnoremap fY "+Y

" 置き換えスクリプト
vmap ii y:%s/<C-r>"/<C-r>"/g

"vimwikiのTodoトグル
nnoremap <A-Space> :<C-u>VimwikiToggleListItem<CR>

nnoremap <F9> :<C-u>!ctags -R .<CR>

noremap ft :<C-u>UniteWithCursorWord -immediately tag<CR>
noremap Ft :<C-u>UniteWithCursorWord -immediately tag/file<CR>

"" EasyMotion Key
let g:EasyMotion_keys = 'fjghdkslaureiwoqpvmbncxz1234567890'
let g:EasyMotion_leader_key = '<Space>'
nmap <Space>l <Space>w
nmap <Space>h <Space>b
vmap <Space>l <Space>w
vmap <Space>h <Space>b

"" マルチバイト対応 strlen() と strpart()
""" via http://vimwiki.net/?ScriptSample%2F16
function! StringLength(str)
  return strlen(substitute(a:str, ".", "x", "g"))
endfunction

function! StringPart(str, start, len)
  let bend = byteidx(a:str, a:start + a:len) - byteidx(a:str, a:start)
  if bend < 0
    return strpart(a:str, byteidx(a:str, a:start))
  else
    return strpart(a:str, byteidx(a:str, a:start), bend)
  endif
endfunction

function! GuiTabLabel()
  let label = expand("%:t")
  let length = StringLength(label)
  "if length > 10   "ファイル名が11文字以上の場合、末尾を切り詰めて10文字にする。
  "  let label = StringPart(label, 0, 10) . ".."
  "endif
  return label
endfunction

set guitablabel=%{GuiTabLabel()}

"Setting the neocomplcation"
let buftabs_only_basename = 1
let buftabs_in_statusline = 1

"Setting the neocomplcation"
imap <expr><TAB> <Plug>(neosnippet_expand_or_jump)
smap <expr><TAB> <Plug>(neosnippet_expand_or_jump)
xmap <expr><TAB> <Plug>(neosnippet_expand_or_target)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
let g:neocomplete#enable_at_startup = 1

"Setting the vimfiler"
let g:vimfiler_trashbox_directory = '~/.vimfiler_trashbox'
let g:vimfiler_safe_mode_by_default = 0
set modifiable
"VimFiler 起動
nmap <silent> [unite]v :<C-u>VimFiler -buffer-name=explorer -quit<CR>
nmap <silent> fv :<C-u>VimFilerBufferDir -buffer-name=explorer -quit<CR>

"VimFiler 起動
nmap <silent> [unite]s :<C-u>call Vshell()<CR>
function Vshell()
  VimShellTab
  map! <buffer> <C-k> <ESC>
endfunction

"Tab indent color"
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 40
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=24
hi IndentGuidesEven ctermbg=22


"Unite prefix key.
nmap [unite] <Nop>
xmap [unite] <Nop>
nmap <C-f> [unite]
xmap <C-f> [unite]
 
"Unite general settings
"インサートモードで開始
let g:unite_enable_start_insert = 0
"最近開いたファイル履歴の保存数
let g:unite_source_file_mru_limit = 50
 
"File_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''

let g:unite_enable_split_vertically = 0
let g:unite_winheight =20 
let g:unite_winwidth = 35

let g:unite_split_rule = 'botright'
 
"現在開いているファイルのディレクトリ下のファイル一覧。
"開いていない場合はカレントディレクトリ
nmap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=tab file<CR>
"バッファ一覧
nmap <silent> fs :<C-u>Unite -toggle buffer<CR>
"レジスタ一覧
nmap <silent> [unite]r :<C-u>Unite -buffer-name=tab -toggle register<CR>
"最近使用したファイル一覧
nmap <silent> [unite]m :<C-u>Unite -buffer-name=tab -toggle file_mru<CR>
"ブックマーク一覧
nmap <silent> [unite]cs :<C-u>Unite -buffer-name=tab -toggle svn/status<CR>
nmap <silent> [unite]cd :<C-u>Unite -buffer-name=tab -toggle svn/diff<CR>

"uniteを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  "ESCでuniteを終了
  nmap <buffer> <ESC> <Plug>(unite_exit)
  "入力モードのときjjでノーマルモードに移動
  imap <buffer> jj <Plug>(unite_insert_leave)
endfunction"}}}

let g:unite_source_alignta_preset_arguments = [
            \ ["Align at '='", '=>\='],  
            \ ["Align at ':'", '01 :'],
            \ ["Align at '|'", '|'   ],
            \ ["Align at '//'", '1 \/\/'],  
            \ ["Align at ','", '01 ,'],  
            \ ["Align at ')'", '0 )' ],
            \ ["Align at ']'", '0 ]' ],
            \ ["Align at '}'", '}'   ],
            \]

let s:comment_leadings = '^\s*\("\|#\|/\*\|//\|<!--\)'
let g:unite_source_alignta_preset_options = [
            \ ["Justify Left",      '<<' ],
            \ ["Justify Center",    '||' ],
            \ ["Justify Right",     '>>' ],
            \ ["Justify None",      '==' ],
            \ ["Shift Left",        '<-' ],
            \ ["Shift Right",       '->' ],
            \ ["Shift Left  [Tab]", '<--'],
            \ ["Shift Right [Tab]", '-->'],
            \ ["Margin 0:0",        '0'  ],
            \ ["Margin 0:1",        '01' ],
            \ ["Margin 1:0",        '10' ],
            \ ["Margin 1:1",        '1'  ],
            \
            \ 'v/' . s:comment_leadings,
            \ 'g/' . s:comment_leadings,
            \]
unlet s:comment_leadings

nmap <silent> [unite]a :<C-u>Unite alignta:options<CR>
xmap <silent> [unite]a :<C-u>Unite alignta:arguments<CR>
"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
set fdm=marker

"---------------------------------------------------------------------------
" 編集に関する設定:
"
set backupdir=$HOME/.vimfiler_trashbox
set directory=$HOME/.vimfiler_trashbox
"let php_folding=1
"au Syntax php set fdm=syntax
"let java_folding=1
"au Syntax java set fdm=syntax
" タブの画面上での幅
set tabstop=4
set sw=4 st=4
" タブをスペースに展開しない (expandtab:展開する)
"set noexpandtab
set expandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
syntax on
set incsearch
set showmode

set background=dark
set hlsearch
"インサート時のハイライト
set nocursorline
autocmd InsertEnter,InsertLeave * set cursorline!

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を非表示 (number:表示)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set nolist
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title

set fileformats=unix,dos,mac
set fenc=utf-8
set fileencodings=utf-8,cp932,iso-2022-jp,euc-jp,ucs2le,ucs-2
set encoding=utf-8

set autoread

let g:PHP_vintage_case_default_indent = 1

set hidden

" 背景色データ
set t_Co=256
hi Normal         ctermbg=none
hi CursorLine                                   cterm = none
hi CursorLineNr   ctermfg = 208                 cterm = none
hi Boolean        ctermfg = 135
hi Character      ctermfg = 144
hi Number         ctermfg = 135
hi String         ctermfg = 224
hi Conditional    ctermfg = 161                 cterm = bold
hi Constant       ctermfg = 135                 cterm = bold
hi Cursor         ctermfg = 16   ctermbg = 253
hi Debug          ctermfg = 225                 cterm = bold
hi Define         ctermfg = 81
hi Delimiter      ctermfg = 216

hi DiffAdd                       ctermbg = 24
hi DiffChange     ctermfg = 181  ctermbg = 239
hi DiffDelete     ctermfg = 162  ctermbg = 53
hi DiffText                      ctermbg = 102  cterm = bold

hi Directory      ctermfg = 150                 cterm = bold
hi Error          ctermfg = 219  ctermbg = 89
hi ErrorMsg       ctermfg = 199  ctermbg = 16   cterm = bold
hi Exception      ctermfg = 118                 cterm = bold
hi Float          ctermfg = 135
hi FoldColumn     ctermfg = 67   ctermbg = 16
hi Folded         ctermfg = 67   ctermbg = 16
hi Function       ctermfg = 150
hi Identifier     ctermfg = 222                 cterm = none
hi Ignore         ctermfg = 244  ctermbg = 232
hi IncSearch      ctermfg = 193  ctermbg = 16

hi keyword        ctermfg = 161                 cterm = bold
hi Label          ctermfg = 229                 cterm = none
hi Macro          ctermfg = 193
hi SpecialKey     ctermfg = 81

hi MatchParen     ctermfg = 208  ctermbg = 233  cterm = bold
hi ModeMsg        ctermfg = 229
hi MoreMsg        ctermfg = 229
hi Operator       ctermfg = 161

hi Pmenu          ctermfg = 81   ctermbg = 16
hi PmenuSel       ctermfg = 81   ctermbg = 244
hi PmenuSbar                     ctermbg = 232
hi PmenuThumb     ctermfg = 81

hi PreCondit      ctermfg = 118                 cterm = bold
hi PreProc        ctermfg = 118
hi Question       ctermfg = 81
hi Repeat         ctermfg = 161                 cterm = bold
hi Search         ctermfg = 253  ctermbg = 66

hi SignColumn     ctermfg = 118  ctermbg = 235
hi SpecialChar    ctermfg = 161                 cterm = bold
hi SpecialComment ctermfg = 230                 cterm = bold
hi Special        ctermfg = 81
hi SpellBad                      ctermbg = 52
hi SpellCap                      ctermbg = 17
hi SpellLocal                    ctermbg = 17
hi SpellRare      ctermfg = none ctermbg = none cterm = reverse
hi Statement      ctermfg = 161                 cterm = bold
hi StatusLine     ctermfg = 238  ctermbg = 253
hi StatusLineNC   ctermfg = 244  ctermbg = 232
hi StorageClass   ctermfg = 208
hi Structure      ctermfg = 81
hi Tag            ctermfg = 161
hi Title          ctermfg = 166
hi Todo           ctermfg = 231  ctermbg = 232  cterm = bold

hi Typedef        ctermfg = 81
hi Type           ctermfg = 81                  cterm = none
hi Underlined     ctermfg = 244                 cterm = underline

hi VertSplit      ctermfg = 244  ctermbg = 232  cterm = bold
hi VisualNOS                     ctermbg = 238
hi Visual         ctermfg = none ctermbg = 60
hi WarningMsg     ctermfg = 231  ctermbg = 238  cterm = bold
hi WildMenu       ctermfg = 81   ctermbg = 16

hi Comment        ctermfg = 123
hi CursorColumn                  ctermbg = 236
hi ColorColumn                   ctermbg = 236
hi LineNr         ctermfg = 250  ctermbg = 236
hi NonText        ctermfg = 130
