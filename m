Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id DE178105644E
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id BDB813EFFDD
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:07 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 1s4uvqusyqaX for <drbd-dev@lists.linbit.com>;
	Tue, 26 Apr 2016 14:36:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 9FE353EFFFB
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:07 +0200 (CEST)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id enMPYm2k00Ni for <drbd-dev@lists.linbit.com>;
	Tue, 26 Apr 2016 14:36:07 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 763B93EFFDD
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 14:36:07 +0200 (CEST)
Resent-Message-ID: <20160426123607.GJ20950@soda.linbit>
Received: from proxy.6wind.com (host.76.145.23.62.rev.coltfrance.com
	[62.23.145.76])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 090D4105644B
	for <drbd-dev@lists.linbit.com>; Tue, 26 Apr 2016 10:12:13 +0200 (CEST)
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: netdev@vger.kernel.org
Date: Tue, 26 Apr 2016 10:06:10 +0200
Message-Id: <1461657978-13360-1-git-send-email-nicolas.dichtel@6wind.com>
Cc: dev@openvswitch.org, sd@queasysnail.net, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, jhs@mojatatu.com,
	pshelar@nicira.com, lars.ellenberg@linbit.com, jack@suse.com,
	johannes@sipsolutions.net, philipp.reisner@linbit.com,
	davem@davemloft.net, kvalo@codeaurora.org, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] [PATCH net-next 0/8] netlink: align attributes when
	needed (patchset #3)
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


This is the continuation (series #3) of the work done to align netlink
attributes when these attributes contain some 64-bit fields.

It's the last patchset from what I've seen.

The last user of nla_put_u64() is block/drbd. This module does not use
standard netlink API (see all the stuff in include/linux/genl_magic_struct.h
and include/linux/genl_magic_func.h). I didn't modify it because it's seems
hard to do it whithout testing and fully understanding the context (for
example, why include/linux/drbd_genl.h is not part of uapi?).
Any thoughts?

 Documentation/networking/gen_stats.txt  |   6 +-
 drivers/net/macsec.c                    | 121 +++++++++++++++++++++++---------
 drivers/net/wireless/mac80211_hwsim.c   |   2 +-
 drivers/net/wireless/mac80211_hwsim.h   |   1 +
 fs/quota/netlink.c                      |  12 ++--
 include/net/gen_stats.h                 |   6 +-
 include/uapi/linux/gen_stats.h          |   1 +
 include/uapi/linux/if_link.h            |   1 +
 include/uapi/linux/if_macsec.h          |   6 ++
 include/uapi/linux/inet_diag.h          |   4 +-
 include/uapi/linux/openvswitch.h        |   2 +
 include/uapi/linux/pkt_cls.h            |   2 +
 include/uapi/linux/quota.h              |   1 +
 include/uapi/linux/rtnetlink.h          |   1 +
 include/uapi/linux/tc_act/tc_bpf.h      |   1 +
 include/uapi/linux/tc_act/tc_connmark.h |   1 +
 include/uapi/linux/tc_act/tc_csum.h     |   1 +
 include/uapi/linux/tc_act/tc_defact.h   |   1 +
 include/uapi/linux/tc_act/tc_gact.h     |   1 +
 include/uapi/linux/tc_act/tc_ife.h      |   1 +
 include/uapi/linux/tc_act/tc_ipt.h      |   1 +
 include/uapi/linux/tc_act/tc_mirred.h   |   1 +
 include/uapi/linux/tc_act/tc_nat.h      |   1 +
 include/uapi/linux/tc_act/tc_pedit.h    |   1 +
 include/uapi/linux/tc_act/tc_skbedit.h  |   1 +
 include/uapi/linux/tc_act/tc_vlan.h     |   1 +
 net/core/gen_stats.c                    |  35 +++++----
 net/core/neighbour.c                    |   3 +-
 net/core/rtnetlink.c                    |   4 +-
 net/core/sock_diag.c                    |   2 +-
 net/ipv4/inet_diag.c                    |   9 ++-
 net/openvswitch/datapath.c              |  27 +++----
 net/sched/act_api.c                     |   7 +-
 net/sched/act_bpf.c                     |   3 +-
 net/sched/act_connmark.c                |   3 +-
 net/sched/act_csum.c                    |   2 +-
 net/sched/act_gact.c                    |   2 +-
 net/sched/act_ife.c                     |   2 +-
 net/sched/act_ipt.c                     |   2 +-
 net/sched/act_mirred.c                  |   2 +-
 net/sched/act_nat.c                     |   2 +-
 net/sched/act_pedit.c                   |   2 +-
 net/sched/act_simple.c                  |   2 +-
 net/sched/act_skbedit.c                 |   2 +-
 net/sched/act_vlan.c                    |   2 +-
 net/sched/cls_u32.c                     |   7 +-
 net/sched/sch_api.c                     |   6 +-
 net/sctp/sctp_diag.c                    |   5 +-
 48 files changed, 211 insertions(+), 98 deletions(-)

Comments are welcomed,
Regards,
Nicolas

