setbreakpoint
===============

Introduction
------------

This is a plungin aimed to facilitate inserting and removing breakpoints in python script. It will add/remove set\_trace() in your code

Installation
------------

Use your plugin manager of choice.

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'ciknight/setbreakpoint'
```
- Make sure to use Vim 7.4 or above
- Usage Python3


## Usage

Add this into your .vimrc:

```vim
autocmd FileType python nnoremap <leader>b :call ToggleBreakPoint()<Cr>
```

When you want to insert or remove a breakpoint at a certain sentence, just click F12.
