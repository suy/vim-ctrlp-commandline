Command line history extension for CtrlP.vim
============================================

This extension provides a convenient interface for finding and executing
previous instructions given in the command line.

Is different to what [sgur](https://github.com/sgur/ctrlp-extensions.vim)
provides, because this extension respects the order when presenting options, and
it doesn't use `:silent` when invoking commands.

Installation
============

Just put the file in the proper `autoload` directory, like CtrlP does. Or use a
plugin manager like [Pathogen](https://github.com/tpope/vim-pathogen).

To load this extension into ctrlp, add this to your vimrc:

```VimL
let g:ctrlp_extensions = ['commandline']
```

If you have other extensions (for example, 'mixed'):

```VimL
let g:ctrlp_extensions = [
    \ 'mixed',
    \ 'commandline',
    \ ]
```

Usage
=====

You can either run Ctrl-P and switch to command mode, or add the
following to your .vimrc

```VimL
    command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id())
```

and use `:CtrlPCommandLine`. Alternatively, the following mapping will
replace `<C-f>` in command mode:

```VimL
    cnoremap <silent> <C-f> <C-c>:call ctrlp#init(ctrlp#commandline#id())<CR>
```
