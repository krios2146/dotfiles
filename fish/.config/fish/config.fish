set -g fish_key_bindings fish_vi_key_bindings
set -g fish_greeting

if test -z "$WAYLAND_DISPLAY" && test (tty) = "/dev/tty1"
    exec dbus-run-session ~/.local/bin/start-niri-session
end
