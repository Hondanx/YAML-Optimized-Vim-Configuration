" ------------------------------------------------------------------
"  ULTRA OPTIMIZED YAML / ANSIBLE / KUBERNETES LOCAL .vimrc
" ------------------------------------------------------------------

" ----- UI -----
set number                      " Show line numbers
set relativenumber              " Relative numbers for navigation
set cursorline                  " Highlight current line
set cursorcolumn                " Highlight current column (important for YAML)
syntax on                       " Enable syntax highlighting
set background=dark             " Dark mode assumed
set colorcolumn=80              " Column 80 guide (general style)
set wrap                        " Wrap long YAML lines
set linebreak                   " Wrap without breaking words

" ----- SEARCH -----
set hlsearch                    " Highlight search matches
set incsearch                   " Incremental search
set ignorecase                  " Case-insensitive search
set smartcase                   " Case-sensitive when uppercase used

" ----- INDENTATION GLOBAL SAFE DEFAULT (YAML-friendly) -----
set expandtab                   " Convert tabs → spaces
set shiftwidth=2                " Auto-indent = 2 spaces
set softtabstop=2               " TAB counts as 2 spaces
set tabstop=2                   " Visual tab = 2 spaces
set autoindent                  " Auto indentation
set smartindent                 " Smarter indentation rules
set smarttab                    " Better tab behavior

" ----- REMOVE TRAILING WHITESPACE ON SAVE -----
autocmd BufWritePre * %s/\s\+$//e

" ------------------------------------------------------------------
"  YAML GENERAL OPTIMIZATION
" ------------------------------------------------------------------
autocmd FileType yaml setlocal ts=2 sw=2 sts=2 expandtab ai
autocmd FileType yaml setlocal foldmethod=indent
autocmd FileType yaml setlocal list listchars=tab:>-,trail:•
autocmd FileType yaml setlocal colorcolumn=120

" Prevent TAB keys from inserting real tabs
autocmd FileType yaml nnoremap <buffer> <Tab> >>
autocmd FileType yaml nnoremap <buffer> <S-Tab> <<

" ------------------------------------------------------------------
"  ANSIBLE FILES DETECTION
" ------------------------------------------------------------------
autocmd BufRead,BufNewFile */ansible/*.yml setfiletype yaml.ansible
autocmd BufRead,BufNewFile */ansible/*.yaml setfiletype yaml.ansible
autocmd BufRead,BufNewFile *playbook*.yml setfiletype yaml.ansible
autocmd BufRead,BufNewFile *playbook*.yaml setfiletype yaml.ansible

" Highlight Ansible keywords
autocmd FileType yaml.ansible syntax keyword ansibleKeywords hosts tasks vars handlers roles become gather_facts include include_role import_tasks import_role
autocmd FileType yaml.ansible highlight ansibleKeywords ctermfg=Yellow guifg=Yellow

" ------------------------------------------------------------------
"  KUBERNETES YAML DETECTION
" ------------------------------------------------------------------
autocmd BufRead,BufNewFile *.yaml,*.yml if search('^kind:', 'nw') | setlocal filetype=yaml.k8s | endif

" Kubernetes YAML improvements
autocmd FileType yaml.k8s setlocal ts=2 sw=2 expandtab ai cursorcolumn
autocmd FileType yaml.k8s setlocal colorcolumn=100
autocmd FileType yaml.k8s setlocal foldmethod=indent

" Highlight K8s resource kinds
autocmd FileType yaml.k8s syntax keyword k8sKind Deployment Service Pod ConfigMap Secret PersistentVolumeClaim StatefulSet Namespace Ingress DaemonSet ClusterRole RoleBinding
autocmd FileType yaml.k8s highlight k8sKind ctermfg=Cyan guifg=Cyan

" ------------------------------------------------------------------
"  JSON SUPPORT
" ------------------------------------------------------------------
autocmd FileType json setlocal ts=2 sw=2 expandtab ai

" ------------------------------------------------------------------
"  HELM TEMPLATES (*.yaml + Go templating)
" ------------------------------------------------------------------
autocmd BufRead,BufNewFile templates/*.yaml setlocal filetype=yaml.helm
autocmd FileType yaml.helm setlocal ts=2 sw=2 expandtab ai
autocmd FileType yaml.helm syntax region helmTpl start=/{{/ end=/}}/ keepend

" ------------------------------------------------------------------
"  TERRAFORM / HCL
" ------------------------------------------------------------------
autocmd FileType terraform setlocal ts=2 sw=2 expandtab ai
