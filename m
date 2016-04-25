Return-Path: <philipp.reisner@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id 8DA3C105644B
	for <drbd-dev@lists.linbit.com>; Mon, 25 Apr 2016 18:42:32 +0200 (CEST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Date: Mon, 25 Apr 2016 11:21:13 -0500
Message-ID: <85987419.JuPsLEWddI@phil-dell-xps.local>
In-Reply-To: <571E37AD.1050607@sandisk.com>
References: <1461586077-11581-1-git-send-email-philipp.reisner@linbit.com>
	<1461586077-11581-5-git-send-email-philipp.reisner@linbit.com>
	<571E37AD.1050607@sandisk.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: Jens Axboe <axboe@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [Drbd-dev] [PATCH 04/30] drbd: Implement handling of thinly
	provisioned storage on resync target nodes
List-Id: "*Coordination* of development, patches,
	contributions -- *Questions* \(even to developers\) go to drbd-user,
	please." <drbd-dev.lists.linbit.com>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev@lists.linbit.com>
List-Help: <mailto:drbd-dev-request@lists.linbit.com?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request@lists.linbit.com?subject=subscribe>

Am Montag, 25. April 2016, 08:28:45 schrieb Bart Van Assche:
> On 04/25/2016 05:10 AM, Philipp Reisner wrote:
> > If during resync we read only zeroes for a range of sectors assume
> > that these secotors can be discarded on the sync target node.
> 
> Hello Phil,
> 
> With which interconnect(s) has this patch been tested? I'm afraid that
> for high-speed interconnects this patch will slow down I/O instead of
> making it faster because all_zero() examines all data before it is sent.
> 

Hi Bart,

that it might make things slower is true for sure. The benefit it
provides is to de-allocate blocks on the secondary obviously.
The whole feature is optional and it is off by default.

Obviously we want to have a generic interface like SEEK_HOLE/
SEEK_DATA for block devices, but that does not exist as of today.

best regards,
 Phil
