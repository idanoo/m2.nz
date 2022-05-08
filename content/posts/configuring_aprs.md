---
title: "Configuring an APRS receiver with an RTL-SDR and Direwolf"
tags: ["aprs", "amateur radio", "direwolf"]
date: "2021-12-16"
featuredimagepreview: "/aprs.jpg"
---

What is APRS? Automatic Packet Reporting System! Essentially a VHF radio sending out GPS location pings in the 2M ham band which can be seen at [aprs.fi](https://aprs.fi/). If you take a look at that link you will often see radiosondes and their reported data, weather stations as well as bunch of amateur operators transmitting data all over the world. Fascinating stuff.

![Yaesu FT3D with APRS tuned](/aprs.png)

I recently got my hands on an RTL-SDR v3 which claims much better accuracy and performance over previous models. Figured I'd give it a go receiving APRS and see what I could get. I did a bit of research and tested a few different packages but ended up settling with [Direwolf](https://github.com/wb2osz/direwolf). For those interested, I'm running this on an Ubuntu 20.04 LXC container with USB passthrough for the SDR itself.

Here is a run through of installing/configuring an APRS feeder with an SDR and Direwolf.
```shell
# Install required packages
apt-get install rtl-sdr direwolf
```

My `sdr.conf` file for reference with callsign and location blanked out.
```shell
ACHANNELS 1
ADEVICE null null
CHANNEL 0

MYCALL <CALLSIGN>-10
IGSERVER aunz.aprs2.net
IGLOGIN <CALLSIGN> 23018

MODEM 1200
AGWPORT 8000
KISSPORT 8001

PBEACON sendto=IG delay=0:30 every=10:00 symbol="/-" lat=-12.3456 long=12.3456 alt=in_meter comment="RTLSDR"
```

This is my `run.sh` script I currently launch in `screen` until I can get around to setting up a systemd service.
It simply gets the output from the APRS frequency and pipes it into direwolf launched with our above `sdr.conf` config.

```shell
#!/bin/bash

# -f 144.575M Tunes to 144.575 Mhz
# -g 20.7 is the gain value, rtl_test to view available options

rtl_fm -f 144.575M -s 22050 -g 20.7 | direwolf -c /root/sdr.conf -r 22050 -D 1 -B 1200 -
```
If you set up the LONG/LAT coords properly, you should be able to view your home station on [aprs.fi](https://aprs.fi/)!