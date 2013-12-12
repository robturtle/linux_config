# The following lines are imported from .bashrc
#
# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# colors
eval $(dircolors)

# End of lines imported from .bashrc

#######################################################
# All about auto completion
#######################################################
# The following lines were added by compinstall
autoload -U  zutil
autoload -Uz compinit
autoload -U  complist
compinit
# End of lines added by compinstall

# Resource files
for file in $HOME/.zsh/rc/*.rc; do
	source $file
done
