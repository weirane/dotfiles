# linuxbrew settings

# go in .zshenv:
user=$USER
HOMEBREW_PREFIX="/home/$user/homebrew";
HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew";
PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin${PATH+:$PATH}";
MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}:";
INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}";
unset user

# go in zshrc:
export HOMEBREW_NO_ENV_HINTS=1
alias pacman='pacaptr --using brew'
