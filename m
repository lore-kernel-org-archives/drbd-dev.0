Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Problems at boot time with drbd-8
Date: Mon, 3 Jul 2006 17:41:43 +0200
References: <342BAC0A5467384983B586A6B0B376710309E7F1@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B376710309E7F1@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200607031741.44057.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Dienstag, 27. Juni 2006 22:13 schrieb Graham, Simon:
> I've been working on getting the pre-release version of DRBD8 up on my
> system and have run into a couple of minor problems... first of all, I
> found that drbdadm dies with a segfault when running 'drbdadm adjust
> all' at boot time - turns out this is because the underlying 'drbdsetup
> /dev/drbd0 show' command returns "# not configured" at that time - the
> parsing of this into a resource structure by drbdadm leaves the
> running->me field NULL and we then trip over an attempt to strcmp the
> name of the device with the configured name - after some checking, I
> found that this problem is actually fixed in the trunk so I moved
> forward to there, BUT there are still a couple of issues with startup,
> namely:
>
> 1.	The routine convert_after_option (in drbdadm_main.c) ends up
> being called twice when the 'drbdadm adjust all' command is issued -
> once when comparing with the current running config and then again if a
> sync operation is actually kicked off - unforturnately, this routine
> actually crashes if the name stored in the after option is not a valid
> resource name (which of course it isn't after it's been converted the
> first time). I fixed this simply by not doing the conversion if the name
> does not represent a valid resource - if it truly is a bad resource name
> then the later attempt to use it will fail.

Thanks, for that detailed description. I took an other route to fixe
the issue, by calling the convert_ functions from one central
place, once. Thanks!

> 2.	The new code added to check IP addresses (verify_ips in
> drbdadm_main.c) is not properly initializing the sin_addr local variable
> which should have the IP address of the local system - thus this routine
> always fails and you get the 'OOPS: the IP address x.y.z.a isn't
> configure/up on your system!' error message.
> 3.	The definition & use of INVALID_IP_IS_INVALID_CONF are
> inconsistent; the definition defines it as zero and implies this means
> the option is disabled whereas the .c file uses #ifdef to check if it is
> enabled. I think this should be #if instead.
>

Right.

Thanks again!

Applied it to SVN...

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=C3=B6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
