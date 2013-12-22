DIR=${HOME}/.dwm
if [ -f "${DIR}"/dwmrc ]; then
	/bin/sh "${DIR}"/dwmrc &
else
	while true; do
		xsetroot -name "`date`"
		sleep 1
	done &
fi

# Key mapping
xmodmap ${HOME}/.Xmodmap

export XMODIFIERS='@im=fcitx'
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
(sleep 5 && exec fcitx) &

(sleep 5 && start-pulseaudio-x11) &                                 # audio control
(sleep 5 && /home/jeremy/bin/hdmibrightness.sh 0.6) &               # adjust backlight of hdmi monitor
(sleep 5 && /home/jeremy/bin/lowerbrightness.A550.sh) &             # adjust backlight of laptop monitor
(sleep 5 && uxterm -title proxy -e "/home/jeremy/bin/goagent.sh") & # start goagent proxy
(sleep 6 && google-chrome) &                                        # start chrome
#(sleep 7 && google-chrome --new-window http://fm.baidu.com) &       # start music webpage FIXME is not work
(sleep 7 && workflowy.sh) &                                         # chrome extension WorkFlowy
(sleep 5 && uxterm) &                                               # the first tag is for terminal

exec ck-launch-session dbus-launch --sh-syntax --exit-with-session /usr/bin/dwm # Enable ConsoleKit support
