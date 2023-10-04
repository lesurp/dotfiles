""""""""""""""""""""
""" COMMON SENSE """
""""""""""""""""""""
" makes startup time MUCH FASTER
let g:python3_host_prog="/usr/bin/python3"

set background=light

" disable auto executed vimscript (fucking RCE waiting to happen)
set nomodeline
" allow changing modified buffers
set hidden
set number
set cursorline
set tabstop=4
set shiftwidth=4
set expandtab
" more room for the messages (lol c++ templates)
set cmdheight=2
set updatetime=0
set shortmess+=cI
set signcolumn=number

" don't fold when opening file, but make the manual one syntax based
if &foldmethod == "manual"
    set foldmethod=syntax
    set foldlevel=99
endif

" change cwd to current netrw dir
let g:netrw_keepdir = 0

"""""""""""""""""""""
""" QOL SHORTCUTS """
"""""""""""""""""""""
" sanity-preserving shortcuts
command Q qa
" fuck ex mode
nnoremap Q <Nop>
nnoremap ]c ]czz
nnoremap n nzz
nnoremap N Nzz
nnoremap ; :
set pastetoggle=<F9>

command E Explore

" search n replace
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>

vnoremap <C-c> "+y
vnoremap <C-x> "+d
inoremap <C-S-v> "+p
xnoremap <C-p> p
xnoremap p "_dP

" resize splits using arrow keys
nnoremap <silent> <C-Right> :vertical resize +5<CR>
nnoremap <silent> <C-Left> :vertical resize -5<CR>
nnoremap <silent> <C-Up> :resize +5<CR>
nnoremap <silent> <C-Down> :resize -5<CR>


" spellczeck
autocmd BufNewFile,BufRead *.tex set spell textwidth=80
autocmd BufNewFile,BufRead *.md set spell textwidth=80
autocmd BufNewFile,BufRead *.txt set spell textwidth=80

""""""""" TERM
" esc in terminal mode; unless it's fzf!
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
" enter insert mode when switching to terminal panel
autocmd BufWinEnter,WinEnter term://* startinsert
" ... and leave it when leaving the panel
autocmd BufLeave term://* stopinsert

" display relative file numbers in terminal
au TermOpen * setlocal nonumber relativenumber

" close nvr when closing git commands editor from terminal
autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

tnoremap <C-w>w <C-\><C-n><C-w>w
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

""""""""" TAB
tnoremap <M-1> <C-\><C-n>1gt
tnoremap <M-2> <C-\><C-n>2gt
tnoremap <M-3> <C-\><C-n>3gt
tnoremap <M-4> <C-\><C-n>4gt
tnoremap <M-5> <C-\><C-n>5gt
tnoremap <M-6> <C-\><C-n>6gt
tnoremap <M-7> <C-\><C-n>7gt
tnoremap <M-8> <C-\><C-n>8gt
tnoremap <M-9> <C-\><C-n>9gt
noremap <M-1> 1gt
noremap <M-2> 2gt
noremap <M-3> 3gt
noremap <M-4> 4gt
noremap <M-5> 5gt
noremap <M-6> 6gt
noremap <M-7> 7gt
noremap <M-8> 8gt
noremap <M-9> 9gt
noremap <silent> <M-0> :tabnew<CR>

" copy pasted mindlessly - ignore whitespaces when diff'ing files
if &diff
    set diffopt+=iwhite
    set diffexpr=DiffW()
    function DiffW()
      let opt = ""
       if &diffopt =~ "icase"
         let opt = opt . "-i "
       endif
       if &diffopt =~ "iwhite"
         let opt = opt . "-w " " swapped vim's -b with -w
       endif
       silent execute "!diff -a --binary " . opt .
         \ v:fname_in . " " . v:fname_new .  " > " . v:fname_out
    endfunction
endif

""""""" BABY PLUGINS
function! EasyTerminal()
    if !exists('g:easy_terminal_canari')
        tabnew
        tabmove
        let g:easy_terminal_canari = win_getid()
        terminal
    endif
    tablast
endfunction
function! EasyTerminalReset(win_id)
    if exists('g:easy_terminal_canari') && a:win_id == g:easy_terminal_canari
        unlet g:easy_terminal_canari
    endif
endfunction
autocmd WinClosed * call EasyTerminalReset(expand("<amatch>"))
noremap <silent> <M-_> :call EasyTerminal()<CR>


