# Filename: tmux_restore_session.sh
# Author:   LIU Yang
# Create Time: Tue Mar 18 13:19:16 CST 2014
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com
# Brief: Create and attach to a tmux session if it's not exists
#        Otherwise just attach to it
SNAME="$1"
tmux has-sesstion -t "$SNAME" &>/dev/null

if [ $? != 0 ]; then
    tmux new-sesstion -s "$SNAME"
    #tmux send-keys -t "$SNAME" ...
fi

tmux attach -t "$SNAME"
