Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] drbd uses wrong API for struct bio
Date: Mon, 24 Jan 2005 15:38:33 +0100
References: <20050123161633.GH24350@marowsky-bree.de>
In-Reply-To: <20050123161633.GH24350@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200501241538.33555.philipp.reisner@linbit.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, axboe@suse.de
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Sonntag, 23. Januar 2005 17:16 schrieb Lars Marowsky-Bree:
> Hi all,
>
> drbd is a quite bad offender for using bio's on stack or embedded in
> other internal structs instead of the pointer interface.
>
> The attached patch shows the 'right' way as an example, which was pretty
> easy because I could use Jens' patch for md with minimal modifications ;-)
> However, the other offending code lines are within the transfer log and
> other places, and I'm not sure Philipp wants me to mess around with that.
>
> Jens, on chip.suse.de:/local/lmb/drbd-07/drbd/ you can find the most rece=
nt
> drbd kernel code. Could you look over drbd_compat_wrappers.h line 326ff in
> particular and give me a rough rundown of what's broken? We need to fix
> this by Tuesday latest :-(
>

Hi Guys,

I just see some hectic discussion going on here, it runs as it is on=20
Linux-2.6.10 as from kernel.org . Could someone tell me what the=20
actual problem is ?

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
