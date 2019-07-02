" write an endline character at the end of the file
autocmd FileType c,cpp,java autocmd BufWritePre <buffer> %s/\s\+$//e
" remove trailing spaces for each row
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" show line numbers
set number
