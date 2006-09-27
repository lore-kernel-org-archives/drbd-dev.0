Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id AC04B2CF7975
	for <drbd-dev@lists.linbit.com>; Wed, 27 Sep 2006 09:55:11 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8: <FOR REVIEW> dynamic tracing facility
Date: Wed, 27 Sep 2006 09:55:10 +0200
References: <342BAC0A5467384983B586A6B0B37671039D4C4D@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671039D4C4D@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200609270955.10894.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Dienstag, 26. September 2006 23:42 schrieb Graham, Simon:
> Hi Philipp,
>
> Just want to make sure I understand fully...
>
> > I have two opinions about this:
> >  * Good stuff, it is nice to have all this in place, although I would
> >    also like to disable the whole tracing/dumping at compile time.
> >
> >  * On the other hand I am not sure if it could become obsolete by
> >    the current rumours about a DTrace replacement on Linux
>
> (SystemTrap)
>
> I was not aware of DTrace but I have looked at SystemTap and decided it
> doesn't really work -- we need some level of trace that is always turned
> on (so we can diagnose field problems after the fact) combined with the
> ability to enable more extensive tracing at will and I don't think
> SystemTap will do both of these. To be honest I don't really like the
> fact that the tracing definition is separate from the driver code
> (probably the exact reason why other people like it
> ;-)
>
> Also -- whilst there may be work afoot to add this to the kernel, we
> need this now with the current kernel versions we are going to ship
> product with - I know that printk's are perhaps not the best (especially
> if you aren't careful about where to insert them) but they do provide
> what is needed now.

Right.

> > So, over all, I will accept a patch:
> >  * That converts our current stuff over to such a tracing framework
>
> Do you mean you want all the existing INFO/WARN/etc tracing to use this?
>

Hi Simon,

No, sorry. I did not express myself clearly.

I am happy with your approach:
 1) Having the framework in place first
 2) Converting the current INFO/WARN statements over to it next
 3) Adding more stuff to it later

I think the only thing that was missing from your patch
was the ability to disable it completely it compile time.

If you had not sent it with the comment 'FOR REVIEW' I had probably
comited it to SVN. ;)

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
