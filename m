Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (unknown [10.9.9.55])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id D538E10556CA
	for <drbd-dev@lists.linbit.com>; Mon, 14 Nov 2011 11:52:02 +0100 (CET)
Resent-Message-ID: <20111114105202.GA11469@barkeeper1-xen.linbit>
Received: from adam.pmcipa.com (adam.pmcipa.com [71.9.23.14])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 409FD10556B9
	for <drbd-dev@lists.linbit.com>; Sun, 13 Nov 2011 12:52:52 +0100 (CET)
Received: from ipa-vault.nvipa.com (fw1-dmz.pmcipa.com [71.9.23.9])
	by adam.pmcipa.com (Postfix) with ESMTP id 06C7F4B0116
	for <drbd-dev@lists.linbit.com>; Sun, 13 Nov 2011 03:35:37 -0800 (PST)
From: "Robinson, Eric" <eric.robinson@psmnv.com>
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Nov 2011 03:34:38 -0800
Message-ID: <768FEA3F936926468F594E3CA7741FE80368307C@ipa-vault.nvipa.com>
References: <4EBF8022.6020202@hastexo.com>
To: "Florian Haas" <florian@hastexo.com>, <drbd-dev@lists.linbit.com>,
	"The Pacemaker cluster resource manager" <pacemaker@oss.clusterlabs.org>
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

> Lars/Andrew,
>=20
> While Eric is evidently on a DRBD version whose=20
> ocf:linbit:drbd does not invoke crm_attribute with the flag=20
> to suppress logging, I'm mildly confused as to what the=20
> correct flag actually is. ocf:linbit:drbd (in both 8.3 and=20
> 8.4) uses "-Q" whereas Pacemaker expects "-q" as of this
> commit:
>=20

FYI, this particular cluster is running DRBD 8.3.2.

--Eric





Disclaimer - November 13, 2011=20
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
