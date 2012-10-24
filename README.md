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

