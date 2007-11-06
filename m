Return-Path: <philipp.reisner@linbit.com>
Received: from mescal.linbit (unknown [81.16.158.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 576B42E084C3
	for <drbd-dev@lists.linbit.com>; Tue,  6 Nov 2007 14:53:22 +0100 (CET)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] PATCH: Missing state change netlink events
Date: Tue, 6 Nov 2007 14:53:21 +0100
References: <342BAC0A5467384983B586A6B0B376710707453A@EXNA.corp.stratus.com>
	<342BAC0A5467384983B586A6B0B376710707474E@EXNA.corp.stratus.com>
In-Reply-To: <342BAC0A5467384983B586A6B0B376710707474E@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711061453.21415.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tuesday 06 November 2007 13:41:34 Graham, Simon wrote:
> > > I think the fix is simple - modify the code so that after_state_ch
> > > broadcasts the new state rather than the current state (patch
> >
> > attached)
> >
> > > - I would have removed the passing of mdev completely from
> > > drbd_bcast_state() if it weren't for the fact it is required by the
> > > generated to_tags function. I'm testing this at the moment but it's
>
> a
>
> > > little hard to be sure it's right since this requires fairly tight
> > > timing.
> >
> > Hi Simon,
> >
> > You are right. Obviously.
> > I have put it into GIT.
>
> Actually, this patch wasn't quite complete -- there were a couple of
> places where the wrong new state was broadcast (where ScheduleAfter was
> _not_ set in the call to _drbd_set_state). Patch attached.
>

Right.

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
