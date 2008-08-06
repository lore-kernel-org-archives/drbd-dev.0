Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id F0D132E38715
	for <drbd-dev@lists.linbit.com>; Wed,  6 Aug 2008 19:09:30 +0200 (CEST)
Date: Wed, 6 Aug 2008 19:09:30 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Troubleshooting digest failures?
Message-ID: <20080806170930.GL32725@soda.linbit>
References: <4899BB99.60904@hostgis.com> <20080806160409.GJ32725@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080806160409.GJ32725@soda.linbit>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Wed, Aug 06, 2008 at 06:04:09PM +0200, Lars Ellenberg wrote:
> On Wed, Aug 06, 2008 at 08:56:25AM -0600, Gregor Mosheh wrote:
> > Hey guys.
> 
> Hello again.
> 
> Sorry for the joke, but I cannot help it.
> You know the story about "The hare and the hedgehog"?
> 
> > I've gotten no response from the user list,
> 
> now, that is not entirely true ;)
> 
> > so maybe it's time  
> > for a different tack debugging DRBD's innards...
> >
> > I've been having a problem which I describe here. The last posting is  
> > probably the most relevant.
> > http://www.gossamer-threads.com/lists/drbd/users/15119
> >
> > How would I go about debugging this?  Is there extra logging or
> > debugging  which I can enable? Have any of you seen this before?
> 
> Anyways,
> appart from what I wrote in your thread, and the 
> "What causes nodes to become out-of-sync?" thread,
>  http://www.gossamer-threads.com/lists/drbd/users/15081
> there is not much else I can say.
> 
> You said you have an other cluster, not yet in production, where it did
> not occur so far, and you suggest it may be just the missing load that
> makes it "appear" healthy.
> 
> How about using it as test setup, and generate load on it,
> until you can provoke the symptom there, too?
> 
> To reverse that, if you cannot provoke the symptom there,
> I'd still point to hardware issues on the affected cluster.

also, please have a look at this thread, where I try to explain
why modifying in-flight data buffers would lead to these symptoms.
http://www.gossamer-threads.com/lists/drbd/users/15189

also, when online-verify reports the out-of-sync sectors,
please to the
 # dd iflag=direct if=/dev/whatever bs=512 \
	skip=sector-offset count=size \
	of=nodename.dump
 # diff -U0 <(xxd node0.dump) <(xxd node1.dump)
trick (explained in the "what causes nodes to become out of sync"
thread) to get a diff of the hexdumps, so we can tell whether there is
  single bit flips,
  multiple word data changes
  complete unrelated stuff
in the corresponding sectors on the different nodes.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
