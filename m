Return-Path: <grawert@b1-systems.de>
Received: from mx1.b1-systems.de (unknown [217.11.58.34])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 233C31059360
	for <drbd-dev@lists.linbit.com>; Wed,  3 Nov 2010 09:04:31 +0100 (CET)
Received: from groupware.intern.b1-systems.de (midgard.systems.b1-systems.de
	[85.10.208.34])
	by mx1.b1-systems.de (Postfix) with ESMTPSA id 061604072
	for <drbd-dev@lists.linbit.com>; Wed,  3 Nov 2010 08:55:15 +0100 (CET)
Message-ID: <20101103085515.16500maycqm4c2ub@groupware.intern.b1-systems.de>
Date: Wed, 03 Nov 2010 08:55:15 +0100
From: Uwe Grawert <grawert@b1-systems.de>
To: drbd-dev@lists.linbit.com
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Drbd-dev] DRBD Resource Agent flaw when stopping
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hello,

in the OCF Resource Agent (ocf:linbit:drbd) is a flaw, when cleaning =20
up a resource and stopping the resource afterwards. The resource agent =20
returns a OCF_ERR_CONFIGURED which happens because of the following =20
lines:

if [[ ${OCF_RESKEY_CRM_meta_notify_start_uname- NOT SET } =3D " NOT SET =20
" ]]; then
=09ocf_log err "you really should enable notify when using this RA"
=09return $OCF_ERR_CONFIGURED
fi

After a cleanup of a started resource the variable =20
OCF_RESKEY_CRM_meta_notify_start_uname is empty. A simple and quick =20
solution would be to add "stop" to the following block in a case switch:

case $__OCF_ACTION in
monitor|validate-all)
:;;

This is line 778 in the Resource Agent. In my opinion it does not make =20
much sense to make the "is notify enabled" check when stopping a =20
resource. Hence it seems reasonable to exclude a stop action from this =20
check.

Is there something that speaks against it? If not, I will send a patch =20
to this list.

--=20
Uwe Grawert
Linux / Unix Consultant & Trainer
Tel.: +49 151 12051100
Mail: grawert@b1-systems.de

B1 Systems GmbH
Osterfeldstra=DFe 7 / 85088 Vohburg / http://www.b1-systems.de
GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt,HRB 3537



