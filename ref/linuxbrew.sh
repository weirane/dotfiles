# linuxbrew settings

# go in .zshenv:
user=$USER
HOMEBREW_PREFIX="/home/$user/.linuxbrew";
HOMEBREW_CELLAR="/home/$user/.linuxbrew/Cellar";
HOMEBREW_REPOSITORY="/home/$user/.linuxbrew/Homebrew";
PATH="/home/$user/.linuxbrew/bin:/home/$user/.linuxbrew/sbin${PATH+:$PATH}";
MANPATH="/home/$user/.linuxbrew/share/man${MANPATH+:$MANPATH}:";
INFOPATH="/home/$user/.linuxbrew/share/info:${INFOPATH:-}";
unset user

# go in zshrc:
export HOMEBREW_NO_ENV_HINTS=1
alias pacman='pacaptr --using brew'
