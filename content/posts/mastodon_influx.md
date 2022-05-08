---
title: "Hosting mastodon.nz and the recent twitter influx"
tags: ["mastodon", "twitter", "self hosting"]
date: "2022-05-08"
featuredimagepreview: "/server1.jpg"
---

Where to begin.. It's been an interesting fortnight!

I started hosting [mastodon.nz](https://mastodon.nz) around January 2020 on my home 'server' for myself and few friends. It started off as a small LXC container inside Proxmox with 2 cores and 2GB RAM allocated. It stayed this way until about 6 months ago when I kept having scheduled power outages and I couldn't keep running it from my house while maintaining a reasonable uptime.

{{< image src="/kitchen_server.jpg" caption="\"Server\" - April 2021" src_s="/kitchen_server.jpg" src_l="/kitchen_server_l.jpg" >}}

Mid 2021 a good friend of mine offered a great deal on some actual hosting in a datacenter. Now we had 8vCPU + 8GB RAM to play with, time to migrate everything. After a few hours of mastering `rsync` and `pg_dump` - it was done, we were set for awhile. At least that's what I thought..

April 2022 brought a nice little surprise - I started getting notifications of new users joining [mastodon.nz](https://mastodon.nz). Confused I started to look at what has changed.. Didn't take long to realise this was only the beginning. I had to allocate more resource to the container to account for the higher throughput.

You can see in the image below it started to approach the allocated 3GB - I bumped it up to 4GB, then shortly after up to 6GB. That's as much as I could give it without moving to bigger hardware.

{{< image src="/masto_memory.jpg" caption="Memory usage in mastodon.nz container" >}}

I thought that would be enough for now. Nope. I got an email from Sendgrid that we had hit their 100 email/day free tier limit. Crap. I managed to upgrade the plan to account for the burst of registrations before any emails started to bounce.

{{< image src="/sendgrid.jpg" caption="Email throughput peaking around 400/day" >}}

It was about at this time I figured we probably needed to look into the future of mastodon and if we plan on maintaining it long term with a much higher capacity. I jumped on trademe and started working out we could afford and what we needed to maintain a decent growth over the next 12+ months. Boom! Found the perfect thing in our price range. A second hand HP DL360p Gen8 - With 32 cores and 80GB ram. The only issue is disks. I've never been one to trust second hand disks. So went waaaay over budget and bought 2 x 500GB EVO870's and 2 x 2TB EVO870's to run in a ZFS mirror for storage.

{{< image src="/server1.jpg" caption="New server" >}}

{{< image src="/server_prov.jpg" caption="Provisioning everything (Excuse the mess)"src_s="/server_prov.jpg" src_l="/server_prov_l.jpg" >}}

After about 6 hours of configuring and installing everything required, I was ready to make a trip to a local datacenter to rack it (Thanks to previously mentioned friend!) and start the painful migration.

More to come soon.