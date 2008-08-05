Return-Path: <philipp.reisner@linbit.com>
Received: from fat-tyre.linbit (office.linbit [86.59.100.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 6E26A2E3B4A2
	for <drbd-dev@lists.linbit.com>; Tue,  5 Aug 2008 13:35:16 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] too small timeout in drbdsetup
Date: Tue, 5 Aug 2008 13:35:15 +0200
References: <87hcastmig.87fxqctmig@87ej5wtmig.message.id>
	<87y73cochw.87wsiwochw@87vdygochw.message.id>
In-Reply-To: <87y73cochw.87wsiwochw@87vdygochw.message.id>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808051335.15444.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 4. August 2008 20:37:00 schrieb syrius.ml@no-log.org:
> syrius.ml@no-log.org writes:
> > Hi,
> >
> > as previously reported here
> > http://thread.gmane.org/gmane.linux.kernel.drbd.devel/330 I also get
> > the error message.
> >
> > looking at
> > http://git.drbd.org/?p=drbd-8.0.git;a=blob;f=user/drbdsetup.c;h=0bca7c1c7
> >73bcbd1c2ed6781062396ed15e77e9c;hb=HEAD#l1919 and
> > http://git.drbd.org/?p=drbd-8.2.git;a=blob;f=user/drbdsetup.c;h=3868f1a18
> >f4cda80cad5b0b05aa6f2348755dedd;hb=HEAD
> >
> > it seems the timeout is still too low (at least for me)
> >
> > I've fixed my problem by increasing the timeout to 5s.
> >
> > to reproduce the bug i was doing several drbdsetup disk one after the
> > other in a script.
> >
> > (in fact the bug was first triggered by heartbeat drbd ocf script)
> >
> > Was do you thing would be the best change to make ?
> > increase the timeout ?
> > why not using NL_TIME (12000) as other drbd_calls ?
>
> Sorry to insist, 8.0.13 is on its way and you haven't answered about
> this subject.
> A lot of people have to make the change by hand and recompile,
> distributions might add their own patch before releasing. Anyway what
> do you think about this ?
>

Hi,

You have an issue with that 500ms in that function, right ?

void ensure_drbd_driver_is_present(void)
{
	struct drbd_tag_list *tl;
	char buffer[4096];
	int sk_nl, rr;

	sk_nl = open_cn();
	/* Might print:
	   Missing privileges? You should run this as root.
	   Connector module not loaded? try 'modprobe cn'. */
	if (sk_nl < 0) exit(20);

	tl = create_tag_list(2);
	add_tag(tl, TT_END, NULL, 0); // close the tag list

	tl->drbd_p_header->packet_type = P_get_state;
	tl->drbd_p_header->drbd_minor = 0;
	tl->drbd_p_header->flags = 0;

	rr = call_drbd(sk_nl, tl, (struct nlmsghdr*)buffer, 4096, 500);
	/* Might print: (after 500ms)
	   No response from the DRBD driver! Is the module loaded? */
	close_cn(sk_nl);
	if (rr == -2) exit(20);
}

We do not experience any issue with the 500ms in our setups, as are reports
about such an issue rather rare. Could you give a more details description
about the conditions you trigger can trigger this ?

I guess we will add an option to drbdsetup then, and have it is setting
in the globals section of drbd.conf. 

I do not want to inrecase it for all users, since is seems to affect only
a very small part of our user base.

-Phil
-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
