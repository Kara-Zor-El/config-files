alias ls='lsd --icon --color=always --group-directories-first'
alias cat='bat'
alias man='batman'

alias ff="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' --layout=reverse"
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
alias mcc="mono /home/kara/Dev/mcc/MinecraftClient.exe"
alias cp='cpg -g'
alias mv='mvg -g'
alias icat='kitty +kitten icat'
alias youtube-dl='yt-dlp'
alias yt-dl='yt-dlp'
alias goto='pushd'
alias goback='popd'
alias fix='fuck'
alias myip='curl http://ipecho.net/plain; echo'
alias weather='curl wttr.in/Toronto\?1nq'
alias vim='nvim'
# alias top='btm'
# alias htop='btm'
alias top='btop'
alias htop='btop'
alias copydir='copypath'
alias lf="ls -la | grep "
alias ssh="kitty +kitten ssh"
alias update-git="yay -S $(yay -Qq | grep -Ee '-(bzr|cvs|darcs|git|hg|svn)$' | tr '\n' ' ' | sed 's/binutils-git//' | sed 's/appmenu-gtk-module-git//')"
alias ...="../../"
alias optipng="oxipng"
# alias slurp="slurp -b \#282A36AA -c \#BD93F9"

function wiki () {
  w3m $(wikit $@ --link | tail -n1)
}

# export XDG_CURRENT_DESKTOP=sway

# Extract files
function extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.tar.xz)    tar xf $1   ;;
           *.bz2)       bzip2 -d $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *.msi)       basename $1 | sed 's/\.[^.]*$//' | xargs mkdir && msiextract $1 -C ./$(basename $1 | sed 's/\.[^.]*$//')     ;;
           *.deb)       mkdir ./$(basename $1 | sed 's/\.[^.]*$//') && dpkg-deb --extract $1 ./$(basename $1 | sed 's/\.[^.]*$//')    ;;
	         *.xz)	      unxz -v $1	;;
           *.img)       7z x $1  ;;
           *.lz)        lzip -d $1  ;;
           *.lzo)       lzop -d $1  ;;
           *.lzop)      lzop -d $1  ;;
           *.lzma)      xz --decompress $1  ;;
           *.lz4)       lz4 --decompress $1 ;;
           *.cpio)      mv $1 $1.temp && mkdir $1 && cpio -idv -D $1 < $1.temp && rm -rf $1.temp  ;;
           *.ar)        ar -x $1  ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

 function wordFrequency() {
   awk '
   BEGIN { "FS=[^a-zA-Z]+" } {
      for (i=1; i<=NF; i++) {
        word = tolower($i)
        words[word]++
      }
    } END {
    for (w in words)
      printf("%3d %s\n", words[w], w)
    } ' | sort -rn | head -n -25
 }

 countdown() {
    start="$(( $(date +%s) + $1))"
    while [ "$start" -ge $(date +%s) ]; do
        ## Is this more than 24h away?
        days="$(($(($(( $start - $(date +%s) )) * 1 )) / 86400))"
        time="$(( $start - `date +%s` ))"
        printf '%s day(s) and %s\r' "$days" "$(date -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
    done
}
