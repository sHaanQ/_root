#!/bin/bash

sudo echo "Installing pulseaudio-utils and lame"
sudo apt-get install pulseaudio-utils lame

mkdir ~/.local/share/applications/record-speakers
cp record_speakers.py record-spreakers.svg record_speakers.glade record_speakers.desktop ~/.local/share/applications/record-speakers

