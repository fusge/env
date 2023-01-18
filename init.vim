set mouse=    
set number    
    
" Make sure that we have vim-plug installed before we do anything    
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'    
if empty(glob(data_dir . '/autoload/plug.vim'))    
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'    
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC    
endif    
    
function! s:JbzCppMan()    
    let old_isk = &iskeyword    
    set iskeyword+=:    
    let str = expand("<cword>")    
    let &l:iskeyword = old_isk    
    execute 'cppman ' . str    
endfunction    
command! JbzCppMan :call s:JbzCppMan()    
    
function! s:JbzClangFormat(first, last)    
  let l:winview = winsaveview()    
  execute a:first . "," . a:last . "!clang-format"    
  call winrestview(l:winview)    
endfunction    
command! -range=% JbzClangFormat call <sid>JbzClangFormat (<line1>, <line2>)    
    
highlight ExtraWhitespace ctermbg=red guibg=red    
match ExtraWhitespace /\s\+$/    
au BufWinEnter * match ExtraWhitespace /\s\+$/    
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/    
au InsertLeave * match ExtraWhitespace /\s\+$/    
au BufWinLeave * call clearmatches()    
au FileType cpp nnoremap <buffer>K :JbzCppMan<CR>    
" Autoformatting with clang-format    
au FileType c,cpp nnoremap <buffer><leader>lf :<C-u>JbzClangFormat<CR>    
au FileType c,cpp vnoremap <buffer><leader>lf :JbzClangFormat<CR>    
    
set tags=./tags;    
let g:gutentags_ctags_exclude_wildignore = 1    
let g:gutentags_ctags_exclude = [    
  \'node_modules', '_build', 'build', 'CMakeFiles', '.mypy_cache', 'venv',    
  \'*.md', '*.tex', '*.css', '*.html', '*.json', '*.xml', '*.xmls', '*.ui']    

