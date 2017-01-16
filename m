Return-Path: <nwang@suse.com>
Received: from prv-mh.provo.novell.com (prv-mh.provo.novell.com
	[137.65.248.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2AF0A1056332
	for <drbd-dev@lists.linbit.com>; Mon, 16 Jan 2017 03:29:03 +0100 (CET)
Message-Id: <587CA0CF02000070000ABE6F@prv-mh.provo.novell.com>
Date: Sun, 15 Jan 2017 19:30:39 -0700
From: "Nick Wang" <nwang@suse.com>
To: "Lars Ellenberg" <lars.ellenberg@linbit.com>
References: <1484288158-25952-1-git-send-email-nwang@suse.com>
	<20170113110345.GA9172@soda.linbit>
In-Reply-To: <20170113110345.GA9172@soda.linbit>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Cc: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd-utils: Fix the default node id
 initialization when upgrade v8 to v9
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

>>> On 2017-1-13 at 19:03, in message <20170113110345.GA9172@soda.linbit>, =
Lars
Ellenberg <lars.ellenberg@linbit.com> wrote:
> With DRBD 9, you *have* to set the node id in the configuration.
> If there is a way around that, we need to fix it.
>=20
I can see error messages when lacking of node-id or connection sections in =
multiple nodes scenario.

> Also, IMO, in virtually all 8 -> 9 upgrade scenarios, you are better off
> creating new DRBD 9 meta data instead of trying to "convert".
>=20

Thanks for the information. Will always do so when upgrading from v8 to =
v9.

Best regards,
Nick=20

