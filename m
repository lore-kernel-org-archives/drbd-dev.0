Return-Path: <lars.ellenberg@linbit.com>
Received: from soda.linbit (office.linbit [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 79D912DF6273
	for <drbd-dev@lists.linbit.com>; Thu, 11 Sep 2008 11:25:12 +0200 (CEST)
Date: Thu, 11 Sep 2008 11:25:12 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] Behaviour of verify: false positives -> true positives
Message-ID: <20080911092512.GC9756@soda.linbit>
References: <200809091602.31104.thomas.schoebel-theuer@1und1.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200809091602.31104.thomas.schoebel-theuer@1und1.de>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On Tue, Sep 09, 2008 at 04:02:30PM +0200, schoebel wrote:
> Hi,
> 
> my company is considering drbd for building up failover clusters in
> shared hosting.
> 
> During our preliminary tests, we noticed that a "drbdadm verify
> /dev/drbdx" detects differences on a heavily loaded test server
> (several thousand customers).
> 
> We noticed two kind of verify differences: one is surely temporary
> (not repeatable), but the other is persistent, even after umounting
> the filesystem.
> 
> According to the manpage on drbd.conf (section "notes on data integrity"), 
> these should be "false positives".  Indeed, we found no real corruptions (all 
> different blocks were associated with deleted files).
> 
> However, this means that verify is (in _our_ point of view) no _reliable_ 
> check for data integrity. Since data integrity of our valuable customer data 
> is of great concern for us, we look for possibilities to change the behavior 
> such that no false positives are reported any more, i.e. any difference 
> reported by verify should be _guaranteed_ to be a "true positive". In my 
> humble opinion, so-called "mission critical" applications demand for that in 
> general.
> 
> In my understanding of kernel architecture, I believe the block differences 
> are caused by an _intended_ race in the kernel at buffer cache level. 
> Whenever a block gets dirty, there is (deliberately) no lock for any consumer 
> of the buffer cache (such as ext3) which would prevent it from 
> (re-)modification while the block is being written to an ordinary disk (even 
> not necessarily a drbd device). IMHO, this deliberate race is _crucial_ for 
> kernel performance (and thus I don't want to dispute on it).
> 
> Normally, this race should be no problem at all, even if an inconsistent block 
> (half of the 512-byte block old, other half new version) is written to disk: 
> the dirty-bit is just set again by the buffer cache level again, leading to 
> another writeout which eventually fixes the problem.
> 
> I believe (but not 100% sure; please comment) that this model can explain the 
> temporary differences seen by a drbd verify: when the data _content_ is 
> mirrored across the network, the local disk version might have 
> another "timestamp" (in _real_ time) than the version transmitted to 
> ethernet. Thus, _any_ IO of dirty blocks might be inconsistent due to the 
> deliberate kernel race on data block _content_ (dereferencing of 
> buffer_head->b_data in parallel to disk IO). With ordinary load patterns, 
> the "chance" to see _temporary_ false positives caused by that race is 
> probably extremely low (perhaps one to some billion). But on a heavily loaded 
> system we have observed it from time to time. Attached below are some tiny 
> perl scripts which can reproduce temporary false positives with a fairly good 
> chance at least on our test systems (I'd be glad to receive reproductions and 
> experience from other users too). Just start io_rewrite_sector2.pl on an 
> (preferably empty) ext3 filesystem on top of drbd, _in parallel_ to a "drbd 
> verify /dev/corresponding_device" (other filesystems not yet tested). My test 
> filesystem for this test was about 2GB size. Possibly you might have to 
> adjust some constants to reproduce the test.
> 
> Up to now, I was reasoning on the _temporary_ false positives. Persistent 
> false positives could be explained by the following theory:
> 
> When a file is eventually deleted or truncated, bforget() is called at the 
> buffer cache interface. After that, dirty blocks are no longer transferred to 
> disk, in order to save IO load (IMHO this is _crucial_ for typical access 
> patterns on /tmp/ where typical lifetimes are often less than 1 second). As a 
> consequence, the above-mentioned "fixing" of inconsistent blocks is no longer 
> carried out and long-term differences can remain on the mirrored device, but 
> belonging to deleted files only. Again, the chance to observe that is very 
> low, but I have written another tiny perl script to reproduce that. Just 
> start test_orphan.pl on an _empty_ drbd-mounted filesystem, and _afterwards_ 
> check it with verify. Since the filesystem is empty again after the test, you 
> can be sure that the differences belong to empty or orphan files (if it would 
> belong to filesystem metadata, you would notice that by inspection of the 
> contents with dd). By investigating the different counter values with dd on 
> the underlying devices (primary vs secondary), you can even tell which 
> version was written first. Interestingly, I found that most of the time the 
> local version was the older one, but sometimes it was vice versa.
> 
> As a side note: test_orphan.pl also produces orphan files. Sometimes the 
> counter values observed in different blocks are lower than the point of 
> unlink() [currently set to 500], but most of the time the counter value is 
> greater. It seems to me that applications producing orphan files raise the 
> chance to observe false positives, but I am not sure. I have not yet a theory 
> for that; please comment. It might be influenced by the timings of the block 
> IO demon and/or by the load patterns.

interessting test setup and solid analysis, I'd say.

> -------
> 
> Now I am reasoning on different solutions. Please comment.
> 
> Here are just some brainstorming ideas, without judging on their quality (this 
> will come later):
> 
> 1) Try to avoid the kernel race on buffer content, specifically for drbd 
> devices as an _option_ (which is _off_ by default). There are at least two 
> sub-variants of that:
> 1a) use locking
> 1b) use an idea published by Herlihy for conflict-free resolution of different 
> _versions_ of blocks, either on the fly or optionally residing in the buffer 
> cache _in parallel_ [nb probably the latter could result in a major rewrite 
> of large portions of the kernel, not to be disputed here on this list]
> 
> 2) Whenever drbd-verify sees a difference, retry the comparison a few times 
> after a short delay (possibly with exponential backoff), until _temporary_ 
> differences have been filtered out. Persistent differences will not be 
> tackled by that.
> 
> 3) As an addition to 2), add an _option_ (which is _off_ by default) to the 
> buffer cache code  to submit bforgotten() blocks specifically to drbd 
> devices.
> 
> 4) Add an option to drbd (as usual _off_ by default), which calculates a 
> checksum on _every_ arriving IO request _first_ (before starting any 
> sub-request). After finishing both the local and remote sub-IO, calculate the 
> checksum again and compare. If a difference is found, restart both 
> sub-transmissions again, until no mismatches are found any more.
> 
> 5) As a refinement of 4), first filter out the temporary false positives by 
> means of 2). Additionally try to identify bforgotten() blocks at the buffer 
> cache level and submit them only _once_ after a bforget(), and only to drbd 
> devices where the corresponding option is set. Then drbd uses method 4) 
> _only_ on those blocks, thereby minimizing the performance impact of 4) to a 
> rare special case.
> 
> 6) Try to establish a complete solution in presence of races solely at the 
> buffer cache level, without affecting drbd in any way. I am not sure whether 
> this is possible. The raw idea is to _identify_ all races _reliably_(!) when 
> they _actually_ occur (as in contrast to _possible_ occurrence). 
> Theoretically b_count, b_state and/or other/similar means should be available 
> to detect actually occurring races during IO, but I am extremely unsure 
> whether this is possible _reliably_ without additional means such as 
> checksumming. Probably this is the wrong list for discussing this topic, but 
> I would be thankful for hints and ideas before going elsewhere with an 
> uncomplete idea.
> 
> Now what I personally think of it: 1a) has too strong performance impact, 1b) 
> would probably complicate the kernel by magnitudes, 2) is easy but does not 
> solve all problems, 3) is feasible for non-general applications (outside 
> of /tmp/ etc) but probably could lead to fundamental discussions with kernel 
> developer (forcing us into an inhouse patch), 4) solves it all very easy but 
> hurts performance, 5) is very complicated, and 6) is no mature idea yet.
> 
> Currently, I would prefer 4) as an option for testing and for gaining 
> experience at the first try, but depending on performance results other 
> mechanisms should be evaluated.
> 
> Of course, other people have other ideas and opinions, so please feel free to 
> comment.


how about holding a ring buffer of pinned pages,
say "drbd max-buffer" pages plus some,
and in drbd_make_request,
memcpy(ring buffer, submitted data)
then checksum that,
and submit it to localdisk as well as to tcp stack.
as these are now "private" data buffers,
the "application" cannot possibly modify them in-flight.

yes, not necessarily performant.

> Thanks for your patience,

thanks for sharing your findings.

-- 
: Lars Ellenberg                
: LINBIT | Your Way to High Availability
: DRBD/HA support and consulting http://www.linbit.com

DRBD® and LINBIT® are registered trademarks of LINBIT, Austria.
