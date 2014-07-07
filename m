Return-Path: <lwang@suse.com>
Received: from soto.provo.novell.com (soto.provo.novell.com [137.65.250.214])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 72CD1101AC75
	for <drbd-dev@lists.linbit.com>; Mon,  7 Jul 2014 10:48:16 +0200 (CEST)
Message-Id: <53BACEB7020000A000009B23@soto.provo.novell.com>
Date: Mon, 07 Jul 2014 02:45:43 -0600
From: "Liuhua Wang" <lwang@suse.com>
To: "Roland Kammerer" <roland.kammerer@linbit.com>, <drbd-dev@lists.linbit.com>
References: <53B6ED86020000A0000099B9@soto.provo.novell.com>
	<20140707083415.GA1962@rck.sh>
In-Reply-To: <20140707083415.GA1962@rck.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Drbd-dev] [PATCH 1/1] fix drbd.rules to avoid start drbd fail
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

Hi, Roland

>>> On 7/7/2014 at 04:34 PM, in message <20140707083415.GA1962@rck.sh>, =
Roland
Kammerer <roland.kammerer@linbit.com> wrote:=20
> On Fri, Jul 04, 2014 at 04:08:06AM -0600, Liuhua Wang wrote:
> > Hi, Roland
> >=20
> > Thank you for you reply.
>=20
> You should really use the ML and not send me private mails...

Sorry, I forgot "cc" to ML.

> >=20
> > There is only drbd0 under /dev/.
> > I think if user can set the device name to "/dev/drbd_r0"
> > it will be better to have the name under /dev.
> >=20
>=20
> I checked with one of our senior-devs and you are actually using
> depricated behavior. What you should use is /dev/drbd/by-*, and not the
> device name in /dev.
OK, we can use /dev/drbd/by-*, but still there is rename problem
in your udev rules, except not permit user to configure the device name.

Regards,
 Liuhua
--
Liuhua Wang
lwang@suse.com

> regards, rck
>=20
>=20


