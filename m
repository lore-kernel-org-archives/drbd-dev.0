Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 029991019A44
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2018 17:57:28 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id o78-v6so33349059wmg.0
	for <drbd-dev@lists.linbit.com>; Mon, 28 May 2018 08:57:28 -0700 (PDT)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	b4-v6sm16525231edr.29.2018.05.28.08.57.27
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 28 May 2018 08:57:28 -0700 (PDT)
Resent-Message-ID: <20180528155727.GB20485@soda.linbit>
Received: from smtprelay.hostedemail.com (smtprelay0142.hostedemail.com
	[216.40.44.142])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 24513101AC7B
	for <drbd-dev@lists.linbit.com>; Wed, 23 May 2018 23:41:36 +0200 (CEST)
Message-ID: <cd46916c876eb552579a5c91b62780c315dd67f8.camel@perches.com>
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
Date: Wed, 23 May 2018 14:41:30 -0700
In-Reply-To: <6bf44255-145f-bf14-e254-860731ff9296@kernel.dk>
References: <5e97a292c1ba38a6b5a0caa271d85dc3de1b2aa7.1527105857.git.joe@perches.com>
	<6bf44255-145f-bf14-e254-860731ff9296@kernel.dk>
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

On Wed, 2018-05-23 at 15:27 -0600, Jens Axboe wrote:
> On 5/23/18 2:05 PM, Joe Perches wrote:
> > Convert the S_<FOO> symbolic permissions to their octal equivalents as
> > using octal and not symbolic permissions is preferred by many as more
> > readable.
> > 
> > see: https://lkml.org/lkml/2016/8/2/1945
> > 
> > Done with automated conversion via:
> > $ ./scripts/checkpatch.pl -f --types=SYMBOLIC_PERMS --fix-inplace <files...>
> > 
> > Miscellanea:
> > 
> > o Wrapped modified multi-line calls to a single line where appropriate
> > o Realign modified multi-line calls to open parenthesis
> 
> Honestly, I see this as pretty needless churn.

It's just for consistency and the ability to highlight
somewhat unusual permissions uses like just 0400.

Apply it at your leisure or ignore it.

btw: Joshua Morris' email address is bouncing.
Maybe it should be removed from MAINTAINERS.
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9051a9ca24a2..0d546a10d0b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5598,7 +5598,6 @@ F:	drivers/base/firmware_loader/
 F:	include/linux/firmware.h
 
 FLASH ADAPTER DRIVER (IBM Flash Adapter 900GB Full Height PCI Flash
Card)
-M:	Joshua Morris <josh.h.morris@us.ibm.com>
 M:	Philip Kelleher <pjk1939@linux.vnet.ibm.com>
 S:	Maintained
 F:	drivers/block/rsxx/
