Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra.linbit.com (zimbra.linbit.com [212.69.161.123])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8917E103B4B5
	for <drbd-dev@lists.linbit.com>; Tue, 11 Sep 2012 10:46:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.linbit.com (Postfix) with ESMTP id 820C31B43C5
	for <drbd-dev@lists.linbit.com>; Tue, 11 Sep 2012 10:46:53 +0200 (CEST)
Received: from zimbra.linbit.com ([127.0.0.1])
	by localhost (zimbra.linbit.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04VPGU7kzFI6 for <drbd-dev@lists.linbit.com>;
	Tue, 11 Sep 2012 10:46:53 +0200 (CEST)
Received: from soda.linbit (tuerlsteher.linbit.com [86.59.100.100])
	by zimbra.linbit.com (Postfix) with ESMTP id 699541B43BE
	for <drbd-dev@lists.linbit.com>; Tue, 11 Sep 2012 10:46:53 +0200 (CEST)
Resent-Message-ID: <20120911084653.GK7028@soda.linbit>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
	[209.85.160.54]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 535AC1013802
	for <drbd-dev@lists.linbit.com>; Tue, 11 Sep 2012 01:12:48 +0200 (CEST)
Received: by pbbrp2 with SMTP id rp2so3631925pbb.27
	for <drbd-dev@lists.linbit.com>; Mon, 10 Sep 2012 16:12:47 -0700 (PDT)
Date: Mon, 10 Sep 2012 16:12:44 -0700
From: Kent Overstreet <koverstreet@google.com>
To: Tejun Heo <tj@kernel.org>
Message-ID: <20120910231244.GD19739@google.com>
References: <8439412.RChiDciQdh@fat-tyre>
	<20120904224620.GB9092@dhcp-172-17-108-109.mtv.corp.google.com>
	<3029802.oqG0dEY71l@fat-tyre>
	<20120905084915.GF3195@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120905100724.GA27527@soda.linbit>
	<20120906212952.GP29092@google.com>
	<20120907084221.GD7028@soda.linbit>
	<20120910225442.GE7677@google.com>
	<20120910230654.GF7677@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120910230654.GF7677@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph Hellwig <hch@lst.de>, Vivek Goyal <vgoyal@redhat.com>,
	drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] FLUSH/FUA documentation & code discrepancy
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Mon, Sep 10, 2012 at 04:06:54PM -0700, Tejun Heo wrote:
> Hello, again.
> 
> cc'ing Kent and Vivek.  The original thread is at
> 
>   http://thread.gmane.org/gmane.linux.network.drbd.devel/2130
> 
> On Mon, Sep 10, 2012 at 03:54:42PM -0700, Tejun Heo wrote:
> > > We can possibly work around that by introducing an additional submitter thread,
> > > or at least our own list where we queue assembled bios until the lower
> > > level device queue drains.
> > > 
> > > But we'd rather have the elevator see the FLUSH/FUA,
> > > and treat them as at least a soft barrier/reorder boundary.
> > > 
> > > I may be wrong here, but all the necessary bits for this seem to be in
> > > place already, if the information would even reach the elevator in one
> > > way or other, and not be completely stripped away early.
> > > 
> > > What would you rather see, the elevator recognizing reorder boundaries?
> > > Or additional higher level queueing and extra thread/work queue/whatever?
> > > 
> > > Both are fine with me, I'm just asking for an opinion.
> > 
> > First of all, using FLUSH/FUA for such purpose is an error-prone
> > abuse.  You're trying to exploit an implementation detail which may
> > change at any time.  I think what you want is to be able to specify
> > REQ_SOFTBARRIER on bio submission, which shouldn't be too hard but I'm
> > still lost why this is necessary.  Can you please explain it a bit
> > more?
> 
> The problem with exposing REQ_SOFTBARRIER at bio submission is that it
> would require block layer not to reorder bios while passing through
> stacked adrivers until it reaches a rq-based driver.  I *suspect* this
> has been true until now but Kent's pending patch to fix possible
> deadlock issue breaks that.
> 
>   http://thread.gmane.org/gmane.linux.kernel.bcache.devel/1017/focus=1356250
> 
> As for what the resolution should be, urgh... I don't know. :(

No, that ordering has definitely not been preserved before - any
stacking driver would need either a giant global lock around its
make_request fn and everything else, or it'd need to serialize all bios
with some kind of linked list or something until they got to the
underlying devices.

And if that wasn't bad enough performance wise, getting the ordering
semantics correct when you've got multiple underlying devices...
*shudder*

I thought these kinds of ordering requirements were what we were getting
away from when old style barriers went away in 2.6.38.
