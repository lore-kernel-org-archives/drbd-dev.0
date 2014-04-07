Return-Path: <philipp.marek@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id DC25F101AC76
	for <drbd-dev@lists.linbit.com>; Mon,  7 Apr 2014 12:49:32 +0200 (CEST)
From: Philipp Marek <philipp.marek@linbit.com>
To: drbd-dev@lists.linbit.com
Date: Mon, 07 Apr 2014 12:49:31 +0200
Message-ID: <5092424.CKW6nX0M7B@cacao>
In-Reply-To: <5302c0939964d7f19bec260413f4c90c@ugr.es>
References: <bd4dca3f93ea0361c978541eb47ff5c1@ugr.es>
	<5302c0939964d7f19bec260413f4c90c@ugr.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Drbd-dev] obtain addr
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

Hi Ra,


>   Where is the seccion in source code that obtain the IP address from
> drbd.conf file?
> 
>   The follow code in drbd_int.h -> struct drbd_connection
> 
>   struct sockaddr_storage my_addr;
>   int my_addr_len;
>   struct sockaddr_storage peer_addr;
>   int peer_addr_len;
the kernel module does _nothing_ with/about the configuration files.


"drbdadm" reads the config files, and runs
   "drbdsetup" commands, these use netlink to pass data to
      the kernel module.

You might want to look at sockaddr_from_str(), in user/drbdsetup.c 
around line 816.


Regards,

Phil

