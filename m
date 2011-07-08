Return-Path: <mrten+drbd@ii.nl>
Received: from mail2.ii.nl (mail2.ii.nl [82.94.191.121])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 1F6541056468
	for <drbd-dev@lists.linbit.com>; Fri,  8 Jul 2011 20:37:10 +0200 (CEST)
Received: from s529c1e11.adsl.wanadoo.nl ([82.156.30.17]:54723 helo=kyra.ii.nl)
	by mail2.ii.nl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mrten+drbd@ii.nl>) id 1QfFvJ-0000BM-La
	for drbd-dev@lists.linbit.com; Fri, 08 Jul 2011 20:37:09 +0200
Received: from dsldevice.lan ([82.156.30.17]:54708 helo=witlap.local)
	by kyra.ii.nl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72) (envelope-from <mrten+drbd@ii.nl>) id 1QfFvI-0005ZT-Me
	for drbd-dev@lists.linbit.com; Fri, 08 Jul 2011 20:37:08 +0200
Message-ID: <4E174E53.5000106@ii.nl>
Date: Fri, 08 Jul 2011 20:37:07 +0200
From: Mrten <mrten+drbd@ii.nl>
MIME-Version: 1.0
To: drbd-dev@lists.linbit.com
References: <1310053461-15060-1-git-send-email-mrten+drbd@ii.nl>	<1310053461-15060-2-git-send-email-mrten+drbd@ii.nl>
	<4E17116D.4080305@linbit.com>
In-Reply-To: <4E17116D.4080305@linbit.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Drbd-dev] [PATCH 2/2] expand section on throughput tuning to
 highlight prime usecase of external metadata
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

On 08-07-2011 16:17:17, Florian Haas wrote:

> You're adding a third item to the enumeration; so it would be nice if
> you could also rephrase the next paragraph which talks about "the 
> minimum between the two".

Will do.

> You're talking about a battery backup of a cache that is not there. 
> Does not compute. :)

So true, will fix ;)

>> DRBD metadata updates necessary to guarantee +  data-completeness 
>> in case of failure can slow down +  write throughput significantly.
>> If a raw device is normally capable of +  250 MB/s write throughput
>> it is not an anomaly to see writes as slow as + 70 MB/s with DRBD
>> enabled (numbers are for rotational disks). This is +  purely
>> caused by head seeks; 4MB data updates have to be followed by
>> metadata updates +  and the data-writes can only continue after the
>> metadata has been reached the +  platters (caching and write
>> reordering does not help).
> 
> I'm afraid you're missing some context here. DRBD performs the 
> synchronous meta data updates you are referring to only when an AL 
> extent goes hot or cold. It doesn't do so randomly or, as your 
> paragraph seems to imply to a casual reader, every time it has 
> written 4M of data.
> 
> And it is definitely _not_ normal to see 250MB/s write bandwidth drop
> to 70 MB/s. 110 MB/s would be entirely normal if you are replicating
> over Gigagit Ethernet, but that is determined by the bandwidth of the
> replication link, it doesn't have much to do with AL updates.

I think I should explain what I trying to convey, or rather, my mental
image of what happened while I was benchmarking (and saw that huge
performance drop).

My backing device for DRBD is a software raid-0 (two disks), with
'meta-disk internal'. Benchmarking was done by dd'ing a few gigs from
/dev/zero. All this dd-writing makes a lot of new extents hot (one for
every 4MB written?), which has to be remembered in the metadata, with
synchronous writes. Since my backing device is raid-0 and the default
chunk size for that is rather large these days, the (small) metadata
updates aren't spread over the raid-0 disks but are concentrated on one
device, which becomes the bottleneck for the benchmark because it has to
seek all the time.

This is not a cause for concern when you have a hardware battery-backed
cache, as the raid-controller can then delay writing the metadata, but I
don't have that.

I've blktrace-d, blkparse-d and seekwatcher-ed the hell out of this and
the images show exactly that happen, so I dared to write it up like this
without having read the source ;). Lots of linear writes, regularly
interrupted by a seek to synchronously write the metadata.


The slowdown wasn't caused by the interconnection between primary and
secondary, the 70MB/s was measured both in StandAlone and UpToDate (I
bonded 3 GE interfaces for nice syncing bandwidth).

And it was pure benchmarking, no other things happening on the server so
I'd expect that only the benchmark made extents hot.

I of course do not know the exact criteria that mark extents hot, if
what I described above is not an accurate description of what happens,
please correct me.


But the reason I think this should be in the docs is that I reckon that
lots of people would like to 0+"network raid-1" with relatively cheap
hardware, do the simplest of benchmarks and get confused by the
slowdown. Googling this I saw this subject passing over the mailinglist
a couple of times.

> And what you mean by "caching and write reordering does not help" I 
> don't understand at all, can you elaborate please?

The synchronous (barrier?) writes for the metadata, as far as I
understand it from a mailing post from Lars, *must* have reached the
platters before the linear dd-writing can continue. So no enabling of
write caches, NCQ or tuning of elevators is going to help.

However, if you think that the paragraph now implies that *every* write
randomly makes extents hot then I should do some polishing ;)


>> +[[s-tune-external-metadata]]

[...]

> This section would be ok, but it's still missing the steps to dump 
> the existing metadata and restore it onto the new metadata device. 
> Can you add that and repost the patch please?

Ah, I hadn't thought of that scenario (am using a raid-1 for the
metadata). Is this along the lines of:

drbdadm down [resource]
drbdadm dump-md [resource] > savefile
[change meta-disk]
drbdmeta /dev/drbdX v08 [metadevice] 0 restore-md savefile

?

Is the index 0 correct usage when using flexible-meta-disk?

Maarten.
