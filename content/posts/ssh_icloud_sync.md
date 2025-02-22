---
title: "iCloud synced SSH configs on macOS"
tags: ["syncing", "config", "ssh"]
date: 2023-08-17
# featuredimagepreview: "/cathacker1.jpg"
---

Maintaining SSH configs can be a pain when you're hopping between multiple devices, even more when syncing apps (Synology/NextCloud/etc) are blocked on some networks/devices.

Make sure you have iCloud Drive enabled and this will symlink your SSH config + key to a folder in iCloud Drive and sync across devices.

The iCloud Drive is located at `~/Library/Mobile Documents/com~apple~CloudDocs`. By putting this file + your config/id_rsa files in here, it will simply symlink them. Warning - the setup script will overwrite existing config/id_rsa files.

Install 
```bash
cd ~/Library/Mobile Documents/com~apple~CloudDocs
mkdir macOS && cd macOS
# Create above setup.sh file and copy in your .ssh/config and .ssh/id_rsa keys
./setup.sh
```

setup.sh file
```bash
#!/bin/bash
FOLDER=$(pwd)
ln -sf "$FOLDER/config" ~/.ssh/config
ln -sf "$FOLDER/id_rsa" ~/.ssh/id_rsa
```



Heavily inspired by [This post](https://leihao0.github.io/Sync-macOS-ssh-config-with-iCloud/)
