Return-Path: <Lars.Ellenberg@linbit.com>
Received: from soda (unknown [86.59.100.100])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 9A2052D9D2C2
	for <drbd-dev@lists.linbit.com>; Thu, 14 Dec 2006 11:14:36 +0100 (CET)
Date: Thu, 14 Dec 2006 11:14:37 +0100
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] resync end in drbd8
Message-ID: <20061214101437.GC7939@soda.linbit>
References: <45805753.1060005@dcs.gla.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45805753.1060005@dcs.gla.ac.uk>
List-Id: Coordination of development <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

/ 2006-12-13 19:41:07 +0000
\ Cristian Zamfir:
> 
> Hi,
> 
> I am using the svn version of drbd8 and the -m option to allow both
> peers to be primary. The states are Connected and UpToDate/UpTodate.
> I am going bursts of writes to one of the disks and I am interested in
> finding out when there are no outstanding writes that need to be
> mirrored to the other disk, basically when the resync ends.

there is no "delayed" resync.
DRBD Protocol C is synchonous
(required for two Primaries).

when the write (fsync, fdatasync) comes back,
the data is on both disks.

if you don't fsync or at least fdatasync,
even without drbd you won't know when data is on the local disk.

these kinds of questions are better posted on drbd-user, btw.

-- 
: Lars Ellenberg                            Tel +43-1-8178292-55 :
: LINBIT Information Technologies GmbH      Fax +43-1-8178292-82 :
: Vivenotgasse 48, A-1120 Vienna/Europe    http://www.linbit.com :
