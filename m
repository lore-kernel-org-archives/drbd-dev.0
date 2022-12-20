Return-Path: <pavel@ucw.cz>
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id ACCA54203C0
	for <drbd-dev@lists.linbit.com>; Tue, 20 Dec 2022 20:47:45 +0100 (CET)
Date: Tue, 20 Dec 2022 20:39:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <Y6IPjC9mpnoquL8S@duo.ucw.cz>
References: <20221220134519.3dd1318b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q4QndSuPZQc8d5xp"
Content-Disposition: inline
In-Reply-To: <20221220134519.3dd1318b@gandalf.local.home>
Cc: alsa-devel@alsa-project.org, linux-staging@lists.linux.dev,
	linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org,
	SHA-cyfmac-dev-list@infineon.com, linux-leds@vger.kernel.org,
	drbd-dev@lists.linbit.com, lvs-devel@vger.kernel.org,
	linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	Julia Lawall <Julia.Lawall@inria.fr>, linux-acpi@vger.kernel.org,
	coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org,
	linux-input@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	linux-ext4@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	linux-media@vger.kernel.org, bridge@lists.linux-foundation.org,
	intel-gfx@lists.freedesktop.org, linux-nfs@vger.kernel.org,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	brcm80211-dev-list.pdl@broadcom.com,
	Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Drbd-dev] [PATCH] treewide: Convert del_timer*() to
	timer_shutdown*()
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>


--Q4QndSuPZQc8d5xp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2022-12-20 13:45:19, Steven Rostedt wrote:
> [
>   Linus,
>=20
>     I ran the script against your latest master branch:
>     commit b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
>=20
>     As the timer_shutdown*() code is now in your tree, I figured
>     we can start doing the conversions. At least add the trivial ones
>     now as Thomas suggested that this gets applied at the end of the
>     merge window, to avoid conflicts with linux-next during the
>     development cycle. I can wait to Friday to run it again, and
>     resubmit.
>=20
>     What is the best way to handle this?
> ]
>=20
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>=20
> Due to several bugs caused by timers being re-armed after they are
> shutdown and just before they are freed, a new state of timers was added
> called "shutdown". After a timer is set to this state, then it can no
> longer be re-armed.
>=20
> The following script was run to find all the trivial locations where
> del_timer() or del_timer_sync() is called in the same function that the
> object holding the timer is freed. It also ignores any locations where the
> timer->function is modified between the del_timer*() and the free(), as
> that is not considered a "trivial" case.
>=20
> This was created by using a coccinelle script and the following
commands:

LED parts looks good to me.

Getting it in just before -rc1 would be best solution for me.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--Q4QndSuPZQc8d5xp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY6IPjAAKCRAw5/Bqldv6
8qFnAJ4h7/YkgMmaMAi5FTo4aeUHj64lowCgv7jO/1JyimzJx+06JHTOXFlIAIk=
=01ne
-----END PGP SIGNATURE-----

--Q4QndSuPZQc8d5xp--
