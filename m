Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Re: drbd uses wrong API for struct bio
Date: Mon, 24 Jan 2005 15:29:24 +0100
References: <20050123161633.GH24350@marowsky-bree.de>
	<20050124102310.GB2716@suse.de>
	<20050124102852.GC5638@marowsky-bree.de>
In-Reply-To: <20050124102852.GC5638@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200501241529.24813.philipp.reisner@linbit.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, Jens Axboe <axboe@suse.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 24. Januar 2005 11:28 schrieb Lars Marowsky-Bree:
> On 2005-01-24T11:23:10, Jens Axboe <axboe@suse.de> wrote:
> > Yes, that is what would be nice to fix :-)
> >
> > Make drbd_ee_init() just init the bastard, and add the page in
> > prepare().
>
> In theory you're right, but drbd seems to use this as a cache and
> allocate the page just once, but fills it with different data of
> different sizes over time, or at least that's what it looks like.
>

This is true.

> I'm not sure that's easily fixed.
>

What ?

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
