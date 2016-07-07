# .bashrc
. /usr/share/skel/.bashrc

# ... source our alias files
dir_aliases=$HOME/.alias
if [[ -d $dir_aliases ]]; then
    for script in $(ls -1 $dir_aliases); do
        . $dir_aliases/$script
    done
fi

# ... source any profile files
dir_profiles=/etc/profile.d
if [[ -d $dir_aliases ]]; then
    for script in $(ls -1 $dir_profiles); do
        . $dir_profiles/$script
    done
fi

export PATH=$PATH:$HOME/bin
