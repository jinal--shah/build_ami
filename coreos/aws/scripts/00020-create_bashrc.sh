# .bashrc
. /etc/bash/bashrc

for script in $(ls /etc/profile.d); do
    . $script
done

for script in $HOME/.alias/* ; do
    if [ -r $script ] ; then
        . $script
    fi
done

