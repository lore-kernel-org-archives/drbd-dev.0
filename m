Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8A692101286B
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2018 17:57:32 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id f6-v6so33284737wmc.4
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2018 08:57:32 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	v37-v6sm1258815edm.0.2018.05.28.08.57.31
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 28 May 2018 08:57:31 -0700 (PDT)
Resent-Message-ID: <20180528155730.GD20485@soda.linbit>
Received: from smtprelay.hostedemail.com (smtprelay0235.hostedemail.com
	[216.40.44.235])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id E57181011B93
	for <drbd-dev@lists.linbit.com>; Thu, 24 May 2018 15:01:10 +0200 (CEST)
Message-ID: <e64c2846b1b9102a52eba7b242f746e7bfff1464.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Jens Axboe <axboe@kernel.dk>, "Ed L. Cashin" <ed.cashin@acm.org>,
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg
	<lars.ellenberg@linbit.com>, Jiri Kosina <jikos@kernel.org>, Josef Bacik
	<josef@toxicpanda.com>,  linux-block@vger.kernel.org, Ilya Dryomov
	<idryomov@gmail.com>, Sage Weil <sage@redhat.com>, Alex Elder
	<elder@kernel.org>, Philip Kelleher <pjk1939@linux.vnet.ibm.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad
	Rzeszutek Wilk <konrad.wilk@oracle.com>, Roger Pau =?ISO-8859-1?Q?Monn=E9?=
	<roger.pau@citrix.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>
Date: Thu, 24 May 2018 06:01:02 -0700
In-Reply-To: <539cc400-28d7-66df-eb24-77fe95d617a2@kernel.dk>
References: <5e97a292c1ba38a6b5a0caa271d85dc3de1b2aa7.1527105857.git.joe@perches.com>
	<6bf44255-145f-bf14-e254-860731ff9296@kernel.dk>
	<56ee8810463b6c537ca0c10c9f82e6d922acd1f1.camel@perches.com>
	<539cc400-28d7-66df-eb24-77fe95d617a2@kernel.dk>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, nbd@other.debian.org,
	xen-devel@lists.xenproject.org, ceph-devel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block drivers/block: Use octal not symbolic
	permissions
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

On Thu, 2018-05-24 at 06:47 -0600, Jens Axboe wrote:
> On 5/23/18 4:35 PM, Joe Perches wrote:
> > On Wed, 2018-05-23 at 15:27 -0600, Jens Axboe wrote:
> > > On 5/23/18 2:05 PM, Joe Perches wrote:
> > > > Convert the S_<FOO> symbolic permissions to their octal equivalents as
> > > > using octal and not symbolic permissions is preferred by many as more
> > > > readable.
> > > > 
> > > > see: https://lkml.org/lkml/2016/8/2/1945
> > > > 
> > > > Done with automated conversion via:
> > > > $ ./scripts/checkpatch.pl -f --types=SYMBOLIC_PERMS --fix-inplace <files...>
> > > > 
> > > > Miscellanea:
> > > > 
> > > > o Wrapped modified multi-line calls to a single line where appropriate
> > > > o Realign modified multi-line calls to open parenthesis
> > > 
> > > Honestly, I see this as pretty needless churn.
> > 
> > btw:
> > 
> > There is currently a mixture of symbolic and octal
> > permissions uses in block and drivers/block
> > 
> > ie: 94 octal and 146 symbolic uses.
> > 
> > If this is applied, all would become octal.
> 
> That does help justify the change. My main worry here is creating
> unnecessary conflicts, which is always annoying. But it's even more
> annoying when the change creating the conflict isn't really that
> important at all. Case in point, the patch doesn't apply to the
> for-4.18/block branch that it should go into...

Done against most recent -next as it's basically impossible
to do anything against multiple private trees.

Also, the script that generated the patch is in the changelog
so it's simple to rerun.


