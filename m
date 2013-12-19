Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 68036105B0C7
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id 249F32B7730
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:53 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id C0vjdaISBWkS for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zimbra13.linbit.com (Postfix) with ESMTP id E609D2B7731
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:52 +0100 (CET)
Received: from zimbra13.linbit.com ([127.0.0.1])
	by localhost (zimbra13.linbit.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VlXNmSUvgzMN for <drbd-dev@lists.linbit.com>;
	Fri, 20 Dec 2013 10:16:52 +0100 (CET)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra13.linbit.com (Postfix) with ESMTPS id 515722B7737
	for <drbd-dev@lists.linbit.com>; Fri, 20 Dec 2013 10:16:52 +0100 (CET)
Resent-Message-ID: <20131220091652.GM31214@soda.linbit>
Date: Thu, 19 Dec 2013 15:17:33 +0530
From: Rashika Kheria <rashika.kheria@gmail.com>
To: linux-kernel@vger.kernel.org
Message-ID: <9f865bdcccb0ff88460787a7a33bdd7faa411d39.1387445397.git.rashika.kheria@gmail.com>
References: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f460591345e87defe53122cf056991c7f2eefa10.1387445396.git.rashika.kheria@gmail.com>
Content-Transfer-Encoding: quoted-printable
Cc: josh@joshtriplett.org, drbd-user@lists.linbit.com,
	Lars Ellenberg <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] [PATCH 11/13] drivers: block: Mark functions as static
	in drbd_nl.c
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

Mark functions conn_khelper(), nla_put_drbd_cfg_context(),
nla_put_status_info() and get_one_status() as static in drbd/drbd_nl.c
because they are not used outside this file.

This eliminates the following warnings in drbd/drbd_nl.c:
drivers/block/drbd/drbd_nl.c:365:5: warning: no previous prototype for =E2=
=80=98conn_khelper=E2=80=99 [-Wmissing-prototypes]
drivers/block/drbd/drbd_nl.c:2727:5: warning: no previous prototype for =E2=
=80=98nla_put_drbd_cfg_context=E2=80=99 [-Wmissing-prototypes]
drivers/block/drbd/drbd_nl.c:2753:5: warning: no previous prototype for =E2=
=80=98nla_put_status_info=E2=80=99 [-Wmissing-prototypes]
drivers/block/drbd/drbd_nl.c:2895:5: warning: no previous prototype for =E2=
=80=98get_one_status=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/block/drbd/drbd_nl.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index c706d50..4c00837 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -362,7 +362,7 @@ int drbd_khelper(struct drbd_conf *mdev, char *cmd)
 	return ret;
 }
=20
-int conn_khelper(struct drbd_tconn *tconn, char *cmd)
+static int conn_khelper(struct drbd_tconn *tconn, char *cmd)
 {
 	char *envp[] =3D { "HOME=3D/",
 			"TERM=3Dlinux",
@@ -2724,7 +2724,8 @@ int drbd_adm_outdate(struct sk_buff *skb, struct ge=
nl_info *info)
 	return drbd_adm_simple_request_state(skb, info, NS(disk, D_OUTDATED));
 }
=20
-int nla_put_drbd_cfg_context(struct sk_buff *skb, struct drbd_tconn *tco=
nn, unsigned vnr)
+static int nla_put_drbd_cfg_context(struct sk_buff *skb,
+		struct drbd_tconn *tconn, unsigned vnr)
 {
 	struct nlattr *nla;
 	nla =3D nla_nest_start(skb, DRBD_NLA_CFG_CONTEXT);
@@ -2750,7 +2751,7 @@ nla_put_failure:
 	return -EMSGSIZE;
 }
=20
-int nla_put_status_info(struct sk_buff *skb, struct drbd_conf *mdev,
+static int nla_put_status_info(struct sk_buff *skb, struct drbd_conf *md=
ev,
 		const struct sib_info *sib)
 {
 	struct state_info *si =3D NULL; /* for sizeof(si->member); */
@@ -2892,7 +2893,7 @@ out:
 	return 0;
 }
=20
-int get_one_status(struct sk_buff *skb, struct netlink_callback *cb)
+static int get_one_status(struct sk_buff *skb, struct netlink_callback *=
cb)
 {
 	struct drbd_conf *mdev;
 	struct drbd_genlmsghdr *dh;
--=20
1.7.9.5

