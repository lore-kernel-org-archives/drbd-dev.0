Return-Path: <neilb@suse.de>
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 55E17420060
	for <drbd-dev@lists.linbit.com>; Fri,  4 Mar 2022 03:47:37 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
In-reply-to: <e8ec98a9c4fab9b7aa099001f09ff9b11f0c3f96.camel@kernel.org>
References: <164549971112.9187.16871723439770288255.stgit@noble.brown>,
	<164549983739.9187.14895675781408171186.stgit@noble.brown>,
	<ccc81eb5c23f933137c5da8d5050540cc54e58f0.camel@kernel.org>,
	<164568131640.25116.884631856219777713@noble.neil.brown.name>,
	<e8ec98a9c4fab9b7aa099001f09ff9b11f0c3f96.camel@kernel.org>
Date: Fri, 04 Mar 2022 13:47:26 +1100
Message-id: <164636204663.29369.1845040729675190216@noble.neil.brown.name>
Cc: Jan Kara <jack@suse.cz>, linux-doc@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	drbd-dev@lists.linbit.com, Paolo Valente <paolo.valente@linaro.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
	Chao Yu <chao@kernel.org>, linux-nilfs@vger.kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Wu Fengguang <fengguang.wu@intel.com>,
	Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [Drbd-dev] [PATCH 06/11] ceph: remove reliance on bdi congestion
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <https://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <https://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Thu, 24 Feb 2022, Jeff Layton wrote:
> On Thu, 2022-02-24 at 16:41 +1100, NeilBrown wrote:
> > On Thu, 24 Feb 2022, Jeff Layton wrote:
> > > On Tue, 2022-02-22 at 14:17 +1100, NeilBrown wrote:
> > > > The bdi congestion tracking in not widely used and will be removed.
> > > >=20
> > > > CEPHfs is one of a small number of filesystems that uses it, setting
> > > > just the async (write) congestion flags at what it determines are
> > > > appropriate times.
> > > >=20
> > > > The only remaining effect of the async flag is to cause (some)
> > > > WB_SYNC_NONE writes to be skipped.
> > > >=20
> > > > So instead of setting the flag, set an internal flag and change:
> > > >  - .writepages to do nothing if WB_SYNC_NONE and the flag is set
> > > >  - .writepage to return AOP_WRITEPAGE_ACTIVATE if WB_SYNC_NONE
> > > >     and the flag is set.
> > > >=20
> > > > The writepages change causes a behavioural change in that pageout() c=
an
> > > > now return PAGE_ACTIVATE instead of PAGE_KEEP, so SetPageActive() will
> > > > be called on the page which (I think) wil further delay the next atte=
mpt
> > > > at writeout.  This might be a good thing.
> > > >=20
> > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > >=20
> > > Maybe. I have to wonder whether all of this is really useful.
> > >=20
> > > When things are congested we'll avoid trying to issue new writeback
> > > requests. Note that we don't prevent new pages from being dirtied here -
> > > - only their being written back.
> > >=20
> > > This also doesn't do anything in the DIO or sync_write cases, so if we
> > > lose caps or are doing DIO, we'll just keep churning out "unlimited"
> > > writes in those cases anyway.
> >=20
> > I think the point of congestion tracking is to differentiate between
> > sync and async IO.  Or maybe "required" and "optional".
> > Eventually the "optional" IO will become required, but if we can delay
> > it until a time when there is less "required" io, then maybe we can
> > improve perceived latency.
> >=20
> > "optional" IO here is write-back and read-ahead.  If the load of
> > "required" IO is bursty, and if we can shuffle that optional stuff into
> > the quiet periods, we might win.
> >=20
>=20
> In that case, maybe we should be counting in-flight reads too and deny
> readahead when the count crosses some threshold? It seems a bit silly to
> only look at writes when it comes to "congestion".

I agree that seems a bit silly.

>=20
> > Whether this is a real need is an important question that I don't have an
> > answer for.  And whether it is better to leave delayed requests in the
> > page cache, or in the low-level queue with sync requests able to
> > over-take them - I don't know.  If you have multiple low-level queue as
> > you say you can with ceph, then lower might be better.
> >=20
> > The block layer has REQ_RAHEAD ..  maybe those request get should get a
> > lower priority ... though I don't think they do.
> > NFS has a 3 level priority queue, with write-back going at a lower
> > priority ... I think... for NFSv3 at least.
> >=20
> > Sometimes I suspect that as all our transports have become faster, we
> > have been able to ignore the extra latency caused by poor scheduling of
> > optional requests.  But at other times when my recently upgraded desktop
> > is struggling to view a web page while compiling a kernel ...  I wonder
> > if maybe we don't have the balance right any more.
> >=20
> > So maybe you are right - maybe we can rip all this stuff out.
> >=20
>=20
> I lean more toward just removing it. The existing implementation seems a
> bit half-baked with the gaps in what's being counted. Granted, the
> default congestion threshold is pretty high with modern memory sizes, so
> it probably doesn't come into play much in practice, but removing it
> would reduce some complexity in the client.

I'd love to have some test that could reliably generate congestion and
measure latencies for other IO.  Without that, it is mostly guess work.
So I cannot argue against your proposal, and do agree that removing the
code would reduce complexity.  I have no idea what the costs might be -
if any.  Hence my focus was on not changing behaviour.

Thanks,
NeilBrown
