Return-Path: <dab21774@gmail.com>
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com
	[209.85.166.47])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id F30DA1028A61
	for <drbd-dev@lists.linbit.com>; Wed,  5 Jun 2019 18:02:55 +0200 (CEST)
Received: by mail-io1-f47.google.com with SMTP id w25so20586062ioc.8
	for <drbd-dev@lists.linbit.com>; Wed, 05 Jun 2019 09:02:55 -0700 (PDT)
Received: from [192.168.1.9] (c-73-78-150-191.hsd1.co.comcast.net.
	[73.78.150.191])
	by smtp.gmail.com with ESMTPSA id 3sm9562258itu.29.2019.06.05.09.02.54
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 09:02:54 -0700 (PDT)
To: drbd-dev@lists.linbit.com
From: David Butterfield <dab21774@gmail.com>
Message-ID: <ca8b7f92-efce-dc39-ddf0-7e0dee15c5b6@gmail.com>
Date: Wed, 5 Jun 2019 10:02:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Drbd-dev] missing newline in call to drbd_info() from
 change_cluster_wide_state()
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

In drbd_state.c:change_cluster_wide_state() there is a drbd_info() call with a missing newline:

@@ -4164,7 +4164,7
        request.mask = cpu_to_be32(context->mask.i);
        request.val = cpu_to_be32(context->val.i);

-       drbd_info(resource, "Preparing cluster-wide state change %u (%u->%d %u/%u)",
+       drbd_info(resource, "Preparing cluster-wide state change %u (%u->%d %u/%u)\n",
                  be32_to_cpu(request.tid),
                  resource->res_opts.node_id,
                  context->target_node_id,

