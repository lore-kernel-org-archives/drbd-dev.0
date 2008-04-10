Return-Path: <Simon.Graham@stratus.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Apr 2008 14:39:11 -0400
Message-ID: <342BAC0A5467384983B586A6B0B3767108F02DDB@EXNA.corp.stratus.com>
From: "Graham, Simon" <Simon.Graham@stratus.com>
To: <drbd-dev@lists.linbit.com>
Subject: [Drbd-dev] Problems with DRBD merge-bvec function
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

I've been doing some performance comparisons using the iometer benchmark
between a system without DRBD and one with and with a specific setup
that simulates a database workload I am seeing a significant performance
drop with DRBD (I see around 60% of the 'native' perf level when running
with DRBD).=20

After several days staring at the perf counter data, I've come to the
conclusion that the only difference between the two cases is the size of
requests passed down to the logical volume below DRBD. The iometer
workload is doing a mixture of synchronous reads and writes but all are
exactly 16KB in size and I see that:

1. When running without DRBD, the logical volume is seeing a constant
request size of 32 sectors (16KB)
2. When running with DRBD, the request size is variable but is <=3D 16
sectors with the vast majority of requests at the 16 sector size.

Enabling the DRBD trace, I can see that we are indeed getting a lot of
8K and smaller requests AND that we never see requests that cross a 32KB
boundary in disk offsets. I think this is causing my problem because
requests are being split above DRBD and then re-merged (sometimes)
between LVM and the physical disk.

Looking at the drbd_merge_bvec function I see that this is indeed
deliberate with the current code being as follows:

#if 1
	limit =3D DRBD_MAX_SEGMENT_SIZE - ((bio_offset &
(DRBD_MAX_SEGMENT_SIZE-1)) + bio_size);
#else
	limit =3D AL_EXTENT_SIZE - ((bio_offset & (AL_EXTENT_SIZE-1)) +
bio_size);
#endif

Since DRBD_MAX_SEGMENT_SIZE is 32KB that means DRBD will never allow a
single BIO to cross the 32KB boundary. The original purpose of this
routine according to the comments was to ensure requests did not cross
the 4MB AL segment size boundary but it seems this was changed.

This seems to be a big problem to me -- even though DRBD advertizes a
max rq size of 32KB, it rarely is able to actually achieve this when
synchronous I/O is done. It's certainly causing me grief at the moment!

I see that I cant simply change this code back to the 4MB boundary check
as we then run into code in drbd_make_request26 that will decide to try
and bio_split the request if it crosses s 32KB boundary... although I
see that the previous code before Lars checkin cbc66a14 actually did the
check based on the AL segment size.

I didn't quite understand the comments re this being necessary to
support two primaries either.

Any suggestions for relaxing this limitation?
Simon
