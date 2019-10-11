if !has('python3')
    finish
endif


" --------------------------------
" Add our plugin to the path
" --------------------------------
python3 import sys
python3 import vim
python3 import re
python3 if vim.eval('expand("<sfile>:p:h")') not in sys.path: sys.path.append(vim.eval('expand("<sfile>:p:h")'))

" --------------------------------
"  Function(s)
" --------------------------------
function! SetBreakPoint()

  if !exists('g:py_breakpoint_cmd')
    python3 << endOfPython
import setbreakpoint
cmd = setbreakpoint.get_breakpoint_cmd()
vim.command("let g:py_breakpoint_cmd='{}'".format(cmd))
endOfPython
  endif

  let l:cursor = line('.')
  let line = getline(l:cursor)
  let plnum = prevnonblank(l:cursor)
  if &expandtab
      let indents = repeat(' ', indent(plnum))
  else
      let indents = repeat("\t", plnum / &shiftwidth)
  endif

  call append(line('.')-1, indents.g:py_breakpoint_cmd)
  normal k
endfunction

function! RemoveBreakPoint()

  python3 << endOfPython
if re.search('set_trace()', vim.current.line) is not None:
    vim.command('normal dd')
endOfPython

endfunction

function! RemoveAllBreakPoints()

  python3 << endOfPython
from setbreakpoint import remove_breakpoints
vim.current.buffer[:] = remove_breakpoints(list(vim.current.buffer))
endOfPython

endfunction

function! ToggleBreakPoint()

  python3 << endOfPython
import re
row, _ = vim.current.window.cursor
if re.search("set_trace()", vim.current.line) is None:
    if re.search("set_trace()", vim.current.buffer[row-2]) is not None:
        vim.command('call RemoveBreakPoint()')
    else:
        vim.command('call SetBreakPoint()')
else:
    vim.command('call RemoveBreakPoint()')
endOfPython

endfunction

" --------------------------------
"  Expose our commands to the user
" --------------------------------
command! SetBreakPoint call SetBreakPoint()
command! RemoveBreakPoints call RemoveBreakPoints()
command! RemoveAllBreakPoints call RemoveAllBreakPoints()
