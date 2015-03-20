Return-Path: <lars.ellenberg@linbit.com>
Received: from zimbra13.linbit.com (zimbra.linbit.com [212.69.161.123])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTPS id EE71C1011B9B
	for <drbd-dev@lists.linbit.com>; Fri, 20 Mar 2015 16:14:50 +0100 (CET)
Date: Fri, 20 Mar 2015 16:14:50 +0100
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Message-ID: <20150320151450.GG3556@soda.linbit>
References: <1426295577-10836-1-git-send-email-akinobu.mita@gmail.com>
	<1426295577-10836-4-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426295577-10836-4-git-send-email-akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] drbd: use bitmap_weight()
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

On Sat, Mar 14, 2015 at 10:12:56AM +0900, Akinobu Mita wrote:
> Use bitmap_weight to count the total number of bits set in bitmap.
> This change just simplifies the code a bit.

"Simplifies", not sure about that, but ok, maybe.

For the "bm_set_full_words_within_one_page", I disagree.
I think it is more cpu cache friendly to hweight_long then set to ~0UL
each word in turn, than to first bitmap_weight() all words, then
bitmap_fill() all words.

Thanks,

	Lars Ellenberg

BTW, you swapped names and email addresses of phil and me.  Are those
listed incorrectly somewhere, or was that just a mishap on your part?
