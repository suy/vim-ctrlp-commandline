" =============================================================================
" File:          autoload/ctrlp/commandline.vim
" Description:   Command line history extension for ctrlp.vim
" =============================================================================


" Get the script's filename.
let s:n = exists('s:n') ? s:n : fnamemodify(expand('<sfile>', 1), ':t:r')

" Load guard
if ( exists('g:loaded_ctrlp_'.s:n) && g:loaded_ctrlp_{s:n} )
	\ || v:version < 700 || &cp
	finish
endif
let g:loaded_ctrlp_{s:n} = 1


" Add this extension's settings to g:ctrlp_ext_vars
"
" Required:
"
" + init: the name of the input function including the brackets and any
"         arguments
"
" + accept: the name of the action function (only the name)
"
" + lname & sname: the long and short names to use for the statusline
"
" + type: the matching type
"   - line : match full line
"   - path : match full line like a file or a directory path
"   - tabs : match until first tab character
"   - tabe : match until last tab character
"
" Optional:
"
" + enter: the name of the function to be called before starting ctrlp
"
" + exit: the name of the function to be called after closing ctrlp
"
" + opts: the name of the option handling function called when initialize
"
" + sort: disable sorting (enabled by default when omitted)
"
call add(g:ctrlp_ext_vars, {
	\ 'init':   'ctrlp#'.s:n.'#init()',
	\ 'accept': 'ctrlp#'.s:n.'#accept',
	\ 'lname':  'command line',
	\ 'sname':  'cmd',
	\ 'type':   'line',
	\ 'sort':   0,
	\ })

" \ 'enter':  'ctrlp#'.s:n.'#enter()',
" \ 'exit':   'ctrlp#'.s:n.'#exit()',
" \ 'opts':   'ctrlp#'.s:n.'#opts()',


" Provide a list of strings to search in
"
" Return: a Vim's List
"
function! ctrlp#{s:n}#init()
	let num = histnr('cmd')
	let line = histget('cmd', num)
	let lines = []
	while num >= 1
		if line != ''
			call add(lines, line)
		endif
		let num = num-1
		let line = histget('cmd', num)
	endwhile
	return lines
endfunction


" The action to perform on the selected string
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
"
function! ctrlp#{s:n}#accept(mode, str)
	call ctrlp#exit()
	" Start adding the entry to the history, so it can be edited if needed.
	call histadd('cmd', a:str)

	" Mnemonic for silent: <C-s>, i.e., horizontal split.
	if a:mode == 'h'
		silent execute ':' . a:str
	" Mnemonic for ediT: <C-t>. Opens the command line and goes up.
	elseif a:mode == 't'
		call feedkeys(":\<C-p>", 'n')
	else
		execute ':' . a:str
	endif
endfunction


" Do something before enterting ctrlp
" function! ctrlp#{s:n}#enter()
" endfunction


" Do something after exiting ctrlp
" function! ctrlp#{s:n}#exit()
" endfunction


" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

" Allow it to be called later
function! ctrlp#{s:n}#id()
	return s:id
endfunction


" Create a command to directly call the new search type
"
" Put this in vimrc or plugin/commanline.vim
" command! CtrlPCommandline call ctrlp#init(ctrlp#commandline#id())


" vim:fen:fdl=0:ts=2:sw=2:sts=2
