Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: axboe@suse.de
Date: Thu, 27 Jan 2005 10:47:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200501271047.09852.philipp.reisner@linbit.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, drbd-dev@lists.linbit.com
Subject: [Drbd-dev] Re: bio clone must copy io_vec
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Hi all,

I am reffering to Jens' fix for md...

> The way md uses bio_clones, it's possible for the original bio to be freed
> before the clone is freed. This means the clone ->bi_io_vec points to fre=
ed
> memory potentially. Fix it by duplicating the io_vec as well.
[...]

In DRBD the thing is different.=20
We use __bio_clone() but we will never end IO for our original bio before=20
we have not finished IO for our cloned BIO.

My fist thought was to have a own copy of __bio_clone() in place, which
behaves like the __bio_clone() of Linux-2.6.10-vanilla.

But on the other hand I think I can convert it over to use bio_clone()
within a few hours. Well I will give it a try, and let you know if
I end up with a patch...

PS: Jens, when I am the owner of a BIO I can do with the private
    member what ever I want, right ?
    And I am the owner of a bio clones with bio_clone() right ?

=2DPhilipp
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
