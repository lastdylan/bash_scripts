export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_121.jdk/Contents/Home
export PATH=$HOME/bin:/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:$HOME/.local/bin
# export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'
alias pdflatex='pdflatex -synctex=1 -interaction=nonstopmode'
alias py36='source activate py36'

export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"
export MANPATH="/opt/local/share/man:$MANPATH"

# The various escape codes that we can use to color our prompt.
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[1;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[1;34m\]"
     PURPLE="\[\033[0;35m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

# determine git branch name
function parse_git_branch(){
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# determine mercurial branch name
function parse_hg_branch(){
  hg branch 2> /dev/null | awk '{print " (" $1 ")"}'
}

# Determine the branch/state information for this git repository.
function set_git_branch() {
  # Get the name of the branch.
  branch=$(parse_git_branch)
  # if not git then maybe mercurial
  if [ "$branch" == "" ]
  then
    branch=$(parse_hg_branch)
  fi

  # Set the final branch string.
  BRANCH="${PURPLE}${branch}${COLOR_NONE} "
}

# Return the prompt symbol to use, colorized based on the return value of the
# previous command.
function set_prompt_symbol () {
  if test $1 -eq 0 ; then
      PROMPT_SYMBOL="\$"
  else
      PROMPT_SYMBOL="${LIGHT_RED}\$${COLOR_NONE}"
  fi
}

# Determine active Python virtualenv details.
function set_virtualenv () {
  if test -z "$CONDA_DEFAULT_ENV" ; then
      PYTHON_VIRTUALENV=""
  else
      PYTHON_VIRTUALENV="${BLUE}[`basename \"$CONDA_DEFAULT_ENV\"`]${COLOR_NONE} "
fi
}

# Set the full bash prompt.
function set_bash_prompt () {
  # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
  # return value of the last command.
  set_prompt_symbol $?

  # Set the PYTHON_VIRTUALENV variable.
  set_virtualenv

  # Set the BRANCH variable.
  set_git_branch

  # Set the bash prompt variable.
  PS1="
${PYTHON_VIRTUALENV}${GREEN}\u@\h${COLOR_NONE}:${YELLOW}\w${COLOR_NONE}${BRANCH}
${PROMPT_SYMBOL} "
}

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
# added by Anaconda3 5.3.0 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/last.feremenga/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/Users/last.feremenga/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/last.feremenga/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/Users/last.feremenga/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
