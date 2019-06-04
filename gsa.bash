#!/bin/env bash
# Copyright 2019 (c) all rights reserved 
# by S D Rausty https://sdrausty.github.io
#####################################################################
set -Eeuo pipefail
shopt -s nullglob globstar

_SINMTRPERROR_() { # Run on script error.
	local RV="$?"
	echo "$RV"
	printf "\\e[?25h\\n\\e[1;48;5;138mBuildAPKs initm.bash ERROR:  Generated script error %s near or at line number %s by \`%s\`!\\e[0m\\n" "${3:-VALUE}" "${1:-LINENO}" "${2:-BASH_COMMAND}"
	exit 179
}

_SINMTRPEXIT_() { # Run on exit.
	printf "\\e[?25h\\e[0m"
	set +Eeuo pipefail 
	exit
}

_SINMTRPSIGNAL_() { # Run on signal.
	local RV="$?"
	printf "\\e[?25h\\e[1;7;38;5;0mBuildAPKs %s WARNING:  Signal %s received!\\e[0m\\n" "initm.bash" "$RV"
 	exit 178 
}

_SINMTRPQUIT_() { # Run on quit.
	local RV="$?"
	printf "\\e[?25h\\e[1;7;38;5;0mBuildAPKs %s WARNING:  Quit signal %s received!\\e[0m\\n" "initm.bash" "$RV"
 	exit 177 
}

trap '_SINMTRPERROR_ $LINENO $BASH_COMMAND $?' ERR 
trap _SINMTRPEXIT_ EXIT
trap _SINMTRPSIGNAL_ HUP INT TERM 
trap _SINMTRPQUIT_ QUIT 

_GSA_() {
	(git submodule add https://github.com/$1 $2) || (echo ; echo "Cannot update $2: continuing...")
}

_GSA_ commonsguy/cw-andexplore Android/tutorials/commonsguy/cw-andexplore 
_GSA_ commonsguy/cw-androidarch Android/tutorials/commonsguy/cw-androidarch
_GSA_ commonsguy/cw-advandroid Android/tutorials/commonsguy/cw-advandroid 
_GSA_ commonsguy/cw-android Android/tutorials/commonsguy/cw-androidtutorials
_GSA_ commonsguy/cw-lunchlist Android/tutorials/commonsguy/cw-lunchlist 
_GSA_ commonsguy/cw-omnibus Android/tutorials/commonsguy/cw-omnibus
_GSA_ ErikCrick/android-tutorials Android/tutorials/ErikCrick/android-tutorials
_GSA_ fx-adi-lima/android-tutorials Android/tutorials/fx-adi-lima/android-tutorials
_GSA_ novoda/android-demos Android/tutorials/novoda/android-demos
