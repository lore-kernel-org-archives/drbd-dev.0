Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 479A8104B1A2
	for <drbd-dev@lists.linbit.com>; Tue, 23 Feb 2016 09:44:34 +0100 (CET)
Date: Tue, 23 Feb 2016 09:44:33 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: =?utf-8?B?67CV6rK966+8?= <kmpak@mantech.co.kr>
Message-ID: <20160223084433.GG17669@soda.linbit>
References: <CALLFrTR-30gWwnWQU2ArAcj3MZAT1LnfDPO6HWJDdg8-RMr_jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALLFrTR-30gWwnWQU2ArAcj3MZAT1LnfDPO6HWJDdg8-RMr_jQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Cc: Windows DRBD <wdrbd@mantech.co.kr>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Parse error on drbdadm adjust command in drbd-utils
 8.9.6
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

On Tue, Feb 23, 2016 at 11:20:26AM +0900, =EB=B0=95=EA=B2=BD=EB=AF=BC wro=
te:
> Hello
>=20
> Lately, I have updated drbd-utils 8.9.3 to 8.9.6 (with drbd-header).
>=20
> I did not tested all command yet, no problem except *adjust* option.
>=20
> At a glance in documents, in v8.9.6, there are some changes about 'path=
' in
> connection, but I don't know how to use and what kind of parse error.

"adjust" parses both drbd config files,
and the output of "drbdsetup show".

My guess is that the parse error is with the "drbdsetup show" output.

And that an adjust while nothing is configured yet would succeed,
because then the output would be empty.

Please post "drbdsetup show" when adjust fails.

Also, please double check that all used binaries (drbdadm, drbdsetup)
are in fact from the new 8.9.6 build.


--=20
: Lars Ellenberg
: http://www.LINBIT.com | Your Way to High Availability
: DRBD, Linux-HA  and  Pacemaker support and consulting

DRBD=C2=AE and LINBIT=C2=AE are registered trademarks of LINBIT, Austria.
