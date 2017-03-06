Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DB05B1056484
	for <drbd-dev@lists.linbit.com>; Mon,  6 Mar 2017 16:59:00 +0100 (CET)
Received: by mail-wm0-f50.google.com with SMTP id v186so67699012wmd.0
	for <drbd-dev@lists.linbit.com>; Mon, 06 Mar 2017 07:59:00 -0800 (PST)
Date: Mon, 6 Mar 2017 16:58:58 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20170306155858.GN10667@soda.linbit>
References: <20170304235644.GA7746@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170304235644.GA7746@mwanda>
Cc: agruen@linbit.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [bug report] drbd: Backport the "events2" command
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


Dan, you may have missed my earlier reply to your earlier post.

On Thu, Feb 23, 2017 at 06:55:08PM +0300, Dan Carpenter wrote:
> Hello Andreas Gruenbacher,

Andreas has since moved to more exiting challenges :)

> The patch a29728463b25: "drbd: Backport the "events2" command" from
> Jul 31, 2014, leads to the following static checker warning:
>
>       drivers/block/drbd/drbd_nl.c:4934 get_initial_state()
>       error: dereferencing freed memory 'skb'
>
> drivers/block/drbd/drbd_nl.c
>   4880  static int get_initial_state(struct sk_buff *skb, struct
>   netlink_callback *cb)
>   4881  {
>   4882          struct drbd_state_change *state_change = (struct
>   drbd_state_change *)cb->args[0];
>   4883          unsigned int seq = cb->args[2];
>   4884          unsigned int n;
>   4885          enum drbd_notification_type flags = 0;
>   4886
>   4887          /* There is no need for taking notification_mutex
>   here: it doesn't
>   4888             matter if the initial state events mix with later
>   state chage
>   4889             events; we can always tell the events apart by the
>   NOTIFY_EXISTS
>   4890             flag. */
>   4891
>   4892          cb->args[5]--;
>   4893          if (cb->args[5] == 1) {
>   4894                  notify_initial_state_done(skb, seq);
>                                                   ^^^
> skb is freed on error inside notify_initial_state_done().

So notify_resource_state_change needs to become non void,
and we need to change notify_initial_state_done(); goto out;
to return notify_initial_state_done();

right?

--
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
