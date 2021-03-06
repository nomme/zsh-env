#source /etc/profile
export prompt_color="$fg_green"
export TERM=dtterm
export TERMINFO=/home/jhogklin/.terminfo
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/jhogklin/local/temp/lib:/usr/local/lib:/home/jhogklin/local/lib
export DISPLAY="`echo $SSH_CONNECTION | awk '{print $1}'`:0.0"
export PATH=/home/jhogklin/local/gcc/bin:"${PATH}"
tmuxsession=`tmux list-panes -F "#S"`

export CURRENTPROJ="TCC_ER_BV_SW"
#export TMUXCOLOR="red"
if [[ $tmuxsession == bv* ]]
then
  export CURRENTPROJ="TCC_ER_BV_SW"
 # export TMUXCOLOR="red"
elif [[ $tmuxsession == kaz* ]]
then
 # export TMUXCOLOR="cyan"
  export CURRENTPROJ="TCC_ER_CIS_SW"
fi

##################
# Functions
##################
extended_rprompt()
{
  echo " ${BLUE}[${RED}$CURRENTPROJ${BLUE}]${NORM}"
}

kaz()
{
  export CURRENTPROJ="TCC_ER_CIS_SW"
}
bv()
{
  export CURRENTPROJ="TCC_ER_BV_SW"
}
gp()
{
  export CURRENTPROJ="TCC_SW"
}
vf()
{
  vim -p `find $2 -name $1`
}

f()
{
  if [ -z `echo "$1" | grep -E "^-"` ];
  then
    flag=""
    search=$1
    dir=$2
  else
    flag=$1
    search=$2
    dir=$3
  fi

  if [ -z $dir ];
  then
    dir="$HOME/$CURRENTPROJ"
  fi

  if [ -z `echo "$dir" | grep -E "/$"` ];
  then
    dir="$dir/"
  fi

  if [ -z $flag ];
  then
    flag=$3
  fi

  grep --color=auto $flag $search `find $dir -name \*.cpp -o -name \*.hpp | grep -viE "test\..pp" | grep -viE "stub\..pp" | xargs`
}

udpsend()
{
  java -cp ~/local/bin udpsend 10.160.154.153 10560 $1
}

man()
{
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
      man "$@"
}

gml()
{
  dir=`pwd | sed 's/\/home\/jhogklin/\$HOME\/solhome/'`
  ssh gbguxs21 "source /etc/profile && cd "$dir" && gmake -j8 NO_OPTIMIZATION=Y"
}

gitupdate()
{
  proj="$HOME/$CURRENTPROJ"
  pushd "$proj/Implementation/TCC_SW"
  git pull
  popd

  pushd "$proj"
  git pull
  git submodule update
  popd
}
##################
# End Functions
##################

alias cgrep='grep --color=always'
alias gm='gmake -j12 NO_OPTIMIZATION=Y'
alias gstub='gmake stub_targets -j12 NO_OPTIMIZATION=Y'
alias runctags='~/local/bin/ctags -R --exclude="*test*" --exclude="*[Ss]tub*" --exclude="*ctcif*" --exclude="*include*"'
alias trim='grep -vi test | grep -vi stub | grep -vi tcov'
alias mt='~/local/Tools/Scripts/build_test.sh'
alias rg='grep -rI --color=auto'
alias myps='ps -leaf | grep jhogklin'
alias level='ps -o comm $PID | grep zsh | wc -l'
alias zsh='/home/jhogklin/local/zsh/bin/zsh'

# navigation
alias c='cd $HOME/$CURRENTPROJ/Implementation/TCC_SW'
alias a='cd $HOME/$CURRENTPROJ'
alias r='cd $HOME/$CURRENTPROJ/**/CBR3/Implementation/source'
alias et='cd $HOME/$CURRENTPROJ/**/CBR3/Implementation/source/InterfaceSpecific/ETCS'
alias i='cd $HOME/$CURRENTPROJ/**/CBI3/Implementation/source'
alias gpu='cd $HOME/$CURRENTPROJ/**/GPU3/Implementation/source'
alias tmp='cd $HOME/$CURRENTPROJ/**/TMP/Implementation/source'
alias cacore='cd $HOME/$CURRENTPROJ/**/CA/Implementation/source'
alias ila='cd $HOME/$CURRENTPROJ/Implementation/ILA*/Implementation/source'
alias rba='cd $HOME/$CURRENTPROJ/Implementation/RBA*/Implementation/source'
alias tm='cd $HOME/$CURRENTPROJ/Implementation/TM*/Implementation/source'
alias ca='cd $HOME/$CURRENTPROJ/Implementation/CA*/Implementation/source'

# tmux alias
alias kaz1='Runtmuxinit.sh kaz1'
alias kaz2='Runtmuxinit.sh kaz2'
alias bv1='Runtmuxinit.sh bv1'
alias bv2='Runtmuxinit.sh bv2'
