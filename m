Return-Path: <grawert@b1-systems.de>
Received: from mx1.b1-systems.de (schattenjagd.systems.b1-systems.de
	[217.11.58.34])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 31E7E1058DED
	for <drbd-dev@lists.linbit.com>; Mon, 15 Nov 2010 14:53:04 +0100 (CET)
Received: from groupware.intern.b1-systems.de (midgard.systems.b1-systems.de
	[85.10.208.34])
	by mx1.b1-systems.de (Postfix) with ESMTPSA id 5835A4051
	for <drbd-dev@lists.linbit.com>; Mon, 15 Nov 2010 14:53:04 +0100 (CET)
Message-ID: <20101115145304.121957du5vfxdv0g@groupware.intern.b1-systems.de>
Date: Mon, 15 Nov 2010 14:53:04 +0100
From: Uwe Grawert <grawert@b1-systems.de>
To: drbd-dev@lists.linbit.com
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Drbd-dev] drbd.ocf Split-Brain detection patch
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,

the following is a patch for the OCF Agent script, to detect a =20
Split-Brain and turn the resource into unmanaged mode if a Split-Brain =20
has been detected. This is not meant as a substitution for a fencing =20
mechanism but as a help to discover a Split-Brain when setting up a =20
cluster.


--- /usr/lib/ocf/resource.d/linbit/drbd=092010-10-28 14:58:05.000000000 +02=
00
+++ drbd.split-brain.patch=092010-11-15 14:28:46.000000000 +0100
@@ -405,6 +405,9 @@
  =09case "${DRBD_ROLE_LOCAL}" in
  =09Primary)
  =09=09rc=3D$OCF_RUNNING_MASTER
+=09=09# This Node is Primary but StandAlone, there must be a Split-Brain
+=09=09[[ $OCF_RESKEY_CRM_meta_master_max =3D 2 && $DRBD_CSTATE =3D "StandA=
lone" ]] \
+=09=09&& rc=3D$OCF_ERR_CONFIGURED
  =09=09;;
  =09Secondary)
  =09=09rc=3D$OCF_SUCCESS
@@ -518,6 +521,11 @@
  =09=09$OCF_RUNNING_MASTER)
  =09=09=09ocf_log warn "$DRBD_RESOURCE already Primary, demoting."
  =09=09=09do_drbdadm secondary $DRBD_RESOURCE
+=09=09=09;;
+=09=09$OCF_ERR_CONFIGURED)
+=09=09=09ocf_log warn "Split-Brain detected! See DRBD logging output."
+=09=09=09rc=3D$status
+=09=09=09break
  =09=09esac
  =09=09$first_try || sleep 1
  =09=09first_try=3Dfalse
@@ -560,6 +568,11 @@
  =09=09$OCF_RUNNING_MASTER)
  =09=09=09rc=3D$OCF_SUCCESS
  =09=09=09break
+=09=09=09;;
+=09=09$OCF_ERR_CONFIGURED)
+=09=09=09ocf_log warn "Split-Brain detected! See DRBD logging output."
+=09=09=09rc=3D$status
+=09=09=09break
  =09=09esac
  =09=09$first_try || sleep 1
  =09=09first_try=3Dfalse
@@ -591,6 +604,11 @@
  =09=09=09;;
  =09=09$OCF_RUNNING_MASTER)
  =09=09=09do_drbdadm secondary $DRBD_RESOURCE
+=09=09=09;;
+=09=09=09$OCF_ERR_CONFIGURED)
+=09=09=09ocf_log warn "Split-Brain detected! See DRBD logging output."
+=09=09=09rc=3D$status
+=09=09=09break
  =09=09esac
  =09=09$first_try || sleep 1
  =09=09first_try=3Dfalse
@@ -619,6 +637,11 @@
  =09=09$OCF_RUNNING_MASTER)
  =09=09=09ocf_log warn "$DRBD_RESOURCE still Primary, demoting."
  =09=09=09do_drbdadm secondary  $DRBD_RESOURCE
+=09=09=09;;
+=09=09$OCF_ERR_CONFIGURED)
+=09=09=09ocf_log warn "Split-Brain detected! See DRBD logging output."
+=09=09=09rc=3D$status
+=09=09=09break
  =09=09esac
  =09=09$first_try || sleep 1
  =09=09first_try=3Dfalse

--=20
Uwe Grawert
Linux / Unix Consultant & Trainer
Tel.: +49 151 12051100
Mail: grawert@b1-systems.de

B1 Systems GmbH
Osterfeldstra=DFe 7 / 85088 Vohburg / http://www.b1-systems.de
GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt,HRB 3537



