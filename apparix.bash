#!/bin/sh
#  BASH-style functions
#
#  Name this file for example .apparix.bash in your $HOME directory
#  and put the line 'source $HOME/.apparix.bash' (without quotes)
#  in the file $HOME/.bashrc.
#  If you use the relevant functions, make sure $EDITOR is set
#  to the name of an available editor.


function toot () {
   if test "$3"; then
      file="$(apparix -favour rOl "$1" "$2")/$3"
   elif test "$2"; then
      file="$(apparix -favour rOl "$1")/$2"
   else
      echo "toot tag dir file OR toot tag file"
      return
   fi
   if [[ $? == 0 ]]; then
      $EDITOR $file
   fi
}

function annot () {
   toot $@ ANNOT
}

function todo () {
   toot $@ TODO
}

function clog () {
   toot $@ ChangeLog
}

function note () {
   toot $@ NOTES
}

function ald () {
  if test "$2"; then
    loc=$(apparix -favour rOl "$1" "$2")
  elif test "$1"; then
    loc=$(apparix --try-current-first -favour rOl "$1")
  fi
  if [[ $? == 0 ]]; then
    ls "$loc"
  fi
}

function als () {
  loc=$(apparix -favour rOl "$1")
  if test "$1"; then
    loc=$(apparix -favour rOl "$1")
  fi
  if [[ $? == 0 ]]; then
     if test "$2"; then
       ls -l "$loc"/$2
    else
       ls -l "$loc"
    fi
  fi
}

function ae () {
  if test "$2"; then
    loc=$(apparix -favour rOl "$1" "$2")
  elif test "$1"; then
    loc=$(apparix --try-current-first -favour rOl "$1")
  fi
  if [[ $? == 0 ]]; then
    files=$(ls $loc)
    if [[ $? == 0 ]]; then
       $EDITOR $files
    else
      echo "no listing for $loc"
    fi
  fi
}

function whence () {
  if test "$2"; then
    loc=$(apparix -pick $2 "$1")
  elif test "$1"; then
   loc=$(apparix "$1")
  else
    loc=$HOME
  fi
  if [[ $? == 0 ]]; then
    cd "$loc"
  fi
}


function to () {
  true
  if test "$2"; then
    loc=$(apparix --try-current-last -favour rOl "$1" "$2")
  elif test "$1"; then
    if test "$1" == '-'; then
      loc="-"
    else
      loc=$(apparix --try-current-last -favour rOl "$1")
    fi
  else
    loc=$HOME
  fi
  if [[ $? == 0 ]]; then
    cd "$loc"
    ls -l
  fi
}

function bm () {
  if test "$2"; then
    apparix --add-mark "$1" "$2";
  elif test "$1"; then
    apparix --add-mark "$1";
  else
    apparix --add-mark;
  fi
}
function portal () {
  if test "$1"; then
    apparix --add-portal "$1";
  else
    apparix --add-portal;
  fi
}
# function to generate list of completions from .apparixrc
function _apparix_aliases ()
{ cur=$2
  dir=$3
  COMPREPLY=()
  nullglobsa=$(shopt -p nullglob)
  shopt -s nullglob
  if let $(($COMP_CWORD == 1)); then
    #get words from bookmars list
    local words=$( cat $HOME/.apparix{rc,expand} | grep "\<j," | cut -f2 -d, )
    #without tree command, string is empty, preview-window is hidden
    #eval: for executing inner string command '..'
    #tree: input third column (directory), level one, force colors
    type tree &> /dev/null && local cmd_tree="eval 'tree {3} -L 1 -C | head -100'"
    #trigger fzf if it's available
    if [ -z "$cur" ] && type fzf &> /dev/null; then
        #fzf: --wit-nth show only second and third column (first is 'j')
        #fzf: --nth=1 limits search only on first displayed column
        #postprocess: trim repeated whitespace then cut to return only second column (bookmark)
        words=$(cat $HOME/.apparix{rc,expand} | column -s ',' -t |
                fzf --with-nth=2,3 --nth=1 --preview="$cmd_tree" |
                tr -s ' ' | cut -d ' ' -f2)
    fi
    #filter words based on cursor
    words=$( compgen  -W "$words" -- $cur )
    #add words with extra space at the end into completion array
    for w in $words; do COMPREPLY+=( "$w " ); done
  else
    # now dir=<apparix mark> and cur=<subdirectory-of-mark> (completing on this)
    # or cur=<fileordir> (when bound for example to ae)
    dir=`apparix --try-current-last -favour rOl $dir 2>/dev/null` || return 0
    eval_compreply="COMPREPLY=( $(
      #check existence before cd
      [[ ! -d "$dir" ]] && return || cd "$dir"
      \ls -d $cur* | while read r
      do
        #feed name to array if only it matches subpath
        if [[ "$r" == *$cur* ]]; then
            #complete directory with suffix '/'
            if [[ -d "$r" ]]; then
                echo \"${r// /\\ }\/\"
            #complete filenames without suffix
            elif [[ $1 == 'ae' || $1 == 'als' ]]; then
                echo \"${r// /\\ }\"
            fi
        fi
      done
    ) )"
  eval $eval_compreply
  fi
  $nullglobsa
  return 0
}


# command to register the above to expand when the 'to' command's args are
# being expanded
complete -o nospace -F _apparix_aliases to
complete -o nospace -F _apparix_aliases ald
complete -o nospace -F _apparix_aliases als
complete -o nospace -F _apparix_aliases ae

export APPARIXLOG=$HOME/.apparixlog

alias via='vi $HOME/.apparixrc'

alias now='cd $(a now)'
