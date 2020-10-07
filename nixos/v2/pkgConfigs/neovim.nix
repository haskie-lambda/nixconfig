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
    ];

    extraConfig = ''
syntax on
filetype plugin on
filetype indent on
set mouse=a

" Turn on hybrid numbers
"set nu rnu
set nonu
"hi LineNr ctermfg=grey

" Turn off ugly status line
set laststatus=0

command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

au FileType haskell setlocal ts=4 sts=4 sw=4 expandtab
au FileType python setlocal ts=4 sts=4 sw=4 expandtab
au FileType sh setlocal ts=4 sts=4 sw=4 expandtab
au FileType nix setlocal ts=2 sts=2 sw=2 expandtab
au BufWritePost *.tex :! pdflatex %

let g:haskell_indent_guard = 4

" Restore the cursor
au VimLeave * set guicursor=a:ver100
    '';
  };
  
}
