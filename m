Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: "Sylvain Coutant" <sco@adviseo.fr>
Subject: Re: [Drbd-dev] larger than 4tb volume status
Date: Thu, 16 Nov 2006 10:46:49 +0100
References: <002a01c7095e$8fa6d640$f1141351@SonyVAIO>
In-Reply-To: <002a01c7095e$8fa6d640$f1141351@SonyVAIO>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200611161046.49357.philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Donnerstag, 16. November 2006 10:06 schrieben Sie:
> >  * Selling DRBD+ licenses
>
> The web site doesn't make clear what is DRBD's current limitation, it
> states
>
>
> - "single device is limited to 4 TB"
> - "DRBD+ uses HIGHMEM[...]necessary in order to mirror over 4 TB in total
> over all devices"
>
>
> So, is it 4 TB total storage per node or 4 TB per drbd volume ? Is this
> different for 32 bits and 64 bits systems ?
>
>

I hope you do not use a proportional font to read your email:

              |         DRBD        |          DRBD+
=2D-------------+---------------------+------------------------
per Device    |    4TiB             |    16iBT on 32bit  (2)
total         | ~4TiB on 32 bit (1) |    unlimited       (3)


(2) on 64 bit it is 2^72 Byte or 4 ZiByte or 4294967296 TiB

(1) You can do tricks with the kernel parameter vmalloc=3D=20
    I do not know the exact limit by heart, but I guess you
    will not be able to reach 6 TB on a 32 bit system.
    On a 64 bit system it might be more (with vmalloc=3D tricks),
    but I do not know.

(3) Unlimited. But limited by available system RAM. DRBD=20
    allocates 32KiByte BitMap (in RAM) for 1GiByte of Storage.

    Storage size   |  DRBD's RAM usage
    ---------------+------------------
       1 TiB       |       32 MiB
       32 TiB      |       1 GiB
       ...                 ...

PS: The largest Volume I know of running in production is 20TB!

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
