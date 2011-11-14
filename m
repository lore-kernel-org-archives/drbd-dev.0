Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id BAB581055706
	for <drbd-dev@lists.linbit.com>; Mon, 14 Nov 2011 11:53:29 +0100 (CET)
Resent-Message-ID: <20111114105329.GD11469@barkeeper1-xen.linbit>
Received: from adam.pmcipa.com (adam.pmcipa.com [71.9.23.14])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A95DA1055705
	for <drbd-dev@lists.linbit.com>; Mon, 14 Nov 2011 11:43:54 +0100 (CET)
Received: from ipa-vault.nvipa.com (fw1-dmz.pmcipa.com [71.9.23.9])
	by adam.pmcipa.com (Postfix) with ESMTP id D44B44B035E
	for <drbd-dev@lists.linbit.com>; Mon, 14 Nov 2011 02:44:55 -0800 (PST)
From: "Robinson, Eric" <eric.robinson@psmnv.com>
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Nov 2011 02:43:51 -0800
Message-ID: <768FEA3F936926468F594E3CA7741FE8036830A1@ipa-vault.nvipa.com>
References: <4EBF8022.6020202@hastexo.com>
	<768FEA3F936926468F594E3CA7741FE80368307C@ipa-vault.nvipa.com>
	<4EBFE9CD.1020302@hastexo.com>
	<768FEA3F936926468F594E3CA7741FE80368307D@ipa-vault.nvipa.com>
	<4EBFF64D.50607@hastexo.com>
To: "Florian Haas" <florian@hastexo.com>
Cc: The Pacemaker cluster resource manager <pacemaker@oss.clusterlabs.org>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] crm_attribute --quiet (was Fwd: [Linux-HA] Should
	This Worry Me?)
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

> > Fair enough. I was only concerned because of that --reboot=20
> switch in=20
> > there.
>=20
> No, that only means that the node attribute being set has a=20
> lifetime of "until the next cluster reboot", meaning it's=20
> only stored in the volatile "status" section of the CIB.
>=20


Good to know. Thanks. :-)

--Eric



Disclaimer - November 14, 2011=20
This email and any files transmitted with it are confidential and =
intended solely for Florian Haas,drbd-dev@lists.linbit.com,The Pacemaker =
cluster resource manager. If you are not the named addressee you should =
not disseminate, distribute, copy or alter this email. Any views or =
opinions presented in this email are solely those of the author and =
might not represent those of Physicians' Managed Care or Physician =
Select Management. Warning: Although Physicians' Managed Care or =
Physician Select Management has taken reasonable precautions to ensure =
no viruses are present in this email, the company cannot accept =
responsibility for any loss or damage arising from the use of this email =
or attachments.=20
This disclaimer was added by Policy Patrol: http://www.policypatrol.com/
