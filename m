Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 11D1A1055FB5
	for <drbd-dev@lists.linbit.com>; Wed, 17 Aug 2011 17:57:31 +0200 (CEST)
Resent-Message-ID: <20110817155731.GD9133@barkeeper1-xen.linbit>
Received: from mail-vx0-f182.google.com (mail-vx0-f182.google.com
	[209.85.220.182]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id CA81E105627A
	for <drbd-dev@lists.linbit.com>; Thu, 11 Aug 2011 20:57:23 +0200 (CEST)
Received: by vxh11 with SMTP id 11so3543555vxh.27
	for <drbd-dev@lists.linbit.com>; Thu, 11 Aug 2011 11:57:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201108081557.48504.philipp.reisner@linbit.com>
References: <201108081557.48504.philipp.reisner@linbit.com>
Date: Thu, 11 Aug 2011 20:34:57 +0200
Message-ID: <CAJAFBLC+MpBRk29dX286G1mkobi_FnXAiQuF++eACZ8VUct2XQ@mail.gmail.com>
From: Fubo Chen <fubo.chen@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] request for review - DRBD multi volume support for
	3.2
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Aug 8, 2011 at 3:57 PM, Philipp Reisner
<philipp.reisner@linbit.com> wrote:
> This is a request for review of drbd-8.4. I intend to send a pull request
> to Jens early next week, for his for-3.2/drivers branch.
>
> I want to point out the idr_for_each_entry() macro, added to
> include/linux/idr.h. =A0Though we use this macro extensively in the new D=
RBD
> code, it is not DRBD specific. I intend to leave it in this patch series,=
 as
> the following patches depend on it.
>
> The most noticeable change is the support for multiple replicated volumes=
 in
> a single DRBD connection. =A0Write-ordering is obeyed among all writes in=
 all
> volumes in a single connection. =A0This feature is really important for u=
sers
> who DRBD for mirroring over longer distances. (Protocol A).

Does not build here. Is EXPORT_SYMBOL(lc_is_used) missing ?

drivers/block/drbd/drbd_main.c: In function 'drbd_buildtag':
drivers/block/drbd/drbd_main.c:3561:19: warning: the comparison will
always evaluate as 'true' for the address of '__this_module' will
never be NULL [-Waddress]
drivers/block/drbd/drbd_nl.c:2463:12: warning: 'drbd_bmio_set_susp_al'
defined but not used [-Wunused-function]
ERROR: "lc_is_used" [drivers/block/drbd/drbd.ko] undefined!
ERROR: "lc_try_lock" [drivers/block/drbd/drbd.ko] undefined!
ERROR: "drbd_nla_parse_nested" [drivers/block/drbd/drbd.ko] undefined!
ERROR: "drbd_nla_find_nested" [drivers/block/drbd/drbd.ko] undefined!

Fubo.
