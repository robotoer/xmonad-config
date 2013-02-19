xmonad-config
=============

My xmonad configuration. To use this configuration:
```bash
cd ~
[ -x .xmonad ] && mv .xmonad .xmonad.old
git clone git@github.com:robotoer/xmonad-config.git .xmonad
[ -x ~/bin ] && mkdir ~/bin

# Adds the following keybindings:
#   <Super-Up> as volume up
#   <Super-Down> as volume down
ln -s ~/.xmonad/scripts/volume ~/bin/volume
```
Then press Mod-q to apply the configuration.
