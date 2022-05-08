---
title: "Recovering from a root 'rm' and why you need backups"
tags: ["recovery", "backup", "proxmox"]
date: "2021-02-06"
featuredimagepreview: "/proxmox.jpg"
---

Last week I was finally getting around to fixing my backup tooling and validating the recovery procedures. I thought it would be a good idea to have rolling nightly backups on a secondary ZFS pool with weekly syncs to an external disk. I ended up using this exact command to purge the rolling backups:

> `$ find ${BACKUP_FOLDER}/* -mtime +${DAYS_TO_KEEP} -exec rm {} \;`

Before we go any further, I want to point out that I was using the variable `${BACKUP_DIR}`, not `${BACKUP_FOLDER}`.  
Can you see where this is going? Yeah.. I didn't pick that up before running my new majestic backup script. Half an hour later I came back to pages of ssh logs resembling `/bin/rm: command not found`. Oops. I instantly knew what had happened, I'd completely written off my Proxmox host and I was lucky it removed the `/bin/rm` binary before removing any actual data.

Further investigation showed that I'd wiped most of /bin and the system was barely usable, I still had rsync.. yay! I quickly shutdown all of my containers/vms and rsync'd `/etc` to my primary ZFS cluster before rebooting to a fresh Proxmox install. After reformatting my root drive and reinstalling from scratch, I copied `/etc/pve/lxc` and  
`/etc/pve/qemu-sever` back into place, ran zpool import `{data,storage}` and gave it one more reboot.

I have never been so relieved to check and see all of my containers booting up back to their normal state. There was one or two other small things I had to fix up post-install such as reinstall `nfs-kernel-server` and several other packages. Overal I was pretty lucky I could copy my container configs before reinstalling and total downtime was under an hour.

### Backups are important

**Test your backups.**

Don't get caught out and expect everything to be there when you really need it.
