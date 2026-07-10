#!/bin/sh

user=$(ls /home)

if [ "$DASFLAG" ]; then
    INSERT_FLAG="$DASFLAG"
    export DASFLAG=no_FLAG
    DASFLAG=no_FLAG
elif [ "$FLAG" ]; then
    INSERT_FLAG="$FLAG"
    export FLAG=no_FLAG
    FLAG=no_FLAG
elif [ "$GZCTF_FLAG" ]; then
    INSERT_FLAG="$GZCTF_FLAG"
    export GZCTF_FLAG=no_FLAG
    GZCTF_FLAG=no_FLAG
else
    INSERT_FLAG="flag{c73c9c3aafe3f967}"
fi

echo $INSERT_FLAG | tee /home/$user/flag
chmod 711 /home/ctf/attachment

/etc/init.d/xinetd start;
sleep infinity;
