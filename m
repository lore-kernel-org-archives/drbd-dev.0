Return-Path: <helmut@wollmersdorfer.at>
Received: from viefep14-int.chello.at (viefep14-int.chello.at [213.46.255.13])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 37BB614317
	for <drbd-dev@lists.linbit.com>; Tue,  5 Oct 2004 23:44:16 +0200 (CEST)
Message-ID: <416315AF.80004@wollmersdorfer.at>
Date: Tue, 05 Oct 2004 23:44:15 +0200
From: Helmut Wollmersdorfer <helmut@wollmersdorfer.at>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 0.7.5 release tomorrow...
References: <200409291054.13765.philipp.reisner@linbit.com>	<200409301410.21550.philipp.reisner@linbit.com>
	<022301c4a704$b2dca950$532210ac@morpheus>
In-Reply-To: <022301c4a704$b2dca950$532210ac@morpheus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: 
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Philipp Hug wrote:
> I created some pre-release debian packages based on the current svn drbd 
> version.
> So if anyone wants to try 'em? I didn't have the time to really test 
> them yet...

Trying from a fresh checkout:

helmut@xp2400:~$ uname -a
Linux xp2400 2.4.26-1-386 #1 Tue Aug 24 13:31:19 JST 2004 i686 GNU/Linux

helmut@xp2400:~$ svn co http://svn.drbd.org/drbd/tags/drbd-0.7.5
helmut@xp2400:~$ cd drbd-0.7.5
helmut@xp2400:~/drbd-0.7.5$ su
Password:
xp2400:/home/helmut/drbd-0.7.5# dpkg-buildpackage -us -uc -b
dpkg-buildpackage: source package is drbd
dpkg-buildpackage: source version is 0.7.5-1
[...]
cd user && /usr/bin/make
make[1]: Entering directory `/home/helmut/drbd-0.7.5/user'
gcc -c -Wall -I../drbd   -c -o drbdsetup.o drbdsetup.c
make[1]: *** No rule to make target `../drbd/drbd_buildtag.o', needed by 
`drbdsetup'.  Stop.
make[1]: Leaving directory `/home/helmut/drbd-0.7.5/user'
make: *** [build-arch-stamp] Error 2

After
    make install-tools
as workaround it builds .debs and works the usual debian way.

Next item:
Whatever the reason is, the following is necessary with current packaging

xp2400:/home/helmut# mv /lib/modules/2.4.26/kernel/drivers/block/drbd.o 
/lib/modules/2.4.26-1-386/kernel/drivers/block/drbd.o

to make this

xp2400:/usr/src# update-modules
xp2400:/usr/src# modprobe drbd

working in Sarge.
Now I will try in Sarge + 2.6.8-1, coming soon ...

> add this to your sources.list:
> deb http://debian.hug.cx/debian/ unstable/

| Forbidden
|
| You don't have permission to access /debian/ on this server.

BTW:
http://packages.debian.org/unstable/misc/drbd
| Not Found
| The requested URL /unstable/misc/drbd was not found on this server.

Helmut Wollmersdorfer
