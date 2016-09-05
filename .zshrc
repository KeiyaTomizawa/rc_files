# Search path for the cd command
#if [ -z ${ZLOGIN:=} ];
#then
#  source ${ZDOTDIR}/.zlogin
#fi
export ZDOTDIR=/home/${USER}/.zsh
export DISPLAY=localhost:0.0
export LANG=ja_JP.UTF-8

cdpath=(.. ~ )

# Use hard limits, except for a smaller stack and no core dumps
unlimit
#limit stack 8192
limit -s

#umask 022

# Set up aliases
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir

alias grep='grep --color'

#alias po=popd
alias ll='ls -l'
alias la='ls -a'
alias sl='ls'
#alias pdflatex='pdflatex test$1 ; pdfcrop -m 5 test$1 test$1'
#alias pdflatex='pdflatex test$1 ; pdfcrop -m 5 test$1 test$1'
alias gd='dirs -v; echo -n "select number: "; read newdir; cd -"$newdir"'
pdf() { 
 if [ $1 = "-c" ];
 then
  pdflatex $2 ; pdfcrop -m 5 `echo $2 | cut -d '.' -f 1`.pdf `echo $2 | cut -d '.' -f 1`.pdf  ;convert -density 500 -alpha off -trim -transparent white `echo $2 | cut -d '.' -f 1`.pdf `echo $2 | cut -d '.' -f 1`.png 
 elif [ $1 = "-e" ];
 then
 pdflatex $2 ; pdfcrop -m 5 `echo $2 | cut -d '.' -f 1`.pdf `echo $2 | cut -d '.' -f 1`.pdf  ;pdftops `echo $2 | cut -d '.' -f 1`.pdf `echo $2 | cut -d '.' -f 1`.eps
 elif [ $1 = "-a" ];
 then
  pdflatex $2 ; pdfcrop -m 5 `echo $2 | cut -d '.' -f 1`.pdf `echo $2 | cut -d '.' -f 1`.pdf  ;convert -density 500 -alpha off -trim -transparent white `echo $2 | cut -d '.' -f 1`.pdf `echo $2 | cut -d '.' -f 1`.png ;apvlv `echo $2 | cut -d '.' -f 1`.pdf
 else
 pdflatex $1 ; pdfcrop -m 5 `echo $1 | cut -d '.' -f 1`.pdf `echo $1 | cut -d '.' -f 1`.pdf  ; 
  fi
 }
#screen shared dir
#alias sd='selector dirref; [[ $? -eq 0 ]] && echo -n "select number: "; read newdir; cd `selector dirref $newdir`'
#alias xs='selector forward_x; [[ $? -eq 0 ]] && echo -n "select number: "; read x; export DISPLAY=`selector forward_x $x`'


export LSCOLORS=ExGxFxdxBxDxDxBxBxExEx
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;31:*.tar=01;31:*.tar.gz=01;31:*.pdf=01;32:*.eps=01;33:*.eps2=01;33'
if [ -x `where dircolors` ] && [ -e ${ZDOTDIR}/.dircolors ]; then
  eval `dircolors ${ZDOTDIR}/.dircolors` 
fi
alias lscolor='ls -F --color=always --show-control-char'
alias ls='ls -F --color=always --show-control-char'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
if [ -n ${TERM:=} ];
then
  case $TERM in
    rxvt-unicode)
    TERM=xterm
    ;;
  esac
fi

#### time
REPORTTIME=4
TIMEFMT="\
    The name of this job.             :%J
    CPU seconds spent in user mode.   :%U
    CPU seconds spent in kernel mode. :%S
    Elapsed time in seconds.          :%E
    The  CPU percentage.              :%P
    The maximum memory useage         :%M Kb"



# Global aliases -- These do not have to be
# at the beginning of the command line.
#alias -g M='|more'
#alias -g H='|head'
#alias -g T='|tail'
alias -g RE='| sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'

#manpath=($X11HOME/man /usr/man /usr/lang/man /usr/local/man /usr/share/man)
#export MANPATH
#
# Set prompts
setopt prompt_subst
PROMPT='%{%(?.%{[01;32m%}.%{[01;31m%})%}%m%{[m%}%# '    # default prompt
RPROMPT='%{[01;34m%}%~%{[m%} %t'     # prompt for right side of screen
#RPROMPT='`~/.tools/apm.pl`[%t]'     # prompt for right side of screen

# Some environment variables
#export MAIL=/var/spool/mail/$USERNAME
#export LESS=-cex3M
export GREPOPTIONS=--color
#export HELPDIR=/usr/local/lib/zsh/help  # directory for run-help function to find docs

