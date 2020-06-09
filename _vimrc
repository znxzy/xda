set nocompatible		" be iMproved, required
filetype off			" required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

Plugin 'https://github.com.cnpmjs.org/VundleVim/Vundle.vim'
Plugin 'https://github.com.cnpmjs.org/neoclide/coc.nvim',{'branch': 'release'}
Plugin 'https://github.com.cnpmjs.org/dense-analysis/ale'
Plugin 'https://github.com.cnpmjs.org/vim-airline/vim-airline'
Plugin 'https://github.com.cnpmjs.org/vim-airline/vim-airline-themes'
Plugin 'https://github.com.cnpmjs.org/ctrlpvim/ctrlp.vim'

" required by denite.nvim
Plugin 'https://github.com.cnpmjs.org/Shougo/denite.nvim'
Plugin 'https://github.com.cnpmjs.org/roxma/nvim-yarp'
Plugin 'https://github.com.cnpmjs.org/roxma/vim-hug-neovim-rpc'
" end

Plugin 'https://github.com.cnpmjs.org/majutsushi/tagbar'
Plugin 'https://github.com.cnpmjs.org/chrisbra/csv.vim'

Plugin 'https://github.com.cnpmjs.org/jmcantrell/vim-virtualenv'

Plugin 'https://github.com.cnpmjs.org/ryanoasis/vim-devicons'

call vundle#end()

" To ignore plugin indent changes, instead use:
"filetype plugin on

""""""
" BEGIN of general settings
"
set encoding=UTF-8
set fileencodings=UTF-8
filetype plugin indent on
syntax enable
set hlsearch
set incsearch

" relative line number
set rnu
augroup relative_number
	autocmd!
	autocmd InsertEnter * :set nu  "norelativenumber
	autocmd InsertLeave * :set rnu "relativenumber
augroup END

set smartindent

" END of general settings
""""""

"" BEGIN tagbar settings
nmap <F8> :TagbarToggle<CR>

"" END tagbar settings


"" BEGIN ctrlp.vim configuration
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_working_path_mode = 'ra'
" 'c' - The directory of the current file.
" 'a' - The directory of the current file, unless it is a subdirectory of the
"       cwd.
" 'r' - The nearest ancestor of the current file that contains one the these
"       directories or files: .git .hg .svn .bzr _darcs
" 'w' - Modifier to 'r': start search from the cwd instead of the current
"       file's directory.
" 0 or ''(empty string) - Disable this feature.
" If none of the default markers (.git .hg .svn .bzr _darcs) are present in a
" project, you can define additional ones with g:ctrl_root_markers:
"let g:ctrlp_root_markers = ['pom.xml', '.p4ignore']

" If a file is already open, open it again in a new pane instead of switch to
" the existing pane
"let g:ctrlp_switch_buffer = 'et'
"
" Exclude files and directories using Vim's wildignore and CtrlP's own
" g:ctrlp_custom_ignore. If a custom listing command is being used,
" excluesions are ignored:
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
	\ 'dir': '\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v\.(exe|so|dll)$',
	\ 'links': '',
	\ }

" use a custom file listing comman
let g:ctrlp_user_command = 'find %s -type f'
" ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

"" END ctrlp.vim configuration



"" BEGIN examples for denite.nvim 
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
	nnoremap <silent><buffer><expr> <CR>
				\ denite#do_map('do_cation')
	nnoremap <silent><buffer><expr> d
				\ denite#do_map('do_action', 'delete')
	nnoremap <silent><buffer><expr> p
				\ denite#do_map('do_action', 'preview')
	nnoremap <silent><buffer><expr> q
				\ denite#do_map('quit')
	nnoremap <silent><buffer><expr> i
				\ denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> <Space>
				\ denite#do_map('toggle_select').'j'
endfunction

"" End of Examples



"" BEGIN airline configuration
let g:airline_theme='deus'

let g:airline#extension#tabline#enabled = 1

"" END of airline configuration


""""""
" BEGIN coc.nvim configuration
"
" TextEdit might fail if hidden is not set
set hidden

" Some servers have issues with backup files
"set nowritebackup
"set nobackup

" Give more space for displaying messages
set cmdheight=2

" Having longer updatetime (default is 4000ms) leads to noticeable delays and
" poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set signcolumn=number

" Use tab for trigger completion with characters ahead and navigate.
" Note: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction

inoremap <silent><expr> <m-space> coc#refresh()

" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
	inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"
" END of coc.nvim configuration
""""""


