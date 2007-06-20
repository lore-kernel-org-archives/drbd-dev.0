Return-Path: <lars@linbit.com>
Date: Wed, 20 Jun 2007 18:31:20 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Running Protocol C with disk cache enabled
Message-ID: <20070620163120.GC24827@ogo.aicooma.com>
References: <342BAC0A5467384983B586A6B0B3767105BD4EEC@EXNA.corp.stratus.com>
	<200706201533.14467.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200706201533.14467.philipp.reisner@linbit.com>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Jun 20, 2007 at 03:33:14PM +0200, Philipp Reisner wrote:
> > However - there is one case that I don't think is covered currently;
> > it's entirely possible that I'm missing something, but I wanted to
> > check; the case in question is if the Secondary system suffers an
> > unexpected power loss, therebye potentially losing some writes that were
> > acknowledged prior to the failure. Now, I think that the activity log
> > maintained by the Primary actually includes the necessary information
> > about blocks which should be resynchronized _but_ I don't see any code
> > that would actually add these blocks to the bitmap when such a failure
> > occurs.
> >
> 
> Right we do not do this. The current opinion on this is: If the
> disk reported IO completion it has to be on disk. (actually a point
> of view of the Linux-2.2 and Linux-2.4 time).

Me and Phil had a few words about this.

Now, lying hardware is sooo broken :(
but, anyways.

the most easy way to realise this workaround
in current drbd apears to be:
 upon attach, always apply the activity log, 
 unless known to have been cleanly shut down.

we would basically maintain the activity log on the secondary
as well, and introduce an additional "cleanly detached" flag.

whenever you attach it again, the extents covered would need to be
resynced.  obviously this behaviour should be configurable, you want to
disable it for good hardware and large activity log.

I can think of few possible optimizations, even...
but we should not over-engineer what is "just" a workaround.

> further comments and opinions welcome of course!

-- 
: Lars Ellenberg                            Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
