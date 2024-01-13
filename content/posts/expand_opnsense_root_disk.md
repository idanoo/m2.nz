---
title: "Expanding OpnSense root disk (21.7+)"
tags: ["opnsense", "disk"]
date: "2024-01-13"
featuredimagepreview: "/opnsense_expand.jpg"
---

Expanding root partition on OpnSense VM

- Expand underlying VM disk
- Reboot
- Run below commands to online resize
- Reboot (Optional?)

```shell
# View the layout
gpart show
# Resolve GPT issue before extending
gpart recover da0
# Make it use all the new space
gpart resize -i 3 da0
# Grow the FS to fill the new partition
growfs /dev/gpt/rootfs
```