#MAILCHECK=300
HISTFILE="${ZDOTDIR}/zhistory"
HISTSIZE=10000
SAVEHIST=10000
setopt extended_history         # コマンドの開始時刻と経過時間を登録
setopt hist_ignore_dups         # 直前のコマンドと同一ならば登録しない
setopt hist_ignore_all_dups     # 登録済コマンド行は古い方を削除
setopt hist_reduce_blanks # 余分な空白は詰めて登録(空白数違い登録を防ぐ)
#setopt append_history  # zsh を終了させた順にファイルに記録(デフォルト)
#setopt inc_append_history # 同上、ただしコマンドを入力した時点で記録
setopt share_history    # ヒストリの共有。(append系と異なり再読み込み不要、これを設定すれば append 系は不要)
setopt hist_no_store            # historyコマンドは登録しない
setopt hist_ignore_space # コマンド行先頭が空白の時登録しない(直後ならば呼べる)

DIRSTACKSIZE=20

setopt list_packed              # 補完候補リストを詰めて表示
setopt print_eight_bit          # 補完候補リストの日本語を適正表示
#setopt menu_complete  # 1回目のTAB で補完候補を挿入。表示だけの方が好き
setopt no_clobber               # 上書きリダイレクトの禁止
setopt no_unset                 # 未定義変数の使用の禁止
setopt no_hup                   # logout時にバックグラウンドジョブを kill しない
setopt no_beep                  # コマンド入力エラーでBEEPを鳴らさない

setopt extended_glob            # 拡張グロブ
setopt numeric_glob_sort        # 数字を数値と解釈して昇順ソートで出力
setopt auto_cd                  # 第1引数がディレクトリだと cd を補完
setopt correct                  # スペルミス補完
setopt no_checkjobs             # exit 時にバックグラウンドジョブを確認しない
setopt ignore_eof              # C-dでlogoutしない(C-dを補完で使う人用)
setopt pushd_to_home        # 引数なしpushdで$HOMEに戻る(直前dirへは cd - で)
setopt pushd_ignore_dups        # ディレクトリスタックに重複する物は古い方を削除
#setopt pushd_silent   # pushd, popd の度にディレクトリスタックの中身を表示しない
setopt interactive_comments     # コマンド入力中のコメントを認める
#setopt rm_star_silent          # rm * で本当に良いか聞かずに実行
#setopt rm_star_wait            # rm * の時に 10秒間何もしない
#setopt chase_links             # リンク先のパスに変換してから実行。


# Watch for my friends
#watch=( $(<~/.friends) )       # watch for people in .friends file
#watch=(notme)                   # watch for everybody but me
#LOGCHECK=300                    # check every 5 min for login/logout activity
#WATCHFMT='%n %a %l from %m at %t.'

# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   automenu
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

## Autoload zsh modules when they are referenced
#zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -a zsh/mapfile mapfile
# Some nice key bindings
#bindkey '^X^Z' universal-argument ' ' magic-space
#bindkey '^X^A' vi-find-prev-char-skip
#bindkey '^Xa' _expand_alias
#bindkey '^Z' accept-and-hold
#bindkey -s '\M-/' \\\\
#bindkey -s '\M-=' \|

#bindkey -v               # vi key bindings
bindkey -e                 # emacs key bindings
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
bindkey '^P' history-beginning-search-backward # 先頭マッチのヒストリサーチ
bindkey '^N' history-beginning-search-forward # 先頭マッチのヒストリサーチ
bindkey '^V' history-incremental-search-forward

#function------------------------------------------------------
typeset -U path
typeset -U cdpath
typeset -U fpath
typeset -U manpath
typeset -U hosts
typeset -U known_hosts
#typeset -U path cdpath fpath manpath hosts known_hosts
# Setup new style completion system. To see examples of the old style (compctl
# based) programmable completion, check Misc/compctl-examples in the zsh
# distribution.
autoload -U compinit
compinit -u

autoload -U promptinit
promptinit;
zstyle ':completion::complete:*' use-cache 1

autoload -U colors
colors
zstyle ':completion:*:processes' command 'ps x'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
# compdef _tex platex             # platex に .tex を
# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)


zmodload -i zsh/complist
#autoload -U zsh/complist
zstyle ':completion:*:default' menu select=1
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

global-alias-space () { zle _expand_alias; zle .self-insert }
zle -N global-alias-space
bindkey ' ' global-alias-space
zstyle :completion:\* regular false

#bindkey -s " " '^Xa^V '
export PYTHONHISTORY=~/.pyhistory
export PYTHONSTARTUP=~/.pystartup

#path=($path /opt/tafsm/bin/)
#export PYTHONPATH="/usr/projects/lib64/python2.7/site-packages" 
#path=($path /opt/tafsm/bin/)
#path=($path /cygdrive/c/Program\ Files/MongoDB/Server/3.2/bin  )
#export PYTHONPATH="/opt/tafsm/lib64/python2.7/site-packages" 
#./Xming.exe :0 -clipboard -notrayicon -c -multiwindow -reset -logverbose 0 &
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/mongodb-win32-x86_64-enterprise-windows-64-3.2.9/bin:$PATH"
#alias docker='/usr/local/bin/console.exe docker'
