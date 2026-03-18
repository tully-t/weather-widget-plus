#!/bin/bash
# Version: 6

# This script will convert the *.po files to *.mo files, rebuilding the package/contents/locale folder.
# Feature discussion: https://phabricator.kde.org/D5209
# Eg: contents/locale/fr_CA/LC_MESSAGES/plasma_applet_org.kde.plasma.eventcalendar.mo

DIR=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`
plasmoidName=`kreadconfig5 --file="$DIR/../../weather.widget.plus/metadata.desktop" --group="Desktop Entry" --key="X-KDE-PluginInfo-Name"`
website=`kreadconfig5 --file="$DIR/../../weather.widget.plus/metadata.desktop" --group="Desktop Entry" --key="X-KDE-PluginInfo-Website"`
bugAddress="$website"
packageRoot=".." # Root of translatable sources
projectName="plasma_applet_${plasmoidName}" # project name

#---
if [ -z "$plasmoidName" ]; then
	echo "[build] Error: Couldn't read plasmoidName."
	exit
fi

echo "[build] Checking the 'gettext' package installation..."
if ! command -v msgfmt > /dev/null; then
	echo "[build] Error: msgfmt command not found. The 'gettext' package is required for it."
	echo "[build] Installing 'gettext'..."

	if command -v apt > /dev/null; then
		sudo apt install gettext
	elif command -v dnf > /dev/null; then
		sudo dnf install gettext
	elif command -v pacman > /dev/null; then
		sudo pacman -S gettext
	elif command -v yum > /dev/null; then
		sudo yum install gettext
	elif command -v zypper > /dev/null; then
		sudo zypper install gettext
	else
		echo "[build] Your package manager is not apt, dnf, pacman, yum, or zypper."
	fi
fi

if command -v msgfmt > /dev/null; then
	echo "[build] The 'gettext' package is installed."
else
	echo "Please install the 'gettext' package, then run this script again."
	exit
fi

#---
echo "[build] Compiling messages"

catalogs=`find . -name '*.po' | sort`
for cat in $catalogs; do
	echo "$cat"
	catLocale=`basename ${cat%.*}`
	msgfmt -o "${catLocale}.mo" "$cat"

	installPath="$DIR/../../weather.widget.plus/contents/locale/${catLocale}/LC_MESSAGES/${projectName}.mo"

	echo "[build] Install to ${installPath}"
	mkdir -p "$(dirname "$installPath")"
	mv "${catLocale}.mo" "${installPath}"
done

echo "[build] Done building messages"

if [ "$1" = "--restartplasma" ]; then
	echo "[build] Restarting plasmashell"
	killall plasmashell
	kstart5 plasmashell
	echo "[build] Done restarting plasmashell"
else
	echo "[build] (re)install the plasmoid and restart plasmashell to test."
fi
