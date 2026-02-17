To make twemoji the default in all apps, use  
`paru tff-twemoji`
`sudo ln -sf /usr/share/fontconfig/conf.avail/75-twemoji.conf /etc/fonts/conf.d/75-twemoji.conf`
and then
`fc-cache -fv`
