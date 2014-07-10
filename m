Return-Path: <lwang@suse.com>
Received: from soto.provo.novell.com (soto.provo.novell.com [137.65.250.214])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 2AFB5101AC71
	for <drbd-dev@lists.linbit.com>; Thu, 10 Jul 2014 09:49:40 +0200 (CEST)
Message-Id: <53BEB579020000A000009DFF@soto.provo.novell.com>
Date: Thu, 10 Jul 2014 01:47:05 -0600
From: "Liuhua Wang" <lwang@suse.com>
To: "Roland Kammerer" <roland.kammerer@linbit.com>
References: <53B6ED86020000A0000099B9@soto.provo.novell.com>
	<20140707083415.GA1962@rck.sh>
In-Reply-To: <20140707083415.GA1962@rck.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Cc: drbd-dev@lists.linbit.com
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

Hi Roland,
=20
>=20
> I checked with one of our senior-devs and you are actually using
> depricated behavior. What you should use is /dev/drbd/by-*, and not the
> device name in /dev.
>=20

I tested pacemaker+drbd8.4.5+drbd-utils-8.9.0,
drbd resource will fail to start in case of device name
different from drbd%minor. for example:

# cat /etc/drbd.d/test.res
---------------------------
resource test {
   protocol	C;
   disk {
      on-io-error	pass_on;
   }
   on vm13-sle12b8 {
      address	192.168.124.13:7788;
      device	/dev/drbd_r0 minor 0;
      disk	/dev/sda4;
      meta-disk	internal;
   }
   on vm14-sle12b8 {
      address	192.168.124.14:7788;
      device	/dev/drbd_r0 minor 0;
      disk	/dev/sda4;
      meta-disk	internal;
   }
}
-------------------

That is because in drbd_start will wait forever for the
drbd%minor settled in loop:
----------------=20
my_udevsettle()
{
        for dev in ${DRBD_DEVICES[@]}; do
                while ! test -b $dev; do
                        sleep 1;
                done
        done
        return 0
}
----------------

I think there is either of the following way to resolve it.
1. fix drbd.rules by adding SYMLINK to drbd%minor
2. fix drbd.ocf not waiting DRBD_DEVICES but drbd%minor

What do you thinks?

> regards, rck
>=20
>=20


