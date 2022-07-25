#!/bin/bash

set -e

USER_HOME=$(eval echo ~${SUDO_USER})
RED="\e[31m"
END_RED="\e[1m"

if [ "$EUID" -ne 0 ]
then 
  echo -e "\n${RED} Please Run as Root! ${END_RED}\n"
  exit 1
fi

# remove configs
if [[ -z $STARSHIP_CONFIG ]]
then
    rm -rf $USER_HOME/.config/starship.toml
else
    rm -rf $STARSHIP_CONFIG
fi

# remove cache
if [[ -z $STARSHIP_CACHE ]]
then
    rm -rf $USER_HOME/.cache/starship
else
    rm -rf $STARSHIP_CACHE
fi

echo -e $RED

rm -rf /usr/local/bin/starship || {
    echo -e "Failed on remove starship bin file!\n" 
}

sed -i -e '/eval "$(starship init bash)"/d' $USER_HOME/.bashrc|| { 
    echo -e "Failed on remove from Bash!\n" 
}

sed -i -e '/eval (starship init elvish)/d' $USER_HOME/.elvish/rc.elv || { 
    echo -e "Failed on remove from Elvish!\n" 
}

sed -i -e '/starship init fish | source/d' $USER_HOME/.config/fish/config.fish|| { 
    echo -e "Failed on remove from Fish!\n" 
}

sed -i -e '/eval $(starship init ion)/d' $USER_HOME/.config/ion/initrc|| { 
    echo -e "Failed on remove from Ion!\n" 
}

sed -i -e '/eval `starship init tcsh`/d' $USER_HOME/.tcshrc || { 
    echo -e "Failed on remove from Tshch!\n" 
}

sed -i -e '/execx($(starship init xonsh))/d' $USER_HOME/.xonshrc|| { 
    echo -e "Failed on remove from Xonsh!\n" 
}

sed -i -e '/eval "$(starship init zsh)"/d' $USER_HOME/.zshrc || { 
    echo -e "Failed on remove from ZSH!\n" 
}

echo -e ${END_RED}