set nocompatible
filetype off

"このif文が必要。
if has("win32") || has("win64")
  call vundle#rc('~/.vim/bundle/')
else
  call vundle#rc()
endif

Bundle 'gmarik/vundle.git'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimfiler'
Bundle 'Shougo/vimshell'
Bundle 'Shougo/vimproc'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'thinca/vim-localrc'
Bundle 'adinapoli/vim-markmultiple.git'
Bundle 'h1mesuke/vim-alignta.git'
Bundle 'Lokaltog/vim-easymotion.git'
Bundle 'tsaleh/vim-matchit.git'
Bundle 'Lokaltog/vim-powerline.git'
filetype plugin indent on
let mapleader="t"

"Setting the keymap"
map <C-k> <ESC>
vmap <C-k> <ESC>
map! <C-k> <ESC>
nmap <C-j> :w<CR>
map! <C-j> <Nop>
nmap <C-l> <Nop>
nmap <C-l> za
nmap f <Nop>
nmap fh :<C-u>tabp<CR>
nmap fl :<C-u>tabn<CR>
nmap fk :<C-u>tabe<CR>
nmap fj :<C-u>execute 'tabnext' g:pre_tabnr<CR>
nmap fa :<C-u>tabn<Space>1<CR>
map fp "+p
map fP "+P
vmap fp "+p
vmap fP "+P
map fy "+y
map fY "+Y
vmap fy "+y
vmap fY "+Y
vmap ii iwyHVL:call ReplaceWord()<CR>
vmap iI iwyggVG:call ReplaceWord()<CR>
vmap iu yHVL:call ReplaceWord()<CR>
vmap iU yggVG:call ReplaceWord()<CR>

"phpドキュメント"
"let g:pdv_cfg_Author = "t.sakuma"
"let g:pdv_cfg_php4always  = 0
"nnoremap fc :call PhpDocSingle()<CR>
"vnoremap fc :call PhpDocRange()<CR>-

map ft g<C-]>

"" EasyMotion Key
let g:EasyMotion_keys = 'fjghdkslaureiwoqpvmbncxz1234567890'
let g:EasyMotion_leader_key = '<Space>'
nmap <Space>h <Nop>
nmap <Space>l <Nop>
nmap <Space>l <Space>w
nmap <Space>h <Space>b
vmap <Space>h <Nop>
vmap <Space>l <Nop>
vmap <Space>l <Space>w
vmap <Space>h <Space>b

"Setteing the localrc"
let g:localrc_filename = 'local.vimrc'
"let g:localrc_filetype = '/^local\..*\<%s\>.*\.vimrc$'

"Setting the neocomplcation"
let buftabs_only_basename = 1
let buftabs_in_statusline = 1

"Setting the neocomplcation"
" snippetの配置場所
let g:neocomplcache_enable_at_startup = 1
nmap <C-h> :<C-u>NeoSnippetEdit<CR>
imap <C-h>     <Plug>(neosnippet_expand_or_jump)
smap <C-h>     <Plug>(neosnippet_expand)
"imap <expr><C-h> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<C-n>"
"smap <expr><C-h> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<C-n>"
let g:neosnippet#snippets_directory = './vim/.snipets'

"Setting the vimfiler"
let g:vimfiler_trashbox_directory = '~/vim/.vimfiler_trashbox'
let g:vimfiler_safe_mode_by_default = 0
"let g:vimfiler_edit_action = 'tabopen'
set modifiable
"VimFiler 起動
nnoremap <silent> [unite]v :<C-u>VimFiler -buffer-name=explorer -quit<CR>
nnoremap <silent> fv :<C-u>VimFilerBufferDir -buffer-name=explorer -quit<CR>

"VimFiler 起動
nnoremap <silent> [unite]s :<C-u>VimShell<CR>

"Tab indent color"
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 40
let g:indent_guides_guide_size = 1

"Unite prefix key.
nnoremap [unite] <Nop>
xnoremap [unite] <Nop>
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
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=tab file<CR>
"バッファ一覧
nnoremap <silent> fs :<C-u>Unite -buffer-name=tab -toggle buffer file_mru file<CR>
"レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=tab -toggle register<CR>
"最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite -buffer-name=tab -toggle file_mru<CR>
"ブックマーク一覧
"nnoremap <silent> [unite]c :<C-u>Unite -buffer-name=tab -toggle bookmark<CR>
"ブックマークに追加
"nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd -buffer-name=tab -toggle<CR>
"ブックマークにをvimfilerで開く
"call unite#custom_default_action('source/bookmark/directory' , 'vimfiler')
"call unite#custom_default_action('file' , 'tabopen')

"uniteを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  "ESCでuniteを終了
  nmap <buffer> <ESC> <Plug>(unite_exit)
  "入力モードのときjjでノーマルモードに移動
  imap <buffer> jj <Plug>(unite_insert_leave)
  "入力モードのときctrl+wでバックスラッシュも削除
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  "ctrl+jで縦に分割して開く
  nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  "ctrl+jで横に分割して開く
  nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
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

	nnoremap <silent> [unite]a :<C-u>Unite alignta:options<CR>
	xnoremap <silent> [unite]a :<C-u>Unite alignta:arguments<CR>
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
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
colorscheme evening " (Windows用gvim使用時はgvimrcを編集すること)

set fileencodings=utf-8,iso-2022-jp,euc-jp,ucs2le,ucs-2,cp932
set fenc=utf-8

set autoread

let g:PHP_vintage_case_default_indent = 1

set hidden
