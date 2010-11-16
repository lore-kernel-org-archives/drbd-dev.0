Return-Path: <grawert@b1-systems.de>
Received: from mx1.b1-systems.de (schattenjagd.systems.b1-systems.de
	[217.11.58.34])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 3F4281058DE2
	for <drbd-dev@lists.linbit.com>; Tue, 16 Nov 2010 10:33:31 +0100 (CET)
Received: from groupware.intern.b1-systems.de (midgard.systems.b1-systems.de
	[85.10.208.34])
	by mx1.b1-systems.de (Postfix) with ESMTPSA id 54FA64051
	for <drbd-dev@lists.linbit.com>; Tue, 16 Nov 2010 10:33:31 +0100 (CET)
Message-ID: <20101116103331.74464skgusdrk73f@groupware.intern.b1-systems.de>
Date: Tue, 16 Nov 2010 10:33:31 +0100
From: Uwe Grawert <grawert@b1-systems.de>
To: drbd-dev@lists.linbit.com
References: <20101115145304.121957du5vfxdv0g@groupware.intern.b1-systems.de>
	<20101115142144.GA20084@barkeeper1-xen.linbit>
	<20101115155546.15091v5tmmvzj75e@groupware.intern.b1-systems.de>
	<20101115170313.GE20084@barkeeper1-xen.linbit>
In-Reply-To: <20101115170313.GE20084@barkeeper1-xen.linbit>
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

> On Mon, Nov 15, 2010 at 03:55:46PM +0100, Uwe Grawert wrote:
>>
>> Zitat von Lars Ellenberg <lars.ellenberg@linbit.com>:
>>
>> >>--- /usr/lib/ocf/resource.d/linbit/drbd=092010-10-28 =20
>> 14:58:05.000000000 +0200
>> >>+++ drbd.split-brain.patch=092010-11-15 14:28:46.000000000 +0100
>> >>@@ -405,6 +405,9 @@
>> >> =09case "${DRBD_ROLE_LOCAL}" in
>> >> =09Primary)
>> >> =09=09rc=3D$OCF_RUNNING_MASTER
>> >>+=09=09# This Node is Primary but StandAlone, there must be a Split-Br=
ain
>> >>+=09=09[[ $OCF_RESKEY_CRM_meta_master_max =3D 2 && $DRBD_CSTATE =3D
>> >>"StandAlone" ]] \
>> >>+=09=09&& rc=3D$OCF_ERR_CONFIGURED
>> >
>> >If only it was so easy.  It it not.
>> >There are other ways to end up in StandAlone.
>>
>> Ok. Meaning there is no way to determine a Split-Brain at a central
>> point like this? This one is off course what I experienced while
>> setting up a cluster.
>
> Not really, no.
> Maybe you can use your "split-brain" notification handler to do it?

That is possible. The intention was to show in the crm status that =20
there is a problem. This is especially helpful if you`re new to DRBD. =20
But if only one of several possible situations can be recognized, the =20
patch doesn't make much sense.

--=20
Uwe Grawert
Linux / Unix Consultant & Trainer
Tel.: +49 151 12051100
Mail: grawert@b1-systems.de

B1 Systems GmbH
Osterfeldstra=DFe 7 / 85088 Vohburg / http://www.b1-systems.de
GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt,HRB 3537



