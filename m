Return-Path: <linux@stwm.de>
Received: from email.studentenwerk.mhn.de (mailin.studentenwerk.mhn.de
	[141.84.225.229])
	by mail19.linbit.com (LINBIT Mail Daemon) with ESMTP id 7B9BD420632
	for <drbd-dev@lists.linbit.com>; Tue, 29 Mar 2022 22:07:16 +0200 (CEST)
MIME-Version: 1.0
Date: Tue, 29 Mar 2022 22:01:15 +0200
From: Wolfgang Walter <linux@stwm.de>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20220329073254.GA20691@lst.de>
References: <20220329070618.GA20396@lst.de>
	<CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
	<20220329073254.GA20691@lst.de>
Message-ID: <ff5bc3eb8fa27845cefa2f96e5241972@stwm.de>
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Cc: Jens Axboe <axboe@kernel.dk>, Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] state of drbd in mainline
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

Am 2022-03-29 09:32, schrieb Christoph Hellwig:
> On Tue, Mar 29, 2022 at 09:22:26AM +0200, Philipp Reisner wrote:
>> Hi Christoph,
>> 
>> what do you expect for the DRBD changes? Usually, they fall into the
>> category: yes, obviously. When you are changing the block layer in 
>> this
>> way, then that is necessary for the in-tree DRBD code.
>> 
>> Regarding users: Yes, there are users of the in-tree DRBD code. Very 
>> big
>> corporations. And, yes, we see pressure building up that we get our 
>> act
>> together and re-sync the in-tree DRBD with the out-of tree DRBD.
> 
> The complete lack of bug reports and maintainer interaction usually
> suggests low to no use and heavy bitrot.  If that is not the case
> here that's fine, just asking..
> 
> _______________________________________________
> drbd-dev mailing list
> drbd-dev@lists.linbit.com
> https://lists.linbit.com/mailman/listinfo/drbd-dev

We use the in-tree DRBD with LTS (actually 5.15.32 and 5.4.188) and 
depend on it. It just works. We never had any issues in the last 5 
years.

Regards
-- 
Wolfgang Walter
Studentenwerk München
Anstalt des öffentlichen Rechts
