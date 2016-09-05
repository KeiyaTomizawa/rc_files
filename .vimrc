"$Id: .vimrc 1167 2009-11-01 04:50:17Z ktaki $
syntax on
set background=dark
set tw=80
set ts=4
set sw=2
set cindent
"set autoindent
"set smartindent
set modeline
set cinoptions=g0,t0,(0,:0

"set makeprg=gmake
set switchbuf=split,useopen
set list
set listchars=tab:>-,eol:$
set dictionary=
set textwidth=0
set nowrap
" CUDA
au BufNewFile,BufRead *.cu setf cu
" VTK 
au BufNewFile,BufRead *.txx setf cpp
au BufNewFile,BufRead *.tex set spell spelllang=en_us
au BufNewFile,BufRead *.xmf setf xml
set wrap
"set wrapmargin=16
nnoremap C-k k
nnoremap C-j j
nnoremap C-h h
nnoremap C-l l
nnoremap j gj
nnoremap k gk
nnoremap z? z=
set fileformats=unix,dos,mac
"set expandtab

"" 以下の順番にファイルのエンコーディングをチェックして行く
"" cp932 -> shift-jis にすると何故か上手く行かない
"set fileencodings=iso-2022-jp,cp932,ucs-4,utf-8,utf-16,ucs-2-internal,ucs-2 ",euc-jp,japan
"set encoding=euc-jp
"set fileencoding=euc-jp
"set termencoding=euc-jp
" 文字コード関連
"
if &encoding !=# 'utf-8'
	set encoding=japan
endif
set fileencoding=japan
if has('iconv')
	let s:enc_euc = 'euc-jp'
	let s:enc_jis = 'iso-2022-jp'
	" iconvがJISX0213に対応しているかをチェック
	if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'euc-jisx0213'
		let s:enc_jis = 'iso-2022-jp-3'
	endif
	" fileencodingsを構築
	if &encoding ==# 'utf-8'
		let s:fileencodings_default = &fileencodings
		let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
		let &fileencodings = &fileencodings .','. s:fileencodings_default
		unlet s:fileencodings_default
	else
		let &fileencodings = &fileencodings .','. s:enc_jis
		set fileencodings+=utf-8,ucs-2le,ucs-2
		if &encoding =~# '^euc-\%(jp\|jisx0213\)$'
			set fileencodings+=cp932
			set fileencodings-=euc-jp
			set fileencodings-=euc-jisx0213
			let &encoding = s:enc_euc
		else
			let &fileencodings = &fileencodings .','. s:enc_euc
		endif
	endif
	" 定数を処分
	unlet s:enc_euc
	unlet s:enc_jis
endif

function! GetStatusEx()
 let str = ''
 let str = str . '[' . &fileformat . ']'
 if has('multi_byte') && &fileencoding != ''
 let str = str . '[' . &fileencoding . ']'
 endif
 return str
endfunction
"set statusline=%n:\ %<%f%y\ %m%r%h%w%{GetStatusEx()}\ %l,%c\ %P
"set statusline=%n:\ %<%f%y%(\ [%M%R%W]%)\ %l\ %c\ %P
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P:%t
set laststatus=2 " 常にステータスバー表示

augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

set hlsearch
set smartcase
set ignorecase
set showcmd
set showmatch
" vim: set fileencoding=utf-8
set encoding=utf-8
set encoding=utf-8
