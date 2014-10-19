" =================================================================================
" File:         ~/$vimfiles/vimrc
" Description:  Vim主配置文件
" Maintainer:   (@Tywin) - <tywinly@gmail.com>
" Last Change:  - 19 Oct, 2014
"
" 编译参数：--enable-multibyte --with-features=huge --enable-pythoninterp=yes --enable-gui=auto
" =================================================================================

" --------------------------- General ------------------------------{{{
" 关闭兼容
set nocompatible

" 平台检测
function! GetOS()
    if (has('win32') || has('win64'))
        return 'windows'
    elseif has('unix')
        return 'linux'
endfunction

" 配置目录
if GetOS() == 'windows'
    let $vimfiles = $HOME.'/vimfiles'
elseif GetOS() == 'linux'
    let $vimfiles = $HOME.'/.vim'
endif

" 资源目录
let $vimdir = $HOME.'/.vimdir'
let $plugins = $vimfiles.'/bundle'
let $resource = $vimfiles.'/resource'

" 全局引导键
let mapleader=','

" 文件编码
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" 持久撤消
set undofile
set undolevels=1000
set undodir=$vimdir/undofiles
if !isdirectory(&undodir)
    call mkdir(&undodir, 'p')
endif

" 状态保持
set viminfo='100,f1,<1000,s100,:100,@100,/100,n$vimdir/viminfo
set viewdir=$vimdir/viewfiles
auto BufWinLeave * if expand('%') != '' && &buftype == '' | mkview          | endif
auto BufReadPost * if expand('%') != '' && &buftype == '' | silent loadview | endif

" 备份选项
set backup
set autoread
set autowrite
set autochdir
auto BufReadPost * if getfsize(expand('%:p')) > 2048000 | set nobackup | endif

" 备份目录
let &backupdir=$vimdir.'/bakfiles/'.strftime('%m')
if !isdirectory(&backupdir)
    call mkdir(&backupdir, 'p')
endif

" 备份扩展名
let &backupext='_»_'.substitute(substitute(getcwd(), "['\" ():*?<>|]", "-", "g"), "[\\/]", "+", "g").'+'.strftime('%m%d%H').'.bak'

" 插件管理
let $vundle = $plugins.'/vundle'
if isdirectory($vundle)
    source $vimfiles/vundle.vim
endif
" }}}

" --------------------------- Platform ---------------------------{{{
" 图形配置
if has('gui_running')
    " 外观配置
    set lines=28 columns=118
    set guioptions=gte

    " 标题配置
    auto BufEnter * let &titlestring = expand("%:p")

    " 消息编码
    set langmenu=zh_CN.UTF-8
    language message zh_CN.UTF-8

    " 鼠标配置
    set mouse=a
    set selection=inclusive
    set mousemodel=popup

    " 单词高亮
    nnoremap <silent><2-LeftMouse> :execute 'match Cword /\<'.expand('<cword>').'\>/'<CR>

    " Windows
    if GetOS() == 'windows'
        " 复制粘贴
        vnoremap <C-c> "+y
        vnoremap <C-x> "+x
        nnoremap <C-a> ggVG
        exe 'inoremap <script><C-v>' paste#paste_cmd['i']

        " 窗口调整
        nnoremap <C-x> :simalt ~x<CR>
        nnoremap <C-n> :simalt ~n<CR>

        " 字体配置
        set guifont=Monaco:h10:cANSI
        set guifontwide=KaiTi:h12:cANSI

        " 默认目录
        let $documents = $vimdir.'/documents'
        if expand("%:t") == ''
            if !isdirectory($documents)
                call mkdir($documents)
            endif
            cd $documents
        endif

    " Linux
    elseif GetOS() == 'linux'
        " 字体配置
        set guifont=Monaco\ 10
    endif
" 终端配置
else
    " 彩色终端
    set t_Co=256

    " 快速终端
    set ttyfast
endif
" }}}

" --------------------------- Syntax ------------------------------{{{
" 语法高亮
syntax on

" 类型检测
filetype indent on
filetype plugin on

" 配色方案
set background=dark
colorscheme solarized

" 代码缩进
set cindent
set autoindent
set smartindent
set smarttab
set expandtab
set shiftwidth=4
set softtabstop=4

" 括号匹配
set matchpairs=(:),[:],{:}

" 自定义颜色
highlight Cword guifg=#8a878a guibg=#1234aa gui=none ctermfg=102 ctermbg=20 cterm=none
highlight SpaceEOL guifg=#ff0000 guibg=NONE gui=none ctermfg=196 ctermbg=NONE cterm=none

