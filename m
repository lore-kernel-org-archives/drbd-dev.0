Return-Path: <roland.kammerer@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 6B19C101AC7A
	for <drbd-dev@lists.linbit.com>; Thu, 10 Jul 2014 10:35:42 +0200 (CEST)
Date: Thu, 10 Jul 2014 10:35:41 +0200
From: Roland Kammerer <roland.kammerer@linbit.com>
To: Liuhua Wang <lwang@suse.com>
Message-ID: <20140710083540.GJ1962@rck.sh>
References: <53B6ED86020000A0000099B9@soto.provo.novell.com>
	<20140707083415.GA1962@rck.sh>
	<53BEB579020000A000009DFF@soto.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53BEB579020000A000009DFF@soto.provo.novell.com>
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 1/1] fix drbd.rules to avoid start drbd fail
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

On Thu, Jul 10, 2014 at 01:47:05AM -0600, Liuhua Wang wrote:
> Hi Roland,
> 
> I tested pacemaker+drbd8.4.5+drbd-utils-8.9.0,
> drbd resource will fail to start in case of device name
> different from drbd%minor. for example:
> [...]
>       device	/dev/drbd_r0 minor 0;
> [...]
> 
> What do you thinks?

Still the same as last time... You are using deprecated behavior. Maybe
"deprecated" is a bit strong, lets say you are using something you
should not use anymore ;-).

>       device	/dev/drbd_r0 minor 0;

We removed the part mentioning this class of names from the man-page in
our internal repo (it will make it into 8.9.1 soon). Simply do not use
these "custom device names". My suggestion: Do not use custom device
names, not now, not in the future.

Regards, rck
