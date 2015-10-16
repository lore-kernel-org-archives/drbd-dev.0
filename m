Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id C1E8710518BE
	for <drbd-dev@lists.linbit.com>; Fri, 16 Oct 2015 13:31:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id B5DBE475572
	for <drbd-dev@lists.linbit.com>; Fri, 16 Oct 2015 13:31:52 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id vblYjMDXXnYl for <drbd-dev@lists.linbit.com>;
	Fri, 16 Oct 2015 13:31:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 97FE6475574
	for <drbd-dev@lists.linbit.com>; Fri, 16 Oct 2015 13:31:52 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KTFGWtIno0wI for <drbd-dev@lists.linbit.com>;
	Fri, 16 Oct 2015 13:31:52 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 7299E475572
	for <drbd-dev@lists.linbit.com>; Fri, 16 Oct 2015 13:31:52 +0200 (CEST)
Date: Fri, 16 Oct 2015 13:31:52 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20151016113152.GS32439@soda.linbit>
References: <1444983195-12439-1-git-send-email-nwang@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1444983195-12439-1-git-send-email-nwang@suse.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] [PATCH] fix failure with new bi_error field of bio
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

On Fri, Oct 16, 2015 at 04:13:15PM +0800, Nick Wang wrote:
> drbd fail to build with new bio structure and interface
> after 4.3.0, see 4246a0b63bd8f56a1469b12eafeb875b1041a451

Yes.
*out-of-tree* drbd, as is in public git right now, that is.

> CC: linux-kernel@vger.kernel.org

No reason to CC linux-kernel, they won't care for out-of-tree drivers.
And the in-tree ones are adjusted to new infrastructure on-the-go,
whenever infrastructure changes. So that's all been done already.

But thanks.

	Lars

--=20
: Lars Ellenberg
: http://www.LINBIT.com | Your Way to High Availability
: DRBD, Linux-HA  and  Pacemaker support and consulting

DRBD=AE and LINBIT=AE are registered trademarks of LINBIT, Austria.
