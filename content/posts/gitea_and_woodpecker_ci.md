---
title: "Gitea and Woodpecker CI"
tags: ["gitea", "woodpecker", "cicd", "self hosting"]
date: "2022-09-12"
draft: "true"
featuredimagepreview: "/woodpecker.jpg"
---

Another year, another post!

This time writing about my experience setting up and configuring [Gitea](https://gitea.io) and [Woodpecker](https://woodpecker-ci.org) as a self-hosted Git setup with full CI/CD pipelines.

I've decided to make the repo for this blog public with a [simple CI script](https://tinker.nz/idanoo/m2.nz/src/branch/main/.woodpecker.yml) configured to do hands free deployments. I'm aware that using `git pull` over SSH is a poor-mans CI script, but it works as a proof of concept and I do plan to tidy it up in the future™.

{{< image src="/woodpecker.jpg" caption="Woodpecker CI deploying this blog" >}}

### Gitea

I've run a Gitea server before so found it pretty seamless to get working. It was a matter of downloading a binary and setting some configuration flags (hostname, database config if needed, etc). 

### Woodpecker CI

Coming from Gitlab CI it seems pretty basic, but in reality it can do almost everything you need. I'm still figuring out it's capbilities but it does the basic stuff