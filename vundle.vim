" =================================================================================
" File:         ~/$vimfiles/vundle.vim
" Descripttion: vim插件配置文件
" Maintainer:   (@Tywin) - <tywinly@gmail.com>
" Last Change:  - 19 Oct, 2014
" =================================================================================

" Vundle {{{
filetype off
set runtimepath+=$vundle
call vundle#begin($plugins)
Plugin 'gmarik/vundle'
" }}}

" 配色方案 {{{
Plugin 'flazz/vim-colorschemes'
" }}}

" 文件浏览 {{{
Plugin 'scrooloose/nerdtree'
let g:NERDTreeWinSize=38
let g:NERDTreeDirArrows=0
let g:NERDTreeQuitOnOpen=0
let g:NERDTreeIgnore=['\.pyc$','\.pyo$','^\.git$','^\.svn$']
auto bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nnoremap <silent><leader>nt :NERDTreeToggle<CR>
" }}}

" 缓冲区浏览 {{{
Plugin 'fholgado/minibufexpl.vim'
let g:miniBufExplVSplit=32
let g:miniBufExplBRSplit=1
let g:miniBufExplorerAutoStart=0
let g:miniBufExplBuffersNeeded=0
nnoremap <silent><leader>mi :MBEToggle<CR>
" }}}

" 文件搜索 {{{
Plugin 'kien/ctrlp.vim'
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlP'
let g:ctrlp_by_filename=1
let g:ctrlp_regexp=1
let g:ctrlp_tabpage_position='bc'
let g:ctrlp_root_markers=['.svn', '.git', '.root']
let g:ctrlp_open_new_file='r'
let g:ctrlp_open_multiple_files='ij'
let g:ctrlp_cache_dir=$vimdir.'/ctrlp'
let g:ctrlp_custom_ignore={
\    'link': 'SOME_BAD_SYMBOLIC_LINKS',
\ }
" }}}

" 代码提示 {{{
Plugin 'Shougo/neocomplcache.vim'
let g:acp_enableAtStartup=0
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_enable_auto_select=1
let g:neocomplcache_temporary_dir=$vimdir.'/neocomplcache'
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
inoremap <expr><CR> pumvisible() ? '<C-y>' : '<CR>'
inoremap <expr><leader>e neocomplcache#cancel_popup()
" }}}

" 括号补全 {{{
Plugin 'Raimondi/delimitMate'
let delimitMate_quotes = "\" ' `"
let delimitMate_matchpairs="(:),[:]"
let delimitMate_nesting_quotes = ['"',"'"]
" }}}

" 状态栏配置 {{{
Plugin 'Lokaltog/vim-powerline'
let g:Powerline_symbols='compatible'
" }}}

" 代码片断 {{{
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger='<Tab>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
let g:UltiSnipsSnippetDirectories=['ultisnips']
" }}}

" 语法检查 {{{
Plugin 'scrooloose/syntastic'
let g:syntastic_mode_map={
\   'mode': 'passive',
\   'active_filetypes': ['php', 'python'],
\ }
let g:syntastic_php_checkers=['php']
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_php_php_args='-l -d display_errors=1'
" }}}

" 快速跳转 {{{
Plugin 'Lokaltog/vim-easymotion'
let g:EasyMotion_mapping_f='<leader>f'
let g:EasyMotion_mapping_F='<leader>F'
" }}}

" 代码对齐 {{{
Plugin 'junegunn/vim-easy-align'
vmap <space> <Plug>(EasyAlign)
let g:easy_align_ignore_groups=['Comment', 'String']
" }}}

" 缩进对齐线 {{{
Plugin 'Yggdroot/indentLine'
let g:indentLine_enabled=1
let g:indentLine_fileType=['php', 'python']
let g:indentLine_char='¦'
let g:indentLine_color_term=239
let g:indentLine_color_gui='#4e4e4e'
nnoremap <silent><leader>id :IndentLinesToggle<CR>
" }}}

" 快速注释 {{{
Plugin 'tomtom/tcomment_vim'
let g:tcommentMapLeaderOp1='<leader>c'
let g:tcommentMapLeaderOp2='<leader>C'
" }}}

" PHP增强 {{{
" PHPTags：ctags -R --fields=+aimS --languages=php
Plugin 'alvan/vim-php-manual'
Plugin 'shawncplus/phpcomplete.vim'
" }}}

" 前端增强 {{{
Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/javascript-libraries-syntax.vim'
let g:used_javascript_libs='jquery,underscore,backbone'
let g:user_emmet_leader_key='<C-y>'
let g:user_emmet_settings={
\   'php': {
\       'extends': 'html',
\   },
\ }
" }}}

" Markdown支持 {{{
Plugin 'plasticboy/vim-markdown'
" }}}

call vundle#end()
