Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2AA581051881
	for <drbd-dev@lists.linbit.com>; Fri, 24 Feb 2017 15:58:53 +0100 (CET)
Received: by mail-wm0-f51.google.com with SMTP id v77so16433445wmv.0
	for <drbd-dev@lists.linbit.com>; Fri, 24 Feb 2017 06:58:53 -0800 (PST)
Received: from soda.linbit ([86.59.100.100]) by smtp.gmail.com with ESMTPSA id
	b10sm2624835wmi.34.2017.02.24.06.58.50
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 Feb 2017 06:58:51 -0800 (PST)
Resent-Message-ID: <20170224145849.GT21236@soda.linbit>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 112C41051881
	for <drbd-dev@lists.linbit.com>; Thu, 23 Feb 2017 16:55:44 +0100 (CET)
Date: Thu, 23 Feb 2017 18:55:08 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: agruen@linbit.com
Message-ID: <20170223155508.GA12798@mwanda>
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
  4880  static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
  4881  {
  4882          struct drbd_state_change *state_change = (struct drbd_state_change *)cb->args[0];
  4883          unsigned int seq = cb->args[2];
  4884          unsigned int n;
  4885          enum drbd_notification_type flags = 0;
  4886  
  4887          /* There is no need for taking notification_mutex here: it doesn't
  4888             matter if the initial state events mix with later state chage
  4889             events; we can always tell the events apart by the NOTIFY_EXISTS
  4890             flag. */
  4891  
  4892          cb->args[5]--;
  4893          if (cb->args[5] == 1) {
  4894                  notify_initial_state_done(skb, seq);
                                                  ^^^
skb is freed on error inside notify_initial_state_done().

  4895                  goto out;
  4896          }
  4897          n = cb->args[4]++;
  4898          if (cb->args[4] < cb->args[3])
  4899                  flags |= NOTIFY_CONTINUES;
  4900          if (n < 1) {
  4901                  notify_resource_state_change(skb, seq, state_change->resource,
  4902                                               NOTIFY_EXISTS | flags);
  4903                  goto next;
  4904          }
  4905          n--;
  4906          if (n < state_change->n_connections) {
  4907                  notify_connection_state_change(skb, seq, &state_change->connections[n],
  4908                                                 NOTIFY_EXISTS | flags);
  4909                  goto next;
  4910          }
  4911          n -= state_change->n_connections;
  4912          if (n < state_change->n_devices) {
  4913                  notify_device_state_change(skb, seq, &state_change->devices[n],
  4914                                             NOTIFY_EXISTS | flags);
  4915                  goto next;
  4916          }
  4917          n -= state_change->n_devices;
  4918          if (n < state_change->n_devices * state_change->n_connections) {
  4919                  notify_peer_device_state_change(skb, seq, &state_change->peer_devices[n],
  4920                                                  NOTIFY_EXISTS | flags);
  4921                  goto next;
  4922          }
  4923  
  4924  next:
  4925          if (cb->args[4] == cb->args[3]) {
  4926                  struct drbd_state_change *next_state_change =
  4927                          list_entry(state_change->list.next,
  4928                                     struct drbd_state_change, list);
  4929                  cb->args[0] = (long)next_state_change;
  4930                  cb->args[3] = notifications_for_state_change(next_state_change);
  4931                  cb->args[4] = 0;
  4932          }
  4933  out:
  4934          return skb->len;
                       ^^^^^^^^
Dereference.

  4935  }

regards,
dan carpenter
