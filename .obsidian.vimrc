" ========== 基本設定 ==========
" システムクリップボードを使う（VSCode: vim.useSystemClipboard）
set clipboard=unnamedplus

" 空白可視化（VSCode: editor.renderWhitespace = all）
set list
set listchars=tab:»\ ,trail:·,nbsp:␣,extends:>,precedes:<,space:·

" リーダーキー（VSCode: vim.leader = <space>）
let mapleader = " "

" 検索強調（VSCode: vim.hlsearch）
set hlsearch

" ビジュアルスター（VSCode: vim.visualstar）
set visualstar


" ========== EasyMotion ==========
" VSCode: vim.easymotion = true
" → Vim/Neovim ではプラグインを使います（例：easymotion/vim-easymotion）
"   Lazy 例: { 'easymotion/vim-easymotion' }
"   vim-plug 例: Plug 'easymotion/vim-easymotion'
" VSCode の「s → <leader><leader> 2 s <char><char>」に相当
" 2文字ジャンプ（現在ウィンドウ）
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap s <Plug>(easymotion-s2)


" ========== ノーマルモードのマッピング（NonRecursive） ==========
" Leader+d: 定義へ移動（VSCode: editor.action.goToDeclaration）
nnoremap <leader>d gd

" Leader+b: 戻る（VSCode: workbench.action.navigateBack）
nnoremap <leader>b <C-o>

" Leader+h: ホバー（VSCode: editor.action.showHover）
" LSP 使用時は 'K' が一般的。K を呼ぶ/同等に。
nnoremap <leader>h K

" u / <C-r>: 既定で undo/redo のため明示マップは不要（参考）
" nnoremap u u
" nnoremap <C-r> <C-r>

" x: 1文字削除をクリップボードに送らない（VSCode設定相当）
" unnamedplus 有効時でも黒穴レジスタに捨てる
nnoremap x "_x

" 行折返し対応（j/k を gj/gk に）
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

" 検索移動時に画面中央へ（n/N/*/#）
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" Leader+c: 行コメントトグル（VSCode: editor.action.commentLine）
" → Vim はプラグインが必要（例：tpope/vim-commentary なら :Commentary）
"   commentary 使用例:
"     vim-plug: Plug 'tpope/vim-commentary'
"     行トグル: :Commentary / ノーマルなら gcc
" 以下は commentary を呼ぶ例
nnoremap <leader>c :Commentary<CR>

" Leader+l: 行末へ
nnoremap <leader>l $

" （VSCode設定では一部コメントアウトされてたが）Leader+h: 行頭へ
nnoremap <leader>h ^

" Leader+]: 対応括弧へ（%）
nnoremap <leader>] %

" Leader+z: 検索ハイライト消去（VSCode: :noh）
nnoremap <leader>z :nohlsearch<CR>


" ========== インサートモードのマッピング（NonRecursive） ==========
" jj でインサートモード終了
inoremap jj <Esc>

" ;; で補完を出す（VSCode: editor.action.triggerSuggest）
" Neovim LSP/omnifunc 前提なら <C-x><C-o>、メニュー補完なら <C-n> を併用
" まずは omnicompletion を呼ぶ例（環境に合わせて変更してください）
inoremap ;; <C-x><C-o>


" ========== ビジュアルモードのマッピング（NonRecursive） ==========
" Leader+l: 行末へ
xnoremap <leader>l $

" Leader+h: 行頭へ
xnoremap <leader>h ^

" Leader+m: 対応括弧へ
xnoremap <leader>m %
