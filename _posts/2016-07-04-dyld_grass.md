---
layout: post
title: A workaround for R-Grass GIS 7 (co-interface) users in Mac OSX
modified:
categories: blog
tags: [GIS, GRASS, R]
excerpt: "A new stable version of GRASS GIS, i.e. GRASS 7.0.4, has been released on May 2, 2016. Although a range of attractive features have been released along with the new version, an update of the existing version across operating systems is, as usual, a troubleshooting..."
comments: true
share: true
---

A new stable version of [GRASS GIS](https://grass.osgeo.org/), i.e. GRASS 7.0.4, has been released on May 2, 2016. Although a range of attractive features have been released along with the new version, an update of the existing version across operating systems is, as usual, a troubleshooting. Particularly, Mac users with the latest OSX "El Capitan" have reported a few problems with updating to and running GRASS GIS 7. In addition, R-GRASS GIS co-interface users like myself, who wants to take advantage of the modules available in both software packages, may have faced some problems with associated python libraries. Below are the problems that I faced while updating to GRASS GIS 7 and co-interfacing with R via ["rgrass 7"](https://cran.r-project.org/web/packages/rgrass7/index.html) package (thanks to Roger Bivand). 

#### GRASS GIS 7 does not run on OSX "El Capitan" because of the new "System Integrity Protection" feature

The first problem was with installing and running GRASS 7 on El Capitan. The new System Integrity Protection (SIP) feature prevents GRASS installation as well as running, and hence, SIP needs to be disabled. Michael Barton has documented the procedure for GRASS installation by disabling SIP [here](http://grassmac.wikidot.com/) that has solved my problem.

#### GRASS does not understand locale UTF-8

The second problem was GRASS failing to understand UTF-8 locale (perhaps because of my default Swedish locale) and consequently not parsing "g.proj" with the following error.

{% highlight shell %}

ValueError: unknown locale: UTF-8

{% endhighlight %}

The workaround is easy. Create a `.bash_profile` file (unless you already have one) and add the locale information there. You can run the following code-snippets in R interface.

{% highlight r %}

system("cd ~/")

system("touch .bash_profile")

system("open -e .bash_profile")

{% endhighlight %}

This will open the `.bash_profile` in your text editor. Add the following lines and save it.

{% highlight python %}

export LC_ALL=en_US.UTF-8

export LANG=en_US.UTF-8

{% endhighlight %}

#### Initiation of GRASS GIS 7 from R interface fails because GRASS fails to symlink a python library

This is a particular problem for the R-GRASS co-interface users. GRASS needs a dynamic link (dyld or symlink) to a python library, i.e. libintl.8.dylib, which is located in `/usr/local/lib`.

GRASS library location: `/Applications/GRASS-7.0.app/Contents/MacOS/lib`.

Originally the link is missing and users end up with the following error while initiating GRASS from R interface.

{% highlight r %}

dyld: Library not loaded: /usr/local/lib/libintl.8.dylib
  Referenced from: /Applications/GRASS-7.0.app/Contents/MacOS/lib/libgrass_gis.7.0.4.dylib
  Reason: image not found

{% endhighlight %}

The solution of straightforward symlinking provided in the [grasswiki](https://grasswiki.osgeo.org/wiki/R_statistics/Installation):

{% highlight r %}

system("sudo ln -s /Applications/GRASS-7.0.app/Contents/MacOS/lib/libintl.8.dylib /usr/local/lib/libintl.8.dylib")

{% endhighlight %}

does not work because a proper symlink to the `FFTW3.framework` is needed. Executing the following code snippets in R interface before initiating GRASS will solve the problem.

{% highlight r %}

switch(
    Sys.info()[['sysname']],
    Windows = { print("I'm a Windows PC.") },
    Linux   = { print("I'm a Penguin.") },
    Darwin  = { print("I'm a Mac.");
    Sys.setenv( DYLD_LIBRARY_PATH = paste(
    "/Applications/GRASS-7.0.app/Contents/MacOS/lib",
    "/Users/(username)/Library/GRASS/7.0/Modules/lib",
    "/Library/GRASS/7.0/Modules/lib",
    "/Applications/GRASS-7.0.app/Contents/MacOS/lib/FFTW3.framework/Versions/3",
    ":DYLD_LIBRARY_PATH",
    sep = ":"
                    )
              )
        }
    )

{% endhighlight %}

I hope that this would solve the R-GRASS problems for Mac users. These were prerequisites for running [ATRIC](https://github.com/AvitBhowmik/ATRIC) in Mac as well. I am currently updating ATRIC for GRASS GIS 7 with the help of a master's student and will release soon.