set nocompatible
set isk+=_,$,@,%,&,# " nonwords
set mouse=a
set hidden " background buffers instead of closing
set backspace=indent,eol,start
set splitbelow
set splitright
set nowritebackup
set noswapfile
set spelllang="en_au"
set title

set hlsearch
set ignorecase
set smartcase

" keep file position
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

syntax on
filetype plugin indent on
" set number

let mapleader=" "
command T spl | terminal
command Vt vspl | terminal
tnoremap <Esc> <C-\><C-n>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
autocmd TermOpen,BufWinEnter,WinEnter term://* nohlsearch
autocmd TermOpen,BufWinEnter,WinEnter term://* startinsert

set whichwrap+=<,>,[,]
set wrap lbr
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

nnoremap Y y$

inoremap jj <Esc>

au BufWritePre * :%s/\s\+$//e
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

if get(g:, '_has_set_default_indent_settings', 0) == 0
  set smartindent
  set expandtab
  set tabstop=4
  set softtabstop=4
  set shiftwidth=4
  let g:_has_set_default_indent_settings = 1
endif

function! UpdateRemotePlugins(...)
  " Needed to refresh runtime files
  let &rtp=&rtp
  UpdateRemotePlugins
endfunction

set softtabstop=4

" ---- plugins ----
call plug#begin(stdpath('data') . '/plugged')
Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }


Plug 'romgrk/fzy-lua-native'
Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'roxma/nvim-yarp', { 'do': 'pip install -r requirements.txt' }

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim'

Plug 'jremmen/vim-ripgrep'

" Plug 'preservim/nerdtree'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'cocopon/pgmnt.vim'
Plug 'deifactor/vale'
Plug 'theacodes/witchhazel'
Plug 'cseelus/vim-colors-lucid'

Plug 'simrat39/symbols-outline.nvim'
Plug 'folke/trouble.nvim'

Plug 'nacitar/a.vim' " go alternate

Plug 'tpope/vim-sleuth'

Plug 'romgrk/barbar.nvim'
Plug 'airblade/vim-gitgutter'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'frazrepo/vim-rainbow'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'hrsh7th/cmp-vsnip'

Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'

" todo we have language server support now, use that
Plug 'tomlion/vim-solidity'
Plug 'mattdf/vim-yul'
Plug 'lervag/vimtex'
call plug#end()

call wilder#setup({'modes': [':', '/', '?']})

call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#python_file_finder_pipeline({
      \       'file_command': ['find', '.', '-type', 'f', '-printf', '%P\n'],
      \       'dir_command': ['find', '.', '-type', 'd', '-printf', '%P\n'],
      \       'filters': ['fuzzy_filter', 'difflib_sorter'],
      \     }),
      \     wilder#cmdline_pipeline(),
      \     wilder#python_search_pipeline(),
      \   ),
      \ ])

call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline({
      \       'fuzzy': 1,
      \       'set_pcre2_pattern': 1,
      \     }),
      \   ),
      \ ])

call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': [
      \   wilder#lua_fzy_highlighter(),
      \ ],
      \ 'highlights': {
      \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
      \ },
      \ }))

call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ 'left': [
      \   ' ', wilder#popupmenu_devicons(),
      \ ],
      \ 'right': [
      \   ' ', wilder#popupmenu_scrollbar(),
      \ ],
      \ }))


set termguicolors
" colorscheme witchhazel-hypercolor
" colorscheme lucid
colorscheme vale
let g:rainbow_active = 1
let g:airline_theme='base16'

let bufferline = get(g:, 'bufferline', {})
let bufferline.auto_hide = v:true
nnoremap <silent> <A-1> :BufferGoto 1<CR>
nnoremap <silent> <A-2> :BufferGoto 2<CR>
nnoremap <silent> <A-3> :BufferGoto 3<CR>
nnoremap <silent> <A-4> :BufferGoto 4<CR>
nnoremap <silent> <A-5> :BufferGoto 5<CR>
nnoremap <silent> <A-6> :BufferGoto 6<CR>
nnoremap <silent> <A-7> :BufferGoto 7<CR>
nnoremap <silent> <A-8> :BufferGoto 8<CR>
nnoremap <silent> <A-9> :BufferGoto 9<CR>

tnoremap <silent> <A-1> <C-\><C-n>:BufferGoto 1<CR>
tnoremap <silent> <A-2> <C-\><C-n>:BufferGoto 2<CR>
tnoremap <silent> <A-3> <C-\><C-n>:BufferGoto 3<CR>
tnoremap <silent> <A-4> <C-\><C-n>:BufferGoto 4<CR>
tnoremap <silent> <A-5> <C-\><C-n>:BufferGoto 5<CR>
tnoremap <silent> <A-6> <C-\><C-n>:BufferGoto 6<CR>
tnoremap <silent> <A-7> <C-\><C-n>:BufferGoto 7<CR>
tnoremap <silent> <A-8> <C-\><C-n>:BufferGoto 8<CR>
tnoremap <silent> <A-9> <C-\><C-n>:BufferGoto 9<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NvimTreeToggle' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NvimTree") && b:NERDTree.isTabTree()) | q | endif
map <M-n> :NvimTreeToggle<CR>

" go other
nnoremap go :A<CR>

nnoremap <C-f> <CMD>Telescope find_files<CR>
nnoremap <C-s> <CMD>Telescope live_grep<CR>
nnoremap <C-b> <CMD>Telescope buffers<CR>
nnoremap <C-d> <CMD>Telescope lsp_dynamic_workspace_symbols<CR>

inoremap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
snoremap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
inoremap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
snoremap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

set completeopt=menuone,noselect
" lsp
lua << EOF
require("nvim-tree").setup {
  disable_netrw = true,
  reload_on_bufenter = true,
  -- open_on_setup = true,
  update_focused_file = {
    enable = true,
  },
}

require('trouble').setup {}

local nvim_lsp = require('lspconfig')
local cmp = require('cmp')

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

cmp.setup {
  -- You can set mappings if you want
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<TAB>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },

  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  -- You should specify your *installed* sources.
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  },
--  cmp.setup.cmdline(':', {
--    mapping = cmp.mapping.preset.cmdline(),
--    sources = cmp.config.sources({
--      { name = 'path' }
--    }, {
--      { name = 'cmdline' }
--    })
--  })

}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<M-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '?', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<Leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end


nvim_lsp.omnisharp.setup {
    use_mono = true
}

require'lspconfig'.jdtls.setup{}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "rust_analyzer", "gopls", "tsserver", "clangd", "metals", "texlab", "jdtls", "gdscript" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
  }
end
EOF