" line breaks after the next comma
" (useful for breaking up long fn declarations)
call setreg('l', "f,ls")


" replace the default "man" by cppman (for cpp source files only)
autocmd FileType cpp set keywordprg=:term\ cppman


""""""""" PLUGINS
call plug#begin()
"Plug 'miversen33/netman.nvim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'shaunsingh/solarized.nvim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'lambdalisue/suda.vim'
Plug 'lervag/vimtex'
Plug 'lesurp/vim_spell_checker_rotation'
Plug 'neoclide/coc.nvim', {
            \ 'branch': 'release', 'do': ':CocInstall coc-pyright coc-vimtex coc-json coc-rust-analyzer coc-snippets coc-clangd',
            \ }
Plug 'mfussenegger/nvim-dap'
call plug#end()

let g:solarized_disable_background = v:true
let g:solarized_contrast = v:false
colorscheme solarized

""""""""""""""""""""""""" FZF CONFIG
nnoremap <leader>t :FZF<CR>
let g:fzf_buffers_jump = 1
let g:fzf_command_prefix = 'Fzf'
nnoremap <leader>b :FzfBuffers<CR>

""""""""""""""""""""""""" ULTISNIP CONFIG
" we use the shortcut from coc, so we simply disable
let g:UltiSnipsExpandTrigger="<Nop>"
let g:UltiSnipsJumpForwardTrigger="<Nop>"
let g:UltiSnipsJumpBackwardTrigger="<Nop>"
let g:snips_author = "Paul Lesur"
let g:snips_github = "lesurp"
nnoremap <silent> <leader>c :cnext<CR>
nnoremap <silent> <leader>v :cprev<CR>

""""""""""""""""""""""""" SPELLCHECKROTATE CONFIG
nnoremap <leader>sp :<C-U>call SpellCheckRotate(v:count)<cr>
let g:spell_checker_rotation = ['en_gb', 'fr', 'de']

""""""""""""""""""""""""" COC CONFIG

" omni complete w/ tab
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nnoremap <silent> gl :CocList<CR>
nnoremap <silent> gc :CocCommand<CR>
nnoremap <silent> gd :call CocActionAsync('jumpDefinition')<CR>
nnoremap <silent> gt :call CocActionAsync('jumpDefinition', 'tab drop')<CR>
nnoremap <silent> ge :CocList diagnostics<CR>
nnoremap <silent> gs :CocList outline<CR>
nnoremap <silent> gr :call CocActionAsync('jumpReferences')<CR>
nnoremap <silent> gx :call CocActionAsync('doQuickfix')<CR>
nmap <silent> gh :call CocActionAsync('doHover')<CR>
nnoremap <silent> gv :call CocActionAsync('preview')<CR>
nnoremap <silent> <F2> :call CocActionAsync('rename')<CR>
nnoremap <silent> <F1> :CocCommand clangd.switchSourceHeader<CR>
nmap <leader>a v<Plug>(coc-codeaction-selected)

nmap <expr> <leader>f CocHasProvider('format') ? ":call CocActionAsync('format')<CR>" : "gg=G''"
vmap <leader>f <Plug>(coc-format-selected)

inoremap <silent><expr> <cr>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ "\<cr>"
      " not sure what this is for might be required?
      \ <SID>check_back_space() ? "\<cr>" :
      \ coc#refresh()


"""""""""""""""""" LaTex
let g:vimtex_view_method = 'zathura'


lua <<LUA
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode-15', -- adjust as needed, must be absolute path
  name = 'lldb'
}
dap.adapters.cpp = dap.adapters.lldb
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

vim.keymap.set('n', '<F5>', function()
    if vim.fn.filereadable('.vscode/launch.json') then
      require('dap.ext.vscode').load_launchjs()
    end
    dap.continue()
end)
vim.keymap.set('n', '<F10>', dap.step_over)
vim.keymap.set('n', '<F11>', dap.step_into)
vim.keymap.set('n', '<F12>', dap.step_out)
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>dB', dap.set_breakpoint)
vim.keymap.set('n', '<leader>dm', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<leader>dr', dap.repl.open)
vim.keymap.set('n', '<leader>dl', dap.run_last)
vim.keymap.set({'n', 'v'}, '<leader>h', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

LUA
