#Credits: Diego Rivera (diego.rivera@montimage.com)

gsetfunction()
{
   if [ ! -d ~/.go ]; then
       mkdir ~/.go;
   fi
   echo "$(pwd)" > ~/.go/$1
}

gofunction()
{
   if [ ! -e ~/.go/$1 ]; then
       echo "Entry not found!"
   else
       cd "$(cat ~/.go/$1)"
   fi
}

gunsetfunction()
{
   if [ ! -e ~/.go/$1 ]; then
      echo "Entry not found!"
   else
      rm -f ~/.go/$1
   fi
}

_go()
{
   local cur
   local dir
   local results

   COMPREPLY=()

   cur=${COMP_WORDS[COMP_CWORD]}
   results=""
   dir=~/.go/*

   for entry in $dir
   do
      results=$results$IFS${entry#~/.go/}
   done

   COMPREPLY=($(compgen -W "$results" -- ${cur}))
}

# "GO" command aliases
alias go='gofunction'
alias gset='gsetfunction'
alias gunset='gunsetfunction'
alias gls='ls ~/.go/'

# Autocompletion for "GO" commands
complete -F _go gunset
complete -F _go go