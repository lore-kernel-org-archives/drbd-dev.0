Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [fix] drbd uses wrong API for struct bio
Date: Tue, 25 Jan 2005 10:26:11 +0100
References: <20050123161633.GH24350@marowsky-bree.de>
	<20050124232318.GV5638@marowsky-bree.de>
In-Reply-To: <20050124232318.GV5638@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200501251026.11669.philipp.reisner@linbit.com>
Cc: drbd-user@linbit.com, Lars Marowsky-Bree <lmb@suse.de>, axboe@suse.de
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Dienstag, 25. Januar 2005 00:23 schrieb Lars Marowsky-Bree:
> On 2005-01-23T17:16:33, Lars Marowsky-Bree <lmb@suse.de> wrote:
>
> The attached patch fixes drbds useage of bios up some. The proper fix
> would be to indeed change it over to use bio_alloc(), bio_get/put(),
> bio_add_page(), bio_clone (instead of __bio_clone) et cetera, but that
> fix is too complex for the timeframe I have right now.
>
> This should keep drbd-0.7.8 from oopsing not only on the SLES9 SP1
> kernel but also the recent 2.6.10-ac series.
>
> (I could possibly _code_ it, but it'd be too invasive and I'm weary of
> the side-effects it might have and the QA would take too long. There's a
> number of potential cleanups like further consolidation between
> drbd_prepare_req_write/_read and others, but I'd propose to do that for
> the drbd-0.8 branch instead when we can do away with 2.4.)
>
> Please comment on the patch, I'd be grateful.
>

Hi Lars,

the patch looks good so far. I am really happy that you have choosen
to go the less intrusive way for drbd-07.

Changing it over to alloc_bio() is something for drbd-08.

[...]
  ONLY_IN_26(unsigned int ee_size;)
  ONLY_IN_26(sector_t ee_sector;)
=2D // THINK: maybe we rather want bio_alloc(GFP_*,1)
+ // TODO: we rather want bio_alloc(GFP_*,1) all through the code!
  ONLY_IN_26(struct bio_vec ee_bvec;)

I am wondering if with a private copy of the bio_vec if we already
have a copy of the IO operations size and start sector that is=20
still in place after the IO operation completed.

 -> If this is the case we could drop the ee_size and ee_sector members
    and take them form e.g. ee_bvec=20

Jens, I guess you can answer that question  easily.

I will commit it to SVN...

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
