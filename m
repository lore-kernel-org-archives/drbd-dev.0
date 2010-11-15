Return-Path: <grawert@b1-systems.de>
Received: from mx1.b1-systems.de (schattenjagd.systems.b1-systems.de
	[217.11.58.34])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7150F1058DE1
	for <drbd-dev@lists.linbit.com>; Mon, 15 Nov 2010 15:55:46 +0100 (CET)
Received: from groupware.intern.b1-systems.de (midgard.systems.b1-systems.de
	[85.10.208.34])
	by mx1.b1-systems.de (Postfix) with ESMTPSA id 3E0454051
	for <drbd-dev@lists.linbit.com>; Mon, 15 Nov 2010 15:55:46 +0100 (CET)
Message-ID: <20101115155546.15091v5tmmvzj75e@groupware.intern.b1-systems.de>
Date: Mon, 15 Nov 2010 15:55:46 +0100
From: Uwe Grawert <grawert@b1-systems.de>
To: drbd-dev@lists.linbit.com
References: <20101115145304.121957du5vfxdv0g@groupware.intern.b1-systems.de>
	<20101115142144.GA20084@barkeeper1-xen.linbit>
In-Reply-To: <20101115142144.GA20084@barkeeper1-xen.linbit>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Drbd-dev] drbd.ocf Split-Brain detection patch
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


Zitat von Lars Ellenberg <lars.ellenberg@linbit.com>:

>> --- /usr/lib/ocf/resource.d/linbit/drbd=092010-10-28 14:58:05.000000000 =
+0200
>> +++ drbd.split-brain.patch=092010-11-15 14:28:46.000000000 +0100
>> @@ -405,6 +405,9 @@
>>  =09case "${DRBD_ROLE_LOCAL}" in
>>  =09Primary)
>>  =09=09rc=3D$OCF_RUNNING_MASTER
>> +=09=09# This Node is Primary but StandAlone, there must be a Split-Brai=
n
>> +=09=09[[ $OCF_RESKEY_CRM_meta_master_max =3D 2 && $DRBD_CSTATE =3D =20
>> "StandAlone" ]] \
>> +=09=09&& rc=3D$OCF_ERR_CONFIGURED
>
> If only it was so easy.  It it not.
> There are other ways to end up in StandAlone.

Ok. Meaning there is no way to determine a Split-Brain at a central =20
point like this? This one is off course what I experienced while =20
setting up a cluster.

--=20
Uwe Grawert
Linux / Unix Consultant & Trainer
Tel.: +49 151 12051100
Mail: grawert@b1-systems.de

B1 Systems GmbH
Osterfeldstra=DFe 7 / 85088 Vohburg / http://www.b1-systems.de
GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt,HRB 3537



