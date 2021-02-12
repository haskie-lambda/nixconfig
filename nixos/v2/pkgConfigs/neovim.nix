{ pkgs, ... }:
{ 

  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      haskell-vim
      vim-nix
      nerdtree
      vim-airline
      ctrlp-vim      
      coc-nvim
    ];

    extraConfig = ''
let g:airline_powerline_fornts = 1
syntax on
filetype plugin on
filetype indent on
set mouse=a

" Turn on hybrid numbers
"set nu rnu
set nonu
"hi LineNr ctermfg=grey
hi Search cterm=NONE ctermbg=232 ctermfg=50
hi IncSearch cterm=NONE ctermbg=50 ctermfg=232


" Turn off ugly status line
set laststatus=0

command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

au FileType haskell setlocal ts=4 sts=4 sw=4 expandtab
au FileType python setlocal ts=4 sts=4 sw=4 expandtab
au FileType sh setlocal ts=4 sts=4 sw=4 expandtab
au FileType nix setlocal ts=2 sts=2 sw=2 expandtab
au FileType * setlocal ts=4 sts=4 sw=4 expandtab
au BufWritePost *.tex :! pdflatex %

map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <C-h> yiwvap:s/^<C-R>0/  /<CR>{O<Esc>jp

" compile commands
map <C-ca> :!asy %:p

let g:haskell_indent_guard = 2
" set shiftwidth=4
set number
" set expandtab

" Restore the cursor
au VimLeave * set guicursor=a:ver100

set ignorecase
set smartcase

hi pmenu ctermbg=39 ctermfg=15
hi CocFloating ctermbg=39 ctermfg=15
hi CocErrorFloat ctermbg=190 ctermfg=red
" tab for navigation; enter for completion
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    '';
  };
  
}
