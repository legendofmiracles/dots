feh "https://images.unsplash.com/photo-1431440869543-efaf3388c585?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1350&q=80" --bg-fill &
dunst &
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
xss-lock --transfer-sleep-lock -- lock --nofork &
# /home/legend/bin/gaming_stop.sh &
bash -c "sleep 1; polybar.sh" &

# activity watch
aw-server-rust
aw-watcher-afk
aw-watcher-window

exec ~/WM/target/release/WM &> penrose.log # $(echo i3\n~/WM/target/release/WM &> penrose.log | fzf)
#exec i3
