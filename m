Return-Path: <nwang@suse.com>
Received: from prv-mh.provo.novell.com (prv-mh.provo.novell.com
	[137.65.248.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 431A71056332
	for <drbd-dev@lists.linbit.com>; Fri, 10 Mar 2017 04:48:04 +0100 (CET)
Message-Id: <58C2928502000070000B2E7D@prv-mh.provo.novell.com>
Date: Thu, 09 Mar 2017 20:48:21 -0700
From: "Nick Wang" <nwang@suse.com>
To: "Roland Kammerer" <roland.kammerer@linbit.com>, <drbd-dev@lists.linbit.com>
References: <1488857279-29079-1-git-send-email-nwang@suse.com>
	<20170309102230.GA18615@rck.sh>
In-Reply-To: <20170309102230.GA18615@rck.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Drbd-dev] [Patch v0 0/8] Patches for compat drbd9 to kernel
 v4.10
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



>>> On 2017-3-9 at 18:22, in message <20170309102230.GA18615@rck.sh>, =
Roland
Kammerer <roland.kammerer@linbit.com> wrote:
> There are some things that need to change before I can apply the series.
> I will answer to some patch mails (2 and 5) that exemplify how we do
> compat work.
>
 Thanks for your opinion, that is much better and valuable. I do struggling=
=20
to find a better idea to compat old version and avoid too many #ifdef=20
branches in code.

> It would then be great if you resend your series. If not, just let
> me know, then I will do the compat work.
  I will polish them based on your idea and resend later.

Best regards,
Nick

