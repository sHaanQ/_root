#!/bin/bash

sudo echo "Installing pulseaudio-utils and lame"
sudo apt-get install pulseaudio-utils lame

sudo mkdir /usr/local/bin/record-speakers
sudo cp record_speakers.py record-spreakers.svg record_speakers.glade /usr/local/bin/record-speakers
cp record_speakers.desktop ${HOME}/.local/share/applications/
