Return-Path: <philipp@hug.cx>
Received: from dandelion.nextdomain.net (62-2-150-10.business.cablecom.ch
	[62.2.150.10])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 3AACB142FF
	for <drbd-dev@lists.linbit.com>; Thu, 25 Nov 2004 00:37:45 +0100 (CET)
Message-ID: <41A51B57.9000208@hug.cx>
Date: Thu, 25 Nov 2004 00:37:59 +0100
From: Philipp Hug <philipp@hug.cx>
MIME-Version: 1.0
To: Sven Mueller <sm+debian@leogic.com>, 282727@bugs.debian.org,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
References: <41A3DAEE.2000307@ciphirelabs.com> <41A45BD4.7020408@hug.cx>
	<41A4F20A.9050008@leogic.com>
In-Reply-To: <41A4F20A.9050008@leogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: 
Subject: [Drbd-dev] Re: Bug#282727: drbd0.7-module-source: Unable to build
 drbd0.7 binary module
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Sven,

If I remember correctly there's a problem building drbd against 2.6.10.
It should be fixed in drbd0.7.6 but it's not released yet.
I think you should define TASK_ZOMBIE as 16 in the meantime, but not sure.

philipp

Sven Mueller wrote:

> Philipp Hug [u] wrote on 24/11/2004 11:00:
>
>> There's a bug in module-assistant that prevents building packages 
>> with a dot in their name.
>> have a look at 
>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=277586 and apply the 
>> attached patch.
>> Maybe I should put info about this into the Debian.README.
>
>
> OK, even after applying that patch, I still have a problem compiling 
> drbd0.7-module (through module-assistant), see attached build-log.
>
> Any idea what might be the cause for this?
>
> As a side note: I got the same build error when trying to build the 
> module from pristine upstream source. When I define TASK_ZOMBIE as "8" 
> (as in the relevant include file), it continues building just to 
> generate an invalid .ko file with some undefined symbol (though I 
> don't recall which, only that it was a function defined in 
> linux/net.h, might have been sock_alloc())
>
>------------------------------------------------------------------------
>
>Build log starting, file: /var/cache/modass/drbd0.7-module-source.buildlog.2.6.10-rc2-incase.1101308449
>Date: Wed, 24 Nov 2004 16:00:49 +0100
>
>dh_clean
>/usr/bin/make -C drbd clean
>make[1]: Entering directory `/usr/src/modules/drbd/drbd'
>rm -f *.[oas] *.ko .*.cmd .*.d .*.tmp *.mod.c .*.flags .depend .kernel*
>make[1]: Leaving directory `/usr/src/modules/drbd/drbd'
>for templ in /usr/src/modules/drbd/debian/drbd0.7-module-_KVERS_.postinst /usr/src/modules/drbd/debian/drbd0.7-module-_KVERS_.postinst.backup /usr/src/modules/drbd/debian/drbd0.7-module-_KVERS_.postinst.modules.in; do \
>    cp $templ `echo $templ | sed -e 's/_KVERS_/2.6.10-rc2-incase/g'` ; \
>  done
>for templ in `ls debian/*.modules.in` ; do \
>    test -e ${templ%.modules.in}.backup || cp ${templ%.modules.in} ${templ%.modules.in}.backup 2>/dev/null || true; \
>    sed -e 's/##KVERS##/2.6.10-rc2-incase/g ;s/#KVERS#/2.6.10-rc2-incase/g ; s/_KVERS_/2.6.10-rc2-incase/g ; s/##KDREV##/2/g ; s/#KDREV#/2/g ; s/_KDREV_/2/g' < $templ > ${templ%.modules.in}; \
>  done
>dh_testdir
>dh_testroot
>dh_clean -k
>/usr/bin/make -C drbd KERNEL_SOURCES=/usr/src/linux-2.6.10-rc2 MODVERSIONS=detect KERNEL=linux-2.6.10-rc2-incase KDIR=/usr/src/linux-2.6.10-rc2
>make[1]: Entering directory `/usr/src/modules/drbd/drbd'
>
>    Calling toplevel makefile of kernel source tree, which I believe is in
>    KDIR=/usr/src/linux-2.6.10-rc2
>
>test -x ../scripts/adjust_drbd_config_h.sh && \
> KDIR=/usr/src/linux-2.6.10-rc2 ../scripts/adjust_drbd_config_h.sh
>make[1]: [kbuild] Error 1 (ignored)
>/usr/bin/make -C /usr/src/linux-2.6.10-rc2 SUBDIRS=/usr/src/modules/drbd/drbd  modules
>make[2]: Entering directory `/usr/src/linux-2.6.10-rc2'
>  CC [M]  /usr/src/modules/drbd/drbd/drbd_buildtag.o
>  CC [M]  /usr/src/modules/drbd/drbd/drbd_bitmap.o
>  CC [M]  /usr/src/modules/drbd/drbd/drbd_fs.o
>/usr/src/modules/drbd/drbd/drbd_fs.c: In function `drbd_ioctl_set_disk':
>/usr/src/modules/drbd/drbd/drbd_fs.c:484: error: `TASK_ZOMBIE' undeclared (first use in this function)
>/usr/src/modules/drbd/drbd/drbd_fs.c:484: error: (Each undeclared identifier is reported only once
>/usr/src/modules/drbd/drbd/drbd_fs.c:484: error: for each function it appears in.)
>make[3]: *** [/usr/src/modules/drbd/drbd/drbd_fs.o] Error 1
>make[2]: *** [_module_/usr/src/modules/drbd/drbd] Error 2
>make[2]: Leaving directory `/usr/src/linux-2.6.10-rc2'
>make[1]: *** [kbuild] Error 2
>make[1]: Leaving directory `/usr/src/modules/drbd/drbd'
>make: *** [binary-modules] Error 2
>  
>
