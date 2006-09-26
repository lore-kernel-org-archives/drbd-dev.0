Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (office.linbit [213.229.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 0672C2CF820E
	for <drbd-dev@lists.linbit.com>; Tue, 26 Sep 2006 18:23:55 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] DRBD-8: <FOR REVIEW> dynamic tracing facility
Date: Tue, 26 Sep 2006 18:23:54 +0200
References: <342BAC0A5467384983B586A6B0B37671039D46DF@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B37671039D46DF@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200609261823.54543.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Sonntag, 24. September 2006 15:47 schrieb Graham, Simon:
> As we discussed a few weeks ago, I propose adding a more general purpose
> trace facility that can be controlled at run time - attached is a patch
> that implements the following:
>
> . New macros TRACE/MTRACE that can be used to add trace statements
> (using existing macros/routines) that
>   are controlled at run time.
> . Controls are module parameters:
>   . trace_type - bitmap of enabled types; currently defined are
> packet-dump, bio-dump, uuid-dump
>   . trace_level - the higher the level, the more detail
>   . trace_devs - bitmap of devices for which trace is enabled
> . I've converted the packet dumping code to use this
> . I've added two new types using it:
>   . bio-dump - this dumps info on bio's coming from above drbd. This is
> controlled by a new config
>     parameter DUMP_EACH_BIO that is off by default (although I think it
> could be on by default and
>     will be in our version).
>   . uuid-dump - dumps info on updates to uuid's, comparisons, etc
>
> I actually went back and forth on how much of this to implement inline
> versus via a routine call and it turned out to be pretty much the same
> amount of code at each trace site no matter what so I made it all
> inline.
>
> Comments?

Hi Simon,

I have two opinions about this:
 * Good stuff, it is nice to have all this in place, although I would=20
   also like to disable the whole tracing/dumping at compile time.

 * On the other hand I am not sure if it could become obsolete by
   the current rumours about a DTrace replacement on Linux (SystemTrap)

So, over all, I will accept a patch:
 * That converts our current stuff over to such a tracing framework
 * Probably add event more tracing. (As you have done for UUIDs)
 * The tracing facility allowes to enable/disable different classes
   of tracing information at run-time.
 * But I would also like to disable it at completely at compile time.

=2DPhil
=2D-=20
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Sch=F6nbrunnerstr 244, 1120 Vienna, Austria    http://www.linbit.com :
