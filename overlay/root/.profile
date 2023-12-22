#
# .profile, started at boot from root user
# 

# wayland
if [ -f /usr/bin/weston ]; then
	mkdir -p /tmp/.xdg &&  chmod 0700 /tmp/.xdg
	export XDG_RUNTIME_DIR=/tmp/.xdg
	weston --tty=2 --idle-time=0&
fi
