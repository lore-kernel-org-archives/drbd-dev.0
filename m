Return-Path: <dietmar@proxmox.com>
Received: from proxmox.maurer-it.com (proxmox.maurer-it.com [94.136.31.133])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 14E05104B1D2
	for <drbd-dev@lists.linbit.com>; Thu, 19 Mar 2015 08:26:29 +0100 (CET)
Received: from proxmox.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox.maurer-it.com (Proxmox) with ESMTP id 3132CAD0920
	for <drbd-dev@lists.linbit.com>; Thu, 19 Mar 2015 08:26:29 +0100 (CET)
Date: Thu, 19 Mar 2015 08:26:26 +0100 (CET)
From: Dietmar Maurer <dietmar@proxmox.com>
To: drbd-dev@lists.linbit.com
Message-ID: <1555782802.4.1426749986934.JavaMail.open-xchange@ronja.mits.lan>
In-Reply-To: <1642954695.26.1426702648470.JavaMail.open-xchange@ronja.mits.lan>
References: <1642954695.26.1426702648470.JavaMail.open-xchange@ronja.mits.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] no files found matching man-pages/drbdmanage.8.gz
Reply-To: Dietmar Maurer <dietmar@proxmox.com>
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Answering myself, I need to call

# python setup.py build_man 

to build the manual pages.

> On March 18, 2015 at 7:17 PM Dietmar Maurer <dietmar@proxmox.com> wrote:
> 
> 
> I just tried to install drbdmanage on debian jessie, but run into the
> following problem:
> 
> # cd drbdmanage
> # python setup.py sdist
> reading manifest template 'MANIFEST.in'
> warning: no files found matching 'man-pages/drbdmanage.8.gz'
> ..
> 
> 
> # python setup.py install
> ...
> running install_data
> copying conf/drbdctrl.res_template -> /etc/drbd.d
> copying conf/drbdmanage-resources.res -> /etc/drbd.d
> copying conf/drbdmanaged.conf -> /etc
> copying conf/drbdmanaged-lvm.conf -> /etc
> copying conf/org.drbd.drbdmanaged.conf -> /etc/dbus-1/system.d
> error: can't copy 'man-pages/drbdmanage.8.gz': doesn't exist or not a regular
> file
> 
> So how can I fix that?

