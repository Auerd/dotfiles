wdir=$(CDPATH="" cd -- "$(dirname -- "$0")" && pwd -P)
clearver=$(/bin/sh "$wdir/openglver.sh" | sed "s/\.//")
noglxpicom=${XDG_CONFIG_HOME:-$HOME/.config}/noglxpicom.conf

if [[ "$clearver" -ge "33" ]]; then
  picom -b
else
  picom -b --config "$noglxpicom"
fi
