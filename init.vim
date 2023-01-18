set mouse=    
set number    
     
" make sure that we have vim-plug installed before we do anything    
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'    
if empty(glob(data_dir . '/autoload/plug.vim'))    
  silent execute '!curl -flo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'    
  autocmd vimenter * pluginstall --sync | source $myvimrc    
endif    
     
function! s:jbzcppman()    
    let old_isk = &iskeyword    
    set iskeyword+=:    
    let str = expand("<cword>")    
    let &l:iskeyword = old_isk    
    execute 'cppman ' . str    
endfunction    
command! jbzcppman :call s:jbzcppman()    
     
function! s:jbzclangformat(first, last)    
  let l:winview = winsaveview()    
  execute a:first . "," . a:last . "!clang-format"    
  call winrestview(l:winview)    
endfunction    
command! -range=% jbzclangformat call <sid>jbzclangformat (<line1>, <line2>)    
     
highlight extrawhitespace ctermbg=red guibg=red    
match extrawhitespace /\s\+$/    
au bufwinenter * match extrawhitespace /\s\+$/    
au insertenter * match extrawhitespace /\s\+\%#\@<!$/    
au insertleave * match extrawhitespace /\s\+$/    
au bufwinleave * call clearmatches()    
au filetype cpp nnoremap <buffer>k :jbzcppman<cr>    
" autoformatting with clang-format    
au filetype c,cpp nnoremap <buffer><leader>lf :<c-u>jbzclangformat<cr>    
au filetype c,cpp vnoremap <buffer><leader>lf :jbzclangformat<cr>    
     
set tags=./tags;    
let g:gutentags_ctags_exclude_wildignore = 1    
let g:gutentags_ctags_exclude = [    
  \'node_modules', '_build', 'build', 'cmakefiles', '.mypy_cache', 'venv',    
  \'*.md', '*.tex', '*.css', '*.html', '*.json', '*.xml', '*.xmls', '*.ui']
