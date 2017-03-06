Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 755051056332
	for <drbd-dev@lists.linbit.com>; Mon,  6 Mar 2017 16:57:02 +0100 (CET)
Received: by mail-wm0-f45.google.com with SMTP id n11so67669801wma.1
	for <drbd-dev@lists.linbit.com>; Mon, 06 Mar 2017 07:57:02 -0800 (PST)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	d1sm27575579wrb.62.2017.03.06.07.57.01
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 Mar 2017 07:57:01 -0800 (PST)
Resent-Message-ID: <20170306155700.GM10667@soda.linbit>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id E46881056332
	for <drbd-dev@lists.linbit.com>; Mon,  6 Mar 2017 16:28:55 +0100 (CET)
Date: Mon, 6 Mar 2017 18:22:51 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: agruen@linbit.com
Message-ID: <20170304235644.GA7746@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [bug report] drbd: Backport the "events2" command
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

Hello Andreas Gruenbacher,

The patch a29728463b25: "drbd: Backport the "events2" command" from
Jul 31, 2014, leads to the following static checker warning:

	drivers/block/drbd/drbd_nl.c:4934 get_initial_state()
	error: dereferencing freed memory 'skb'

drivers/block/drbd/drbd_nl.c
  4841  static void notify_initial_state_done(struct sk_buff *skb, unsigned int seq)
  4842  {
  4843          struct drbd_genlmsghdr *dh;
  4844          int err;
  4845  
  4846          err = -EMSGSIZE;
  4847          dh = genlmsg_put(skb, 0, seq, &drbd_genl_family, 0, DRBD_INITIAL_STATE_DONE);
  4848          if (!dh)
  4849                  goto nla_put_failure;
  4850          dh->minor = -1U;
  4851          dh->ret_code = NO_ERROR;
  4852          if (nla_put_notification_header(skb, NOTIFY_EXISTS))
  4853                  goto nla_put_failure;
  4854          genlmsg_end(skb, dh);
  4855          return;
  4856  
  4857  nla_put_failure:
  4858          nlmsg_free(skb);

We free this on error, but it's a void function so it seems like the
callers just assume it succeeded leading to a use after free bug.

(It's also possible that I have misunderstood the refcounting here).

  4859          pr_err("Error %d sending event. Event seq:%u\n", err, seq);
  4860  }

regards,
dan carpenter
