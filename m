Return-Path: <lars.ellenberg@linbit.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 38C0E101E043
	for <drbd-dev@lists.linbit.com>; Fri,  8 Mar 2019 11:37:45 +0100 (CET)
Received: by mail-wr1-f67.google.com with SMTP id g12so20804194wrm.5
	for <drbd-dev@lists.linbit.com>; Fri, 08 Mar 2019 02:37:45 -0800 (PST)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at.
	[212.186.191.219]) by smtp.gmail.com with ESMTPSA id
	c17sm11517488wrs.17.2019.03.08.02.32.39
	for <drbd-dev@lists.linbit.com>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 08 Mar 2019 02:32:39 -0800 (PST)
Resent-Message-ID: <20190308103236.GM31741@soda.linbit>
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com
	[192.185.49.124])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id CF1591011B9A
	for <drbd-dev@lists.linbit.com>; Tue, 26 Feb 2019 20:52:58 +0100 (CET)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
	by gateway23.websitewelcome.com (Postfix) with ESMTP id 10B0522CFA
	for <drbd-dev@lists.linbit.com>; Tue, 26 Feb 2019 13:31:24 -0600 (CST)
To: Roland Kammerer <roland.kammerer@linbit.com>
References: <20190123064501.GA26147@embeddedor>
	<20190129094230.ezjzpfwf5xx47luu@rck.sh>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <577904a8-2882-1895-007b-55e92cfdf918@embeddedor.com>
Date: Tue, 26 Feb 2019 13:31:22 -0600
MIME-Version: 1.0
In-Reply-To: <20190129094230.ezjzpfwf5xx47luu@rck.sh>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@chromium.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Philip Kelleher <pjk1939@linux.ibm.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Joshua Morris <josh.h.morris@us.ibm.com>, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block: Mark expected switch fall-throughs
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



On 1/29/19 3:42 AM, Roland Kammerer wrote:
> On Wed, Jan 23, 2019 at 12:45:01AM -0600, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> This patch is part of the ongoing efforts to enabling
>> -Wimplicit-fallthrough
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  drivers/block/drbd/drbd_int.h      | 2 +-
>>  drivers/block/drbd/drbd_receiver.c | 4 ++--
>>  drivers/block/drbd/drbd_req.c      | 2 +-
>>  drivers/block/rsxx/core.c          | 1 +
>>  4 files changed, 5 insertions(+), 4 deletions(-)
>>
> 
> Hi Gustavo,
> 
> as also discussed with Lars in person, obviously OK for the DRBD part.
> 
> Acked-by: Roland Kammerer <roland.kammerer@linbit.com>
> 

Thank you, Roland.

Friendly ping:

Who can take this, please?

Thanks
--
Gustavo
