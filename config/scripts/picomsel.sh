wdir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
clearver=$(/bin/sh $wdir/openglver.sh | sed "s/\.//")
noglxpicom=$HOME/.config/noglxpicom.conf
[[ -a $XDG_CONFIG_HOME ]] && noglxpicom=$XDG_CONFIG_HOME/noglxpicom.conf;

if [[ "$clearver" -ge "33" ]]
then 
  picom -b
else 
  picom -b --config $noglxpicom
fi
