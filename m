Return-Path: <philipp.reisner@linbit.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] 0.7.11 soon
Date: Mon, 9 May 2005 11:37:01 +0200
References: <200505091030.00455.philipp.reisner@linbit.com>
	<200505091058.42759.hug@abanet.ch>
In-Reply-To: <200505091058.42759.hug@abanet.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200505091137.01385.philipp.reisner@linbit.com>
Cc: Philipp Hug <hug@abanet.ch>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 9. Mai 2005 10:58 schrieb Philipp Hug:
> philipp,
>
> if you release a new version it won't make it into sarge...
> 0.7.10 will be in sarge and has to be supported for about 2 years ;-)
>
> philipp
>
> On Monday 09 May 2005 10.30, Philipp Reisner wrote:
> > Hi,
> >
> > The last DRBD release happened on the 31st Jan of 2005, this
> > is more than 3 month by now. I guess we need to give our
> > users the feeling that DRBD is still alive :)
> >
> > 0.7.11 (api:77/proto:74)
> > -----
> >  * The upper limit of the runtime tuning parameter max_buffers
> >    was ways too low for today's IBM storage controllers.
> >    Was 32 - 10000 ; Now it is 32 - 131072 ( Now one could
> >    allow DRBD to allocate up to half a gigabyte of memory as
> >    receive buffers)
> >  * A fix to the Makefiles to make building of RPMs work on RAHS4.
> >  * A workaround to have DBRD running on PPC64 with Linux-2.4.x kernels,
> >    on Linux-2.6.x everything was fine already.
> >  * Removal of dead code (busy_blocks).
> >
> > I will tag, create the tar-ball and announce it on wednesday,
> > as long as nobody objects.

Yes, I expected this.=20

The only relevant patch for Debian is the first item of the changelog:

=2D-- user/drbd_limits.h  (.../https://svn.drbd.org/drbd/tags/drbd-0.7.10) =
       (Revision 1789)
+++ user/drbd_limits.h  (.../http://svn.drbd.org/drbd/branches/drbd-0.7)   =
     (Revision 1789)
@@ -49,8 +49,8 @@
   /* I don't think that a tcp send buffer of more than 10M is usefull */
   RANGE(SNDBUF_SIZE, 1, 10000000);

=2D  /* arbitrary. */
=2D  RANGE(MAX_BUFFERS, 32, 10000);
+  /* @4k PageSize -> 128kB - 512MB */
+  RANGE(MAX_BUFFERS, 32, 131072);

   /* 0 is disabled.
    * 200 should be more than enough even for very short timeouts */


Maybe you can slip it in by creating a "drbd-0.7.10-4" or something.
But it is nothing critical at all ... as we know drbd-0.7.10 is really
fine for most people.

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