" 显示行末空格
match SpaceEOL /\s\+$/
" }}}

" --------------------------- Options ------------------------------{{{
" 外观显示
set list
set ruler
set number
set showcmd
set wildmenu
set laststatus=2
set shortmess=atI
set listchars=tab:>>,extends:»,precedes:«,trail:~

" 搜索配置
set magic
set incsearch
set hlsearch
set ignorecase
set smartcase

" 折行配置
set wrap
set textwidth=0
set backspace=2
set showbreak=»
set whichwrap=b,<,>,[,]
set foldmethod=marker
set formatoptions+=mM

" 消息提示
set hidden
set noerrorbells
set novisualbell
set t_vb=
set report=0

" 其它配置
set tags=tags;
set complete+=k
set virtualedit=block
set completeopt=menuone,longest
set wildignore=*.pyc,*.pyo,*.exe,*.dll,*.so,*.a,*.o,.svn,.git
" }}}

" --------------------------- Shortcut ------------------------------{{{
" 重载配置文件
nnoremap <leader>vi :runtime vimrc<CR>

" 重画屏幕
nnoremap <leader>rd :redraw!<CR>

" 保存/退出
nnoremap w :w<CR>
nnoremap q :q<CR>

" 光标键映射
nnoremap <left> :bprevious<CR>
nnoremap <right> :bnext<CR>
nnoremap <up> :tabnext<CR>
nnoremap <down> :tabprevious<CR>

" 复制操作
nnoremap <leader>yw "+yiw
nnoremap <leader>yy "+yy
nnoremap <leader>ya :%y+<CR>

" 插入模式操作(SecureCRT需设置“Backspace send delete”)
inoremap <C-h> <left>
inoremap <C-l> <right>
inoremap <C-a> <home>
inoremap <C-e> <end>
inoremap <C-d> <del>

" 命令模式操作
cnoremap <C-b> <left>
cnoremap <C-n> <down>
cnoremap <C-p> <up>
cnoremap <C-f> <right>
cnoremap <C-a> <home>
cnoremap <C-e> <end>
cnoremap <C-d> <del>

" 屏幕滚动
nnoremap <C-d> 3<C-d>
nnoremap <C-u> 3<C-u>
vnoremap <C-d> 3<C-d>
vnoremap <C-u> 3<C-u>
nnoremap <space> <C-f>

" 分割窗口移动
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 分割窗口调整
nnoremap <C-up>    <C-w>-
nnoremap <C-down>  <C-w>+
nnoremap <C-left>  <C-w><
nnoremap <C-right> <C-w>>

" 标签跳转
nnoremap <leader>t <C-]>
nnoremap <leader>T <C-t>
nnoremap <leader>s g]

" 缓冲区操作
nnoremap <leader>bo <C-w>n
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>

" 模式切换
nnoremap <silent><leader>ls :set list!<CR>
nnoremap <silent><leader>ps :set paste!<CR>
nnoremap <silent><leader>nb :set number!<CR>
nnoremap <silent><leader>hl :set cursorline!<CR>
nnoremap <silent><leader>hc :set cursorcolumn!<CR>

" 高亮当前单词
nnoremap <silent><leader>? :execute 'match Cword /\<'.expand('<cword>').'\>/'<CR>
nnoremap <silent><leader>/ :nohls<CR>:match none<CR>
" }}}

" --------------------------- Languages ------------------------------{{{
" 文件类型（指定多种类型补全时会闪屏）
auto BufRead,BufNewFile *.ctp set filetype=php

" 智能补全
auto FileType php setlocal omnifunc=phpcomplete#CompletePHP
auto FileType python setlocal omnifunc=pythoncomplete#Complete
auto FileType css setlocal omnifunc=csscomplete#CompleteCSS
auto FileType html setlocal omnifunc=htmlcomplete#CompleteTags
auto FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" }}}

" --------------------------- Functions ------------------------------{{{
" 清理文件格式
function! ClearFiles()
    silent retab
    silent set fileformat=unix
    silent %s/\r//e
    silent %s/\s\+$//e
endfunction
nnoremap <silent><leader>cf :call ClearFiles()<CR>

" 切换粘贴模式
function! TogglePaste()
    set paste!
    if exists('g:syntax_on') | syntax off | else | syntax on | endif
endfunction
nnoremap <silent><leader>ps :call TogglePaste()<CR>

" 加载本地配置
if filereadable(glob('$vimdir/vimrc'))
    source $vimdir/vimrc
endif
" }}}
