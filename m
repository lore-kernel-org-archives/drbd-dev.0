Return-Path: <P.Miedzik@gsi.de>
Received: from lxmtout2.gsi.de (lxmtout2.gsi.de [140.181.3.112])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 765981051881
	for <drbd-dev@lists.linbit.com>; Wed,  6 Jul 2016 10:07:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lxmtout2.gsi.de (Postfix) with ESMTP id 246155D4
	for <drbd-dev@lists.linbit.com>; Wed,  6 Jul 2016 09:58:48 +0200 (CEST)
Received: from lxmtout2.gsi.de ([127.0.0.1])
	by localhost (lxmtout2.gsi.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qTpsVJ4JVVEy for <drbd-dev@lists.linbit.com>;
	Wed,  6 Jul 2016 09:58:48 +0200 (CEST)
Received: from W2k053.campus.gsi.de (w2k053.gsi.de [10.10.4.27])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by lxmtout2.gsi.de (Postfix) with ESMTPS id C3A6139C
	for <drbd-dev@lists.linbit.com>; Wed,  6 Jul 2016 09:58:47 +0200 (CEST)
From: "Miedzik, Piotr Bogdan" <P.Miedzik@gsi.de>
To: "'drbd-dev@lists.linbit.com'" <drbd-dev@lists.linbit.com>
Date: Wed, 6 Jul 2016 07:58:46 +0000
Message-ID: <B7D370631C221640AE09F705C57A14F37329FAF0@W2K050.campus.gsi.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Drbd-dev] [PATCH] drbd.ocf: drbdsetup v9 has no sh-status command
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

https://github.com/qermit/drbd-utils

---
 scripts/drbd.ocf | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/scripts/drbd.ocf b/scripts/drbd.ocf
index eee8d62..3995a24 100755
--- a/scripts/drbd.ocf
+++ b/scripts/drbd.ocf
@@ -359,13 +359,19 @@ drbd_set_status_variables() {
        DRBD_DSTATE_LOCAL=3D()
        DRBD_DSTATE_REMOTE=3D()

-       if $DRBD_HAS_MULTI_VOLUME ; then
-               out=3D"$($DRBDSETUP sh-status "$DRBD_RESOURCE")" && eval "$=
out"
-       else
-               # without "MULTI_VOLUME", the DRBD_DEVICES array
-               # should contain exactly one value
-               out=3D"$($DRBDSETUP "$DRBD_DEVICES" sh-status)" && eval "$o=
ut"
-       fi
+       while : ; do
+               read -r tmp_resource tmp_nodeid tmp_role tmp_suspended
+               DRBD_ROLE_LOCAL[0]=3D${tmp_role#role:}
+               read -r tmp_volume tmp_minor tmp_dstate tmp_blocked
+               DRBD_DSTATE_LOCAL[0]=3D${tmp_dstate#disk:}
+               read -r tmp_remotenode tmp_remotenodeid tmp_remoteconnected=
 tmp_remoterole tmp_remotecongested
+               DRBD_CSTATE[0]=3D${tmp_remoteconnected#connection:}
+               DRBD_ROLE_REMOTE[0]=3D${tmp_remoterole#role:}
+               read -r tmp_remotevolume tmp_replication tmp_remotedstate t=
mp_resync
+               DRBD_DSTATE_REMOTE[0]=3D${tmp_remotedstate#peer-disk:}
+               break
+       done < <($DRBDSETUP status $DRBD_RESOURCE --verbose)
+

        # if there was no output at all, or a weird output
        # make sure the status arrays won't be empty.
--
1.8.3.1
