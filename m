Return-Path: <en@lightwerk.com>
Received: from mail2.lightwerk.com (mail2.lightwerk.com [213.23.242.244])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id F3B951057D4F
	for <drbd-dev@lists.linbit.com>; Wed,  1 Jun 2011 14:02:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail2.lightwerk.com (Postfix) with ESMTP id 3C5CB123BBF
	for <drbd-dev@lists.linbit.com>; Wed,  1 Jun 2011 14:02:47 +0200 (CEST)
Received: from mail2.lightwerk.com ([127.0.0.1])
	by localhost (mail2.lightwerk.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 06892-08 for <drbd-dev@lists.linbit.com>;
	Wed,  1 Jun 2011 14:02:32 +0200 (CEST)
Received: from ibiza.lightwerk.loc (unknown [192.168.1.46])
	by mail2.lightwerk.com (Postfix) with ESMTP id 0AB59113F38
	for <drbd-dev@lists.linbit.com>; Wed,  1 Jun 2011 14:02:32 +0200 (CEST)
Date: Wed, 1 Jun 2011 14:02:30 +0200
From: Eric Price <en@lightwerk.com>
To: drbd-dev@lists.linbit.com
Message-ID: <20110601140230.5cdf7c56@ibiza.lightwerk.loc>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/ztDPeYk21m33YOZUjwiZ6tY"
Subject: [Drbd-dev] drbd-8.4.0-rc2 Pacemaker ocf resource agent script bugfix
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

--MP_/ztDPeYk21m33YOZUjwiZ6tY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


I dunno if you guys already spotted and/or fixed that in git.


The drbd resource agent makes a check in "dual primary configuration"
whether

> drbdadm <resource> -d -v dump

includes a line called

> allow-two-primaries;

however with 8.4.x drbdadmin reports that line as

> allow-two-primaries yes;

(even though drbd still accepts the old syntax in the config file)

Thus the regex grep in the resource agent doesn't find it, and the
resource startup fails.

My fix just checks for an optional [ yes] in front of the ; and the
resource management works again.


Hope that helps.


Cheers

--=20
Eric Price
Linux Solutions / Development

Lightwerk GmbH - www.lightwerk.com
Schulze-Delitzsch-Str. 38, 70565 Stuttgart
E-Mail: en@lightwerk.com

Gesch=C3=A4ftsf=C3=BChrender Gesellschafter: Veikko W=C3=BCnsche
Amtsgericht Stuttgart, HRB 22214
Ust.-ID: DE 813315708


--MP_/ztDPeYk21m33YOZUjwiZ6tY
Content-Type: text/x-patch; name=drbd_resource.patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=drbd_resource.patch

--- drbd.ocf.orig	2011-06-01 13:08:05.331245528 +0200
+++ drbd.ocf		2011-06-01 13:08:04.597124211 +0200
@@ -867,7 +867,7 @@
 	case $__OCF_ACTION:$OCF_RESKEY_CRM_meta_master_max in
 	start:2|promote:2)
 		if ! $DRBDADM -d -v dump $DRBD_RESOURCE 2>/dev/null |
-			grep '^[[:space:]]*allow-two-primaries;$'
+			grep '^[[:space:]]*allow-two-primaries\( yes\)\?;$'
 		then
 			ocf_log err "master-max =3D 2, but DRBD resource $DRBD_RESOURCE does no=
t allow-two-primaries."
 			return $OCF_ERR_CONFIGURED

--MP_/ztDPeYk21m33YOZUjwiZ6tY--
