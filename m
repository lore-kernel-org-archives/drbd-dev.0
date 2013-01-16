Return-Path: <pallair78@gmail.com>
Received: from mail-la0-f43.google.com (mail-la0-f43.google.com
	[209.85.215.43]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 92D49101707A
	for <drbd-dev@lists.linbit.com>; Wed, 16 Jan 2013 23:50:15 +0100 (CET)
Received: by mail-la0-f43.google.com with SMTP id eg20so1980765lab.2
	for <drbd-dev@lists.linbit.com>; Wed, 16 Jan 2013 14:50:14 -0800 (PST)
MIME-Version: 1.0
Sender: pallair78@gmail.com
In-Reply-To: <20130116102621.GI18620@soda.linbit>
References: <CALj=1wh+JA2m9nuhtS_+eyuvvK9GBaY+W2RYc71YPaxh1+PUhw@mail.gmail.com>
	<CALj=1whe16wjWO=DFgqPRz=uwxKQTnSOVNq=FM8RymF1aALVow@mail.gmail.com>
	<20130116102621.GI18620@soda.linbit>
Date: Wed, 16 Jan 2013 23:50:14 +0100
Message-ID: <CALj=1wiRE+WLjGm5PRT62ZxVRNGBbROSDMCfV1AAXBsfkud_vw@mail.gmail.com>
From: Pallai Roland <dap@magex.hu>
To: drbd-dev@lists.linbit.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] /usr/lib/drbd/crm-unfence-peer.sh: fencing rule leak?
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

2013/1/16 Lars Ellenberg <lars.ellenberg@linbit.com>:
> But still, the race, or races, you describe
> would still be possible in one form or an other.
>
> The only sane way I see would be to add some logic to the resource agent
> monitor section, and try to reliably detect a "healthy" replication (all
> nodes "UpToDate"), then "race free" remove a possibly leaked constraint.
>
> Unless cibadmin has a "compare exchange" mode, I don't see how you can
> do this race free. Hm, okay, you could protect both "critical sections"
> of crm-fence-peer and the resource agent monitor with flock, maybe.

I think there is no such fencing race if the fencing node does the
unfencing too. In that case the fencing and unfencing requests may be
queued in FIFO order in the cluster (optionally with some locking that
you outlined), no leaked constraints.

Extend drbd.conf's handlers to support primary side unfencing seems
like easy. What's the problem with that?

> --
> : Lars Ellenberg
> : LINBIT | Your Way to High Availability
> : DRBD/HA support and consulting http://www.linbit.com
>
> DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
>

(Lars, reply to drbd-user@ or personally me if this thread is too
annoying on drbd-dev@, sorry.)
