export PYTHONPATH=$(pwd)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# >>> pyenv >>>
# mpsエラーの対処
export PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0
# >>> zshカスタム >>>

export PATH=$HOME/command:$PATH
# git-promptの読み込み
source ~/.zsh/completion/git-prompt.sh

# git-completionの読み込み
fpath=(~/.zsh/completion $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/completion/git-completion.bash
autoload -Uz compinit && compinit

# プロンプトのオプション表示設定
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

# git ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  local branch_name st branch_status

  branch='\ue0a0'
  color='%{\e[38;5;' #  文字色を設定
  green='114m%}'
  red='001m%}'
  yellow='227m%}'
  blue='033m%}'
  reset='%{\e[0m%}'   # reset

  color='%{\e[38;5;' #  文字色を設定
  green='114m%}'

  # ブランチマーク
  if [ ! -e  ".git" ]; then
    # git 管理されていないディレクトリは何も返さない
    return
  fi
    branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
    st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全て commit されてクリーンな状態
    branch_status="${color}${green}${branch}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # git 管理されていないファイルがある状態
    branch_status="${color}${red}${branch}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git add されていないファイルがある状態
    branch_status="${color}${red}${branch}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commit されていないファイルがある状態
    branch_status="${color}${yellow}${branch}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "${color}${red}${branch}!(no branch)${reset}"
    return
  else
    # 上記以外の状態の場合
    branch_status="${color}${blue}${branch}"
  fi

  # ブランチ名を色付きで表示する
  echo "(${branch_status}$branch_name${reset})"
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# プロンプトの右側(RPROMPT)にメソッドの結果を表示させる
# PROMPT='`rprompt-git-current-branch`'
# PROMPT='%F{cyan}%~%f `rprompt-git-current-branch`
# \$ '

function git-current-branch {
  local branch_name
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  if [ -n "$branch_name" ]; then
    echo "%B%F{29}◀%f%K{29}%F{15} $branch_name %f%k%b"
  fi
}

setopt prompt_subst
# RPROMPT='%F{99}%D{%H:%M:%S}%f'
PROMPT='%F{33}%~%f `git-current-branch`
\$ '

# 環境変数
export LANG=ja_JP.UTF-8

# 色を使用出来るようにする
autoload -Uz colors
colors

export CLICOLOR=1

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 改変箇所_1
# 時間表記の追加
setopt extended_history
alias history='history -t "%F %T"'

# プロンプト
# 1行表示
# PROMPT="%~ %# "

# PROMPT="%{${fg[blue]}%}%n:%{${reset_color}%} %c/ %# "
# 2行表示
# PROMPT="%{${reset_color}%}%~ %F{red}$(__git_ps1 "(%s)")%f
# \$ "

# 出力の後に改行を入れる
function add_line {
  if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    printf '\n'
  fi
}
PROMPT_COMMAND='add_line'

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

########################################
# >>> zshカスタム >>>

#alias
# alias sed='gsed'
alias ll='ls -logG'
alias ls='ls -logG'
alias cl='clear'
alias br='git branch'
alias brd='git branch -d $1'
alias st='git status'
alias co='git checkout $1'
alias add='git add $1'
alias cm='git commit -m ''$1'''
alias dj='python manage.py $1'export PATH="/usr/local/opt/openjdk@17/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


function chpwd() {
    if [ -d .venv ]; then
        source .venv/bin/activate
    fi
    if [ -d venv ]; then
        source .venv/bin/activate
    fi
}

function zipwin ()
{
  if [ -z $1 ] || [ $1 = . ]; then
    # 現在の作業ディレクトリをZIPファイルに圧縮する．
    local zip_name="$(basename $(pwd)).zip"
    fd --type file --strip-cwd-prefix . -X 7z a -tzip -scsWIN $zip_name {}
  else
    # 指定したディレクトリをZIPファイルに圧縮する．
    local loc_dir=$(dirname $1)
    local target=$(basename $1)
    local zip_name="$(pwd)/${target}.zip"
    fd --type file --base-directory=$loc_dir . $target -X 7z a -tzip -scsWIN $zip_name {}
  fi

  # 作成したZIPファイルに含まれるファイルを確認する．不要であればコメントアウトしてください．
  7z l $zip_name

  return 0
}
